
## Étapes à suivre

1. Exécutez la commande suivante pour installer les dépendances dans la racine du projet /spectacle/:  
   ```bash
   flutter pub get
   ```

2. Modifiez le fichier de configuration pour accéder à l'API :  
   Ouvrez le fichier `spectacle/lib/config/config.dart` et remplacez la valeur de `BaseApiUrl` par le lien de votre API :
   ```dart
   static const String BaseApiUrl = "lien/vers/l'api";
   ```

3. Pour lancer l'application, utilisez la commande suivante :  
   ```bash
   flutter run
   ```

## Identifiants de connexion par défaut

- **Client**  
  - Email : romeo@gmail.com  
  - Mot de passe : romeo

- **Propriétaire de salle**  
  - Email : marc@gmail.com  
  - Mot de passe : marc

## Navigation dans l'application

- La déconnexion se trouve à la fin de la liste dans la page Profil.
- Les paramètres sont accessibles au début de la liste dans la page Profil.
- Vous pouvez modifier le thème de l'application, la langue, le style de texte, ainsi que le mode (sombre, système, clair).

## Base de données

Importez le fichier `reservation_salle.sql` pour créer la base de données MySQL, les tables, et les données par défaut.

---

