# -*- coding: UTF-8 -*-
"""
Production specific settings.
Don't customise this file, use local.py for specific local settings
@author: Sébastien Renard (sebastien.renard@digitalfox.org)
@license: AGPL v3 or newer (http://www.gnu.org/licenses/agpl-3.0.html)
"""
import os

# Root dir - needed for MEDIA_ROOT
PYDICI_ROOTDIR = os.path.join(os.path.abspath(os.path.dirname(__file__)), os.path.pardir, os.path.pardir)

DEBUG = os.environ.get('DEBUG', 'False').lower() == 'true'

# Parse ALLOWED_HOSTS from environment variable (comma-separated list)
ALLOWED_HOSTS = os.environ.get('ALLOWED_HOSTS', '').split(',') if os.environ.get('ALLOWED_HOSTS') else []

MIDDLEWARE = [
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.contrib.auth.middleware.RemoteUserMiddleware',
    'auditlog.middleware.AuditlogMiddleware',
    'core.middleware.ScopeMiddleware',
]


AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.RemoteUserBackend',
]

MEDIA_ROOT = PYDICI_ROOTDIR