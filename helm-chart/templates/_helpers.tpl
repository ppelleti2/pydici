{{/*
Expand the name of the chart.
*/}}
{{- define "pydici.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pydici.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pydici.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pydici.labels" -}}
helm.sh/chart: {{ include "pydici.chart" . }}
{{ include "pydici.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pydici.selectorLabels" -}}
app.kubernetes.io/part-of: {{ include "pydici.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
MariaDB host
*/}}
{{- define "pydici.mariadbHost" -}}
{{- if .Values.mariadb.enabled }}
{{- include "pydici.fullname" . }}-mariadb
{{- else }}
{{- .Values.mariadb.externalHost }}
{{- end }}
{{- end }}

{{/*
Redis host
*/}}
{{- define "pydici.redisHost" -}}
{{- if .Values.redis.enabled }}
{{- include "pydici.fullname" . }}-redis
{{- else }}
{{- .Values.redis.externalHost }}
{{- end }}
{{- end }}

{{/*
Memcached host
*/}}
{{- define "pydici.memcachedHost" -}}
{{- if .Values.memcached.enabled }}
{{- include "pydici.fullname" . }}-memcached
{{- else }}
{{- .Values.memcached.externalHost }}
{{- end }}
{{- end }}