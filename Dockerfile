FROM python:3.11-slim as base

RUN apt-get update && apt-get install -y --no-install-recommends \
    gettext \
    chromium \
    ghostscript \
    mariadb-client \
    libmariadb-dev \
    gcc \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r pydici --gid=1000 && \
    useradd -r -g pydici --uid=1000 --home-dir=/home/pydici --create-home pydici

ENV PATH="/home/pydici/.local/bin:$PATH" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/code \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /code

COPY --chown=pydici:pydici requirements*.txt ./
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install -r requirements-sklearn.txt && \
    pip install -r requirements-dev.txt && \
    pip install gunicorn

COPY --chown=pydici:pydici . .

USER pydici

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health/ || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "--timeout", "120", "pydici.wsgi:application"]

