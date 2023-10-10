#!/bin/bash

# Installer xclip (gestion des erreurs)
if ! sudo apt-get install -y xclip; then
    echo "Erreur lors de l'installation de xclip."
    exit 1
fi

# Installer Tesseract OCR (gestion des erreurs)
if ! sudo apt-get install -y tesseract-ocr; then
    echo "Erreur lors de l'installation de tesseract-ocr."
    exit 1
fi

# Installer gnome-screenshot (gestion des erreurs)
if ! sudo apt-get install -y gnome-screenshot; then
    echo "Erreur lors de l'installation de gnome-screenshot."
    exit 1
fi

# Définir le répertoire d'installation dans le répertoire personnel de l'utilisateur
installation_dir="$HOME/screenshotOCR"

# Créer le répertoire d'installation s'il n'existe pas
if [ ! -d "$installation_dir" ]; then
    mkdir -p "$installation_dir"
else
    echo "Le répertoire d'installation existe déjà : $installation_dir"
    exit 1
fi

# Copier les fichiers de l'application dans le répertoire d'installation
cp -r * "$installation_dir"

# Changer les autorisations pour les fichiers dans le répertoire d'installation
sudo chmod -R 755 "$installation_dir"

# Changer les autorisations d'exécution pour le script principal
sudo chmod +x "$installation_dir/run.sh"

# Créer un raccourci dans le menu d'applications (facultatif)
desktop_file="/usr/share/applications/screenshotOCR.desktop"
echo "[Desktop Entry]" | sudo tee "$desktop_file" > /dev/null
echo "Version=1.0" | sudo tee -a "$desktop_file" > /dev/null
echo "Type=Application" | sudo tee -a "$desktop_file" > /dev/null
echo "Name=Screenshot OCR" | sudo tee -a "$desktop_file" > /dev/null
echo "Exec=$installation_dir/run.sh" | sudo tee -a "$desktop_file" > /dev/null
echo "Icon=$installation_dir/icon.png" | sudo tee -a "$desktop_file" > /dev/null
echo "Categories=Graphics;Utility;" | sudo tee -a "$desktop_file" > /dev/null

# Créer un lien symbolique pour exécuter l'application depuis n'importe où (facultatif)
sudo ln -sf "$installation_dir/run.sh" /usr/local/bin/screenshotOCR

# Installer xbindkeys (gestion des erreurs)
if ! sudo apt-get install -y xbindkeys; then
    echo "Erreur lors de l'installation de xbindkeys."
    exit 1
fi

echo "Installation terminée. Vous pouvez maintenant lancer votre application en tapant 'screenshotOCR' dans le terminal, en la recherchant dans le menu d'applications, ou simplement en appuyant sur Ctrl + Imprime écran."

