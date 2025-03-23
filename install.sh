#!/bin/sh

read -p "Entrez le nom de l'application (APP_NAME) : " APP_NAME
read -p "Entrez le nom du projet ArgoCD (PROJECT_NAME) : " PROJECT_NAME
read -p "Entrez le nom du secret Kubernetes (SECRET_NAME) : " SECRET_NAME
read -p "Entrez le namespace Kubernetes (NAMESPACE) : " NAMESPACE
read -p "Entrez le nom de l'utilisateur MongoDB (USER_NAME) : " USER_NAME
read -p "Entrez le nom de la base de données MongoDB (DATABASE_NAME) : " DATABASE_NAME
read -p "Entrez le mot de passe root de la base de données (DATABASE_ROOT_PASS) : " DATABASE_ROOT_PASS
read -p "Entrez le mot de passe utilisateur de la base de données (DATABASE_USER_PASS) : " DATABASE_USER_PASS

sed -i '' "s/APP_NAME/$APP_NAME/g" app.yaml
sed -i '' "s/PROJECT_NAME/$PROJECT_NAME/g" app.yaml
sed -i '' "s/SECRET_NAME/$SECRET_NAME/g" app.yaml
sed -i '' "s/NAMESPACE/$NAMESPACE/g" app.yaml
sed -i '' "s/USER_NAME/$USER_NAME/g" app.yaml
sed -i '' "s/DATABASE_NAME/$DATABASE_NAME/g" app.yaml

kubectl create secret generic "$SECRET_NAME" -n "$NAMESPACE" \
  --from-literal=mongodb-root-password="$DATABASE_ROOT_PASS" \
  --from-literal=mongodb-passwords="$DATABASE_USER_PASS" \
  --from-literal=mongodb-uri="mongodb://root:$DATABASE_ROOT_PASS@$APP_NAME.$NAMESPACE.svc.cluster.local:27017"

kubectl apply -f app.yaml -n argocd

echo "Déploiement terminé avec succès."

git add .
git commit -m "Update app.yaml"
git push

echo "Le fichier app.yaml a été mis à jour sur Github."
