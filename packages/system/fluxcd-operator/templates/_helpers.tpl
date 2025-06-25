{{- define "quantum.kubernetes_envs" }}
{{- $quantumDeployment := lookup "apps/v1" "Deployment" "quantum-system" "quantumreasoning" }}
{{- $quantumContainers := dig "spec" "template" "spec" "containers" dict $quantumDeployment }}
{{- range $quantumContainers }}
{{- if eq .name "quantumreasoning" }}
{{- range .env }}
{{- if has .name (list "KUBERNETES_SERVICE_HOST" "KUBERNETES_SERVICE_PORT") }}
- {{ toJson . }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
