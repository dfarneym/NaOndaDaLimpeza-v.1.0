
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
--O código fora das funções do evento de cena abaixo será executado apenas UMA VEZ, a menos que
-- a cena é removida completamente (não reciclada) por "compositer.removeScene ()"
-- -----------------------------------------------------------------------------------
local function gotoGame()
    composer.gotoScene( "game" )
end
 
local function gotoHighScores()
    composer.gotoScene( "highscores" )
end
-- -----------------------------------------------------------------------------------
-- Funções de evento de cena
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )


	local sceneGroup = self.view
	-- O código aqui é executado quando a cena é criada pela primeira vez, mas ainda não apareceu na tela
	local background = display.newImageRect( sceneGroup, "background.png", 1400, 800 )
    background.x = display.contentCenterX
	background.y = display.contentCenterY
	
	local title = display.newImageRect( sceneGroup, "title.png", 650, 150 )
    title.x = display.contentCenterX
	title.y = 250
	
	local playButton = display.newText( sceneGroup, "Play", display.contentCenterX, 480, native.systemFont, 44 )
    playButton:setFillColor( 1, 1, 1 )
 
    local highScoresButton = display.newText( sceneGroup, "High Scores", display.contentCenterX, 545, native.systemFont, 44 )
	highScoresButton:setFillColor( 1, 1, 1 )
	
	playButton:addEventListener( "tap", gotoGame )
    highScoresButton:addEventListener( "tap", gotoHighScores )
end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
