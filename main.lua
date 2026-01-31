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

