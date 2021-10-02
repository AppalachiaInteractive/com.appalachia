#!/usr/bin/env bash

npm-cli-login -u "$NPM_USER" -p "$NPM_PASS" -e "$NPM_EMAIL" -r "$NPM_REGISTRY"

npm whoami --registry "$NPM_REGISTRY"
