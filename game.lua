local composer = require( "composer" )
local scene = composer.newScene()

local physics = require "physics"
physics.start()

--### Variaveis ###--
local w = display.contentWidth -- largura da tela
local h = display.contentHeight -- altura da tela


local lives = 1
local score = 0
local died = false

local livesText
local scoreText

--### Grupos ###--
local backGroup = display.newGroup()  
local mainGroup = display.newGroup()  
local uiGroup = display.newGroup() 

--### Background ###--
display.setDefault("textureWrapX","mirroredRepeat")

local bg1 = display.newRect(backGroup, display.contentCenterX , display.contentCenterY , 1400 , 800)
bg1.fill={type = "image" , filename = "imagens/background1.jpg"}

local function animationB1()

        transition.to(bg1.fill ,{ time = 5000,x=1 ,delta = true, onComplete = animationB1})
        
end
animationB1()

--### Pontuação e Vidas ###--

livesText = display.newText( uiGroup, "Lives: " .. lives, 200, 80, native.systemFont, 35 )
livesText.x = 70
livesText.y = 20
scoreText = display.newText( uiGroup, "Score: " .. score, 400, 80, native.systemFont, 35 )
scoreText.x = 300
scoreText.y = 20

local function updateText()
    livesText.text = "Lives: " .. lives
    scoreText.text = "Score: " .. score
end

--### Largura, altura e nº de frames do sprite do Surfista ###--
local sheetData = { width = 84, height = 120, numFrames = 11 }

--### Cria uma nova imagem usando a sprite ###--
local sheet = graphics.newImageSheet("imagens/BonecoTeste1.png", sheetData)

local sequenceData = 
{
    
    {name = "Walk", start = 2, count = 11,time =600, loopCount = 0}  
}


--### Cria um valor inicial para sprite,"Idle", por isso o o sprite começa parado ###--
local player = display.newSprite(mainGroup,sheet, sequenceData)

player.x = w * .13
player.y = h * .64
physics.addBody( player, "dynamic", {bounce = 0} )  

--Valor inicial para sprite
player:setSequence("Walk")

--Botões
local buttons = {}

buttons[1] = display.newImage("imagens/button.png")--jump
buttons[1].x = 50
buttons[1].y = 720
buttons[1].rotation = -90
buttons[1].myName = "jump"


local passosX = 0
local passosY = 0


local touchFunction = function(e)
    if e.phase == "began" or e.phase == "moved" then
        if e.target.myName == "jump" then
            player:setSequence("Walk") 
            passosY = -10
            passosX = 0
            physics.addBody( player, "dynamic", {bounce = 0} )                              
        end 
    else
        if e.target.myName == "jump" then 
            player:setSequence("Walk")        
        end
        passosX = 0
        passosY = 0           
    end
end

local j = 1

for j = 1, #buttons do
    buttons[j]:addEventListener("touch", touchFunction)
end

--### Atualiza a posição do jogador na tela ###--
local update = function()
        player.x = player.x + passosX
        player.y = player.y + passosY
        
        if player.x <= player.width * .5 then 
            player.x = player.width * .5
        elseif player.x >= w - player.width * .5 then 
            player.x = w - player.width * .5
        end
    
        if player.y <= player.height * .5 then
            player.y = player.height * .5
        elseif player.y >= h - player.height * .5 then 
            player.y = h - player.height * .5
        end 
        
         player:play()
 
end

Runtime:addEventListener("enterFrame", update)

--### Craian Boss1 ###--
local ini1 = display.newImage("ini1.png")
ini1.x = 1200
ini1.y = 550
ini1.speed = math.random(2,6)
ini1.initY = ini1.y
ini1.amp = math.random(20,100)
ini1.angle = math.random(1,360)
physics.addBody(ini1, "static", {density=.5, bounce=0.1, friction=.2, radius=12})
uiGroup:insert(ini1)

--### Craian Boos1 ###--
local ini2 = display.newImage("ini2.png")
ini2.x = 1200
ini2.y = 600
ini2.speed = math.random(2,6)
ini2.initY = ini1.y
ini2.amp = math.random(20,100)
ini2.angle = math.random(1,360)
physics.addBody(ini2, "static", {density=.5, bounce=0.1, friction=.2, radius=12})
uiGroup:insert(ini2)  

--### Movendo o Inimigo ###--
function moveIni1(self,event)
    if self.x < -50 then
        self.x = 1200
        self.y = math.random(90,220)
        self.speed = math.random(2,6)
        self.amp = math.random(20,100)
        self.angle = math.random(1,360)
    else 
        self.x = self.x - self.speed
        self.angle = self.angle + .0
        self.y = self.amp*math.sin(self.angle)+self.initY
    end
end

ini1.enterFrame = moveIni1 
Runtime:addEventListener("enterFrame", ini1)

ini2.enterFrame = moveIni1 
Runtime:addEventListener("enterFrame", ini2)

----------------------------------------------------------------------------
--### Listener setup ###--

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

--### Plataforma ###--
local pf = display.newImageRect( "imagens/platform.png", 1400, 50 )
pf.x = display.contentWidth -700
pf.y = display.contentHeight-120
physics.addBody( pf, "static", {bounce = 0} )
pf.alpha = -0.13


--### fim de jogo ###--
local function endGame()
	composer.setVariable( "finalScore", score )
	composer.gotoScene( "scores", { time=800, effect="crossFade" } )
end
function gameOver()
    composer.gotoScene("menu")
end


return scene

