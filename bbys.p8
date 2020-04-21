pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

-- DEBUG CONTROLS
DEBUG = true

-- Constants
MAP_SIZE_X = 16
MAP_SIZE_Y = 16

-- Palettes that bbys can be
PALETTE_ORANGE = 0
PALETTE_GREEN = 1
PALETTE_BLUE = 2
PALETTE_GREY = 3

-- Other Palettes
PALETTE_PINK = 4
PALETTE_BLACK = 5

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
  "NOODL", "JEFF", "GORBY", "VINNY", "BBYCAKE", "CHARLI", "BBYJESUS", "TIPPR", "MAMA", "BABA", "DAN", "LUA", "LUNA",
  "GOOBY", "GARFO", "BBYHITLR", "MR BBY", "CARL", "UGLI", "QTBBY", "MARI", "GRINCH", "CONWAY", "GARTH",
  "MARK", "TOM", "SPUD", "ADRI", "LINDA", "RAINY", "FROGI", "MARSHL", "SEAN", "SANS", "ANG", "GENO", "MARIO", "PEACH",
  "DAISY", "BRIT", "KYLE", "TESS", "NIC", "NICK", "RYAN", "HALY", "TERAN", "WINDY", "KENNY"
}

BBY_NAMES_LENGTH = 0
for _, _ in pairs(BBY_NAMES) do BBY_NAMES_LENGTH += 1 end

TOP_COLLISION = 0
BOTTOM_COLLISION = 1
LEFT_COLLISION = 2
RIGHT_COLLISION = 3

TILE_UNWALKABLE = 0

SFX_UNDEFINED = 0
SFX_CONSUME_FOOD = 1
SFX_CONSUME_ITEM = 2
SFX_HIT_ROCK = 3
SFX_UNDEFINED = 4
SFX_PUSH_BBY = 5
SFX_TOGGLE_UI = 6
SFX_BBY_DEATH = 7
SFX_ENEMY_DEATH = 8
SFX_BBY_DAMAGED = 9
SFX_ENEMY_DAMAGED = 10
SFX_HEAL_ALL_BBYS = 11
SFX_SCRAMBLE_CHARS = 12
SFX_CRASH = 13
SFX_TALK = 14

MUSIC_SPLASH_SCREEN = 50
MUSIC_LVL1 = 0
MUSIC_HELL = 20

MUSIC_BITMASK = 3

-- Globals
IN_SPLASH_SCREEN = true
IN_PLAYER_LOST_SCREEN = false
DISPLAY_NAMEBAR_UI = true
SPLASH_SCREEN_Y_POS = 0
LAST_CHECKED_TIME = 0.0
DELTA_TIME = 0.0  -- time since last frame
UNLOCKED_PALETTES = {PALETTE_ORANGE}

-- Use all palettes in debug mode
if DEBUG then UNLOCKED_PALETTES = PALETTES end


-- Game Loop 🅾️_🅾️
function _init()
  print("welcome 🅾️_🅾️♥")

  music(MUSIC_SPLASH_SCREEN, 0, MUSIC_BITMASK)
end

function _update()
  local t = time()
  DELTA_TIME = t - LAST_CHECKED_TIME
  LAST_CHECKED_TIME = t
  if IN_SPLASH_SCREEN then
    get_splash_screen_input()
  elseif IN_PLAYER_LOST_SCREEN then
    get_player_lost_input()
  else
    -- Update level manager
    level_manager:update()

    player:update()

    -- Update bby physics
    for _, bby in pairs(bbys) do 
      bby:update()
    end

    -- Update enemy physics
    for _, enemy in pairs(enemies.enemies) do 
      enemy:update()
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
  elseif IN_PLAYER_LOST_SCREEN then
    draw_player_lost_message()
  else
    -- Clear screen
    cls()

    -- Draw the Level Manager
    level_manager:draw()

    -- Draw the rocks
    set_palette(level_manager.map_palette)
    for _, rock in pairs(rocks.rocks) do 
      rock:draw() 
    end
    reset_palette()

    -- Draw the foods
    for _, food in pairs(foods.foods) do 
      food:draw() 
    end

    -- Draw the items
    for _, item in pairs(items.items) do 
      item:draw() 
    end

    -- Table of character to draw in order of y axis
    local draw_table = {}
    draw_table[1] = player
    merge_tables(draw_table, bbys)
    merge_tables(draw_table, enemies.enemies)
    sort_table_by_pos(draw_table, 2)

    for _, character in pairs(draw_table) do 
      character:draw()
    end

    -- Draw stage specific ui updates
    level_manager:draw_stage_ui()

  end
end

-- Splash screen code

function get_splash_screen_input()
  if (btnp(4)) then 
    IN_SPLASH_SCREEN = false
    make_level_manager()
  end
end

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

function get_player_lost_input()
  if (btnp(4)) then 
    IN_PLAYER_LOST_SCREEN = false
    level_manager:reset_level()
  end
end

function draw_player_lost_message()
  level_manager:draw_msg(
    tile_to_pixel_pos({8, 7}),
    ":(  🐱 BBY DIED 🐱  :(  ", 
    PALETTE_GREY)
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

function tile_to_pixel_pos(tile_coord)
  -- Given the coordinate of a tile, translate that to pixel values
  return {tile_coord[1] * 8, tile_coord[2] * 8}
end

function tile_pos_to_rect(tile_coord)
  -- Given the coordinate of a tile, translate that to a rect of the tile
  local pixel_coords = tile_to_pixel_pos(tile_coord)
  return {x=pixel_coords[1], y=pixel_coords[2], w=8, h=8 }
end

function pixel_to_tile_pos(pixel_coord)
  -- Given coordinates in pixels, translate that to a tile position
  return {pixel_coord[1] / 8, pixel_coord[2] / 8}
end

function tile_has_flag(x, y, flag)
  local tile = mget(x, y)
  local has_flag = fget(tile, flag)
  return has_flag
end

function can_move(pos)
  tile_coord = pixel_to_tile_pos(pos)
  return not tile_has_flag(tile_coord[1], tile_coord[2], TILE_UNWALKABLE)
end

