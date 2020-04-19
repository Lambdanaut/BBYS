pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

-- DEBUG CONTROLS
DEBUG = false

-- Constants
MAP_SIZE_X = 16
MAP_SIZE_Y = 16

PALETTE_ORANGE = 0
PALETTE_GREEN = 1
PALETTE_BLUE = 2
PALETTE_GREY = 3

PALETTES = {PALETTE_ORANGE, PALETTE_GREEN, PALETTE_BLUE, PALETTE_GREY}
PALETTES_LENGTH = 0
for _, _ in pairs(PALETTES) do PALETTES_LENGTH += 1 end

ITEM_INDEXES = {69, 70, 71, 72, 73, 74, 75, 76, 85, 86, 87, 88, 89, 90, 91, 92}

BBY_INDEXES = {32, 33, 34, 35, 36, 37, 38, 39, 48, 49, 50, 51, 52, 53, 54, 55}
BBY_INDEXES_LENGTH = 0
for _, _ in pairs(BBY_INDEXES) do BBY_INDEXES_LENGTH += 1 end

FOOD_MILK_INDEX = 144
FOOD_STEAK_INDEX = 145

BBY_NAMES = {
  "JON", "BETTY", "SAL", "CAT", "JOSH", "K8E", "JACK", "ANDY", "SCOTT", "ERICA", "JOEL", 
  "NOODL", "JEFF", "GORBY", "VINNY", "BBYCAKE", "CHARLI", "BBYJESUS",
  "GOOBY", "GARFO", "BBYHITLR", "MR BBY", "CARL", "TRUMP", "GRINCH", "CONWAY", "GARTH",
  "MARK", "TOM", "SPUD", "ADRI", "LINDA", "RAINY", "FROGI", "MARSHL", "SEAN",
}

BBY_NAMES_LENGTH = 0
for _, _ in pairs(BBY_NAMES) do BBY_NAMES_LENGTH += 1 end

TOP_COLLISION = 0
BOTTOM_COLLISION = 1
LEFT_COLLISION = 2
RIGHT_COLLISION = 3

TILE_UNWALKABLE = 0

-- Globals
IN_SPLASH_SCREEN = true
SPLASH_SCREEN_Y_POS = 0
LAST_CHECKED_TIME = 0.0
DELTA_TIME = 0.0  -- time since last frame


-- Game Loop 🅾️_🅾️
function _init()
  print("welcome 🅾️_🅾️♥")

  map_setup()
  make_player()
  make_items()
  make_foods()
  make_rocks()
  make_bbys({tile_coord_to_pixel_coord({8, 8})})
end

function _update()
  local t = time()
  DELTA_TIME = t - LAST_CHECKED_TIME
  LAST_CHECKED_TIME = t
  if IN_SPLASH_SCREEN then
    get_splash_screen_input()
  else
    -- Update player physics
    player:update()

    -- Update bby physics
    for _, bby in pairs(bbys) do 
      bby:update()
    end

    -- Update rock physics
    for _, rock in pairs(rocks.rocks) do 
      rock:update()
    end

    -- Update item physics
    for _, item in pairs(items.items) do 
      item:update()
    end

    -- Update food physics
    for _, food in pairs(foods.foods) do 
      food:update()
    end

  end
end

function _draw()
  if IN_SPLASH_SCREEN then
    draw_splash_screen()
  else
    -- Clear screen
    cls()

    -- Draw the map
    draw_map() 

    -- Draw the rocks
    for _, rock in pairs(rocks.rocks) do 
      rock:draw() 
    end

    -- Draw the foods
    for _, food in pairs(foods.foods) do 
      food:draw() 
    end

    -- Draw the items
    for _, item in pairs(items.items) do 
      item:draw() 
    end

    -- Draw the bbys
    for _, bby in pairs(bbys) do 
      bby:draw() 
    end

    -- Draw player
    player:draw()  
    
  end
end

-- Splash screen code

function draw_splash_screen()
  rectfill(0, 0, 8*16, 8*16, 15)
  draw_bby_iterations(2)

  time_modulo = time() % 2
  if (time_modulo < 1) then
    title_y_pos = bounce(0, 6*16, time() % 1)
  else
    title_y_pos = bounce(6*16, 0, time() % 1)
  end

  draw_title(0, title_y_pos)
end

function get_splash_screen_input()
  if (btnp(4)) then 
    IN_SPLASH_SCREEN = false
  end
end

function draw_title(offset_pixels_x, offset_pixels_y)
  x = -1
  y = -1
  for y = 0, 4 do
    for x = 0, 15 do
      sprite = y * 16 + x
      spr(192+sprite, x*8 + offset_pixels_x, y*8 + offset_pixels_y)
    end
  end
end

function draw_bby_iterations(iterations)
  if iterations == nil then iterations = 1 end

  x = -2
  for _ = 1, iterations do
    for _, palette in pairs(PALETTES) do
      x += 2
      y = -1
      for _, item_index in pairs(ITEM_INDEXES) do
        y += 1

        temp_x = x
        if (y % 2 == 0) then temp_x += 1  end

        set_palette(palette)
        spr(item_index_to_bby_index(item_index), temp_x*8, y*8)
        reset_palette()
      end
    end
  end
end
--map code

function map_setup()
end

function draw_map()
  map(0, 0, 0, 0, 16, 16)
end

function tile_coord_to_pixel_coord(tile_coord)
  -- Given the coordinate of a tile, translate that to pixel values
  return {tile_coord[1] * 8, tile_coord[2] * 8}
