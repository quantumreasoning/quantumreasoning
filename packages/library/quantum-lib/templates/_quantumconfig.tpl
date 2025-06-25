{{- define "quantum-lib.loadQuantumConfig" }}
{{-   include "quantum-lib.checkInput" . }}
{{-   if not (hasKey (index . 1) "quantumConfig") }}
{{-     $quantumConfig := lookup "v1" "ConfigMap" "quantum-system" "quantumreasoning" }}
{{-     $_ := set (index . 1) "quantumConfig" $quantumConfig }}
{{-   end }}
{{- end }}
