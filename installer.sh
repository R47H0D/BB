#!/bin/bash -i

# === Bersecbbt UNIVERSAL ===
# More than 90+ tools — modern & clean
# Ubuntu, Debian, Kali — 2025 ready
# Thanks to the InfoSec community ❤️

# === CONFIG ===

TOOLS_DIR=~/tools
GOVER=1.22.4
AMASSVER=3.25.0
AQUATONEVER=1.7.0
PPFUZZVER=1.2.1
KITERUNNERVER=1.0.2
TRUFFLEHOGVER=3.72.0
GOWITNESSVER=2.5.0

BLUE="\e[34m"
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

# === START ===

clear
echo -e "${BLUE}[*] Starting Bersecbbt — more than 90+ tools!${RESET}\n"

# Check root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[ERROR] Run as root!${RESET}"
  exit 1
fi

# Banner
mkdir -p $TOOLS_DIR
cat << "EOF"

██████╗ ███████╗██████╗ ███████╗███████╗ ██████╗
██╔══██╗██╔════╝██╔══██╗██╔════╝██╔════╝██╔═══██╗
██████╔╝█████╗  ██████╔╝███████╗█████╗  ██║  
██╔══██╗██╔══╝  ██╔══██╗╚════██║██╔══╝  ██║   ██║
██████╔╝███████╗██║  ██║███████║███████╗╚██████╔╝
╚═════╝ ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝

Master Bug Bounty Installer 
Thanks to the InfoSec community ❤️

EOF

# === ENVIRONMENT SETUP ===

echo -e "${BLUE}[ENV] Installing core packages...${RESET}"
apt-get update -y && apt-get install -y \
  python3 python3-pip unzip make gcc git curl jq nmap sqlmap tmux build-essential \
  libpcap-dev libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev ruby \
  libgmp-dev zlib1g-dev wfuzz nikto ripgrep ruby-full gem chromium-browser || apt-get install chromium

# Golang
echo -e "${BLUE}[ENV] Installing Golang...${RESET}"
cd /tmp && curl -O https://dl.google.com/go/go${GOVER}.linux-amd64.tar.gz
tar -C /usr/local -xzf go${GOVER}.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc

# === SUBDOMAINS ENUMERATION ===

go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/tomnomnom/assetfinder@latest
cd /tmp && wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux.zip && unzip findomain-linux.zip && chmod +x findomain && mv findomain /usr/local/bin/findomain
go install github.com/gwen001/github-subdomains@latest
go install github.com/gwen001/gitlab-subdomains@latest
cd /tmp && wget https://github.com/OWASP/Amass/releases/download/v${AMASSVER}/amass_linux_amd64.zip && unzip amass_linux_amd64.zip && mv amass_linux_amd64/amass /usr/local/bin/amass
go install github.com/cgboal/sonarsearch/cmd/crobat@latest

# === DNS TOOLS ===

git clone https://github.com/blechschmidt/massdns.git $TOOLS_DIR/massdns && cd $TOOLS_DIR/massdns && make && ln -s $TOOLS_DIR/massdns/bin/massdns /usr/local/bin/massdns
go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install github.com/d3mondev/puredns/v2@latest

# === HTTP PROBES ===

go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/tomnomnom/httprobe@latest

# === VISUAL RECON ===

cd /tmp && wget https://github.com/michenriksen/aquatone/releases/download/v${AQUATONEVER}/aquatone_linux_amd64_${AQUATONEVER}.zip && unzip aquatone_linux_amd64_${AQUATONEVER}.zip && mv aquatone /usr/local/bin/aquatone
cd /tmp && wget https://github.com/sensepost/gowitness/releases/download/${GOWITNESSVER}/gowitness-${GOWITNESSVER}-linux-amd64 && mv gowitness-${GOWITNESSVER}-linux-amd64 /usr/local/bin/gowitness && chmod +x /usr/local/bin/gowitness

# === NETWORK SCANNER ===

apt-get install -y nmap
git clone https://github.com/robertdavidgraham/masscan $TOOLS_DIR/masscan && cd $TOOLS_DIR/masscan && make && make install
go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install github.com/s0md3v/smap/cmd/smap@latest

# === WEB CRAWLING ===

go install github.com/jaeles-project/gospider@latest
go install github.com/hakluke/hakrawler@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest

# === PARAMETER DISCOVERY ===

