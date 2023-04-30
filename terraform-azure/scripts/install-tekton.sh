#!/bin/bash

# Install Tekton Pipelines
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

# Install Tekton Triggers
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml

# Install Tekton Dashboard with LoadBalancer type service
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml \
--overwrite=true \
--selector app=tekton-dashboard \
--set service.type=LoadBalancer