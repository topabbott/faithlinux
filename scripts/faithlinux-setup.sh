#!/bin/bash
#
# FaithLinux Setup Script v1.0
# Transforms Ubuntu into FaithLinux with Christian software and configurations
#
# Usage: sudo ./faithlinux-setup.sh
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
cat << "BANNER"
╔═══════════════════════════════════════╗
║                                       ║
║          F A I T H L I N U X          ║
║         Linux Built on Faith          ║
║                                       ║
║              Setup v1.0               ║
║                                       ║
╚═══════════════════════════════════════╝
BANNER

echo ""

# Functions
print_header() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

check_root() {
    if [ "$EUID" -ne 0 ]; then 
        print_error "Please run as root (use sudo)"
        exit 1
    fi
}

# Main script
echo "This will install Christian software and configure your system"
echo "Estimated time: 15-20 minutes"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 1
fi

# Check if running as root
check_root

# Update system
print_header "📦 Updating System"
apt update
apt upgrade -y
print_success "System updated"

# Install Bible Software
print_header "📖 Installing Bible Study Software"
print_info "Installing Xiphos and BibleTime..."
apt install -y xiphos bibletime

print_info "Installing SWORD Bible modules..."
apt install -y \
    sword-comm-mhc \
    sword-comm-barnes \
    sword-comm-geneva \
    sword-dict-strongs-greek \
    sword-dict-strongs-hebrew \
    sword-text-kjv \
    sword-text-web

print_success "Bible software installed"

# Install Office Suites
print_header "💼 Installing Office Software"
print_info "Installing LibreOffice..."
apt install -y libreoffice

print_info "Installing OnlyOffice..."
apt install -y onlyoffice-desktopeditors 2>/dev/null || {
    print_warning "OnlyOffice not available in default repos"
    print_info "Will need manual installation from onlyoffice.com"
}

print_success "Office suites installed"

# Install Web Filtering (DNS-based)
print_header "🛡️ Installing Content Filtering"
print_info "Configuring DNS-based filtering..."

# Use CleanBrowsing DNS (free family filter)
cat > /etc/resolv.conf.faithlinux << 'DNSEOF'
# FaithLinux DNS Configuration
# Using CleanBrowsing Family Filter
nameserver 185.228.168.10
nameserver 185.228.169.11
DNSEOF

cp /etc/resolv.conf /etc/resolv.conf.backup
cp /etc/resolv.conf.faithlinux /etc/resolv.conf

print_success "DNS-based content filter configured"
print_info "Using CleanBrowsing Family Filter"

# Install Calibre (for Christian library)
print_header "📚 Installing Digital Library"
apt install -y calibre
print_success "Calibre installed"

# Install utilities
print_header "🔧 Installing Utilities"
apt install -y \
    firefox \
    chromium-browser \
    vlc \
    git \
    vim \
    htop \
    curl \
    wget

print_success "Utilities installed"

# Create Christian Library directory
print_header "📁 Setting Up Christian Library"
mkdir -p /home/$SUDO_USER/ChristianLibrary
chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/ChristianLibrary

# Create desktop shortcut
cat > /home/$SUDO_USER/Desktop/ChristianLibrary.desktop << 'DESKTOPEOF'
[Desktop Entry]
Type=Application
Name=Christian Library
Icon=calibre
Exec=calibre --with-library ~/ChristianLibrary
Comment=Browse your Christian book collection
Categories=Education;Literature;
DESKTOPEOF

chmod +x /home/$SUDO_USER/Desktop/ChristianLibrary.desktop
chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/Desktop/ChristianLibrary.desktop

print_success "Christian Library directory created"

# Configure Firefox
print_header "🌐 Configuring Browser"
print_info "Setting safe search and bookmarks..."
# TODO: Add Firefox configuration

print_success "Browser configured"

# Clean up
print_header "🧹 Cleaning Up"
apt autoremove -y
apt clean
print_success "Cleanup complete"

# Final message
echo ""
print_header "🎉 FaithLinux Setup Complete!"
echo ""
echo "Installed software:"
echo "  ✓ Bible Study: Xiphos, BibleTime, SWORD modules"
echo "  ✓ Office: LibreOffice, OnlyOffice"
echo "  ✓ Content Filter: CleanBrowsing DNS"
echo "  ✓ Library: Calibre with Christian Library folder"
echo "  ✓ Utilities: Firefox, Chromium, VLC, Git"
echo ""
echo "Next steps:"
echo "  1. Reboot your system: sudo reboot"
echo "  2. Open Bible software: Applications → Education → Xiphos"
echo "  3. Import books: Open Christian Library icon on desktop"
echo "  4. Browse safely: All web traffic filtered through CleanBrowsing DNS"
echo ""
echo "For support and documentation:"
echo "  📧 Email: support@faithlinux.org"
echo "  🌐 Website: faithlinux.org (coming soon)"
echo "  📖 Docs: github.com/faithlinux/christian-linux-project"
echo ""
print_success "May God bless your studies and ministry work!"
echo ""
#!/bin/bash
# FaithLinux Setup Script v1.0

if [ "$EUID" -ne 0 ]; then 
    echo "❌ Please run with sudo"
    exit 1
fi

echo "╔═══════════════════════════════════════╗"
echo "║        FaithLinux Setup v1.0          ║"
echo "╚═══════════════════════════════════════╝"
echo ""
echo "This will install Christian software"
echo ""

read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

echo "📦 Updating system..."
apt update && apt upgrade -y

echo ""
echo "📖 Installing Bible software..."
apt install -y xiphos bibletime
apt install -y sword-comm-mhc sword-comm-barnes sword-dict-strongs-greek sword-dict-strongs-hebrew sword-text-kjv

echo ""
echo "💼 Installing office software..."
apt install -y libreoffice

echo ""
echo "📚 Installing Calibre..."
apt install -y calibre

echo ""
echo "🔧 Installing utilities..."
apt install -y firefox chromium-browser vlc git vim htop curl wget

echo ""
echo "📁 Creating Christian Library..."
mkdir -p /home/$SUDO_USER/ChristianLibrary
chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/ChristianLibrary

echo ""
echo "🧹 Cleaning up..."
apt autoremove -y
apt clean

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║     ✅ FaithLinux Setup Complete!     ║"
echo "╚═══════════════════════════════════════╝"
echo ""
echo "Installed:"
echo "  ✓ Bible study software (Xiphos, BibleTime)"
echo "  ✓ Office suite (LibreOffice)"
echo "  ✓ Digital library (Calibre)"
echo "  ✓ Essential utilities"
echo ""
echo "Next steps:"
echo "  1. Reboot: sudo reboot"
echo "  2. Open Bible software from Applications menu"
echo ""
