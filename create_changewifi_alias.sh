#!/bin/bash

if [ ! -d "$HOME/bin" ]; then
    echo "Création du répertoire ~/bin"
    mkdir -p "$HOME/bin"
fi

if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo "Ajout de ~/bin au PATH"
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
    source "$HOME/.bashrc"
fi

ln -sf "$HOME/workspace/Setup-Ubuntu22/changewifi.sh" "$HOME/bin/changewifi"
echo "Le lien symbolique pour changewifi.sh a été créé/mis à jour."

chmod +x "$HOME/workspace/Setup-Ubuntu22/changewifi.sh"
echo "changewifi.sh est maintenant exécutable."
