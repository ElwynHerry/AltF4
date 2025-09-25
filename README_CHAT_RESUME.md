# Résumé du projet API--ALT-F4-

## Description générale
Ce projet est une API web développée en Swift avec le framework Vapor. Elle expose plusieurs endpoints pour la gestion de jeux vidéo (via l’API RAWG) et de tâches (CRUD). L’API est structurée selon les bonnes pratiques REST et inclut des fonctionnalités avancées comme des quiz et des blind tests sur les jeux vidéo.

### 1. Blind Test Playlist
- **Route :** `GET /blindtest/playlist`
- **Description :** Retourne 10 questions de blind test. Chaque question contient une image et 4 propositions (1 bonne réponse, 3 fausses).
- **Format de réponse :**
  ```json
  {
    "questions": [
      {
        "image": "url",
        "correct_answer": "Nom du jeu",
        "fake_answers": ["Faux 1", "Faux 2", "Faux 3"]
      },
      ...
    ]
  }
  ```

### 2. Quiz Vrai/Faux
- **Route :** `GET /quiz/truefalse`
- **Description :** Retourne 10 questions vrai/faux sur les jeux (genre, année, note). Chaque question a une image, l’énoncé, la réponse (true/false) et le nom du jeu.
- **Format de réponse :**
  ```json
  {
    "questions": [
      {
        "image": "url",
        "question": "Le jeu X est du genre Y.",
        "answer": true,
        "game_name": "Nom du jeu"
      },
      ...
    ]
  }
  ```


### 3. Quiz "Trouve le jeu à partir d'indices"
- **Route :** `GET /quiz/guessgame`
- **Description :** Retourne 10 questions. Chaque question donne 2-3 indices (image, date, genres, note) et attend le nom du jeu.
- **Format de réponse :**
  ```json
  {
    "questions": [
      {
        "hints": {
          "image": "url",
          "released": "2015-09-01",
          "genres": ["Action", "Aventure"]
        },
        "answer": "Nom du jeu"
      },
      ...
    ]
  }
  ```
---

**Ce fichier sert de mémo rapide pour comprendre la structure, les endpoints et les points techniques clés de l’API.**
