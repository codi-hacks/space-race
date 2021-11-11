keyboard = {}

keyboard.key_map = {
  escape = function()
      love.event.quit()
  end,
  b = function()
      debugOn = not debugOn
  end
}

function keyboard.move(time, obj)
  local movespeed = 400

  local xpos = obj.body:getX()
  local ypos = obj.body:getY()

  -- Detect up/down/left/right
  if love.keyboard.isDown('w') then
    if love.keyboard.isDown('a') then
        xpos = xpos - time * movespeed * 0.5
        ypos = ypos - time * movespeed * 0.5
    elseif love.keyboard.isDown('s') then
        ypos = ypos
    elseif love.keyboard.isDown('d') then
        xpos = xpos + time * movespeed * 0.5
        ypos = ypos - time * movespeed * 0.5
    else
        ypos = ypos - time * movespeed
    end
  
  elseif love.keyboard.isDown('s') then
    if love.keyboard.isDown('a') then
        xpos = xpos - time * movespeed * 0.5
        ypos = ypos + time * movespeed * 0.5

    elseif love.keyboard.isDown('d') then
        xpos = xpos + time * movespeed * 0.5
        ypos = ypos + time * movespeed * 0.5
    else
        ypos = ypos + time * movespeed
    end
  
  elseif love.keyboard.isDown('a') then
    if love.keyboard.isDown('d') then
        xpos = xpos
    else
        xpos = xpos - time * movespeed
    end
  
  elseif love.keyboard.isDown('d') then
    xpos = xpos + time * movespeed
  end

  obj.body:setX(xpos)
  obj.body:setY(ypos)

  if love.keyboard.isDown('up') then
    objects.square.body:applyForce(0, -300)
  end
  if love.keyboard.isDown('down') then
    objects.square.body:applyForce(0, 300)
  end
  if love.keyboard.isDown('right') then
    objects.square.body:applyForce(300, 0)
  end
  if love.keyboard.isDown('left') then
    objects.square.body:applyForce(-200, 0)
  end
end

return keyboard