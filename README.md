# passbolt-operator-helm

A repository that contains the Helm chart for the Passbolt operator

## Installation

If you want to install the Passbolt Operator with Helm, you need to first add the Helm repository:

```bash
helm repo add passbolt-operator https://urbanmedia.github.io/passbolt-operator-helm
```

Before installing the Passbolt Operator, make sure that you have created the `controller-passbolt-secret` secret in the corresponding namespace. When the secret is created, you can install the Passbolt Operator with the following command:

```bash
helm install \
  passbolt-operator passbolt-operator/passbolt-operator \
  -n passbolt-operator-system
```
