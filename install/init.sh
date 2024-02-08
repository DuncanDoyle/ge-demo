#!/bin/sh

####################################################################################
#
# Initiates the GE Demo
#
# Requires an existing Gloo Edge 1.15+ setup with ExtAuth and RateLimiting.
# Requires the glooctl CLI to be installed.
#
####################################################################################

pushd ../

# Apply the HTTPBin sevice
kubectl apply -f apis/httpbin.yaml

# Setup ExtAuth and RateLimit configurations
kubectl apply -f policies/extauth/auth-config.yaml
kubectl apply -f policies/ratelimit/ratelimit-config.yaml

# Create the ApiKeys for the extauth and ratelimit test-runs
policies/extauth/create-apikey.sh
policies/extauth/create-apikey-for-ratelimit.sh
policies/extauth/create-apikey-for-ratelimit-warmup.sh

# Apply the VirtualService
kubectl apply -f virtualservices/api-example-com-vs-extauth-rl.yaml

popd