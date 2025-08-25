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

# Farben definieren
CYAN="\033[1;36m"
RED="\033[1;31m"
GREEN="\033[1;32m"
RESET="\033[0m"

# Funktion für farbige Ausgabe
msg() {
  echo -e "${CYAN}$1${RESET}"
}

success() {
  echo -e "${GREEN}$1${RESET}"
}

error() {
  echo -e "${RED}$1${RESET}"
}

msg "---------------------------------------------------------------"
msg "=== 3CX Installationsskript von Lorscheid-EDV UG (haftungsbeschränkt) ==="
msg "Website: https://www.lorscheid-edv.de | Support: info@lorscheid-edv.de"
msg "---------------------------------------------------------------"

msg "=== 1. System aktualisieren und Abhängigkeiten installieren ==="
apt update
apt install -y wget gnupg2 sudo dphys-swapfile

msg "=== 2. 3CX GPG-Key importieren ==="
wget -O- https://repo.3cx.com/key.pub \
  | gpg --dearmor \
  | tee /usr/share/keyrings/3cx-archive-keyring.gpg >/dev/null

msg "=== 3. 3CX Repository eintragen ==="
echo "deb [arch=amd64 by-hash=yes signed-by=/usr/share/keyrings/3cx-archive-keyring.gpg] http://repo.3cx.com/3cx bookworm main" \
  | tee /etc/apt/sources.list.d/3cxpbx.list

msg "=== 4. Paketquellen aktualisieren ==="
apt update

msg "=== 5. 3CX installieren ==="
if apt install -y 3cxpbx; then
  success "3CX erfolgreich installiert!"
else
  error "Fehler bei der Installation von 3CX!"
  exit 1
fi

msg "---------------------------------------------------------------"
success "Installation abgeschlossen!"
msg "Erstellt von Lorscheid-EDV UG (haftungsbeschränkt)"
msg "Besuchen Sie uns unter https://www.lorscheid-edv.de"
msg "---------------------------------------------------------------"