end

function tile_coord_to_rect(tile_coord)
  -- Given the coordinate of a tile, translate that to a rect of the tile
  local pixel_coords = tile_coord_to_pixel_coord(tile_coord)
  return {x=pixel_coords[1], y=pixel_coords[2], w=8, h=8 }
end

function pixel_coord_to_tile_coord(pixel_coord)
  -- Given coordinates in pixels, translate that to a tile position
  return {pixel_coord[1] / 8, pixel_coord[2] / 8}
end

function tile_has_flag(x, y, flag)
  local tile = mget(x, y)
  local has_flag = fget(tile, flag)
  return has_flag
end

function can_move(pos)
  tile_coord = pixel_coord_to_tile_coord(pos)
  return not tile_has_flag(tile_coord[1], tile_coord[2], TILE_UNWALKABLE)
end

--player code

function make_player()
  player = {}

  -- Configurations
  player.max_speed = 1.0
  player.damage_to_rocks = 0.05

  player.pos = {4*8, 4*8}
  player.sprite = 64
  player.v = {0, 0}

  -- Components
  player.animator = make_animator(
    player,
    0.1,
    1,
    PALETTES[flr(rnd(PALETTES_LENGTH)) + 1],
    false)
  player.collider = make_collider(
    player,
    8,
    8)

  player.update = function(self)
    self:move()
    self.collider:update_collider()
    self:collide()
  end

  player.move = function(self)
    local did_move = false
    local x_change = 0
		local y_change = 0

    -- Get input
		if (btn(⬅️)) then x_change = -self.max_speed end
		if (btn(➡️)) then x_change = self.max_speed end
		if (btn(⬆️)) then y_change = -self.max_speed end
		if (btn(⬇️)) then y_change = self.max_speed end

    if (x_change != 0 or y_change != 0) then
  		-- if can_move({new_x,  new_y}) then
        did_move = true
        self.v = {x_change, y_change}
  		-- else
  		--   sfx(0)
  		-- end
    else
      self.v = {0, 0}
    end

    -- Update position based on velocity
    self.pos = v_add(self.pos, self.v)

    -- Do animation if we moved
    self.animator.animation_flag = did_move
    if x_change > 0 then self.animator.flip_sprite = true elseif x_change < 0 then self.animator.flip_sprite = false end

    -- Adjust position based on collision
    self:collide()

  end

  player.collide = function(self)
    -- Do bby collision
    for _, bby in pairs(bbys) do
      if self.collider:is_colliding(bby) then
        bby.is_being_pushed = true
        local collision_direction = self.collider:get_collision_direction(bby)
        if collision_direction == TOP_COLLISION then
          -- Colliding top
          bby.pos[2] = self.pos[2] - self.collider.rect.h
        elseif collision_direction == BOTTOM_COLLISION then
          -- Colliding bottom
          bby.pos[2] = self.pos[2] + self.collider.rect.h
        elseif collision_direction == LEFT_COLLISION then
          -- Colliding left
          bby.pos[1] = self.pos[1] - self.collider.rect.w
        elseif collision_direction == RIGHT_COLLISION then
          -- Colliding  right
          bby.pos[1] = self.pos[1] + self.collider.rect.w
        end
      else
        bby.is_being_pushed = false
      end
    end

    -- Do rock collision
    for _, rock in pairs(rocks.rocks) do
      if rock.active and self.collider:is_colliding(rock) then
        rock.health:damage(self.damage_to_rocks)
        local collision_direction = self.collider:get_collision_direction(rock)
        if collision_direction == TOP_COLLISION then
          -- Colliding top
          self.pos[2] = rock.pos[2] + self.collider.rect.h
        elseif collision_direction == BOTTOM_COLLISION then
          -- Colliding bottom
          self.pos[2] = rock.pos[2] - self.collider.rect.h
        elseif collision_direction == LEFT_COLLISION then
          -- Colliding left
          self.pos[1] = rock.pos[1] + self.collider.rect.w
        elseif collision_direction == RIGHT_COLLISION then
          -- Colliding  right
          self.pos[1] = rock.pos[1] - self.collider.rect.w
        end
      end
    end

  end

  player.draw = function(self)
    self.animator:animate()
    self.animator:draw()
    if DEBUG then
      self.collider:draw()
    end
	end

end

-- Item code

function make_items()
  items = {}

  items.items = {}
 
  for _, index in pairs(ITEM_INDEXES) do
    item_pos_x = flr(rnd(MAP_SIZE_X - 2)) + 1
    item_pos_y = flr(rnd(MAP_SIZE_Y - 2)) + 1
    items.items[index] = make_item(index, {item_pos_x*8, item_pos_y*8})
  end
end

function make_item(sprite, pos)
  local item = {}

  item.sprite = sprite
  item.active = true
  item.pos = pos

  -- Components
  item.collider = make_collider(
    item,
    8,
    8)

  item.update = function(self)
    self.collider:update_collider()
  end

  item.draw = function(self)
    if self.active then
      spr(self.sprite, self.pos[1], self.pos[2])
    end
  end

  item.to_bby = function(self)
    return item_index_to_bby_index(self.sprite)
  end

  return item

end

function item_index_to_bby_index(item)
  return item-37  -- Items are 37 sprite tiles further than their bby sprites.
end


function make_foods()
  foods = {}

  foods.foods = {}
end


