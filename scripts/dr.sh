#!/bin/bash

# Argument handling
if [ "$1" == "--help" ]; then
  echo "Usage: ./dr.sh --failover"
  exit 0
fi

if [ "$1" != "--failover" ]; then
  echo "❌ Invalid argument"
  echo "Usage: ./dr.sh --failover"
  exit 1
fi
DR_BUCKET="../data/dr_bucket"
DR_DB_PATH="../data/dr/application.db"

echo "🚨 Starting Disaster Recovery Failover..."

# Step 1: Check primary health
echo "🔍 Checking primary application..."

curl -f http://localhost:5001/health > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "❌ Primary is still running! Stop it first."
  exit 1
fi

echo "✅ Primary is down. Proceeding..."

# Step 2: Get latest backup
LATEST_FILE=$(ls -t $DR_BUCKET | head -n 1)

if [ -z "$LATEST_FILE" ]; then
  echo "❌ No backup found in DR bucket!"
  exit 1
fi

echo "📦 Restoring from: $LATEST_FILE"

# Step 3: Restore database
gunzip -c "$DR_BUCKET/$LATEST_FILE" > "$DR_DB_PATH"

echo "✅ Database restored to DR"

# Step 4: Start DR app
echo "🚀 Starting DR application..."

docker-compose up -d --scale dr_app=1 dr_app

sleep 5

# Step 5: Check DR health
echo "🔍 Checking DR application..."

curl -f http://localhost:5002/health > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "🎉 FAILOVER SUCCESSFUL!"
  echo "🌐 New Active URL: http://localhost:5002"
else
  echo "❌ DR app failed to start"
fi
