{{/*
Expand the name of the chart.
*/}}
{{- define "apache-cassandra.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apache-cassandra.fullname" -}}
{{- $name := default .Chart.Name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "apache-cassandra.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "apache-cassandra.labels" -}}
helm.sh/chart: {{ include "apache-cassandra.chart" . }}
{{ include "apache-cassandra.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "apache-cassandra.selectorLabels" -}}
app.kubernetes.io/name: {{ include "apache-cassandra.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
author: olson1998
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "apache-cassandra.serviceAccountName" -}}
{{- default (include "apache-cassandra.fullname" .) .Values.serviceAccount.name }}
{{- end }}