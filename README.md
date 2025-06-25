# MongoDB

## values.yaml

```yaml
persistence:
  enabled: true
  size: 1Gi
  storageClass: "csi-cinder-high-speed"
```

Adaptez les valeurs de `size` et `storageClass` selon vos besoins.

## Déploiement de MongoDB

Le déploiement peut être réalisé en utilisant le script `install.sh`.

Ce script va :
- créer le secret `unikalo-mongodb-secret` contenant les identifiants de connexion. (Pensez à modifier ce nom sur le déploiement Meow si besoin)
- déployer MongoDB en utilisant ArgoCD