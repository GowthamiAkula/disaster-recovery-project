# Multi-Region Cloud Disaster Recovery Automation Framework

## 📌 Project Overview

This project implements a **Disaster Recovery (DR) system** that ensures application availability during failures. It simulates a **multi-region cloud environment** using Docker containers and automation scripts.

The system automatically performs:

* Data backup
* Backup replication
* Failure detection
* Failover to Disaster Recovery (DR) system

---

## 🎯 Objectives

* Ensure high availability of application
* Minimize downtime (RTO)
* Minimize data loss (RPO)
* Automate recovery process

---

## 🧠 Architecture Overview

### Primary Region

* Flask Application (Primary)
* SQLite Database
* Backup Storage

### Disaster Recovery (DR) Region

* DR Flask Application
* Restored Database
* Replicated Backup Storage

---

## 🛠️ Technologies Used

* **Python (Flask)** – Web application
* **Docker & Docker Compose** – Containerization
* **Shell Scripting (Bash)** – Automation
* **SQLite** – Database
* **Terraform (IaC)** – Infrastructure simulation

---

## 📂 Project Structure

```
project_root/
│
├── app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── scripts/
│   ├── backup.sh
│   ├── replicate_storage.sh
│   ├── replicate_compute.sh
│   └── dr.sh
│
├── iac/
│   └── main.tf
│
├── data/
│   ├── primary/
│   ├── dr/
│   ├── primary_bucket/
│   └── dr_bucket/
│
├── docker-compose.yml
├── .env.example
├── README.md
└── DR_METRICS.md
```

---

## ⚙️ Setup Instructions

### 1️⃣ Clone / Open Project

```bash
cd disaster-recovery-project
```

---

### 2️⃣ Start Application

```bash
docker-compose up -d --build
```

---

### 3️⃣ Verify Application

Open browser:

```
http://localhost:5001/health
```

Expected:

```json
{"status":"ok"}
```

---

## 🧪 Application Testing

### ➤ Write Data

```bash
curl -X POST http://localhost:5001/write
```

---

### ➤ Read Data

```bash
curl http://localhost:5001/data
```

---

## 💾 Backup Process

### Run Backup Script

```bash
cd scripts
./backup.sh
```

✔ Creates compressed database backup
✔ Stores in `data/primary_bucket`

---

## 🔁 Replication Process

### Run Replication Script

```bash
./replicate_storage.sh
```

✔ Copies latest backup
✔ Moves to `data/dr_bucket`

---

## 🔄 Failover Process (Disaster Simulation)

### Step 1: Stop Primary Application

```bash
docker-compose stop primary_app
```

---

### Step 2: Run Failover Script

```bash
./dr.sh --failover
```

---

### Step 3: Verify DR Application

```bash
curl http://localhost:5002/data
```

✔ Data should be restored successfully

---

## 📊 Disaster Recovery Workflow

1. Application runs in Primary Region
2. Data is written to database
3. Backup script creates compressed backup
4. Replication script copies backup to DR
5. Primary failure is simulated
6. Failover script restores data in DR
7. DR application becomes active

---

## ⏱️ DR Metrics

### Recovery Time Objective (RTO)

* Target: 2 minutes
* Measured: ~30 seconds

### Recovery Point Objective (RPO)

* Minimal data loss (depends on backup frequency)

---

## 🔐 Environment Configuration

Defined in `.env.example`

Includes:

* Region names
* Bucket names
* Database paths
* Credentials (dummy values)

---

## 📦 Infrastructure as Code (IaC)

* Defined using Terraform (`iac/main.tf`)
* Simulates:

  * Primary storage
  * DR storage

---

## 🚨 Failover Features

* Detects primary failure
* Restores latest backup
* Starts DR application
* Validates system health
* Outputs new active endpoint

---

## ✅ Key Features

* Automated backup system
* Cross-region replication
* Disaster recovery simulation
* Zero manual intervention during failover
* Containerized environment
* End-to-end validation

---

## 🧪 End-to-End Test Scenario

1. Start system
2. Write data
3. Run backup
4. Run replication
5. Stop primary
6. Trigger failover
7. Verify DR data

---

## 🎯 Conclusion

This project successfully demonstrates a **complete disaster recovery lifecycle** including:

* Backup
* Replication
* Failover
* Data restoration

It ensures **business continuity** and **high availability** in case of failures.

---

## 👩‍💻 Author

Gowthami Akula