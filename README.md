Project Overview
A brief 2–3 sentence executive summary explaining what the project is and why it exists.

Example: "An automated, cloud-native Detection-as-Code (DaC) CI/CD pipeline that validates, tests, and prepares Sigma detection rules for production deployment. This project automates syntax linting and query compilation using the OpenSearch Lucene backend, ensuring zero-day misconfigurations never reach production SIEM environments."

🛠️ Architecture & Flow
This is where your technical design shines. Break it down into clear stages:

Authoring: Writing rules in standard YAML/Sigma format using VS Code/WSL.

Validation (CI): GitHub Actions triggers on every push or PR to main.

Compilation: pySigma environment spins up, validates syntax, and test-compiles the rule using --without-pipeline flags for the opensearch_lucene target backend.

💻 CI/CD Pipeline Implementation (The "How")
Briefly highlight the engineering hurdles you overcame to show your depth:

The Challenge: Transitioning compilation logic from non-supported enterprise engines to target OpenSearch-compliant queries while bypassing rigid log-source mapping constraints during development.

The Solution: Implemented a modular validation script (validate_rules.sh) coupled with a streamlined GitHub Actions workflow targeting specific backend compiler flags (--without-pipeline).

## 💻 Getting Started & Local Validation

To demonstrate the reproducibility of this Detection-as-Code pipeline, you can run the validation suite locally within a Linux/WSL environment or a VS Code Dev Container.

### Prerequisites

Ensure you have Python 3.11+ installed, then set up the required Sigma tooling:

```bash
# Install core Sigma CLI and the OpenSearch backend plugin
pip3 install sigma-cli
sigma plugin install opensearch
