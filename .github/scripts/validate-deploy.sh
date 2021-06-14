#!/usr/bin/env bash

GIT_REPO=$(cat git_repo)
GIT_TOKEN=$(cat git_token)

mkdir -p .testrepo

git clone https://${GIT_TOKEN}@${GIT_REPO} .testrepo

cd .testrepo || exit 1

ls -l

if [[ ! -f "argocd/2-services/active/namespaces.yaml" ]]; then
  echo "ArgoCD config for namespace missing"
  exit 1
else
  echo "ArgoCD config for namespace found"
fi

cat argocd/2-services/active/namespaces.yaml

if [[ $(ls "payload/2-services/namespaces" | wc -l) -gt 0 ]]; then
  echo "Namespace config not found"
  exit 1
else
  echo "Namespace config found"
fi

ls payload/2-services/namespaces/
ls payload/2-services/namespaces/ | while read file;
do
  cat "payload/2-services/namespaces/${file}"
done

cd ..
rm -rf .testrepo
