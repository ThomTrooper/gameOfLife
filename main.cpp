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

