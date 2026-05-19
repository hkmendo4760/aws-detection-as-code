# 🛡️ Detection-as-Code (DaC) Automation Pipeline

## 🚀 Project Overview
An automated, cloud-native Detection-as-Code (DaC) CI/CD pipeline that validates, tests, and prepares Sigma detection rules for production deployment. This project automates syntax linting and query compilation using the OpenSearch Lucene backend, ensuring zero-day misconfigurations never reach production SIEM environments.

---

## 🛠️ Architecture & Flow

This pipeline provides an automated lifecycle for security analytics, moving rules seamlessly from an engineer's IDE to a validated state ready for ingestion.

```mermaid
graph LR
    A[VS Code / WSL / Codespaces] -- git push --> B(GitHub Repository)
    B --> C{GitHub Actions Trigger}
    subgraph CI/CD Runner Environment [Ubuntu-Latest]
        C -- Spin Up --> D[Python 3.11 Setup]
        D --> E[Install Sigma CLI & OpenSearch Plugin]
        E --> F[Execute validate_rules.sh]
    end
    F -- Pass --> G[🚀 Ready for OpenSearch Deployment]
    F -- Fail --> H[❌ Blocked / Pipeline Alert]

    style G fill:#238636,stroke:#fff,stroke-width:2px,color:#fff
    style H fill:#da3633,stroke:#fff,stroke-width:2px,color:#fff

---

---

## ⚙️ CI/CD Pipeline Implementation (The "How")

### The Challenge
Transitioning validation and compilation logic from generic or legacy security engines to highly specific target OpenSearch-compliant queries. During development, default compilers strictly require centralized processing pipelines for log-source mapping, which routinely breaks local validation suites and halts decoupled engineering workflows.

### The Solution
Designed and implemented a modular validation script (`validate_rules.sh`) coupled with a streamlined GitHub Actions continuous integration workflow. By explicitly executing compilation tests with the `--without-pipeline` flag, the pipeline successfully isolates and validates core detection logic independently from platform-specific delivery pipelines.

---

## 💻 Getting Started & Local Validation

To demonstrate the high reproducibility of this Detection-as-Code pipeline, you can run the validation suite locally within any Linux/WSL environment or a VS Code Dev Container.

### 1. Prerequisites

Ensure you have Python 3.11+ installed, then set up the required Sigma tooling and dependencies:

```bash
# Install core Sigma CLI and the OpenSearch backend plugin
pip3 install sigma-cli
sigma plugin install opensearch
