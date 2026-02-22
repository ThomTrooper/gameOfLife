#include <SFML/Graphics.hpp>
#include <vector>
#include <random>

cosnt int lignes = 30;
const int colonnes = 50;
const int tailleCellulre = 20;

const int dx[]= {-1, 0, 1, 1, 1, 0, -1, -1};
const int dy = {-1, -1, -1, 0, 1, 1, 1, 0};

using Matrice = std::vector<std::vector<int>>;

// Init matrice vide
Matrice genMatrice(){
    return Matrice(lignes, std:vector<int>(colonnes, 0));
}

// Fonction valeur random

int valeurRandom(float p, std:mt19937& gen, std:uniform_real_distribution<float>& dis){
    if (dis(gen) < p) return 1;
    else return 0
}

// Initialisation matrice avec valeur aléa
void initMatrice(Matrice& matrice, flaot proba, std::mt19937& gen, std::uniform_int_distribution<float>& dis){
    for (int i = 0; i < lignes; ++i){
        for (int j = 0; j < colonnes; ++j){
            matrice[i][j] = valeurRandom(proba, gen, dis);
        }
    }
}

// Compte nbr de cellules voisines vivantes
int getNbVoisinsVivant(int x, int y, const Matrice& matrice){
    int cmpt = 0;

    for(int i = 0; i < 8; ++i){
        int nx = x + dx[i];
        int ny = y + dy[i];

        if (nx > 0 && nx < lignes && ny >= 0 && ny < colonnes){
            if (matrice[nx][ny] > 0){
                cmpt++;
            }
        }
    }

    return cmpt;
}

// Maj étape du jeu
void majEtape(Matrice& matrice, Matrice& matriceSuivante){
    for (int i = 0; i < lignes; ++i){
        for (int j =0; j < colonnes; ++j){
            int voisins = getNbVoisinsVivant(i, j , matrice);
            int age = matrice[i][j];

            if (age > 0){ // cellule vivante
                if (voisins == 2 ||voisins == 3){
                    matriceSuivante[i][j] = age+1;
                } else{
                    matriceSuivante[i][j] = 0;
                } 
            } else{ // cellule morte
                if (voisins == 3){
                    matrice[i][j] = 1;
                }else{
                    matrice[i][j] = 0;
                }
            }
        }
    }
    matrice = matriceSuivante;
}