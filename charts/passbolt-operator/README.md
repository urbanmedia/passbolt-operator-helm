# passbolt-operator

![Version: 1.2.3](https://img.shields.io/badge/Version-1.2.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.3.0](https://img.shields.io/badge/AppVersion-v1.3.0-informational?style=flat-square)

A Helm chart to deploy the Passbolt Operator. The Passbolt Operator is a Kubernetes Operator to manage Passbolt Secrets in Kubernetes (Passbolt --> Kubernetes secret).

## Installation

### Add Helm repository

```bash
helm repo add passbolt-operator https://urbanmedia.github.io/passbolt-operator-helm
```

### Install the operator

First, create the namespace where the operator will be installed:

```bash
kubectl create namespace passbolt-operator-system
```

Then, create the secret containing the Passbolt API credentials:

```bash
kubectl create secret generic controller-passbolt-secret \
  --from-file=gpg_key='/path/to/gpg.key' \
  --from-literal=password='<my-user-password>' \
  --from-literal=url='<my-passbolt-url>' \
  --namespace system
```

Finally, install the operator:

```bash
helm install \
  passbolt-operator passbolt-operator/passbolt-operator \
  -n passbolt-operator-system
```

### Upgrading from previous major version

Since the operator is installed along with the CRDs, you need to force the upgrade to ensure the CRDs are updated:

```bash
helm upgrade \
  passbolt-operator passbolt-operator/passbolt-operator \
  -n passbolt-operator-system \
  --force
```

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| leonsteinhaeuser | <leonsteinhaeuser@gmail.com> | <https://github.com/leonsteinhaeuser> |
| f-pietsch | <falk.pietsch@tagesspiegel.de> | <https://github.com/f-pietsch> |
| helgebonert | <helge.bonert@tagesspiegel.de> | <https://github.com/helgebonert> |

## Requirements

| Repository | Name | Version |
|------------|------|---------|

## Values

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity to use for the deployment |
| fullnameOverride | string | `""` | Full name to use for the deployment |
| imagePullSecrets | list | `[]` | Image pull secrets |
| monitoring | object | `{"enabled":false,"rbacProxy":{"image":{"pullPolicy":"IfNotPresent","repository":"gcr.io/kubebuilder/kube-rbac-proxy","tag":"v0.13.0"},"resources":{}},"serviceMonitor":{"enabled":false,"namespace":""}}` | Monitoring configuration |
| monitoring.enabled | bool | `false` | Enable Prometheus Operator Monitoring |
| monitoring.rbacProxy | object | `{"image":{"pullPolicy":"IfNotPresent","repository":"gcr.io/kubebuilder/kube-rbac-proxy","tag":"v0.13.0"},"resources":{}}` | RBAC Proxy configuration |
| monitoring.rbacProxy.image | object | `{"pullPolicy":"IfNotPresent","repository":"gcr.io/kubebuilder/kube-rbac-proxy","tag":"v0.13.0"}` | Image to use for the RBAC Proxy |
| monitoring.rbacProxy.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| monitoring.rbacProxy.image.repository | string | `"gcr.io/kubebuilder/kube-rbac-proxy"` | Image repository |
| monitoring.rbacProxy.image.tag | string | `"v0.13.0"` | Tag overrides the image tag whose default is the chart appVersion. |
| monitoring.rbacProxy.resources | object | `{}` | RBAC Proxy resource configuration |
| monitoring.serviceMonitor | object | `{"enabled":false,"namespace":""}` | ServiceMonitor configuration |
| monitoring.serviceMonitor.enabled | bool | `false` | Enable ServiceMonitor |
| monitoring.serviceMonitor.namespace | string | `""` | Service Monitor namespace |
| nameOverride | string | `""` | Name to use for the deployment |
| nodeSelector | object | `{}` | Node selector to use for the deployment |
| podAnnotations | object | `{}` | Pod annotations to add to the deployment |
| rbacProxy | object | `{"resources":{"limits":{"cpu":"500m","memory":"128Mi"},"requests":{"cpu":"5m","memory":"64Mi"}}}` | rbac proxy configuration |
| rbacProxy.resources | object | `{"limits":{"cpu":"500m","memory":"128Mi"},"requests":{"cpu":"5m","memory":"64Mi"}}` | resource configuration |
| replicaCount | int | `1` | Replicas count |
| resources | object | `{"limits":{"cpu":"500m","memory":"128Mi"},"requests":{"cpu":"10m","memory":"64Mi"}}` | Controller container resource configuration |
| secret | object | `{"name":"","passbolt":{"gpgKey":"","password":"","url":""}}` | Secret configuration to authenticate with the Passbolt API |
| secret.name | string | `""` | Name of the secret to use If not set, we expect the user to pass in the credentials via the values file |
| secret.passbolt | object | `{"gpgKey":"","password":"","url":""}` | The passbolt API authentication configuration |
| secret.passbolt.gpgKey | string | `""` | The passbolt API User GPG key |
| secret.passbolt.password | string | `""` | The passbolt API User passphrase |
| secret.passbolt.url | string | `""` | The passbolt API URL |
| serviceAccount | object | `{"annotations":{},"name":""}` | Service account to use for the deployment |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set, a name is generated using the fullname template |
| tolerations | list | `[]` | Tolerations to use for the deployment |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
