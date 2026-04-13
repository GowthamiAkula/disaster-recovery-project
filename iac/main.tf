# Simulated Infrastructure

provider "aws" {
  region = "us-east-1"
}

# Primary bucket (simulated)
resource "aws_s3_bucket" "primary" {
  bucket = "my-app-backups-primary"
}

# DR bucket (simulated)
resource "aws_s3_bucket" "dr" {
  bucket = "my-app-backups-dr"
}
