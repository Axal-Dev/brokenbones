local startTime = tick() -- Obtenir le temps de départ

-- Afficher un message d'attente au joueur
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui") -- Assure que le GUI est chargé

-- Créer un écran temporaire avec un message
local messageGui = Instance.new("ScreenGui", playerGui)
messageGui.Name = "WaitMessage"

local messageLabel = Instance.new("TextLabel", messageGui)
messageLabel.Size = UDim2.new(1, 0, 1, 0) -- Prend tout l'écran
messageLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Fond noir
messageLabel.BackgroundTransparency = 0.5 -- Transparence légère
messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Texte blanc
messageLabel.TextScaled = true -- Taille du texte automatique
messageLabel.Text = "Veuillez patienter 20 secondes..." -- Texte initial
messageLabel.Font = Enum.Font.SourceSansBold -- Police du texte

-- Fonction pour envoyer les requêtes
local function updateStat(statName, value)
    local args = {
        [1] = statName,
        [2] = value
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer(unpack(args))
end

-- Liste des statistiques à mettre à jour
local stats = {
    "breakslevel",
    "sprainslevel",
    "dislocationslevel",
    "flightlevel",
    "speedlevel",
    "jumplevel",
    "elasticitylevel",
    "frictionlevel",
    "cooldownlevel",
    "fuellevel"
}

-- Fonction pour vérifier le temps écoulé
local function shouldKick()
    return tick() - startTime >= 20
end

-- Boucle infinie avec vérification du temps
while true do
    for _, stat in ipairs(stats) do
        updateStat(stat, 1)
    end
    
    -- Vérifier si 20 secondes se sont écoulées
    if shouldKick() then
        -- Retirer le message et expulser le joueur
        if messageGui then
            messageGui:Destroy()
        end
        player:Kick("Veuillez vous reconnecter.")
        break
    end

    wait(0) -- Éviter de surcharger le script
end
