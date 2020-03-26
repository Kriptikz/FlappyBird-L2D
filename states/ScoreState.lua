--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local bronze = love.graphics.newImage('bronze.png')
local silver = love.graphics.newImage('silver.png')
local gold = love.graphics.newImage('gold.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
    self.medal = bronze

    if self.score >= 2 then
        self.medal = silver
    end
    if self.score >= 3 then
        self.medal = gold 
    end
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 200, VIRTUAL_WIDTH, 'center')

    love.graphics.draw(self.medal, (VIRTUAL_WIDTH / 2) - 20, 100)

    love.graphics.printf('Press Enter to Play Again!', 0, 220, VIRTUAL_WIDTH, 'center')
end