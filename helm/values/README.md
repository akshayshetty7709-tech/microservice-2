# Per-service values

Each of the 18 microservices gets a small values file here that overrides
only what differs from `locate360-service/values.yaml` (name, image repo,
ingress host, Vault secret path). Jenkins loops over this directory and runs:

    helm upgrade --install <service-name> ./helm/locate360-service \
      -f ./helm/values/<service-name>.yaml \
      --set image.tag=$BUILD_TAG

Add one file per service, e.g. auth-service.yaml, search-service.yaml,
review-service.yaml, notification-service.yaml, etc. — naming must match
the SERVICES list in the Jenkinsfile.
