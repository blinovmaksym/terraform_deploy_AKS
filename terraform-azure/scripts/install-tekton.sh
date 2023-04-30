#!/bin/bash

# Install Tekton Pipelines
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

# Install Tekton Triggers
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml

# Install Tekton Dashboard with LoadBalancer type service
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml

# Update Tekton Dashboard service to use LoadBalancer
kubectl patch service tekton-dashboard -n tekton-pipelines --type='json' -p '[{"op":"replace","path":"/spec/type","value":"LoadBalancer"}]'

if ! curl -s -H "Authorization: token $TOKEN_TEKTON" https://api.github.com/user/keys | grep -q "Tekton SSH Key"; then
    ssh-keygen -t rsa -b 4096 -C "tekton@tekton.dev" -f tekton_key
    # save as tekton / tekton_key.pub
    # Get the public key contents
    public_key=$(cat tekton_key.pub)
    # Create a new SSH key on GitHub
    curl -X POST -H "Authorization: token $TOKEN_TEKTON" -d '{"title":"Tekton SSH Key","key":"'"${public_key}"'"}' https://api.github.com/user/keys

    # # create secret YAML from contents
    cat tekton_key | base64 -w 0 > tekton_key_base64.txt
    cat > tekton-git-ssh-secret.yaml << EOM
apiVersion: v1
kind: Secret
metadata:
name: git-ssh-key
namespace: tekton-pipelines
annotations:
    tekton.dev/git-0: github.com
type: kubernetes.io/ssh-auth
data:
ssh-privatekey: $(cat tekton_key_base64.txt)
---
EOM

kubectl apply -f tekton-git-ssh-secret.yaml
else    
    # Tekton SSH key exists on GitHub, skip generating and adding it
    echo "Tekton SSH key already exists on GitHub"

fi   
# # create your Docker registry secret, for example:
# cat ~/.docker/config.json | base64 -w 0
# cat > regsecret.yaml << EOM
# kind: Secret
# apiVersion: v1
# metadata:
#   name: regsecret
# data:
#   .dockercfg: <base 64 data>
# type: kubernetes.io/dockercfg
# EOM

# kubectl apply -n tekton-pipelines -f regsecret.yaml

kubectl apply -f tekton/