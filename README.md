# Roboshop Deployment using Shell Scripting

This repository demonstrates the deployment of the **Roboshop microservices application** using Shell scripting.

The project focuses on automating application setup and configuration on a Linux server using Bash scripts, forming the foundation for advanced DevOps tools like Ansible and Terraform.

---

## Project Overview

Roboshop is a **microservices-based e-commerce application** consisting of multiple services such as:

- Web (Frontend)
- Catalogue
- User
- Cart
- Shipping
- Payment
- Dispatch

Each service is installed and configured using **individual shell scripts** or a combined automation script.

---

## Tech Stack

- Linux
- Bash (Shell Scripting)
- Git & GitHub

---

## Architecture

- All services can be deployed on a **single server** or multiple servers
- Backend services connect to databases like:

  - MongoDB
  - MySQL
  - Redis
  - RabbitMQ
- Nginx is used as a frontend web server

---

## Key Features

- Automated service setup using shell scripts
- Modular scripts for each microservice
- Easy to understand and execute
- Foundation for configuration management tools

---

## Setup & Execution

### Clone the Repository

```bash
git clone https://github.com/Jayani22/shell-roboshop.git
cd shell-roboshop
```

---

### Give Execute Permission

```bash
chmod +x *.sh
```

---

### Run Individual Service

```bash
./catalogue.sh
```

---

### Run Full Setup

```bash
./all.sh
```

---

## Example Script Snippet

```bash
#!/bin/bash

echo "Installing Nginx..."
sudo apt install nginx -y

echo "Starting Nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx
```

---

## Learning Outcomes

Through this project, I gained hands-on experience in:

- Writing shell scripts for automation
- Installing and configuring services
- Understanding application dependencies
- Managing Linux-based deployments

---

## Future Enhancements

- Convert scripts into Ansible playbooks
- Integrate with Docker for containerization
- Automate infrastructure using Terraform
- Add logging and error handling
---

## Note

This project is part of my DevOps learning journey, focusing on understanding how real-world applications are deployed manually before moving to advanced automation tools.

