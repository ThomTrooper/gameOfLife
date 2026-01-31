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

-- Compte le nombre de cell voisines vivantes
lcoal function getNbVoisinsVivant(x, y, matrice)
    local cmpt = 0 
    local dx = {-1, 0, 1, 1, 1, 0, -1, -1}
    local dy = {-1, -1, -1, 0, 1,1 ,1, 0}

    for i = 1, #dx do
        local nx = x + dx[i]
        local ny = y + dy[i]

        if nx >= 1 and nx <= lignes and ny >= 1 and ny <= colonnes then
            if matrice[nx][ny] > 0 then
                cmpt = cmpt + 1
            end
        end
    end

    return cmpt    
end