pip3 install arjun
cd /tmp && wget https://github.com/Sh1Yo/x8/releases/download/v0.9.4/x86_64-linux-x8.gz && gzip -d x86_64-linux-x8.gz && chmod +x x86_64-linux-x8 && mv x86_64-linux-x8 /usr/local/bin/x8

# === JS HUNTING ===

git clone https://github.com/GerbenJavado/LinkFinder.git $TOOLS_DIR/LinkFinder && cd $TOOLS_DIR/LinkFinder && pip3 install -r requirements.txt && python3 setup.py install
git clone https://github.com/m4ll0k/SecretFinder.git $TOOLS_DIR/SecretFinder && cd $TOOLS_DIR/SecretFinder && pip3 install -r requirements.txt
go install github.com/lc/subjs@latest
git clone https://github.com/xnl-h4ck3r/xnLinkFinder.git $TOOLS_DIR/xnLinkFinder && cd $TOOLS_DIR/xnLinkFinder && python3 setup.py install

# === XSS ===

go install github.com/hahwul/dalfox/v2@latest
git clone https://github.com/s0md3v/XSStrike.git $TOOLS_DIR/XSStrike && cd $TOOLS_DIR/XSStrike && pip3 install -r requirements.txt
go install github.com/tomnomnom/hacks/kxss@latest

# === FUZZING ===

go install github.com/ffuf/ffuf@latest
go install github.com/OJ/gobuster/v3@latest
apt-get install -y wfuzz
go install github.com/musana/fuzzuli@latest

# === PROTOTYPE POLLUTION ===

cd /tmp && wget https://github.com/dwisiswant0/ppfuzz/releases/download/v${PPFUZZVER}/ppfuzz-v${PPFUZZVER}-x86_64-unknown-linux-musl.tar.gz && tar -zxvf ppfuzz-v${PPFUZZVER}-x86_64-unknown-linux-musl.tar.gz && mv ppfuzz /usr/local/bin/ppfuzz
git clone https://github.com/kleiton0x00/ppmap.git $TOOLS_DIR/ppmap && cd $TOOLS_DIR/ppmap && bash setup.sh

# === SSRF ===

git clone https://github.com/swisskyrepo/SSRFmap.git $TOOLS_DIR/SSRFmap && cd $TOOLS_DIR/SSRFmap && pip3 install -r requirements.txt
git clone https://github.com/tarunkant/Gopherus.git $TOOLS_DIR/Gopherus && cd $TOOLS_DIR/Gopherus && chmod +x install.sh && ./install.sh
go install github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest

# === SQLI ===

apt-get install -y sqlmap

# === VULNERABILITY SCANNERS ===

go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && nuclei -update-templates
go install github.com/jaeles-project/jaeles@latest
git clone https://github.com/jaeles-project/jaeles-signatures.git $TOOLS_DIR/jaeles-signatures
apt-get install -y nikto

# === CMS SCANNERS ===

gem install wpscan
pip3 install droopescan
git clone https://github.com/0ang3el/aem-hacker.git $TOOLS_DIR/aem-hacker && cd $TOOLS_DIR/aem-hacker && pip3 install -r requirements.txt

# === GIT HUNTING ===

git clone https://github.com/obheda12/GitDorker.git $TOOLS_DIR/GitDorker && cd $TOOLS_DIR/GitDorker && pip3 install -r requirements.txt
git clone https://github.com/hisxo/gitGraber.git $TOOLS_DIR/gitGraber && cd $TOOLS_DIR/gitGraber && pip3 install -r requirements.txt
pip3 install GitHacker
git clone https://github.com/internetwache/GitTools.git $TOOLS_DIR/GitTools

# === WORDLISTS ===

git clone https://github.com/danielmiessler/SecLists.git $TOOLS_DIR/SecLists
git clone https://github.com/six2dez/OneListForAll.git $TOOLS_DIR/OneListForAll
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git $TOOLS_DIR/PayloadsAllTheThings

# === USEFUL TOOLS ===

go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/qsreplace@latest
go install github.com/tomnomnom/unfurl@latest
go install github.com/tomnomnom/anew@latest
go install github.com/tomnomnom/hacks/anti-burl@latest
pip3 install uro

# === FINISH ===

echo -e "${GREEN}[*] All tools installed! Bersecbbt environment ready!${RESET}"
echo -e "${GREEN}[*] Thanks to the InfoSec community!${RESET}"
