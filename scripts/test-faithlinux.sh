#!/bin/bash
# FaithLinux Component Test Script

echo "╔═══════════════════════════════════════╗"
echo "║   FaithLinux Component Verification   ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Test function
test_cmd() {
    if command -v $1 &> /dev/null; then
        echo "✅ $2"
    else
        echo "❌ $2 NOT FOUND"
    fi
}

echo "📖 Bible Software:"
test_cmd xiphos "  Xiphos"
test_cmd bibletime "  BibleTime"

echo ""
echo "💼 Office Software:"
test_cmd libreoffice "  LibreOffice"

echo ""
echo "📚 Digital Library:"
test_cmd calibre "  Calibre"
if [ -d "$HOME/ChristianLibrary" ]; then
    echo "✅   Christian Library folder exists"
else
    echo "❌   Christian Library folder NOT FOUND"
fi

echo ""
echo "🔧 Utilities:"
test_cmd firefox "  Firefox"
test_cmd git "  Git"
test_cmd vim "  Vim"

echo ""
echo "═══════════════════════════════════════"
echo "Test complete!"
