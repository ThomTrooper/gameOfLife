# 🧬 GameOfLife

**GameOfLife** est une implémentation du **Jeu de la vie** de John Conway.
Le but du projet est d’explorer différents paradigmes et styles de programmation à travers ce même concept.

---

## 🎯 Objectifs

- Implémenter le **Jeu de la vie** dans divers langages de programmation
- Créer une base multi-langage simple à comprendre et à étendre

---

## 📜 Règle du Jeu de la vie

Le **Jeu de la vie** est un automate cellulaire imaginé par John Conway.  
Chaque cellule d'une grille peut être **vivante** ou **morte**, et évolue selon des règles simples :

1. Une cellule **vivante** avec 2 ou 3 voisines vivantes survit.  
2. Une cellule **morte** avec exactement 3 voisines vivantes devient vivante.  
3. Dans tous les autres cas, la cellule meurt ou reste morte.

---

## ✨ Caractéristiques spéciales

### 🎨 Système d'âge coloré
Chaque cellule vivante possède un **compteur d'âge** qui détermine sa couleur :

| Âge      | Couleur          | Signification             |
|----------|------------------|---------------------------|
| 1        | 🟢 Vert         | Jeune / Naissance récente |
| 2-10     | 🟡 Jaune        | Adulte / État stable      |
| 11-20    | 🔴 Rouge        | Vieillissante             |
| 21+      | 🟣 Magenta      | Très ancienne             |
| 0        | ⚫ Gris foncé   | Morte / Inactive          |
