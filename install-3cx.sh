#!/bin/bash
set -e

echo "=== 1. System aktualisieren und Abhängigkeiten installieren ==="
apt update
apt install -y wget gnupg2 sudo dphys-swapfile

echo "=== 2. 3CX GPG-Key importieren ==="
wget -O- https://repo.3cx.com/key.pub \
  | gpg --dearmor \
  | tee /usr/share/keyrings/3cx-archive-keyring.gpg >/dev/null

echo "=== 3. 3CX Repository eintragen ==="
echo "deb [arch=amd64 by-hash=yes signed-by=/usr/share/keyrings/3cx-archive-keyring.gpg] http://repo.3cx.com/3cx bookworm main" \
  | tee /etc/apt/sources.list.d/3cxpbx.list

echo "=== 4. Paketquellen aktualisieren ==="
apt update

echo "=== 5. 3CX installieren ==="
apt install -y 3cxpbx

echo "=== Fertig! Du kannst nun die Weboberfläche öffnen und 3CX einrichten. ==="
