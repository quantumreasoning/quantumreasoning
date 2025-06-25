{{- define "quantum-lib.checkInput" }}
{{-   if not (kindIs "slice" .) }}
{{-     fail (printf "called quantum-lib function without global scope, expected [<arg>, $], got %s" (kindOf .)) }}
{{-   end }}
{{- end }}
