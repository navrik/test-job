{{/*
Expand the name of the chart.
*/}}
{{- define "care.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "care.fullname" -}}
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
{{- define "care.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "back.labels" -}}
helm.sh/chart: {{ include "care.chart" . }}
{{ include "back.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/part-of: {{ include "care.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: "{{ include "care.name" . }}-back"
version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- define "crontabs.labels" -}}
helm.sh/chart: {{ include "care.chart" . }}
{{ include "crontabs.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/part-of: {{ include "care.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: "{{ include "care.name" . }}-crontabs"
version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- define "cmsadmin.labels" -}}
helm.sh/chart: {{ include "care.chart" . }}
{{ include "cmsadmin.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/part-of: {{ include "care.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: "{{ include "care.name" . }}-cmsadmin"
version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "back.selectorLabels" -}}
app.kubernetes.io/name: "{{ include "care.name" . }}-back"
app.kubernetes.io/component: "app"
{{- end }}
{{- define "crontabs.selectorLabels" -}}
app.kubernetes.io/name: "{{ include "care.name" . }}-crontabs"
app.kubernetes.io/component: "app"
{{- end }}
{{- define "cmsadmin.selectorLabels" -}}
app.kubernetes.io/name: "{{ include "care.name" . }}-cmsadmin"
app.kubernetes.io/component: "app"
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "care.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "care.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "imagePullSecret" }}
{{- with .Values.imageCredentials }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password .email (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}
