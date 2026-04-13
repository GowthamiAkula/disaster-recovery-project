#!/bin/bash

PRIMARY_BUCKET="../data/primary_bucket"
DB_PATH="../data/primary/application.db"
BACKUP_NAME="backup-$(date +%Y%m%d-%H%M%S).db.gz"

echo "📦 Starting backup..."

# Create bucket folder if not exists
mkdir -p $PRIMARY_BUCKET

# Check DB exists
if [ ! -f "$DB_PATH" ]; then
  echo "❌ Database not found!"
  exit 1
fi

# Compress DB
gzip -c "$DB_PATH" > "$BACKUP_NAME"

echo "✅ Database compressed: $BACKUP_NAME"

# Copy to "bucket"
cp "$BACKUP_NAME" "$PRIMARY_BUCKET/"

echo "☁ Backup stored in local bucket"

# Cleanup
rm "$BACKUP_NAME"

echo "Backup completed successfully!"
