#!/bin/bash
# Comprehensive security check script
# Runs all security tools and checks

set -e

echo "🔒 Running comprehensive security checks..."

# Run the main security scan
./scripts/security-scan.sh

echo "🧹 Running code quality and security linting..."

# Run Ruff with security rules
echo "Running Ruff linting..."
ruff check . || true

echo "Running Ruff formatting check..."
ruff format --check . || true

# Run MyPy type checking (if available)
if command -v mypy &> /dev/null; then
    echo "Running MyPy type checking..."
    mypy . || true
fi

# Check for pre-commit hooks
echo "🪝 Checking pre-commit hooks..."
if [ -f ".pre-commit-config.yaml" ]; then
    if command -v pre-commit &> /dev/null; then
        echo "Running pre-commit checks..."
        pre-commit run --all-files || true
    else
        echo "Installing pre-commit..."
        pip install pre-commit
        pre-commit install
        pre-commit run --all-files || true
    fi
fi

# Check for secrets in git history
echo "🔍 Checking git history for secrets..."
if command -v trufflehog &> /dev/null; then
    trufflehog git file://. --only-verified || true
else
    echo "TruffleHog not installed - install from https://github.com/trufflesecurity/trufflehog"
fi

# Validate configuration files
echo "📄 Validating configuration files..."
if [ -f "pyproject.toml" ]; then
    python -c "import tomllib; tomllib.load(open('pyproject.toml', 'rb'))" && echo "✅ pyproject.toml is valid"
fi

if [ -f ".pre-commit-config.yaml" ]; then
    python -c "import yaml; yaml.safe_load(open('.pre-commit-config.yaml'))" && echo "✅ .pre-commit-config.yaml is valid"
fi

# Check for required security files
echo "📋 Checking for required security files..."
required_files=(
    ".gitignore"
    "SECURITY.md"
    "LICENSE"
    ".pre-commit-config.yaml"
    ".secrets.baseline"
    ".env.example"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing"
    fi
done

echo ""
echo "🎉 Comprehensive security check complete!"
echo "📊 Review all reports in the security-reports/ directory"
echo "🔧 Fix any issues found and re-run this script"