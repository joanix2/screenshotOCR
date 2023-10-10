#!/bin/bash
# Demander confirmation à l'utilisateur avant de procéder à la suppression
read -p "Voulez-vous vraiment supprimer l'application Screenshot OCR ? (O/N) " confirmation
if [ "$confirmation" != "O" ] && [ "$confirmation" != "o" ]; then
    echo "Suppression annulée."
    exit 0
fi

# Supprimer le répertoire d'installation
installation_dir="$HOME/screenshotOCR"
if [ -d "$installation_dir" ]; then
    sudo rm -rf "$installation_dir"
fi

# Supprimer le raccourci du menu d'applications
desktop_file="/usr/share/applications/screenshotOCR.desktop"
if [ -f "$desktop_file" ]; then
    sudo rm "$desktop_file"
fi

# Supprimer le lien symbolique de l'exécutable
if [ -f "/usr/local/bin/screenshotOCR" ]; then
    sudo rm "/usr/local/bin/screenshotOCR"
fi

echo "Suppression terminée. L'application Screenshot OCR a été complètement désinstallée de votre système."

