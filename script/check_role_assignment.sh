#!/usr/bin/env bash

set -e

SCOPE="$1"
ROLE="$2"
PRINCIPAL_ID="$3"

ASSIGNMENTS=$(az role assignment list \
  --scope "$SCOPE" \
  --role "$ROLE" \
  --assignee "$PRINCIPAL_ID" \
  --query [].id \
  --output tsv)

if [ -z "$ASSIGNMENTS" ]; then
  echo '{"exists": "false"}'
else
  echo '{"exists": "true"}'
fi
