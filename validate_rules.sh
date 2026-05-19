cat << 'EOF' > validate_rules.sh
#!/bin/bash
set -e

echo "=========================================="
echo "🛡️  Running Sigma Detection Validation 🛡️"
echo "=========================================="

if ! command -v sigma &> /dev/null; then
    echo "❌ Error: sigma-cli is not installed. Please rebuild your devcontainer."
    exit 1
fi

echo "🔍 Scanning for Sigma rules..."
for rule in $(find detections/ -name "*.yml" -o -name "*.yaml"); do
    echo "------------------------------------------"
    echo "📄 Checking: $rule"
    
    if sigma check "$rule" &> /dev/null; then
        echo "✅ Syntax: Valid"
    else
        echo "❌ Syntax: Invalid"
        sigma check "$rule"
        exit 1
    fi

    echo "⚙️  Testing OpenSearch Lucene compilation..."
    sigma convert -t opensearch_lucene -p aws "$rule" > /dev/null
    echo "🚀 Compilation: Successful"
done

echo "=========================================="
echo "🎉 All rules passed validation successfully!"
echo "=========================================="
EOF
