# ScamSnare

ScamSnare is a cybersecurity hobby project built with Elixir + Phoenix, designed to detect and help fix brittle web infrastructure — like exposed login panels and weak authentication.

🔒 Built by someone who just likes the idea of protecting people.

<br>

### ✨ Features
✅ Connects Phoenix to a background worker using RabbitMQ

🛡️ Sends messages to analyze potentially risky URLs

⚙️ Modular AMQP wrapper with support for mocking/tests via Mox

🚀 .env-driven config for secure, local development

💬 Plans to expand with a Rust-powered fingerprinting backend

<br/>

---
### 📦 Tech Stack
Phoenix – web interface and job orchestrator

RabbitMQ – messaging between Elixir and future Rust worker

Oban – background job processor (coming soon)

Dotenvy – secure local config

Docker – local RabbitMQ + Postgres setup

<br/>

### 📁 Project Goals
Help users identify weak points like /admin or /wp-login endpoints

Surface outdated sites and open ports

Suggest real fixes — not just vulnerability reports

Be free and open-source ❤️

<br/>

### 🧪 Run Locally

```bash
# Clone & enter the project
git clone https://github.com/YOUR_USERNAME/scam_snare.git
cd scam_snare

# Start Postgres & RabbitMQ
docker compose up -d

# Install Elixir deps
mix deps.get

# Run the server
mix phx.server
```


###🧠 Author
Built by a defensive-security-focused engineer learning Rust, growing Elixir skills, and exploring AI collaboration.
Wanna help out? PRs and ideas welcome!