-- Level manager code
function make_level_manager()
  level_manager = {}

  level_manager.level = 3
  level_manager.stage = 1  -- The progression of the current level
  level_manager.stage_duration = 5
  level_manager.final_level = 5

  -- Number of stages for each level, listed sequentially
  level_manager.stage_count = {2, 27, 40, 28}
  level_manager.map_bounds = {x=1*8, y=1*8, w=15*8, h=15*8}  -- Rect of map bounds

  level_manager.enemy_spawn_tl = {0, 0}
  level_manager.enemy_spawn_t = {8, 0}
  level_manager.enemy_spawn_tr = {17, 0}
  level_manager.enemy_spawn_r = {17, 8}
  level_manager.enemy_spawn_br = {17, 17}
  level_manager.enemy_spawn_b = {8, 17}
  level_manager.enemy_spawn_bl = {0, 17}
  level_manager.enemy_spawn_l = {0, 8}

  level_manager.message_pos = tile_to_pixel_pos({8.5, 2})  -- position on screen to display dialogue messages at

  level_manager.time_since_last_stage = 0

  level_manager.map_palette = nil

  -- Components

  -- do_for that can be edited from anywhere. Hotswap the callback_fn and do start() to run it
  level_manager.ui_do_for = make_do_for(level_manager, 2.5, nil)  

  level_manager.init_level = function(self)
    -- Play music on first 4 levels
    music(MUSIC_LVL1, 0, MUSIC_BITMASK)

    make_player()
    make_items()
    make_foods()
    make_bbys()
    make_enemies()
    make_rocks()

    self.stage = 1

    if DEBUG then
        make_bby({9, 7})
        -- make_bby({9, 8})
        -- make_bby({9, 9})
        -- make_bby({9, 10})
        -- make_bby({9, 11})

        make_rock({3, 3})
        make_rock({3, 5})
        make_rock({3, 7})
        make_rock({3, 9})

        make_enemy({16, 16})

        items.create_all_items_randomly()

      return
    end

    if self.level == 1 then
      local rock_pos = {
        {4, 3}, {4, 5}, {4, 7}, {4, 9}, {4, 11}, {4, 13},
        {13, 12}, {13, 10}, {13, 8}, {13, 6}, {13, 4}
      }
      make_rocks(rock_pos)

      UNLOCKED_PALETTES = {PALETTE_ORANGE}
    elseif self.level == 2 then
      self.map_palette = PALETTE_GREEN
      local rock_pos = {
        {3, 4}, {5, 4}, {7, 4}, {9, 4}, {11, 4}, {13, 4},
        {4, 3}, {4, 5}, {4, 7}, {4, 9}, {4, 11}, {4, 13},
        {13, 12}, {13, 10}, {13, 8}, {13, 6}, 
      }
      make_rocks(rock_pos)

      UNLOCKED_PALETTES = {PALETTE_ORANGE, PALETTE_GREEN}
    elseif self.level == 3 then
      self.map_palette = PALETTE_BLUE
      local rock_pos = {
        {3, 4}, {5, 4}, {7, 4}, {9, 4}, {11, 4}, {13, 4},
        {4, 3}, {4, 5}, {4, 7}, {4, 9}, {4, 11}, {4, 13},
        {13, 14}, {13, 12}, {13, 10}, {13, 8}, {13, 6},
        {6, 13}, {8, 13}, {10, 13}, {12, 13}, {14, 13},
      }
      make_rocks(rock_pos)
    elseif self.level == 4 then
      self.map_palette = PALETTE_ORANGE
    end

  end

  level_manager.reset_level = function(self)
    self:destroy_level()
    self:init_level()
    self:init_stage()
  end

  level_manager.destroy_level = function(self)
    -- Reset all level components
    -- player = player
    items.items = {}
    foods.foods = {}
    rocks.rocks = {}
    enemies.enemies = {}
    bbys = {}

  end

  level_manager.init_stage = function(self)
    if DEBUG then
      return
    end

    if self.stage == 20 and self.level < 4then
      -- Replay the music if it's stopped
      music(MUSIC_LVL1, 0, MUSIC_BITMASK)
    end

    if DEBUG then return end

    -- Called once each time a new stage is entered
    if self.level == 1 then
      if self.stage == 1 then
        self:draw_ui_msg("HI THERE 🅾️O🅾️  ")
        sfx(SFX_TALK)
        make_bby({8, 6})
      elseif self.stage == 2 then
        self:draw_ui_msg("THIS IS UR BBY! 🅾️U🅾️  ")
        sfx(SFX_TALK)
      elseif self.stage == 3 then
        self:draw_ui_msg("MOVE HER WITH A PUSH ♥ ")
        sfx(SFX_TALK)
      elseif self.stage == 4 then
        self:draw_ui_msg("SHE HUNGR. HIT ROCK 4 FOOD!!")
        sfx(SFX_TALK)
      elseif self.stage == 5 then
        self:draw_ui_msg("BUT MOST IMPORTANT... 🅾️_🅾️  ")
        sfx(SFX_TALK)
      elseif self.stage == 6 then
        self:draw_ui_msg("SAVE HER FROM BEIN FOOD ❎~❎  ")
        sfx(SFX_TALK)
        make_enemy(self.enemy_spawn_b)
      elseif self.stage == 9 then
        make_enemy(self.enemy_spawn_b)
        make_enemy(self.enemy_spawn_b)
      elseif self.stage == 12 then
        make_enemy(self.enemy_spawn_l)
        make_enemy(self.enemy_spawn_r)
      elseif self.stage == 15 then
        make_enemy(self.enemy_spawn_r)
      elseif self.stage == 19 then
        make_enemy(self.enemy_spawn_t)
        make_enemy(self.enemy_spawn_b)
        make_enemy(self.enemy_spawn_l)
        make_enemy(self.enemy_spawn_r)
      end
    elseif self.level == 2 then
      if self.stage == 1 then
        make_bby({8, 6}, PALETTE_ORANGE)
        self:draw_ui_msg("HEWWO! ^o^ SO SRY 2 SEE...")
        sfx(SFX_TALK)
      elseif self.stage == 2 then
        self:draw_ui_msg("  ...  ")
        sfx(SFX_TALK)
      elseif self.stage == 3 then
        self:draw_ui_msg("WUT ❎∧🅾️ UR BBY ALIVE?   ")
        sfx(SFX_TALK)
      elseif self.stage == 4 then
        make_bby({8, 7}, PALETTE_GREEN)
        self:draw_ui_msg("WELL.. I GIVE U MORE BBY")
        sfx(SFX_TALK)
      elseif self.stage == 5 then
        self:draw_ui_msg("GOOD LUCK. >->")
        sfx(SFX_TALK)
      elseif self.stage == 6 then
        make_enemy(self.enemy_spawn_b, PALETTE_GREEN)
      elseif self.stage == 10 then
        -- Enemies go only after new bby
        make_enemy(self.enemy_spawn_l, PALETTE_GREEN)
      elseif self.stage == 15 then
        -- Two more enemies from the same location go after other bby
        make_enemy(self.enemy_spawn_t, PALETTE_ORANGE)
        make_enemy(self.enemy_spawn_r, PALETTE_ORANGE)
      elseif self.stage == 19 then
        make_enemy(self.enemy_spawn_t, PALETTE_GREEN)
      elseif self.stage == 20 then
        make_enemy(self.enemy_spawn_b, PALETTE_GREEN)
      elseif self.stage == 21 then
        make_enemy(self.enemy_spawn_r, PALETTE_ORANGE)
      elseif self.stage == 22 then
        make_enemy(self.enemy_spawn_l, PALETTE_GREEN)
      end
    elseif self.level == 3 then
      if self.stage == 1 then
        self:draw_ui_msg("...")
        sfx(SFX_TALK)
        make_bby({8, 6}, PALETTE_ORANGE)
        make_bby({8, 7}, PALETTE_GREEN)
      elseif self.stage == 2 then
        self:draw_ui_msg("XCUSE ME 🅾️_🅾️  ")
        sfx(SFX_TALK)
      elseif self.stage == 3 then
        self:draw_ui_msg("...I MEAN... ♪_♪  ")
        sfx(SFX_TALK)
      elseif self.stage == 4 then
        self:draw_ui_msg("R U RLY STIL ALIVE")
        sfx(SFX_TALK)
      elseif self.stage == 5 then
        self:draw_ui_msg("TAKE THIS ONE THEN")
        sfx(SFX_TALK)
        make_bby({8, 7}, PALETTE_BLUE)
      elseif self.stage == 7 then
        make_enemy(self.enemy_spawn_bl, PALETTE_BLUE)
      elseif self.stage == 8 then
        make_enemy(self.enemy_spawn_br, PALETTE_BLUE)
      elseif self.stage == 13 then
        make_enemy(self.enemy_spawn_l, PALETTE_GREEN)
        make_enemy(self.enemy_spawn_r, PALETTE_ORANGE)
      elseif self.stage == 17 then
        make_enemy(self.enemy_spawn_tl, PALETTE_BLUE)
        make_enemy(self.enemy_spawn_bl, PALETTE_GREEN)
      elseif self.stage == 22 then
        self:draw_ui_msg("...")
        sfx(SFX_TALK)
      elseif self.stage == 23 then
        self:draw_ui_msg("WHAT THE SH*T")
        sfx(SFX_TALK)
      elseif self.stage == 24 then
        self:draw_ui_msg("WHY WONT THEY DIE")
        sfx(SFX_TALK)
      elseif self.stage == 25 then
        self:draw_ui_msg("WHY DO U PROTECT THEM")
        sfx(SFX_TALK)
      elseif self.stage == 26 then
        self:draw_ui_msg("U DONT LOVE THEM")
        sfx(SFX_TALK)
      elseif self.stage == 27 then
        self:draw_ui_msg("NOBODY LOVES THEM")
        sfx(SFX_TALK)
      elseif self.stage == 28 then
        self:draw_ui_msg("...")
        sfx(SFX_TALK)
      elseif self.stage == 29 then
        self:draw_ui_msg("HERE COME THE MNSTERS ☉∧☉   ")
        sfx(SFX_TALK)
      elseif self.stage == 30 then
        make_enemy(self.enemy_spawn_tl, PALETTE_BLUE)
        make_enemy(self.enemy_spawn_tr, PALETTE_GREEN)
        make_enemy(self.enemy_spawn_bl, PALETTE_ORANGE)
        make_enemy(self.enemy_spawn_br, PALETTE_BLUE)
      elseif self.stage == 31 then
        make_enemy(self.enemy_spawn_t, PALETTE_BLUE)
      elseif self.stage == 32 then
        make_enemy(self.enemy_spawn_b, PALETTE_ORANGE)
      elseif self.stage == 33 then
        make_enemy(self.enemy_spawn_b, PALETTE_GREEN)
      end
    elseif self.level == 4 then
      if self.stage == 1 then
        self:draw_ui_msg("HEY BUDDI... I THNK MAYBE...")
        sfx(SFX_TALK)
      elseif self.stage == 2 then
        self:draw_ui_msg("WE GOT OFF ON WRONG FOOT.")
        sfx(SFX_TALK)
        music(-1, 3000)
      elseif self.stage == 3 then
        self:draw_ui_msg("MAYB WE CAN TRY AGAIN")
        sfx(SFX_TALK)
      elseif self.stage == 4 then
        self:draw_ui_msg("I JUST WANTED 2 SAY")
        sfx(SFX_TALK)
      elseif self.stage == 5 then
        self:draw_ui_msg(".welcom to hell mothr fuckr.", 
          PALETTE_BLACK)
        sfx(SFX_CRASH)
        music(MUSIC_HELL, 0, MUSIC_BITMASK)
        self.map_palette = PALETTE_BLACK
      end
    elseif self.level == self.final_level then
      bby1=make_bby({2, 14}, PALETTE_ORANGE)
      bby1.wanderer.active = false
      bby2=make_bby({6, 14}, PALETTE_GREEN)
      bby2.wanderer.active = false
      bby3=make_bby({10, 14}, PALETTE_BLUE)
      bby3.wanderer.active = false
      bby4=make_bby({14, 14}, PALETTE_GREY)
      bby4.wanderer.active = false
    end
  end

  level_manager.draw_stage_ui = function(self)
    -- Called each frame for stage_specific ui updates

    -- Update our ui do_for that let's us spawn messages
    self.ui_do_for:update()
  end

  level_manager.update = function(self)
    self.time_since_last_stage += DELTA_TIME

    -- Toggle display of namebar ui
    if (btnp(5)) then 
      sfx(SFX_TOGGLE_UI)
      DISPLAY_NAMEBAR_UI = not DISPLAY_NAMEBAR_UI
    end

    if self.level < self.final_level then

      -- Keep player and bbys in map bounds
      self:keep_in_map_bounds()

      if self.time_since_last_stage > self.stage_duration then
        -- Next stage
        self.time_since_last_stage = 0
        self.stage += 1
        self:init_stage()
      end

      if self.stage > self.stage_count[self.level] then
        -- Next level
        self.time_since_last_stage = 0
        self.level += 1
        self:destroy_level()
        self:init_level()
        self:init_stage()
      end
    end

  end

  level_manager.draw = function(self)
    set_palette(self.map_palette)
    self:draw_map() 
    reset_palette()
  end

  level_manager.draw_map = function(self)
    camera(8, 8)
    map(0, 0, 0, 0, 18, 18)
  end

  level_manager.keep_in_map_bounds = function(self)
    -- Keep player in map bounds
    if player.pos[2] < self.map_bounds.y then
      -- top
      player.pos[2] = self.map_bounds.y
    end
    if player.pos[2] > self.map_bounds.y + self.map_bounds.h then
      -- bottom
      player.pos[2] = self.map_bounds.y + self.map_bounds.h 
    end
    if player.pos[1] < self.map_bounds.x then
      -- left
      player.pos[1] = self.map_bounds.x
    end
    if player.pos[1] > self.map_bounds.x + self.map_bounds.w then
      -- bottom
      player.pos[1] = self.map_bounds.x + self.map_bounds.w
    end

    -- Keep bbys in map bounds
    for _, bby in pairs(bbys) do
      -- Add/subtract 8 for one tile difference with bbys (they can't go all the way to the edge)
      if bby.pos[2] < self.map_bounds.y + 8 then
        -- top
        bby.pos[2] = self.map_bounds.y + 8
      end
      if bby.pos[2] > self.map_bounds.y + self.map_bounds.h - 8 then
        -- bottom
        bby.pos[2] = self.map_bounds.y + self.map_bounds.h - 8
      end
      if bby.pos[1] < self.map_bounds.x + 8 then
        -- left
        bby.pos[1] = self.map_bounds.x + 8
      end
      if bby.pos[1] > self.map_bounds.x + self.map_bounds.w - 8 then
        -- bottom
        bby.pos[1] = self.map_bounds.x + self.map_bounds.w - 8
      end
    end
  end

  level_manager.draw_ui_msg = function(self, msg, palette, duration, dont_overwrite)
    if dont_overwrite and self.ui_do_for.time_left > 0 then
      return
    end 
    self.ui_do_for.callback_fn = function(l)
      l:draw_msg(self.message_pos, msg, palette)
    end 
    if duration then
      self.ui_do_for.duration = duration
    else
      self.ui_do_for.duration = 5
    end
    self.ui_do_for:start()
  end

  level_manager.draw_msg = function(self, center_pos, msg, palette, display_namebar, bar_length)

    if display_namebar or display_namebar == nil then
      msg_length = #msg
    else
      -- Trim the message length if we're not display the full name bar
      msg_length = 2
    end

    local bar_length = bar_length
    if bar_length ~= nil then
      -- bar_length should be between 0.0 and 1.0
      local bar_length = max(0.0, bar_length or 1.0)
    end
    local padding = 2
    local x_pos = center_pos[1] + 5 - msg_length * 4 / 2 
    local y_pos = center_pos[2]
    local bg_color = 6

    -- PALETTE_GREY IS DEFAULT 
    if (palette != nil) then
      if palette == PALETTE_ORANGE then
        bg_color = 9
      elseif palette == PALETTE_GREEN then
        bg_color = 3  -- dark green
      elseif palette == PALETTE_BLUE then
        bg_color = 12
      elseif palette == PALETTE_PINK then
        bg_color = 14
      elseif palette == PALETTE_BLACK then
        bg_color = 8  -- Palette black has red background for text boxes
      end
    end

    if (display_namebar or display_namebar == nil) then
      -- Draw Message Background Rectangle
      rectfill(
        x_pos - padding,
        y_pos - padding,
        x_pos + msg_length * 4 ,
        y_pos + 5,
        bg_color)

      -- Draw message
      print(msg, x_pos, y_pos - 1, 0)
    end

    -- Draw bar
    if (bar_length) then
      local bar_bg_color = 0
      local bar_fill_color = 8

      -- Bar Background
      line(
        x_pos - padding,
        y_pos + 5,
        x_pos + msg_length * 4,
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
          x_pos - padding + (((msg_length * 4) + padding) * bar_length),
          y_pos + 5,
          bar_fill_color
        )
      end
    end
  end

  level_manager:init_level()
  level_manager:init_stage()

  return level_manager

end

-- Player code

function make_player(pos)
  player = {}

  -- Configurations
  player.max_speed = 1.0
  player.damage_to_rocks = 0.1

  player.pos = tile_to_pixel_pos(pos or {8, 8})
  player.sprite = 64
  player.v = {0, 0}
  player.active = true

  player.max_speed_collision_modifier = 2.0  -- Amount to set max_speed to when colliding with a bby with pants
  player.default_speed = player.max_speed

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
    self.collider:update()
    self:collide()
    self:update_position()
  end

  player.update_position = function(self)
    -- Update position based on velocity
    self.pos = v_add(self.pos, self.v)
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

    -- Do animation if we moved
    self.animator.animation_flag = did_move
    if x_change > 0 then self.animator.flip_sprite = true elseif x_change < 0 then self.animator.flip_sprite = false end

  end

  player.collide = function(self)
    -- Do bby collision
    local touching_bby_with_pants = false
    for _, bby in pairs(bbys) do
      if self.collider:is_colliding(bby) then

        if bby.current_item ~= nil and bby.current_item.sprite == 88 then
          -- Run faster when we're touching a baby with pants on
          self.max_speed = self.max_speed_collision_modifier
          touching_bby_with_pants = true
        end

        if bby.is_colliding_with_unwalkable then
          -- BBY is colliding with unwalkable. We can't move this way
          local collision_direction = self.collider:get_collision_direction(bby)
          if collision_direction == TOP_COLLISION then
            -- Colliding top
            self.pos[2] = bby.pos[2] + bby.collider.rect.h
          elseif collision_direction == BOTTOM_COLLISION then
            -- Colliding bottom
            self.pos[2] = bby.pos[2] - bby.collider.rect.h
          elseif collision_direction == LEFT_COLLISION then
            -- Colliding left
            self.pos[1] = bby.pos[1] + bby.collider.rect.w
          elseif collision_direction == RIGHT_COLLISION then
            -- Colliding right
            self.pos[1] = bby.pos[1] - bby.collider.rect.w
          end
        else
          sfx(SFX_PUSH_BBY)
          bby.push_index = 1
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
            -- Colliding right
            bby.pos[1] = self.pos[1] + self.collider.rect.w
          end
        end
      elseif not bby.is_pushed_by_bby then
        bby.push_index = 0
      end
    end

    if not touching_bby_with_pants then
      self.max_speed = self.default_speed
    end

    -- Do enemy collision
    for _, enemy in pairs(enemies.enemies) do
      if enemy.active and self.collider:is_colliding(enemy) then
        -- Potentially let player damage enemies!
        -- enemy.health:damage(self.damage_to_enemies)
        local collision_direction = self.collider:get_collision_direction(enemy)
        if collision_direction == TOP_COLLISION then
          -- Colliding top
          self.pos[2] = enemy.pos[2] + self.collider.rect.h
        elseif collision_direction == BOTTOM_COLLISION then
          -- Colliding bottom
          self.pos[2] = enemy.pos[2] - self.collider.rect.h
        elseif collision_direction == LEFT_COLLISION then
          -- Colliding left
          self.pos[1] = enemy.pos[1] + self.collider.rect.w
        elseif collision_direction == RIGHT_COLLISION then
          -- Colliding right
          self.pos[1] = enemy.pos[1] - self.collider.rect.w
        end
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
          -- Colliding right
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
 
  items.create_all_items_randomly = function(self)
    -- Create all items on map in random positions. Some may be overlapping
    for _, index in pairs(ITEM_INDEXES) do
      item_pos_x = flr(rnd(MAP_SIZE_X - 2)) + 1
      item_pos_y = flr(rnd(MAP_SIZE_Y - 2)) + 1
      item = make_item(index, {item_pos_x*8, item_pos_y*8})
      item.health.auto_dps_active = false
    end
  end
end

function make_item(sprite, pos)
  local item = {}

  item.sprite = sprite or ITEM_INDEXES[flr(rnd(#ITEM_INDEXES)) + 1]
  item.active = true
  item.pos = pos

  -- Components
  item.collider = make_collider(
    item,
    8,
    8)

  death_callback_fn = function(item)
    -- Called on death
    item.active = false
  end
  item.health = make_health(
    item,
    1.0,  -- Max health
    nil, -- Damage SFX to play
    nil, -- Cooldown duration
    0.07,  -- Auto damage taken per second
    death_callback_fn  -- Callback function to call on death
  )

  item.update = function(self)
    if self.active then
      self.collider:update()
      self.health:update()
    end
  end

  item.draw = function(self)
    if self.active then
      spr(self.sprite, self.pos[1], self.pos[2])
    end
  end

  item.to_bby = function(self)
    return item_index_to_bby_index(self.sprite)
  end

  item.apply_modifier = function(self, bby)
    -- Adds an items modifier, affecting the game
    local s = self.sprite

    local draw_msg = function(msg)
      -- Helper function to display a message for the item picked up
      level_manager:draw_ui_msg(msg, PALETTE_PINK, 3.5, true)
    end

    if s == 69 then
      -- Meg cap
      draw_msg("PINK HAT IS UTTERLY USELESS")
    elseif s == 70 then
      -- Flower
      -- Create food in random positions
      for _ = 0, 6 do
        local pos = tile_to_pixel_pos(random_tile_on_map())
        make_food(pos)
      end
      draw_msg("FLOWER GENERATED FOOD")
    elseif s == 71 then
      -- Eye Patch
      for _, enemy in pairs(enemies.enemies) do
        if enemy.active then
          enemy.health:damage(1.0)
          break
        end
      end
      draw_msg("EYEPATCH ASSASSINATED MONSTER")
    elseif s == 72 then
      -- Wig
      for _, enemy in pairs(enemies.enemies) do
        enemy.follower.target = nil
      end
      draw_msg("WIG ATTRACTS MONSTERS")
    elseif s == 73 then
      -- Crown
      for _ = 0, 10 do
        local pos = random_tile_on_map()
        make_rock(pos)
      end
      draw_msg("CROWN GENERATED ROCKS")
    elseif s == 74 then
      -- Clown nose
     sfx(SFX_HEAL_ALL_BBYS)
     for _, bby in pairs(bbys) do
       if bby.active then bby.health.health = 1.0 end
     end
      draw_msg("CLOWN NOSE HEALED ALL")
    elseif s == 75 then
      -- Karate headband 
      bby.destroy_rocks_on_collision = true
      draw_msg("HEADBAND BREAKS ROCKS")
    elseif s == 76 then
      -- Bra
      bby.health.auto_dps_active = false
      draw_msg("BRA STOPS HUNGER")
    elseif s == 85 then
      -- Dress
      bby.heal_bbys_on_collision = true
      draw_msg("DRESS HEAL ON CONTACT")
    elseif s == 86 then
      -- Sunglasses
      draw_msg("SUNGLASSES SLOWS MONSTERS")
    elseif s == 87 then
      -- Bandit bandana
      draw_msg("BANDANA HURTS MONSTERS")
    elseif s == 88 then
      -- Pants
      -- Code is in player.collide. Speed up player on collision
      draw_msg("PANTS UPS PUSHING SPEED")
    elseif s == 89 then
      -- Kenny hoody
      bby.health.direct_damage_active = false
      draw_msg("COAT GIVES INVULNERABILITY")
    elseif s == 90 then
      -- Alien antlers
      -- Randomize locations of bbys and enemies
      sfx(SFX_SCRAMBLE_CHARS)
      local chars_to_randomize = {player}
      merge_tables(chars_to_randomize, bbys)
      merge_tables(chars_to_randomize, enemies)
      for _, char in pairs(chars_to_randomize) do
        local pos = tile_to_pixel_pos(random_tile_on_map())
        if char.active then 
          char.pos = pos
        end
      end
      draw_msg("ANTENNAE TELEPORTS YOU")
    elseif s == 91 then
      -- Mask
      for _, enemy in pairs(enemies.enemies) do
        enemy.follower.target = nil
      end
      draw_msg("MASK HIDES FROM MONSTERS")
    elseif s == 92 then
      -- Box
      bby.wanderer.active = false
      draw_msg("BOX STOPS BBY WANDERING")
    end

  end

  item.revert_modifier = function(self, bby)
    -- Reverts an items modifier, removing it
    local s = self.sprite

    if s == 69 then
      -- Meg cap
    elseif s == 70 then
      -- Flower
    elseif s == 71 then
      -- Eye Patch
    elseif s == 72 then
      -- Wig
      for _, enemy in pairs(enemies.enemies) do
        enemy.follower.target = nil
      end
    elseif s == 73 then
      -- Crown
    elseif s == 74 then
      -- Clown nose
    elseif s == 75 then
      -- Karate headband 
      bby.destroy_rocks_on_collision = false
    elseif s == 76 then
      -- Bra
      bby.health.auto_dps_active = true
    elseif s == 85 then
      -- Dress
    elseif s == 86 then
      bby.heal_bbys_on_collision = false
      -- Sunglasses
    elseif s == 87 then
      -- Bandit bandana
    elseif s == 88 then
      -- Pants
    elseif s == 89 then
      -- Kenny hoody
      bby.health.direct_damage_active = true
    elseif s == 90 then
      -- Alien antlers
    elseif s == 91 then
      -- Mask
      for _, enemy in pairs(enemies.enemies) do
        enemy.follower.target = nil
      end
    elseif s == 92 then
      -- Box
      bby.wanderer.active = true
    end
  end

  items.items[#items.items + 1] = item

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
    self.collider:update()
  end

  food.draw = function(self)
    if (self.active) then
      spr(self.sprite, self.pos[1], self.pos[2])
    end
  end

  foods.foods[#foods.foods + 1] = food

  return food
end

-- Rocks code

function make_rocks(rocks_tile_pos)
  -- Takes as input a table of rock tile positions (pixel pos divided by 8)
  rocks = {}

  rocks.rocks = {}

  if rocks_tile_pos ~= nil then
    for _, pos in pairs(rocks_tile_pos) do
      make_rock(pos)
    end
  end
end

function make_rock(pos)
  local rock = {}

  rock.pos = tile_to_pixel_pos(pos or {8,8})
  rock.active = true
  rock.sprite = 60

  death_callback_fn = function(rock)
    -- Called on death

    -- Create food at place of death
    make_food(rock.pos)

    rock.active = false
  end

  -- Components
  rock.health = make_health(
    rock,
    1.0,  -- Max health
    SFX_HIT_ROCK,  -- Damage sfx to play
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
    self.collider:update()
    self.health:update()
  end

  rocks.rocks[#rocks.rocks + 1] = rock

  return rock
end

-- BBY code
function make_bbys(bbys_pos)
  bbys = {}
 
  if bbys_pos then
    for i, pos in pairs(bbys_pos) do
      bbys[i] = make_bby(pos)
    end
  end
end

function make_bby(pos, palette)
  local bby = {}

  -- Configurations
  bby.max_speed = 0.5

  bby.name = BBY_NAMES[flr(rnd(BBY_NAMES_LENGTH)) + 1]
  bby.pos = tile_to_pixel_pos(pos or {8,8})
  bby.v = {0, 0}
  bby.sprite = 40
  bby.active = true

  bby.bandana_damage_dealt = 0.2

  bby.push_index = 0
  bby.is_pushed_by_bby = false
  bby.is_colliding_with_unwalkable = false  -- true if colliding with a rock
  bby.current_item = nil
  bby.heal_bbys_on_collision = false  -- Item modifier for the dress
  bby.destroy_rocks_on_collision = false -- Ite modifier for the headband

  -- Components
  bby.animator = make_animator(
    bby, 
    0.3,
    64, 
    palette or UNLOCKED_PALETTES[flr(rnd(#UNLOCKED_PALETTES)) + 1])
  bby.collider = make_collider(
    bby,
    8,
    8)

  death_callback_fn = function(bby)
    sfx(SFX_BBY_DEATH)

    IN_PLAYER_LOST_SCREEN = true
  end

  bby.health = make_health(
    bby,
    1.0, -- Max health
    SFX_BBY_DAMAGED, -- Damage sfx to play
    0.5, -- Cooldown duration
    0.0125, -- Auto damage taken per second
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
      if self.push_index > 0 then self.wanderer:stop() else self.wanderer:wander() end
      self:move()
      self:collide()
      self.collider:update()
      self.health:update()
    end
  end

  bby.draw = function(self)
    if self.active then
      self.animator:animate()
      self.animator:draw()

      local nametag = self.name
      if DEBUG then nametag = tostr(self.push_index) end
      level_manager:draw_msg({self.pos[1], self.pos[2] - 8}, nametag, self.animator.palette, DISPLAY_NAMEBAR_UI, self.health.health)
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

  bby.collide = function(self, i)
    -- Set flag if colliding with player
    local colliding_with_player = false
    if player.active and self.collider:is_colliding(player) then
      colliding_with_player = true
    end

    -- Do bby collision
    self.is_pushed_by_bby = false
    for _, other_bby in pairs(bbys) do
      if other_bby ~= self then
        if self.collider:is_colliding(other_bby) then

          if self.heal_bbys_on_collision then 
            if other_bby.health.health < 0.98 then
              sfx(SFX_CONSUME_FOOD)
              other_bby.health:heal(0.1)
            end
          end

          if other_bby.push_index == self.push_index and self.push_index > 0 then
            -- Fixes some edge cases where bbys next to each other would increment each other indefinitely
            other_bby.push_index += 1
          end

          if other_bby.push_index > self.push_index then
            -- Do colliding with pushed bby
            self.push_index = other_bby.push_index
            other_bby.push_index += 1
            self.is_pushed_by_bby = true

            local collision_direction = self.collider:get_collision_direction(other_bby)
            if collision_direction == TOP_COLLISION then
              -- Colliding top
              self.pos[2] = other_bby.pos[2] + self.collider.rect.h
            elseif collision_direction == BOTTOM_COLLISION then
              -- Colliding bottom
              self.pos[2] = other_bby.pos[2] - self.collider.rect.h
            elseif collision_direction == LEFT_COLLISION then
              -- Colliding left
              self.pos[1] = other_bby.pos[1] + self.collider.rect.w
            elseif collision_direction == RIGHT_COLLISION then
              -- Colliding right
              self.pos[1] = other_bby.pos[1] - self.collider.rect.w
            end
          elseif other_bby.push_index == 0 then
            -- Do colliding with wandering bby
            local collision_direction = self.collider:get_collision_direction(other_bby)
            if collision_direction == TOP_COLLISION then
              -- Colliding top
              other_bby.pos[2] = self.pos[2] - self.collider.rect.h
            elseif collision_direction == BOTTOM_COLLISION then
              -- Colliding bottom
              other_bby.pos[2] = self.pos[2] + self.collider.rect.h
            elseif collision_direction == LEFT_COLLISION then
              -- Colliding left
              other_bby.pos[1] = self.pos[1] - self.collider.rect.w
            elseif collision_direction == RIGHT_COLLISION then
              -- Colliding right
              other_bby.pos[1] = self.pos[1] + self.collider.rect.w
            end
          end
        end
      end
    end

    -- Do enemy collision
    for _, enemy in pairs(enemies.enemies) do
      if enemy.active and self.collider:is_colliding(enemy) then
        -- Get hurt
        self.health:damage(enemy.damage_dealt)

        -- Do damage to enemy if we're wearing the bandana
        if self.current_item ~= nil and self.current_item.sprite == 87 then
          enemy.health:damage(self.bandana_damage_dealt)
        end

        local collision_direction = self.collider:get_collision_direction(enemy)
        if collision_direction == TOP_COLLISION then
          -- Colliding top
          self.pos[2] = enemy.pos[2] + self.collider.rect.h
        elseif collision_direction == BOTTOM_COLLISION then
          -- Colliding bottom
          self.pos[2] = enemy.pos[2] - self.collider.rect.h
        elseif collision_direction == LEFT_COLLISION then
          -- Colliding left
          self.pos[1] = enemy.pos[1] + self.collider.rect.w
        elseif collision_direction == RIGHT_COLLISION then
          -- Colliding  right
          self.pos[1] = enemy.pos[1] - self.collider.rect.w
        end
      end
    end

    -- Do Food collision
    for _, food in pairs(foods.foods) do
      if food.active and self.collider:is_colliding(food) then
        self.health:heal(food.health_given)
        food.active = false
        sfx(SFX_CONSUME_FOOD)
      end
    end

    -- Do Item collision
    for _, item in pairs(items.items) do
      if item.active and self.collider:is_colliding(item) then
        -- Revert the previous item's effects
        if self.current_item then
          self.current_item:revert_modifier(self)
        end
        -- Apply the new item's effects
        item:apply_modifier(self)

        self.sprite = item:to_bby()
        self.current_item = item
        item.active = false

        sfx(SFX_CONSUME_ITEM)
      end
    end

    -- Do rock collision
    self.is_colliding_with_unwalkable = false
    for _, rock in pairs(rocks.rocks) do
      if rock.active and self.collider:is_colliding(rock) then
        local bounceback_modifier = 1
        if self.destroy_rocks_on_collision then
          rock.health:damage(0.99)
        end
        self.is_colliding_with_unwalkable = true
        local collision_direction = self.collider:get_collision_direction(rock)
        
        -- Note: Offset position by 1 so we hopefully don't get stuck on rocks as much
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

    if i==nil then
      self:collide(false)
    end

  end

  bbys[#bbys + 1] = bby

  return bby

end

-- Enemy code
function make_enemies(enemies_pos)
  enemies = {}

  enemies.enemies = {}
 
  if enemies_pos ~= nil then
    for _, pos in pairs(enemies_pos) do
      make_enemy(pos)
    end
  end
end

function make_enemy(pos, palette)
  local enemy = {}

  -- Configurations
  enemy.max_speed = 0.2

  enemy.name = " 🐱  "
  enemy.pos = tile_to_pixel_pos(pos or {0, 0})
  enemy.v = {0, 0}
  enemy.sprite = 128
  enemy.active = true
  enemy.damage_dealt = 0.065

  enemy.default_speed = enemy.max_speed
  enemy.sunglasses_speed_modifier = 0.12

  -- Components
  enemy.animator = make_animator(
    enemy, 
    0.3,
    1, 
    palette or UNLOCKED_PALETTES[flr(rnd(#UNLOCKED_PALETTES)) + 1]
  )
  enemy.collider = make_collider(
    enemy,
    8,
    8)

  death_callback_fn = function(enemy)
    sfx(SFX_ENEMY_DEATH)

    make_item(nil, enemy.pos)

    enemy.active = false
  end
  enemy.health = make_health(
    enemy,
    1.0, -- Max health
    SFX_ENEMY_DAMAGED, -- Damage sfx to play
    0.1, -- Cooldown duration
    0.05, -- Auto damage taken per second
    death_callback_fn  -- Callback function to call on death
  )
  find_target_fn = function(enemy)
    -- Find a target with the same color palette as us
    local new_target = nil
    for _, bby in pairs(bbys) do
      if bby.active then
        local bby_is_wearing_mask = bby.current_item ~= nil and bby.current_item.sprite == 91
        if bby.animator.palette == enemy.animator.palette and not bby_is_wearing_mask then
          -- Prioritize same color, deprioritize mask.
          new_target = bby
        end
        if bby.current_item ~= nil and bby.current_item.sprite == 72 then
          -- Prioritize bbys wearing the wig
          new_target = bby
          break
        end
      end
    end

    -- Set the target to the player if one wasn't found
    if new_target == nil then
      new_target = player
    end

    return new_target
  end
  enemy.follower = make_follower(
    enemy,
    nil,
    nil,
    find_target_fn
  ) 

  enemy.update = function(self)
    if self.active then
      self:update_for_sunglasses()
      self.collider:update()
      self.follower:update()
      self.health:update()
      self:move()
    end
  end

  enemy.draw = function(self)
    if self.active then
      self.animator:animate()
      self.animator:draw()
      level_manager:draw_msg({self.pos[1], self.pos[2] - 8}, self.name, self.animator.palette, DISPLAY_NAMEBAR_UI, self.health.health)
    end
  end

  enemy.move = function(self)
    new_pos = v_add(self.pos, self.v)
    self.pos = new_pos
    if (self.v[1] != 0 or self.v[2] != 0) then
      self.animator.animation_flag = true
    else
      self.animator.animation_flag = false
    end
  end

  enemy.update_for_sunglasses = function(self)
    -- Slow us down if a bby is wearing sunglasses
    self.max_speed = self.default_speed
    for _, bby in pairs(bbys) do
      if bby.active and bby.current_item ~= nil and bby.current_item.sprite == 86 then
        self.max_speed = self.sunglasses_speed_modifier
        break
      end
    end
  end

  enemies.enemies[#enemies.enemies + 1] = enemy

  return enemy
end


-- Follow code
function make_follower(parent, target, follow_speed, find_target_fn)
  local follower = {}
  follower.parent = parent

  follower.target = target  -- target must have pos
  follower.follow_speed = follow_speed  -- Uses parent's max_speed attribute if this is nil
  follower.is_following = true
  follower.find_target_fn = find_target_fn  -- Optional function to find a target. Also called if target becomes inactive

  -- Find a target if we have a function but no starting target
  if follower.find_target_fn ~= nil and follower.target == nil then
    follower.target = follower.find_target_fn(follower.parent)
  end

  follower.update = function(self)
    if self.find_target_fn ~= nil and (self.target == nil or (self.target ~= nil and not self.target.active)) then
      -- If our target is inactive or nil, find a new one
      self.target = self.find_target_fn(self.parent)
    end

    if self.target ~= nil then
      local speed = self.follow_speed or self.parent.max_speed
      local difference = v_subtraction(self.target.pos, self.parent.pos)
      local normalized = v_normalized(difference)
      local v = v_scalar_multiplication(normalized, speed)

      self.parent.v = v
    elseif self.find_target_fn ~= nil then
      -- We've lost a target. Try to find one.
      self.find_target_fn(self.parent)
    end
  end

  return follower
end


-- Wander code
function make_wanderer(parent, wander_speed, frequency, duration, random_offset)
  local wanderer = {}
  wanderer.parent = parent

  wanderer.wander_speed = wander_speed
  wanderer.frequency = frequency
  wanderer.duration = duration
  wanderer.random_offset = random_offset or 0 -- Additional random time(from zero to this number) that is added to time between wanderings

  wanderer.time_since_last_wander = 0
  wanderer.time_since_starting_wander = 0
  wanderer.is_wandering = false

  wanderer.active = true

  wanderer.stop = function(self)
    -- Stops and resets the active wandering. Will start up again. 
    self.is_wandering = false
    self.time_since_starting_wander = 0
    self.time_since_last_wander = 0 - rnd(self.random_offset)
    self.parent.v = {0, 0}  -- Stop moving
  end

  wanderer.wander = function(self)
    if self.active then
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
  end

  return wanderer
end


-- Animator code

function make_animator(parent, fps, sprite_offset, palette, animation_flag)
  local animator = {}
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

  return animator

end

-- Collider
function make_collider(parent, w, h, offset)
  local collider = {}
  collider.parent = parent

  collider.offset = offset or 1
  collider.rect = {
    x=0,
    y=0,
    w=w - collider.offset*2,
    h=h - collider.offset*2}

  -- Uninitialized collider detectors as rects(xpos, ypos, width, height)
  collider.t = {x=0,y=0,w=0,h=0} 
  collider.b = {x=0,y=0,w=0,h=0}
  collider.l = {x=0,y=0,w=0,h=0}
  collider.r = {x=0,y=0,w=0,h=0}

  collider.update = function(self)
    local offset_x = parent.pos[1] + self.offset
    local offset_y = parent.pos[2] + self.offset

    self.rect = {x=offset_x, y=offset_y, w=self.rect.w, h=self.rect.h}

    self.t = {x=offset_x + 1, y=offset_y, w=self.rect.w - 2, h=self.rect.h / 2}
    self.b = {x=offset_x + 1, y=offset_y + self.rect.h / 2, w=self.rect.w - 2, h=self.rect.h / 2}
    self.l = {x=offset_x, y=offset_y + 1, w=self.rect.w / 2, h=self.rect.h - 2}
    self.r = {x=offset_x + self.rect.w / 2, y=offset_y + 1, w=self.rect.w / 2, h=self.rect.h - 2}
  end
  collider:update()

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

  local health = {}
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

  
  health.active = true
  health.direct_damage_active = true
  health.auto_dps_active = true

  health.update = function(self)
    if self.cooldown_duration ~= nil then
      self.time_since_last_damage += DELTA_TIME
    end
    if self.auto_damage_per_second ~= nil and self.auto_dps_active then
      -- Hurt ourselves every second
      self.time_since_last_autodamage += DELTA_TIME
      if (self.time_since_last_autodamage > 1.0) then
        self.time_since_last_autodamage = 0
        self:damage(self.auto_damage_per_second, false)
      end
    end
  end

  health.damage = function(self, damage, play_sfx)
    if self.active and self.direct_damage_active and (self.cooldown_duration == nil or (self.time_since_last_damage > self.cooldown_duration)) then
      self.health -= damage
      self.time_since_last_damage = 0

      if self.damage_sfx ~= nil and play_sfx ~= false then
        -- Play damaged audio
        sfx(self.damage_sfx)
      end

      if low_health_sprite ~= nil and self.health < self.low_health_amount then
        -- Update the sprite when health is low
        self.parent.sprite = self.low_health_sprite
      end

      if self.health <= 0.0 and self.death_callback_fn ~= nil then
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


function make_do_for(parent, duration, callback_fn)
  -- Calls a callback function n amount of times per second(default is every frame) until duration expires
  -- Call start() to start the timer
  local do_for = {}

  do_for.parent = parent
  do_for.duration = duration
  do_for.callback_fn = callback_fn

  do_for.time_left = 0

  do_for.update = function(self)
    if self.time_left > 0 then
      self.time_left -= DELTA_TIME
      if self.callback_fn ~= nil then
        self.callback_fn(parent)
      end
    end
  end

  do_for.start = function(self)
    self.time_left = self.duration
  end

  do_for.stop = function(self)
    self.time_left = 0
  end

  return do_for
end



-- Linear Interpolation functions
function lerp(a, b, t)
  -- Does a linear interpolation between two points
  return a + (b - a) * t
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
    pal(15, 11)
  elseif palette == PALETTE_BLUE then
    pal(9,  1)
    pal(10, 12)
    pal(15, 6)  
    pal(4, 0) -- Additionally change dark brown for blue palette
  elseif palette == PALETTE_GREY then
    pal(9,  5)
    pal(10, 6)
    pal(15, 6)
  elseif palette == PALETTE_BLACK then
    pal(9,  8)
    pal(10, 6)
    pal(15, 2)
    pal(7,  0) -- Additionally change white to black for black palette
  end
end

function reset_palette()
  pal(9,  9)
  pal(10, 10)
  pal(15, 15)
  pal(4, 4)
  pal(7, 7)
end

-- Vector functions
function v_add(v1, v2)
  return {v1[1] + v2[1], v1[2] + v2[2]}
end

function v_subtraction(v1, v2)
  return {v1[1] - v2[1], v1[2] - v2[2]}
end

function v_scalar_division(v, scalar)
  return {v[1] / scalar, v[2] / scalar}
end

function v_scalar_multiplication(v, scalar)
  return {v[1] * scalar, v[2] * scalar}
end

function v_magnitude(v)
  return sqrt(v[1]^2 + v[2]^2)
end

function v_normalized(v)
  return v_scalar_division(v, v_magnitude(v))
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
function sort_table_by_pos(a, pos_index)
  -- pos_index should be an integer 1 or 2 denoting the x or y coord to sort by
  for i=1,#a do
    local j = i
      while j > 1 and a[j-1].pos[pos_index] > a[j].pos[pos_index] do
        a[j],a[j-1] = a[j-1],a[j]
        j = j - 1
      end
  end
end

function merge_tables(t1, t2)
  -- merges the second table into the first
  i = #t1 + 1
  for _, v in pairs(t2) do 
    t1[i] = v 
    i += 1
  end
end

function random_tile_on_map()
  return {flr(rnd(MAP_SIZE_X - 2)) + 2, flr(rnd(MAP_SIZE_Y - 2)) + 2}
end



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
00eeee0000999e0e0e9999000eeeeee00e9ee9e000999900e09999000099990000999900000000000090009ff900000000000000000000000000000000000000
0eeeeee0097aaae009eaaa9eeeeeeeee0eeeeee0097aaa900eeeeee0097aaa90097aaa90000000000000009f9400000000000000000000000000000000000000
974aa4a9974aaeae974eeee9ee4ee4ee974ee4a9974aa4a9e74aa4a9974aa4a9974aa4a9000000000000009f9400000000000000000000000000000000000000
9a2aa2a99a2aa2a99a2aeee9ee2ae2ae9a2aa2a99a2ee2a99a2aa2a99a2aa2a99a2aa2a9000000000000009ff400000000000000000000000000000000000000
ee9aa9eeee9aa9eeee9aaeeeee9aa9eeee9aa9eeee9ee9eeee9aa9ee9eeaaee9ee9aa9ee000000000000009ff400000000000000000000000000000000000000
09a44a9009a44a9009a44a9009a44a9009a44a9009a44a9009a44a90eeeeeeee09a44a90000000000000009f9400000000000000000000000000000000000000
009999000099990000999900009999000099990000999900009999000ee99ee00099990000000000000009ff9940000000000000000000000000000000000000
09900990099009900990099009900990099009900990099009900990099009900990099000000000000009ff9940000000000000000000000000000000000000
0099990000999900009999000099990000eeee00e099990ee099990eeeeeeeee000000000000000000004ffff940000000000000000000000000000000000000
097aaa90097aaa90097aaa90097aaa900eeeeee00e7aaae0eeeeeeeee97aaa9e000000000000000000004ffff940000000097900000000000000000000000000
974aa4a97eeee7ee974aa4a9974aa4a9ee4aa4ee974aa4a9e74ee4aee74aa4ae000000000000000000004f999994000000979990000000000000000000000000
9a2aa2a9e7eeee7e9a2aa2a99a2aa2a9ee2aa2ee9a2aa2a9ea2ee2aeea2aa2ae000000000000000000049ffff9f9400000979990000000000000000000000000
ee9aa9eeee7aaee7eeeeeeeeee9aa9eeee9aa9eeee9aa9eeeeeaaeeeee9aa9ee000000000000000000049ffffff9400009999995000000000000000000000000
09a44a9009a44a900eeeeee009a44a900eeeeee009a44a900ea44ae0e9a44a9e0000000000000000000499f99999400009999995000000000000000000000000
00eeee000099990000eeee0000eeee0000eeee000099990000999900e099990e0000000000000000000449999994400005999950000000000000000000000000
0eaeeae009900990099ee9900ee00ee00ee00ee00990099009900990eeeeeeee0000000000000000000044444444000000555500000000000000000000000000
0e8eeee00e8eeee00e8eeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
888888808888888088888880000000000000000000000000000eee00ee00000000eeeee0000ee00000000000e000000000e4ee00000000000000000000000000
099a9a90099a9a90099a9a90000000000000000000000000000eee0044e000000eeeeeeee0eeee0e000ee0000e000000eee4eee4000000000000000000000000
09aaaa9009aaaa9009aaaa90000000000000000000eeee00ee04e4ee004e000eee4ee4eeeeeeeeee00eeee4000eeeeeeeee4eee4000000000000000000000000
00999990009999900099999000000000000000000eeeeee0eee04eee0004eee4ee4e40ee4444444400eeee4000eeeeeeeee4eee4000000000000000000000000
099eee90099eee90099eee900000000000000000eeeeeeeeee4e44ee0004eee4e444004e00000000004ee4000e44444444404440000000000000000000000000
00999990099999900099999000000000000000004444444400eee00000004e404e4004e40000000000044000e400000000000000000000000000000000000000
09900990000009900990000000000000000000000000000000eee000000004000400004000000000000000004000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000eeee00000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000eeeeeeee0000000000000000077777700eeeeee000000000e000000e0eeeeee4000000000000000000000000
000000000000000000000000000000000000000000eeee447eeee7eeeeeeeeee0eeeeee4eeeeeeeee000000eeeeeeeee0eeeeee4000000000000000000000000
0000000000000000000000000000000000000000000ee400e7eeee7e4eeeeee40ee40ee4eeeeeeeeee0000eee00ee00e0eeeeee4000000000000000000000000
000000000000000000000000000000000000000000eeee00ee744ee704eeee400ee40ee4eeeeeeee4ee00ee4e00ee00e0eeeeee4000000000000000000000000
00000000000000000000000000000000000000000eeeeee044400444004ee4000ee40ee44eeeeee404e40e40eee44eee0eeeeee4000000000000000000000000
0000000000000000000000000000000000000000eeeeeeee00000000000440000ee40ee404eeee40004004004e4004e40eeeeee4000000000000000000000000
0000000000000000000000000000000000000000444444440000000000000000044004400ee44ee0000000000400004004444444000000000000000000000000
00eeee0000999e0e0e9999000eeeeee00e9ee9e000999900e0999900009999000099990000000000000000000000000000000000000000000000000000000000
0eeeeee0097aaae009eaaa9eeeeeeeee0eeeeee0097aaa900eeeeee0097aaa90097aaa9000000000000000000000000000000000000000000000000000000000
974aa4a9974aaeae974eeee9ee4ee4ee974ee4a9974aa4a9e74aa4a9974aa4a9974aa4a900000000000000000000000000000000000000000000000000000000
9a2aa2a99a2aa2a99a2aeee9ee2ae2ae9a2aa2a99a2ee2a99a2aa2a99a2aa2a99a2aa2a900000000000000000000000000000000000000000000000000000000
ee9aa9eeee9aa9eeee9aaeeeee9aa9eeee9aa9eeee9ee9eeee9aa9ee9eeaaee9ee9aa9ee00000000000000000000000000000000000000000000000000000000
09a44a9009a44a9009a44a9009a44a9009a44a9009a44a9009a44a90eeeeeeee09a44a9000000000000000000000000000000000000000000000000000000000
099999000999990009999900099999000999990009999900099999000ee99ee00999990000000000000000000000000000000000000000000000000000000000
00000990000009900000099000000990000009900000099000000990000009900000099000000000000000000000000000000000000000000000000000000000
0099990000999900009999000099990000eeee00e099990ee099990eeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
097aaa90097aaa90097aaa90097aaa900eeeeee00e7aaae0eeeeeeeee97aaa9e0000000000000000000000000000000000095500000000000000000000000000
974aa4a97eeee7ee974aa4a9974aa4a9ee4aa4ee974aa4a9e74ee4aee74aa4ae0000000000000000000000000000000000955990000000000000000000000000
9a2aa2a9e7eeee7e9a2aa2a99a2aa2a9ee2aa2ee9a2aa2a9ea2ee2aeea2aa2ae0000000000000000000000000000000000955990000000000000000000000000
ee9aa9eeee7aaee7eeeeeeeeee9aa9eeee9aa9eeee9aa9eeeeeaaeeeee9aa9ee0000000000000000000000000000000009559595000000000000000000000000
09a44a9009a44a900eeeeee009a44a900eeeeee009a44a900ea44ae0e9a44a9e0000000000000000000000000000000009599955000000000000000000000000
0eeeee000999990009eeee000eeeee000eeeee000999990009999900e999990e0000000000000000000000000000000005999950000000000000000000000000
000eeae000000990000ee99000000ee000000ee00000099000000990eeeeeeee0000000000000000000000000000000000555500000000000000000000000000
00000000900000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a990099a9a0000a9a990099a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90199109099009909019910900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90499409001991009049940900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00911900004994000091190000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09111190909119090911119000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90911909091111909091190900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009119000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00644600008878880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00600600888887880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06000060888787880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06777760788888870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06777760788888700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06777760077777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00eeee0000999e0e0e9999000eeeeee00e9ee9e000999900e0999900009999000099990000000000000000000000000000000000000000000000000000000000
0eeeeee0097aaae009eaaa9eeeeeeeee0eeeeee0097aaa900eeeeee0097aaa90097aaa9000000000000000000000000000000000000000000000000000000000
974aa4a9974aaeae974eeee9ee4ee4ee974ee4a9974aa4a9e74aa4a9974aa4a9974aa4a900000000000000000000000000000000000000000000000000000000
9a2aa2a99a2aa2a99a2aeee9ee2ae2ae9a2aa2a99a2ee2a99a2aa2a99a2aa2a99a2aa2a900000000000000000000000000000000000000000000000000000000
ee9aa9eeee9aa9eeee9aaeeeee9aa9eeee9aa9eeee9ee9eeee9aa9ee9eeaaee9ee9aa9ee00000000000000000000000000000000000000000000000000000000
09a44a9009a44a9009a44a9009a44a9009a44a9009a44a9009a44a90eeeeeeee09a44a9000000000000000000000000000000000000000000000000000000000
009999900099999000999990009999900099999000999990009999900ee99ee00099999000000000000000000000000000000000000000000000000000000000
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
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012121212121212121212121212121212000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012070606060606060606060606060512000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012090202020202020202020202020312000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012121212121212121212121212121212000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010e00000c4400c4300c4200c4400c4300c4200c4400c4300c4200c4400c4300c4200c4200c4100c4200c4100c4400c4300c4200c4400c4300c4200c4400c4300c4200c4400c4300c4200c4200c4100c4200c410
00090000130501e050290502e0501505006050020500205001000060000c0001600026000360001a0000f0000d0001100016000250003c0001f0001b0001a00019000190001a0000000000000000000000000000
000900000b2501a250282501625035250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0003000019640316302e63031630243301b3300533000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c00000055005500025000550005500025000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
000600003a1203d110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003f35037250302502b25025250212501c25017250122500e250092500425001250153501e350153501e350143501e3501e3501b3501835016350133501e3501b3500c3500a3500a350073500435004350
000300001515015150141501315012150111500f1500d1500c1500915007150051500d15008150071500615006150031500215001150001500015000000000000000000000000000000000000000000000000000
000400002025020250192500a25002250112500025003250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00090000130501e050290502e0501505006050020500205001050060500c0501605026050360501a0500f0500d0501105016050250503c0501f0501b0501a05019050190501a0500000000000000000000000000
010500000d200152001c200242002c20033200382003220025200000000d20000200042001520000000272003220038200000002920021200092000e200162002620029200362003b20038200262000b20000000
000300003a673346732e67329673246731f6731d6731d6731b6731a67318673176731567313673126730d6730c673086730667304673026730067300673006730066500655006550065500655006550065500655
000a00000b140061500e140061500b14006100001000b100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01100000180300f0001c030000001f030000002303000000240300100023030010001a0000f000180300100021030140001f0300200021030020001c0300200021030030001a0300600021000040001803005000
011000000c0733f2003f2253f2000c073296000c0733f2150c073000003f22500000246150000029615000000c0733f200296253f2000c07300000296153f2000c073000003f2251b3003f225000003f22500000
011000000c0533f2003f2003f2000c053296000c0003f2000c053000002960000000246150000029600000000c0533f200296153f2000c05300000296153f2000c053000003f2151b3003f215000003f21500000
011000001304113031135211304113531130211354113031130211304113531130211304113011135411301113041130311352113041135311302113541130311302113041135311302113041130111354113011
011000000c7500f70010750000000c7500000010750000001175001000107500e7500c7500f70011750010001175014700107500e7500c7500200015750020001575003000137501175010750040000c75005000
00100000185501d550185501c5001c5501f5501a5500050023550215501f5501d5501f5501d5501c550015001c5501d5501f5501a5001f55021550235500250023550215501f5501d5501c5501a5501855018500
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010f00000e0500e050130500e050130500e0500e050150500e0500e050150500e050180500e050130500e050110500e050100500e050110500e050100500e0500e0500e0500c0500e0500e050100500e0500e050
011000000c0733f2000c0000c0730c000296000c0733f2000c073000000c0000c0730c000000000c073000000c0733f200296000c0730c000000000c0733f2000c073000003f2000c0730c000000000c07300000
011000000c0733f2000c0733f2050c67029600187533f2030c073000001875300000186700000018753000000c0733f2000c0733f2001867000000186703f2000c07300000187531b30018670000001875300000
011000000c0733f2000c0733f2050c67029600187533f2030c073000001875300000186700000018753000000c0733f2000c0733f2001867000000186703f2000c07300000187531b3003f2253f2253f2253f225
011000001855018550245501f5001c5501c5001d5001d5501d5001c550245001a550185501a5501a5001a500185501a5502455000500305500050000500345500050034550005003255030550325500050000500
01100000104420c4300c4200c4420c4300c4200c4420c4300c4200c4420c4300c4200c4220c4100c4200c4100c4420c4300c4200c4420c4300c4200c4420c4300c4200c4420c4300c4200c4220c4100c4200c410
011000000c2740c2742450022274005001d274345001b2741e2740050024300112741c300005000c274303000c2740c2742450022274005001d274345001b27425274252742a274332741c300005000c27430300
011000000c2740c2742450022274005001d274345001b2741e2740050024300112741c300005000c274303000c2740c2742450022274005001d274345001b2742327423274232742f2742f2742f2742f2742f274
01100000185501a550245501f5001c5501c5001d5001d5501d5001c550245001a550185501a5501a5001a500185501a550245500050030550005000050034550005003455000500375503b5503c5503e5503c550
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003a600346002e60029600246001f6001d6001d6001b6001a60018600176001560013600126000d6000c600086000660004600026000060000600006000060000600006000160000600016000060000600
__music__
01 57174344
01 56174b44
00 15175444
00 15175444
00 15171844
00 15171844
00 14175855
00 14175855
00 14185854
01 15141854
00 15145454
00 15145855
00 14175855
00 14171855
00 14171854
00 14171854
00 55571855
00 41421844
00 41424344
00 41424344
00 23626044
00 23206044
00 23206044
00 23242044
00 23242044
00 23242044
01 23252044
00 23200d44
00 23210d44
00 23200d44
00 23210d44
00 22232144
00 22232144
00 22232044
00 26232044
00 23202444
00 23212544
00 23200d44
00 23210d44
00 230d2044
00 23210d44
00 23202244
00 23202644
00 23652044
00 23652044
00 23656044
00 23656044
00 41424344
00 41424344
00 41424344
00 1e424344
00 1e424344

