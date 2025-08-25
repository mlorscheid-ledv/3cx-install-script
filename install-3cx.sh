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

# === ASCII-Header ===
clear
echo "==============================================================="
echo "   3CX Installationsskript | Lorscheid-EDV UG (haftungsbeschränkt)"
echo "   Website: https://www.lorscheid-edv.de  |  Support: info@lorscheid-edv.de"
echo "==============================================================="

# === Prüfen und dos2unix installieren, falls nötig ===
if ! command -v dos2unix &> /dev/null; then
    echo "dos2unix nicht gefunden. Installiere..."
    apt update && apt install -y dos2unix
fi

# Skript sich selbst ins richtige Format bringen
dos2unix "$0" >/dev/null 2>&1 || true

# === System aktualisieren und Abhängigkeiten installieren ===
apt update
apt install -y wget gnupg2 sudo dphys-swapfile

# === 3CX GPG-Key importieren ===
wget -O- https://repo.3cx.com/key.pub \
  | gpg --dearmor \
  | tee /usr/share/keyrings/3cx-archive-keyring.gpg >/dev/null

# === 3CX Repository eintragen ===
echo "deb [arch=amd64 by-hash=yes signed-by=/usr/share/keyrings/3cx-archive-keyring.gpg] http://repo.3cx.com/3cx bookworm main" \
  | tee /etc/apt/sources.list.d/3cxpbx.list

# === Paketquellen aktualisieren ===
apt update

# === 3CX installieren ===
apt install -y 3cxpbx

echo "---------------------------------------------------------------"
echo "Installation abgeschlossen!"
echo "Erstellt von der Lorscheid-EDV UG (haftungsbeschränkt)"
echo "Besuchen Sie uns unter https://www.lorscheid-edv.de"
echo "---------------------------------------------------------------"
