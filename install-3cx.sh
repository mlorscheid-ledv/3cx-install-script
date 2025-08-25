#!/bin/bash
# ===========================================================
#  3CX Installationsskript für Debian 12
#  Erstellt von Lorscheid-EDV UG (haftungsbeschränkt)
#  Website: https://www.lorscheid-edv.de
#  Support: info@lorscheid-edv.de
#
#  Dieses Skript installiert automatisch 3CX auf Debian 12.
#  Nutzung auf eigene Gefahr. Keine Haftung für Datenverlust
#  oder Systemschäden. Alle Rechte vorbehalten © 2025
# ===========================================================

set -e

echo "=== 3CX Installationsskript der Lorscheid-EDV UG (haftungsbeschränkt) ==="
echo "Website: https://www.lorscheid-edv.de | Support: info@lorscheid-edv.de"
echo "---------------------------------------------------------------"

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

echo "---------------------------------------------------------------"
echo "Installation abgeschlossen!"
echo "Erstellt von der Lorscheid-EDV UG (haftungsbeschränkt)"
echo "Besuchen Sie uns unter https://www.lorscheid-edv.de"
echo "---------------------------------------------------------------"

