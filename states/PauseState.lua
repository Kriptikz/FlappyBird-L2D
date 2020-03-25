PauseState = Class{__includes = BaseState}

function PauseState:init()
    self.loaded = false

    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.spawnTime = math.random(1.5, 2.5)
    self.score = 0
end

function PauseState:update(dt)
    -- check for input to unpause
    if love.keyboard.wasPressed('p')then
        -- pass in the saved data
        gStateMachine:change('play', {
            bird = self.bird,
            pipePairs = self.pipePairs,
            timer = self.timer,
            spawnTime = self.spawnTime,
            score = self.score,
            wasPaused = true
        })
    end
end

function PauseState:render()
    if self.loaded then
        for k, pair in pairs(self.pipePairs) do
            pair:render()
        end

        love.graphics.setFont(flappyFont)
        love.graphics.print('Score: ' .. tostring(self.score), 8, 8)        
        self.bird:render()
    end
end

--[[
    Called when this state is transitioned to from another state.
]]
function PauseState:enter(params)
    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.timer = params.timer
    self.spawnTime = params.spawnTime
    self.score = params.score

    self.loaded = true

    -- pause music
    sounds['music']:pause()
    -- play pause sound effect

end

--[[
    Called when this state changes to another state.
]]
function PauseState:exit()
    self.loaded = false

    -- resume music
    sounds['music']:resume()
end