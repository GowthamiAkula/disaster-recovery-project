#!/bin/bash

PRIMARY_BUCKET="../data/primary_bucket"
DR_BUCKET="../data/dr_bucket"

echo "🔁 Starting replication..."

# Create DR bucket if not exists
mkdir -p $DR_BUCKET

# Find latest backup file
LATEST_FILE=$(ls -t $PRIMARY_BUCKET | head -n 1)

if [ -z "$LATEST_FILE" ]; then
  echo "❌ No backup found!"
  exit 1
fi

echo "📦 Latest backup: $LATEST_FILE"

# Copy to DR bucket
cp "$PRIMARY_BUCKET/$LATEST_FILE" "$DR_BUCKET/"

echo "✅ Replication completed to DR bucket!"