function make_food(pos, sprite)
  local food = {}

  food.pos = pos
  food.sprite = sprite or flr(rnd(2)) + 144 -- Randomly chooses between the two food sprites at 144 and 145
  food.active = true

  -- Milk heals less than steak
  if food.sprite == 144 then food.health_given = 0.5 else food.health_given = 1.0 end

  -- Components
  food.collider = make_collider(
    food,
    8,
    8)

  food.update = function(self)
    self.collider:update_collider()
  end

  food.draw = function(self)
    if (self.active) then
      spr(self.sprite, self.pos[1], self.pos[2])
    end
  end

  return food
end

-- Rocks code

function make_rocks(bbys_pos)
  rocks = {}

  rocks.rocks = {make_rock({6*8, 6*8})}
end

function make_rock(pos)
  local rock = {}

  rock.pos = pos
  rock.active = true
  rock.sprite = 60

  death_callback_fn = function(rock)
    -- Called on death

    -- Create food at place of death
    local new_food = make_food(pos)
    foods.foods[#foods.foods+1] = new_food

    rock.active = false
  end

  -- Components
  rock.health = make_health(
    rock,
    0.1,  -- Max health
    3,  -- Damage sfx to play
    0.4, -- Cooldown duration
    nil,  -- Auto damage taken per second (none)
    death_callback_fn,  -- Callback function to call on death
    0.65,  -- Low health sprite change threshhold
    rock.sprite + 64 -- Sprite to change to on low health
    )
  rock.collider = make_collider(
    rock,
    8,
    8)

  rock.draw = function(self)
    if (self.active) then
      spr(self.sprite, self.pos[1], self.pos[2])
    end
  end

  rock.update = function(self)
    self.collider:update_collider()
    self.health:update()
  end

  return rock
end

-- BBY code
function make_bbys(bbys_pos)
  bbys = {}
 
  for i, pos in pairs(bbys_pos) do
    bbys[i] = make_bby(pos)
  end
end

function make_bby(pos)
  local bby = {}

  -- Configurations
  bby.max_speed = 0.5

  bby.name = BBY_NAMES[flr(rnd(BBY_NAMES_LENGTH)) + 1]
  bby.pos = pos
  bby.v = {0, 0}
  bby.sprite = 40
  bby.active = true

  bby.is_being_pushed = false

  -- Components
  bby.animator = make_animator(
    bby, 
    0.3,
    64, 
    PALETTES[flr(rnd(PALETTES_LENGTH)) + 1])
  bby.collider = make_collider(
    bby,
    8,
    8)

  death_callback_fn = function(bby)
    sfx(5)
    bby.active = false
  end

  bby.health = make_health(
    bby,
    1.0, -- Max health
    nil, -- Damage sfx to play
    1.0, -- Cooldown duration
    0.02, -- Auto damage taken per second
    death_callback_fn  -- Callback function to call on death
  )
  bby.wanderer = make_wanderer(
    bby,
    0.2, 
    1, 
    0.8,
    0.8) 

  bby.update = function(self)
    if self.active then
      if self.is_being_pushed then self.wanderer:stop() else self.wanderer:wander() end
      self:move()
      bby:collide()
      self.collider:update_collider()
      self.health:update()
    end
  end

  bby.draw = function(self)
    if self.active then
      self.animator:animate()
      self.animator:draw()
      self.animator:draw_message(self.name, self.health.health)
    end
  end

  bby.move = function(self)
    new_pos = v_add(self.pos, self.v)
    if can_move(new_pos) then
      self.pos = new_pos
    end
    if (self.v[1] != 0 or self.v[2] != 0) then
      self.animator.animation_flag = true
    else
      self.animator.animation_flag = false
    end
  end

  bby.collide = function(self)
    -- Do Food collision
    for _, food in pairs(foods.foods) do
      if food.active and self.collider:is_colliding(food) then
        self.health:heal(food.health_given)
        food.active = false
        sfx(1)
      end
    end

    -- Do Item collision
    for _, item in pairs(items.items) do
      if item.active and self.collider:is_colliding(item) then
        self.sprite = item_index_to_bby_index(item.sprite)
        item.active = false
        sfx(2)
      end
    end

    -- Do rock collision
    for _, rock in pairs(rocks.rocks) do
      if rock.active and self.collider:is_colliding(rock) then
        local collision_direction = self.collider:get_collision_direction(rock)
        if collision_direction == TOP_COLLISION then
          -- Colliding top
          self.pos[2] = rock.pos[2] + self.collider.rect.h
        elseif collision_direction == BOTTOM_COLLISION then
          -- Colliding bottom
          self.pos[2] = rock.pos[2] - self.collider.rect.h
        elseif collision_direction == LEFT_COLLISION then
          -- Colliding left
          self.pos[1] = rock.pos[1] + self.collider.rect.w
        elseif collision_direction == RIGHT_COLLISION then
          -- Colliding  right
          self.pos[1] = rock.pos[1] - self.collider.rect.w
        end
      end
    end
 
  end

  return bby

end


-- Wander code
function make_wanderer(parent, wander_speed, frequency, duration, random_offset)
  wanderer = {}
  wanderer.parent = parent

  wanderer.wander_speed = wander_speed
  wanderer.frequency = frequency
  wanderer.duration = duration
  wanderer.random_offset = random_offset or 0 -- Additional random time(from zero to this number) that is added to time between wanderings

  wanderer.time_since_last_wander = 0
  wanderer.time_since_starting_wander = 0
  wanderer.is_wandering = false

  wanderer.stop = function(self)
    -- Stops the active wandering
    self.is_wandering = false
    self.time_since_starting_wander = 0
    self.time_since_last_wander = 0 - rnd(self.random_offset)
    self.parent.v = {0, 0}  -- Stop moving
  end

  wanderer.wander = function(self)
    if not self.is_wandering then
      -- We're not wandering

      -- Increment the time_since_last_wander count
      self.time_since_last_wander += DELTA_TIME

      if self.time_since_last_wander > self.frequency then
        -- Start wandering

        local rand_x = rnd(3)
        local rand_y = rnd(3)
        local x = 0
        local y = 0
        -- Get random x value
        if rand_x > 2 then 
          x = self.wander_speed 
        elseif rand_x > 1 then
          x = -self.wander_speed 
        else 
          x = 0 
        end

        -- Get random y value
        if rand_y > 2 then 
          y = self.wander_speed 
        elseif rand_y > 1 then
          y = -self.wander_speed 
        else 
          y = 0 
        end

        self.parent.v = {x, y}

        self.is_wandering = true
      end
    else
      -- We are wandering
      self.time_since_starting_wander += DELTA_TIME
      if self.time_since_starting_wander > self.duration then
        -- Stop wandering
        self:stop()
      end
    end
  end

  return wanderer
end


-- Animator code

function make_animator(parent, fps, sprite_offset, palette, animation_flag)
  animator = {}
  animator.parent = parent
  animator.fps = fps
  animator.sprite_offset = sprite_offset
  animator.animation_flag = animation_flag or false

  animator.time_since_last_frame = 0
  animator.animation_frame = 0
  animator.flip_sprite = false

  animator.palette = palette

  animator.animate = function(self)
    -- Increment the animation frame count
    self.time_since_last_frame += DELTA_TIME
    if self.animation_flag and self.time_since_last_frame > self.fps then
      self.animation_frame = (self.animation_frame + 1) % 2
      self.time_since_last_frame = 0
    end
  end

  animator.get_animation_frame = function(self)
    if self.animation_flag then
      return self.parent.sprite + self.sprite_offset * (self.animation_frame + 1)
    else
      return self.parent.sprite
    end
  end

  animator.draw = function(self)
    if(self.palette != nil) then
      set_palette(self.palette)
    end

    spr(self:get_animation_frame(), parent.pos[1], parent.pos[2], 1.0, 1.0, self.flip_sprite)

    if(self.palette != nil) then
      reset_palette()
    end
  end

  animator.draw_message = function(self, message, bar_length)
    -- bar_length should be between 0.0 and 1.0

    local bar_length = max(0.0, bar_length)
    local padding = 2
    local x_pos = self.parent.pos[1] + 5 - #message * 4 / 2 
    local y_pos = self.parent.pos[2] - 8
    local bg_color = 9

    if (self.palette != nil) then
      if self.palette == PALETTE_ORANGE then
        bg_color = 9
      elseif self.palette == PALETTE_GREEN then
        bg_color = 3  -- dark green
      elseif self.palette == PALETTE_BLUE then
        bg_color = 12
      elseif self.palette == PALETTE_GREY then
        bg_color = 6
      end
    end

    -- Draw Message Background Rectangle
    rectfill(
      x_pos - padding,
      y_pos - padding,
      x_pos + #message * 4 ,
      y_pos + 5,
      bg_color)

    -- Draw message
    print(message, x_pos, y_pos - 1, 0)

    -- Draw bar
    if (bar_length) then
      local bar_bg_color = 0
      local bar_fill_color = 8

      -- Bar Background
      line(
        x_pos - padding,
        y_pos + 5,
        x_pos + #message * 4,
        y_pos + 5,
        bar_bg_color
      )
      -- Bar Fill
      if(bar_length > 0.0) then
        -- Green
        local bar_fill_color = 11
        if (bar_length < 0.25) then
          -- Red
          bar_fill_color = 8
        elseif (bar_length < 0.6) then
          -- Yellow
          bar_fill_color = 10
        end

        line(
          x_pos - padding,
          y_pos + 5,
          x_pos - padding + (((#message * 4) + padding) * bar_length),
          y_pos + 5,
          bar_fill_color
        )
      end
    end


  end

  return animator

end

-- Collider
function make_collider(parent, w, h)
  collider = {}
  collider.parent = parent

  collider.rect = {x=0,y=0,w=w,h=h}

  -- Uninitialized collider detectors as rects(xpos, ypos, width, height)
  collider.t = {x=0,y=0,w=0,h=0} 
  collider.b = {x=0,y=0,w=0,h=0}
  collider.l = {x=0,y=0,w=0,h=0}
  collider.r = {x=0,y=0,w=0,h=0}

  collider.update_collider = function(self)
    self.rect = {x=parent.pos[1], y=parent.pos[2], w=self.rect.w, h=self.rect.h}

    self.t = {x=parent.pos[1] + 2, y=parent.pos[2], w=self.rect.w - 4, h=self.rect.h / 2}
    self.b = {x=parent.pos[1] + 2, y=parent.pos[2] + self.rect.h / 2, w=self.rect.w - 4, h=self.rect.h / 2}
    self.l = {x=parent.pos[1], y=parent.pos[2] + 2, w=self.rect.w / 2, h=self.rect.h - 4}
    self.r = {x=parent.pos[1] + self.rect.w / 2, y=parent.pos[2] + 2, w=self.rect.w / 2, h=self.rect.h - 4}
  end
  collider:update_collider()

  collider.is_colliding = function(self, other)
    return rects_are_colliding(self.rect, other.collider.rect)
  end

  collider.get_collision_direction = function(self, other)
    local other = other.collider.rect

    local top_hit = rects_are_colliding(self.t, other)
    if (top_hit) then return TOP_COLLISION end
    local bottom_hit = rects_are_colliding(self.b, other)
    if (bottom_hit) then return BOTTOM_COLLISION end
    local left_hit = rects_are_colliding(self.l, other)
    if (left_hit) then return LEFT_COLLISION end
    local right_hit = rects_are_colliding(self.r, other)
    if (right_hit) then return RIGHT_COLLISION end
  end

  collider.draw = function(self)
    for _, r in pairs({self.t, self.b, self.l, self.r}) do
      rect(
        r.x,
        r.y,
        r.w + r.x - 1,
        r.h + r.y - 1,
        0)
    end
  end

  return collider

end


-- Health
function make_health(parent, 
  max_health, damage_sfx, cooldown_duration, auto_damage_per_second, 
  death_callback_fn, low_health_amount, low_health_sprite)

  health = {}
  health.parent = parent

  health.max_health = max_health
  health.health = max_health
  health.cooldown_duration = cooldown_duration
  health.auto_damage_per_second = auto_damage_per_second  --Optional. Damages this much per second
  health.death_callback_fn = death_callback_fn  --Optional. Function to call when health drops below 0
  health.damage_sfx = damage_sfx  -- Optional. Index of SFX to play on damage

  -- Optional params to change sprite on low health
  health.low_health_amount = low_health_amount
  health.low_health_sprite = low_health_sprite

  health.time_since_last_damage = cooldown_duration
  health.time_since_last_autodamage = 0.0

  health.update = function(self)
    if self.cooldown_duration ~= nil then
      self.time_since_last_damage += DELTA_TIME
    end
    if self.auto_damage_per_second ~= nil then
      -- Hurt ourselves every second
      self.time_since_last_autodamage += DELTA_TIME
      if (self.time_since_last_autodamage > 1.0) then
        self.time_since_last_autodamage = 0
        self:damage(self.auto_damage_per_second)
      end
    end
  end

  health.damage = function(self, damage)
    if (self.cooldown_duration == nil or (self.time_since_last_damage > self.cooldown_duration)) then
      self.health -= damage
      self.time_since_last_damage = 0

      if self.damage_sfx ~= nil then
        -- Play damaged audio
        sfx(self.damage_sfx)
      end

      if low_health_sprite ~= nil and self.health < self.low_health_amount then
        -- Update the sprite when health is low
        self.parent.sprite = self.low_health_sprite
      end

      if self.health < 0.0 and self.death_callback_fn ~= nil then
        -- Do death callback function when dead
        self.death_callback_fn(self.parent)
      end
    end
  end

  health.heal = function(self, health)
    self.health += health
    self.health = min(self.health, 1.0)
  end

  return health
end




-- Linear Interpolation functions

function lerp(a, b, t)
  -- Does a linear interpolation between two points
  return a + (b - a) * t
end

function quad(a, b, t)
  -- Does a quadratic interpolation between two points
  local x = lerp(a, b, t^2)
  return x
end

function bounce(a, b, t)
  -- Does a bounce interpolation between two points
  local x
  if t <= 1/2.75 then
    x = 7.5625 * t * t
  elseif t <= 2/2.75 then
    x = 7.5625 * (t - 1.5/2.75)^2 + .75
  elseif t <= 2.25/2.75 then
    x = 7.5625 * (t - 2.25/2.75)^2 + .9375
  elseif t <= 1 then
    x = 7.5625 * (t - 2.625/2.75)^2 + .984375
  end
  return lerp(a, b, x)
end

-- Palette functions
function set_palette(palette)
  if palette == PALETTE_ORANGE then
    return
  elseif palette == PALETTE_GREEN then
    pal(9,  3)
    pal(10, 11)
  elseif palette == PALETTE_BLUE then
    pal(9,  1)
    pal(10, 12)
    pal(4, 0)
  elseif palette == PALETTE_GREY then
    pal(9,  5)
    pal(10, 6)
  end
end

function reset_palette()
  pal(9,  9)
  pal(10, 10)
  pal(4, 4)
end

-- Vector functions

function v_add(v1, v2)
  return {v1[1] + v2[1], v1[2] + v2[2]}
end

function v_in_rect(v, left, top, right, bottom)
  return top < v[2] and v[2] < bottom and left < v[1] and v[1] < right
end

function lines_overlapping(min1, max1, min2, max2)
  -- Checks if 2 parallel lines are overlapping two other parallel lines
  return max1 > min2 and max2 > min1
end


-- Rect functions

function rects_are_colliding(r1, r2)
  -- Determines if two rects are colliding
  local top = r1.y
  local bottom = top + r1.h
  local left = r1.x
  local right = left + r1.w
  local r2_top = r2.y
  local r2_bottom = r2_top + r2.h
  local r2_left = r2.x
  local r2_right = r2_left + r2.w

  local horizontal_collision = lines_overlapping(left, right, r2_left, r2_right)
  local vertical_collision = lines_overlapping(top, bottom, r2_top, r2_bottom)

  return horizontal_collision and vertical_collision
end


-- Utility functions


__gfx__
000000007777f77f777777777f7777f97f7777f999999999999999999999999999f7777799f77777000000994999000000000000000000000000000000000000
0000000077f777777f777f7777777f9977777f999f9f9999f9f9f9f99999f9f99f77f7f79f7f7f77000999494999990000000000000000000000000000000000
0070070077777f77777f7777777f77f9777f77f9f777f9997f7f7f7f99ff7f7f99f7777799f7777f009999999944499000000000000000000000000000000000
00077000f77777777f777f7f7f7777f97f777f9977777f99777777779f7777f79f7f77f79f777777099449949499949000000000000000000000000000000000
000770007777f7777777777777777f99777777f977f777f9777f777f99f7f77799f7777799f77f77994999499949999900000000000000000000000000000000
0070070077f7777ff7f7f7f7f7f7f999777f7f9977777f997f777f779f77777f9f777f77999ff7f7999994999994999900000000000000000000000000000000
00000000777777779f9f9f9f9f9f99997f7777f97f7f77f9777f777799f777f799f7777799999f9f99999999f994999900000000000000000000000000000000
000000007f7777f7999999999999999977777f9977777f99777777779f77f7779f77f7f79999999999e49999fe999e9900000000000000000000000000000000
000000000000000099999999000000000000000000000000000000000000000000000000000000009ee999eefee99e0900000000000000000000000000000000
000000000000000099999999000000000000000000000000000000000000000000000000000000009e999eeef9e9900900000000000000000000000000000000
0000000000000000999999990000000000000000000000000000000000000000000000000000000090999eeef990900900000000000000000000000000000000
00000000000000009999999900000000000000000000000000000000000000000000000000000000909909eff990900900000000000000000000000000000000
000000000000000099999999000000000000000000000000000000000000000000000000000000009099099ff990900000000000000000000000000000000000
000000000000000099999999000000000000000000000000000000000000000000000000000000000090099ff990900000000000000000000000000000000000
000000000000000099999999000000000000000000000000000000000000000000000000000000000090009ff900900000000000000000000000000000000000
000000000000000099999999000000000000000000000000000000000000000000000000000000000090009ff900000000000000000000000000000000000000
00eeee0000999e0e0e9999000eeeeee0009ee90000999900e09999000099990000999900000000000090009ff900000000000000000000000000000000000000
0eeeeee0097aaae009eaaa9eeeeeeeee0eeeeee0097aaa900eeeeee0097aaa90097aaa90000000000000009f9400000000000000000000000000000000000000
974aa4a9974aaeae974eeee9ee4ee4ee974ee4a9974aa4a9e74aa4a9974aa4a9974aa4a9000000000000009f9400000000000000000000000000000000000000
9a2aa2a99a2aa2a99a2aeee9ee2ae2ae9a2aa2a99a2ee2a99a2aa2a99e2aa2e99a2aa2a9000000000000009ff400000000000000000000000000000000000000
ee9aa9eeee9aa9eeee9aaeeeee9aa9eeee9aa9eeee9ee9eeee9aa9eeee9aa9eeee9aa9ee000000000000009ff400000000000000000000000000000000000000
09a44a9009a44a9009a44a9009a44a9009a44a9009a44a9009a44a90eea44aee09a44a90000000000000009f9400000000000000000000000000000000000000
00999900009999000099990000999900009999000099990000999900ee9999ee0099990000000000000009ff9940000000000000000000000000000000000000
09900990099009900990099009900990099009900990099009900990099009900990099000000000000009ff9940000000000000000000000000000000000000
0099990000999900009999000099990000eeee00e099990ee099990eeeeeeeee000000000000000000004ffff940000000000000000000000000000000000000
097aaa90097aaa90097aaa90097aaa900eeeeee00e7aaae0eeeeeeeee97aaa9e000000000000000000004ffff940000000097900000000000000000000000000
974aa4a97eeee7ee974aa4a9974aa4a9ee4aa4ee974aa4a9e74ee4aee74aa4ae000000000000000000004f999994000000979990000000000000000000000000
9a2aa2a9e7eeee7e9a2aa2a99a2aa2a9ee2aa2ee9a2aa2a9ea2ee2aeea2aa2ae000000000000000000049ffff9f9400000979990000000000000000000000000
ee9aa9eeee7aaee7eeeeeeeeee9aa9eeee9aa9eeee9aa9eeeeeaaeeeee9aa9ee000000000000000000049ffffff9400009999998000000000000000000000000
09a44a9009a44a900eeeeee009a44a900eeeeee009a44a900ea44ae0e9a44a9e0000000000000000000499f99999400009999998000000000000000000000000
00eeee000099990000eeee0000eeee0000eeee000099990000999900e099990e0000000000000000000449999994400008999980000000000000000000000000
0eaeeae009900990099ee9900ee00ee00ee00ee00990099009900990eeeeeeee0000000000000000000044444444000000888800000000000000000000000000
0e8eeee00e8eeee00e8eeee0000000000000000000000000e000000e000000000000000000000000000000000000000000000000000000000000000000000000
888888808888888088888880000000000000000000000000ee0000eeee00000000eeeee0000ee00000000000e000000000000000000000000000000000000000
099a9a90099a9a90099a9a90000000000000000000000000eee00eee44e000000eeeeeee00eeee00000ee0000e00000000e4ee00000000000000000000000000
09aaaa9009aaaa9009aaaa90000000000000000000eeee00eeeeeeee004e000eee4ee4eeeeeeeeee00eeee4000eeeeeeeee4eee4000000000000000000000000
00999990009999900099999000000000000000000eeeeee0eee40eee0004eee4ee4e40ee444ee44400eeee4000eeeeeeeee4eee4000000000000000000000000
099eee90099eee90099eee900000000000000000eeeeeeeeee4004ee0004eee4e444004e000ee400004ee4000e444444eee4eee4000000000000000000000000
009999900999999000999990000000000000000044444444e400004e00004e404e4004e40004400000044000e400000044404440000000000000000000000000
09900990000009900990000000000000000000000000000000000000000004000400004000000000000000004000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000eeee00000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000077777700eeeeee000000000e000000e0eeeeee4000000000000000000000000
0000000000000000000000000000000000000000eeeeeeee7eeee7eeeeeeeeee0eeeeee4eeeeeeeee000000eeeeeeeee0eeeeee4000000000000000000000000
000000000000000000000000000000000000000044eeee44e7eeee7e4eeeeee40ee40ee4eeeeeeeeee0000eee00ee00e0eeeeee4000000000000000000000000
0000000000000000000000000000000000000000004ee400ee744ee704eeee400ee40ee4eeeeeeee4ee00ee4e00ee00e0eeeeee4000000000000000000000000
00000000000000000000000000000000000000000004400044400444004ee4000ee40ee44eeeeee404e40e40eee44eee0eeeeee4000000000000000000000000
00000000000000000000000000000000000000000000000000000000000440000ee40ee404eeee40004004004e4004e40eeeeee4000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000044004400ee44ee0000000000400004004444444000000000000000000000000
00eeee0000999e0e0e9999000eeeeee0009ee90000999900e0999900009999000099990000000000000000000000000000000000000000000000000000000000
0eeeeee0097aaae009eaaa9eeeeeeeee0eeeeee0097aaa900eeeeee0097aaa90097aaa9000000000000000000000000000000000000000000000000000000000
974aa4a9974aaeae974eeee9ee4ee4ee974ee4a9974aa4a9e74aa4a9974aa4a9974aa4a900000000000000000000000000000000000000000000000000000000
9a2aa2a99a2aa2a99a2aeee9ee2ae2ae9a2aa2a99a2ee2a99a2aa2a99e2aa2e99a2aa2a900000000000000000000000000000000000000000000000000000000
ee9aa9eeee9aa9eeee9aaeeeee9aa9eeee9aa9eeee9ee9eeee9aa9eeee9aa9eeee9aa9ee00000000000000000000000000000000000000000000000000000000
09a44a9009a44a9009a44a9009a44a9009a44a9009a44a9009a44a90eea44aee09a44a9000000000000000000000000000000000000000000000000000000000
09999900099999000999990009999900099999000999990009999900ee9999ee0999990000000000000000000000000000000000000000000000000000000000
00000990000009900000099000000990000009900000099000000990000009900000099000000000000000000000000000000000000000000000000000000000
0099990000999900009999000099990000eeee00e099990ee099990eeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
097aaa90097aaa90097aaa90097aaa900eeeeee00e7aaae0eeeeeeeee97aaa9e0000000000000000000000000000000000091100000000000000000000000000
974aa4a97eeee7ee974aa4a9974aa4a9ee4aa4ee974aa4a9e74ee4aee74aa4ae0000000000000000000000000000000000911990000000000000000000000000
9a2aa2a9e7eeee7e9a2aa2a99a2aa2a9ee2aa2ee9a2aa2a9ea2ee2aeea2aa2ae0000000000000000000000000000000000911990000000000000000000000000
ee9aa9eeee7aaee7eeeeeeeeee9aa9eeee9aa9eeee9aa9eeeeeaaeeeee9aa9ee0000000000000000000000000000000009119198000000000000000000000000
09a44a9009a44a900eeeeee009a44a900eeeeee009a44a900ea44ae0e9a44a9e0000000000000000000000000000000009199918000000000000000000000000
0eeeee000999990009eeee000eeeee000eeeee000999990009999900e999990e0000000000000000000000000000000001999980000000000000000000000000
000eeae000000990000ee99000000ee000000ee00000099000000990eeeeeeee0000000000000000000000000000000000888800000000000000000000000000
90000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9a0000a9a990099a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09900990901991090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00199100904994090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00499400009119000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90911909091111900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09111190909119090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00911900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00644600008878880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00600600888887880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06000060888787880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06777760788888870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06777760788888700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06777760077777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00eeee0000999e0e0e9999000eeeeee0009ee90000999900e0999900009999000099990000000000000000000000000000000000000000000000000000000000
0eeeeee0097aaae009eaaa9eeeeeeeee0eeeeee0097aaa900eeeeee0097aaa90097aaa9000000000000000000000000000000000000000000000000000000000
974aa4a9974aaeae974eeee9ee4ee4ee974ee4a9974aa4a9e74aa4a9974aa4a9974aa4a900000000000000000000000000000000000000000000000000000000
9a2aa2a99a2aa2a99a2aeee9ee2ae2ae9a2aa2a99a2ee2a99a2aa2a99e2aa2e99a2aa2a900000000000000000000000000000000000000000000000000000000
ee9aa9eeee9aa9eeee9aaeeeee9aa9eeee9aa9eeee9ee9eeee9aa9eeee9aa9eeee9aa9ee00000000000000000000000000000000000000000000000000000000
09a44a9009a44a9009a44a9009a44a9009a44a9009a44a9009a44a90eea44aee09a44a9000000000000000000000000000000000000000000000000000000000
00999990009999900099999000999990009999900099999000999990ee9999ee0099999000000000000000000000000000000000000000000000000000000000
09900000099000000990000009900000099000000990000009900000099000000990000000000000000000000000000000000000000000000000000000000000
0099990000999900009999000099990000eeee00e099990ee099990eeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
097aaa90097aaa90097aaa90097aaa900eeeeee00e7aaae0eeeeeeeee97aaa9e0000000000000000000000000000000000000000000000000000000000000000
974aa4a97eeee7ee974aa4a9974aa4a9ee4aa4ee974aa4a9e74ee4aee74aa4ae0000000000000000000000000000000000000000000000000000000000000000
9a2aa2a9e7eeee7e9a2aa2a99a2aa2a9ee2aa2ee9a2aa2a9ea2ee2aeea2aa2ae0000000000000000000000000000000000000000000000000000000000000000
ee9aa9eeee7aaee7eeeeeeeeee9aa9eeee9aa9eeee9aa9eeeeeaaeeeee9aa9ee0000000000000000000000000000000000000000000000000000000000000000
09a44a9009a44a900eeeeee009a44a900eeeeee009a44a900ea44ae0e9a44a9e0000000000000000000000000000000000000000000000000000000000000000
00eeeee00099999000eeee9000eeeee000eeeee00099999000999990e099999e0000000000000000000000000000000000000000000000000000000000000000
0eaee00009900000099ee0000ee000000ee000000990000009900000eeeeeeee0000000000000000000000000000000000000000000000000000000000000000
00008888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000888888888888000000000000
00088888888888888888888990000000000000000000000000000000000000000000000000000000000000000000000000000008888888888888888000000000
000888888888888888888889990000000000888888888888888800000000000000088888a0000000000000000000000000000008888888888888888880000000
000888888888888888888889999000000000888888888888888888889000000000888888a0000000000000000000000000000888888888888888888888800000
00088888aaaa888888888888999900000000888888888888888888888990000008888888aa000000000000888880000000008888888888888888888888880000
00088888aa00aaaa88888888999900000000888888888888888888888999000008888888aa000000000008888888800000008888888888888888888888888000
00088888a0000000aaa888888999900000008888888888888888888888999000888888888aa000000000888888888880000088888888aaaaaaaaa88888888000
0008888aa00000000008888889999000000088888aaaaaaaa888888888999000888888888aa00000000888888888888800008888888900000000aaa888888000
0088888aa00000000008888889999000000888888aa000000aa8888888999000888888888aaa000000888888888888990000888888890000000000aa88888000
0088888aa00000000008888889999000000888888aa0000000088888899990008888888888aaa000088888888888899900008888888999000000000aa888a000
0088888aa00000000088888889990000000888888aa0000000088888899900008888888888aaaa008888888888889999000088888888899999000000aaaa0000
0088888aa00000888888888899990000000888888aa00000008888889999000008888888888aaaa8888888888889999000008888888888888999900000000000
00888888888888888888888899990000000888888aaa00000888888999900000088888888888aa88888888888899990000000888888888888888899900000000
008888888888888888888889999000000008888888aa008888888899990000000088888888888888888888888999000000000088888888888888888990000000
00888888888888888888889990000000000888888888888888888999900000000008888888888888888888889999000000000000888888888888888889000000
08888888888888888888889000000000008888888888888888889990000000000000088888888888888888899900000000000000008888888888888888990000
08888888888888888888889000000000008888888888888888889900000000000000008888888888888888999900000000000000000088888888888888890000
08888888888888888888888900000000008888888888888888889999000000000000000088888888888899999000000000000000000000888888888888889000
0888888aaaa888888888888890000000008888888888888888889999990000000000000088888888888999900000000000000000000000000008888888889900
088888aa000aaa888888888899000000008888888888888888888999999900000000000000888888888999000000000000000008800000000000008888889900
088888aa000000aa8888888889000000088888888888888888888899999990000000000000088888888990000000000000000888888000000000000888889900
088888a000000000aa888888899000000888888888aaaaaaaaa88889999999900000000000088888888990000000000000008888888800000000000888889900
88888aa00000000000888888899000000888888888aa000000aaa888999999900000000000088888888990000000000000008888888888000000008888889900
88888aa00000000000888888899000000888888888aa000000000888889999990000000000088888888990000000000000088888888888880000008888889900
88888aa00000000000888888899000000888888888aa000000008888888999990000000000088888888990000000000000088888888888888888888888899900
88888aa00000000008888888999000000888888888aa000000008888888999990000000000088888888990000000000000098888888888888888888888899900
8888888888888888888888899990000088888888888aa00008888888888999990000000000088888888990000000000000099998888888888888888888899900
88888888888888888888889999900000888888888888888888888888889999990000000000088888888990000000000000009999888888888888888888999000
88888888888888888888899999900000999998888888888888888899999999990000000000088888889990000000000000000099998888888888888888999000
99999998888888888889999999000000999999999998899999999999999999000000000000099999999900000000000000000099999998888888888999990000
99999999999999999999999900000000099999999999999999999999990000000000000000000999999000000000000000000009999999999988899999900000
99999999999999999999000000000000000000009999999999999000000000000000000000000000000000000000000000000000999999999999999999000000
__gff__
0000000000000000000000000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1212121212121212121212121212121200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1207060606060606060606060606051200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1208010101010101010101010101041200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1209020202020202020202020202031200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1212121212121212121212121212121200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000e03000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00090000130501e050290502e05015050060500205002050010500200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000900000b2501a250282501625035250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003b630316302e63031630243301b3200533000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
