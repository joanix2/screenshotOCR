#!/bin/bash

# Capture d'écran et enregistrement de l'image temporaire
screenshot_file="/tmp/screenshot.png"
if gnome-screenshot -a -f "$screenshot_file"; then
    echo "Capture d'écran réussie."
else
    echo "Erreur lors de la capture d'écran."
    exit 1
fi

# Utilisation de Tesseract pour l'OCR
text_result=$(tesseract "$screenshot_file" - 2> /dev/null)
if [ $? -eq 0 ]; then
    echo "OCR réussie : $text_result"
else
    echo "Erreur lors de l'OCR : $text_result"
    rm "$screenshot_file"
    exit 1
fi

# Supprimer le caractère de saut de page (ASCII 12) et les sauts de ligne à la fin du texte
cleaned_text=$(echo "$text_result" | sed 's/\x0C//;s/[[:space:]]*$//')

# Copie du texte OCR dans le presse-papiers
if echo -n "$cleaned_text" | xclip -selection clipboard; then
    echo "Texte copié dans le presse-papiers."
else
    echo "Erreur lors de la copie dans le presse-papiers."
fi

# Notification de la fin du processus
notify-send "OCR terminée" "Le texte a été copié dans le presse-papiers."

# Suppression de l'image temporaire
rm "$screenshot_file"
