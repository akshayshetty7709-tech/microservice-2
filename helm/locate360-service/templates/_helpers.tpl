{{- define "locate360-service.fullname" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "locate360-service.labels" -}}
app.kubernetes.io/name: {{ include "locate360-service.fullname" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "locate360-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "locate360-service.fullname" . }}
{{- end -}}
