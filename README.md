# File Explorer Session Saver

## 🚀 Présentation

**File Explorer Session Saver** est une solution automatisée pour gérer l'Explorateur de fichiers Windows 11 comme un navigateur web moderne. L'outil sauvegarde automatiquement tous vos onglets ouverts à la fermeture et les restaure à la prochaine ouverture de l'Explorateur, vous permettant de reprendre exactement où vous vous êtes arrêté.

## ✨ Fonctionnalités

- **Sauvegarde automatique** des chemins de tous vos onglets d'Explorateur quand vous fermez la dernière fenêtre
- **Restauration automatique** de tous vos onglets dans une même fenêtre à la réouverture
- **Surveillance en arrière-plan** qui ne perturbe pas votre flux de travail
- **Filtrage intelligent** des dossiers spéciaux du système pour éviter les erreurs

## 🛠️ Composants techniques

Le projet utilise une combinaison de technologies pour contourner les limitations actuelles de l'API Windows :

| Composant | Technologie | Fonction |
|-----------|------------|----------|
| **explorer_watcher.ahk** | AutoHotkey | Surveille l'ouverture et la fermeture de l'Explorateur de fichiers |
| **sauvegarde_explorateur.ps1** | PowerShell | Sauvegarde les chemins de tous les onglets ouverts |
| **restaure_explorateur.ahk** | AutoHotkey | Restaure tous les onglets sauvegardés dans une même fenêtre |

## 📋 Comment ça fonctionne

1. **Surveillance continue** : Le script explorer_watcher.ahk tourne en arrière-plan et surveille l'état de l'Explorateur de fichiers
2. **À la fermeture** : Quand toutes les fenêtres de l'Explorateur sont fermées, le script PowerShell sauvegarde les chemins dans `%USERPROFILE%\explorateur_fenetres.txt`
3. **À l'ouverture** : Quand l'Explorateur est lancé à nouveau, le script AutoHotkey ouvre le premier dossier sauvegardé puis ajoute chaque dossier supplémentaire en tant que nouvel onglet

## 🚦 Limitations actuelles

- **Simulation d'interface utilisateur** : En l'absence d'API officielle pour les onglets de l'Explorateur de fichiers Windows 11, la solution repose sur l'automatisation de séquences de touches
- **PowerShell uniquement pour la sauvegarde** : Le script PowerShell alternatif pour la restauration (`restaure_explorateur.ps1`) ne peut ouvrir que des fenêtres séparées et non des onglets
- **Timing de sauvegarde** : Actuellement pour l'automatisation, il faudrait déclencher bien le script de sauvegarde, AVANT la fermeture des fenêtres, détecter un "before closure", sauvegarder puis fermer normalement.

## 🔮 Améliorations futures

Des pistes sont possibles via du C++ et C#, en interrogeant les différents éléments Windows, en l'absence d'API déjà existantes. Cela rendrait aussi possible de ne pas passer par AutoHotkey pour la restauration et directement via un script beaucoup plus discret et propre.

## 📌 Installation

1. Clonez ce dépôt dans un dossier de votre choix
2. Assurez-vous qu'AutoHotkey est installé sur votre système
3. Lancer "sauvegarde_explorateur.ps1" avant de fermer l'explorer
4. Lancer "restaure_explorateur.ahk" pour la restauration

## 🔄 Contributions

Les contributions sont les bienvenues ! En particulier, si vous trouvez une méthode plus directe pour manipuler les onglets de l'Explorateur via une API ou une autre approche.
