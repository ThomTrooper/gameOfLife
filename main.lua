local lignes = 30
local colonnes = 50
local tailleCellule = 20
local matrice = {}

-- Génération d'ne matrice vide
local function genMatrice()
    local matrice = {}
    for i = 1 , lignes do
        matrice[i] = {}
        for j = 1, colonnes do
            matrice[i][j] = 0
        end
    end
    
    return matrice
end

-- Function valeur random
local function valeurRadnom(p)
    if love.math.random() < p then
        return 1
    else
        return 0
    end
end

-- Initialisation de la matrice
local function initMatrice(matrice, proba)
    proba = proba or 0.5
    for i = 1, lignes do
        for j= 1, colonnes do
            matrice[i][j] = valeurRadnom(proba)
        end
    end
end
