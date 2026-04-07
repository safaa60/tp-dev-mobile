#  Pointage App

Application mobile développée avec **Flutter** permettant de **certifier la présence d’un employé dans une entreprise**.

L’utilisateur se connecte à l’application puis **signe directement sur l’écran** pour valider sa présence.

---

# 📌 Fonctionnalités

* Authentification avec **email et mot de passe**
* Signature sur écran** pour certifier la présence
* Mode clair / mode sombre**
* Historique des présences**
* Déconnexion utilisateur**

---

# 🛠️ Technologies utilisées

* **Flutter**
* **Dart**
* **Gradle** (build Android)
* **Android Studio / VS Code**

---

# Packages utilisés

| Package            | Description                                  |
| ------------------ | -------------------------------------------- |
| signature          | Permet de dessiner une signature sur l’écran |
| intl               | Formatage de la date et de l’heure           |
| shared_preferences | Stockage local de données                    |

---

#  Structure du projet

```
lib/
 ├── main.dart
 │
 ├── models/
 │   └── pointage.dart
 │
 ├── screens/
 │   ├── login_screen.dart
 │   ├── home_screen.dart
 │   └── historique_screen.dart
 │
 └── services/
     └── pointage_service.dart
```

---

#  Authentification

L'application utilise une **authentification locale** (sans base de données).

Identifiants de test :

```
Email : admin@gmail.com
Mot de passe : 123456
```

---

#  Validation de présence

Pour certifier la présence :

1. L'utilisateur se connecte
2. Il signe sur l’écran avec son doigt
3. Il clique sur **Valider la présence**
4. La présence est enregistrée avec :

   * la **date**
   * l’**heure**

---

# 🌙 Mode sombre

L'application permet de changer entre :

* **Mode clair**
* **Mode sombre**

Grâce à un bouton dans la barre supérieure de l’application.

---

# Historique

L’utilisateur peut consulter la liste des présences enregistrées dans l’application avec :

* la **date**
* l’**heure**

---

# ⚙️ Installation du projet

### 1️⃣ Cloner le projet

```
git clone https://github.com/ton-repo/pointage_app.git
```

### 2️⃣ Aller dans le dossier

```
cd pointage_app
```

### 3️⃣ Installer les dépendances

```
flutter pub get
```

### 4️⃣ Lancer l'application

```
flutter run
```

---

# 📱 Générer un APK

Pour créer le fichier APK :

```
flutter build apk
```

Le fichier sera disponible dans :

```
build/app/outputs/flutter-apk/app-release.apk
```

---

#  Auteur

Projet réalisé dans le cadre d’un **TP de développement mobile**.

Auteur : Safaa Zemmar
