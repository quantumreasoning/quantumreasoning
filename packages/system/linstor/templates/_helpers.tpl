{{- define "quantum.linstor.version" -}}
{{- $piraeusConfigMap := lookup "v1" "ConfigMap" "quantum-linstor" "piraeus-operator-image-config"}}
{{- if not $piraeusConfigMap }}
  {{- fail "Piraeus controller is not yet installed, ConfigMap quantum-linstor/piraeus-operator-image-config is missing" }}
{{- end }}
{{- $piraeusImagesConfig := $piraeusConfigMap | dig "data" "0_piraeus_datastore_images.yaml" nil | required "No image config" | fromYaml }}
base: {{ $piraeusImagesConfig.base | required "No image base in piraeus config" }}
controller:
  image: {{ $piraeusImagesConfig | dig "components" "linstor-controller" "image" nil | required "No controller image" }}
  tag: {{ $piraeusImagesConfig | dig "components" "linstor-controller" "tag" nil | required "No controller tag" }}
satellite:
  image: {{ $piraeusImagesConfig | dig "components" "linstor-satellite" "image" nil | required "No satellite image" }}
  tag: {{ $piraeusImagesConfig | dig "components" "linstor-satellite" "tag" nil | required "No satellite tag" }}
{{- end -}}

{{- define "quantum.linstor.version.controller" -}}
{{- $version := (include "quantum.linstor.version" .) | fromYaml }}
{{- printf "%s/%s:%s" $version.base $version.controller.image $version.controller.tag }}
{{- end -}}

{{- define "quantum.linstor.version.satellite" -}}
{{- $version := (include "quantum.linstor.version" .) | fromYaml }}
{{- printf "%s/%s:%s" $version.base $version.satellite.image $version.satellite.tag }}
{{- end -}}
