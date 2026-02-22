local lignes = 30
local colonnes = 50
local tailleCellule = 20
local matrice = {}

local dx = {-1, 0, 1, 1, 1, 0, -1, -1}
local dy = {-1, -1, -1, 0, 1, 1 ,1, 0}

local matrice = {}
local matriceSuivante = {}

-- Génération d'une matrice vide
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

-- Fonction valeur random
local function valeurRandom(p)
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
            matrice[i][j] = valeurRandom(proba)
        end
    end
end

-- Compte le nombre de cell voisines vivantes
local function getNbVoisinsVivant(x, y, matrice)
    local cmpt = 0 

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

local function majEtape()
    for i= 1, lignes do
        for j = 1, colonnes do
            local voisins = getNbVoisinsVivant(i, j, matrice)
            local age = matrice[i][j]

            if age > 0 then
                -- cellule vivante
                if voisins == 2 or voisins == 3 then
                    matriceSuivante[i][j] = age + 1
                else
                    matriceSuivante[i][j] = 0
                end
            else
                -- cellule morte
                if voisins == 3 then 
                    matriceSuivante[i][j] = 1
                else
                    matriceSuivante[i][j] = 0
                end
            end
        end
    end
    -- la prochaine matrice deviens la matrice actuelle
    matrice = matriceSuivante
    matriceSuivante = matrice
end


-- Initialisation de love2D
function love.load()
    love.window.setMode(colonnes * tailleCellule, lignes * tailleCellule)
    love.math.setRandomSeed(os.time())
    matrice = genMatrice()
    matriceSuivante = genMatrice()
    initMatrice(matrice, 0.5)
end

local intervalleEtape = 1/3  -- 3 FPS
local minuterieEtape = 0 

function love.update(dt)
    -- ajout du temps écoulé depuis la dernière frame
    minuterieEtape = minuterieEtape + dt
    if minuterieEtape >= intervalleEtape then
        majEtape()
        minuterieEtape = 0
    end
end

function love.draw()
    for i = 1, lignes do
        for j = 1, colonnes do
            local valeur = matrice[i][j]
            if valeur > 0 then 
                if valeur == 1 then
                    love.graphics.setColor(0, 1, 0) --vert
                elseif valeur <= 10 then
                    love.graphics.setColor(1, 1, 0) -- jaune
                elseif valeur <= 20 then
                    love.graphics.setColor(1, 0, 0) -- rouge
                else
                    love.graphics.setColor(1, 0, 1) -- magenta
                end
            else
                love.graphics.setColor(0.2 , 0.2, 0.2) -- gris
            end
            love.graphics.rectangle("fill", (j-1)*tailleCellule, (i-1)*tailleCellule, tailleCellule-1, tailleCellule-1)
        end
    end 
end