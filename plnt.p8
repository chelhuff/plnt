pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
game = {}

--initialize
function _init()
    show_menu()
    music(0, 0, 0)
end

-------------------------------------------
--player object
-------------------------------------------

player = {}

--starting position
player.x = 5
player.y = 54

--used for character animation
player.sprite = 0
player.speed = 2
player.moving = false

--stun status
player.stun_counter = 100

-------------------------------------------
--spider object 
-------------------------------------------
spider = {}

spider.x = 296
spider.y = 128
spider.direction = 1
spider.sprite = 84
spider.width = 6
spider.height = 6
spider.flipped = false

-------------------------------------------
--crab object
-------------------------------------------
crab = {}

crab.x = 256
crab.y = 88
crab.direction = 1
crab.sprite = 26
crab.width = 6
crab.height = 6

-------------------------------------------
--scorpion object
-------------------------------------------
scorpion = {}

scorpion.x = 130
scorpion.y = 150
scorpion.direction = -1
scorpion.sprite = 98
scorpion.width = 6
scorpion.height = 6
scorpion.flipped = false

-------------------------------------------
--ghost object
-------------------------------------------
ghost = {}

ghost.x = 140
ghost.y = 88
ghost.direction = 1
ghost.sprite = 23
ghost.width = 6
ghost.height = 6

-------------------------------------------
--cactus object
-------------------------------------------
cactus = {}

cactus.x = 128
cactus.y = 170
cactus.sprite = 70
cactus.inventory_sprite = 255
cactus.width = 8
cactus.height = 8

-------------------------------------------
--menu
-------------------------------------------
function show_menu()
    game.upd = menu_update
    game.drw = menu_draw
end

--if z pressed, transition to game
function menu_update()
    if btn(4) then
        show_game()
    end
end

--menu UI design
function menu_draw()
    cls()
    
    --draw PLNT
    spr(52, 55, 20)
    spr(53, 65, 20)
    spr(54, 75, 20)
    spr(55, 85, 20)

    --draw plot text
    print("be weary traveler, ", 40, 50, 10)
    print("for this tale may ", 40, 60, 10)
    print("become a true one...", 40, 70, 10) --8+(t/4)%8)

    --user instructions
    print("press z to start", 42, 100, 7)
end



-------------------------------------------
--inventory
-------------------------------------------
function show_inventory()
    game.upd = inventory_update
    game.drw = inventory_draw
end

--if X is pressed at any time, show the inventory
function inventory_update()
    if btn(5) then
        show_inventory()
    end

    if btn(4) then
        show_game()
    end
end

--inventory
function inventory_draw()
    cls()

    --draw PLNT
    spr(52, 45, 10)
    spr(53, 55, 10)
    spr(54, 65, 10)
    spr(55, 75, 10)

    --row 1, box 1
    spr(16, 10, 20)
    spr(17, 18, 20)
    spr(18, 24, 20)
    spr(32, 10, 27)
    spr(cactus.inventory_sprite, 18, 27)
    spr(34, 26, 27)
    spr(48, 10, 34)
    spr(49, 18, 34)
    spr(50, 24, 34)

    --row 1, box 2
    spr(16, 50, 20)
    spr(17, 58, 20)
    spr(18, 64, 20)
    spr(32, 50, 27)
    spr(34, 66, 27)
    spr(48, 50, 34)
    spr(49, 58, 34)
    spr(50, 64, 34)

    --row 1, box 3
    spr(16, 90, 20)
    spr(17, 98, 20)
    spr(18, 104, 20)
    spr(32, 90, 27)
    spr(34, 106, 27)
    spr(48, 90, 34)
    spr(49, 98, 34)
    spr(50, 104, 34)

    --row 2, box 1
    spr(16, 10, 50)
    spr(17, 18, 50)
    spr(18, 24, 50)
    spr(32, 10, 57)
    spr(34, 26, 57)
    spr(48, 10, 64)
    spr(49, 18, 64)
    spr(50, 24, 64)

    --row 2, box 2
    spr(16, 50, 50)
    spr(17, 58, 50)
    spr(18, 64, 50)
    spr(32, 50, 57)
    spr(34, 66, 57)
    spr(48, 50, 64)
    spr(49, 58, 64)
    spr(50, 64, 64)

    --row 2, box 3
    spr(16, 90, 50)
    spr(17, 98, 50)
    spr(18, 104, 50)
    spr(32, 90, 57)
    spr(34, 106, 57)
    spr(48, 90, 64)
    spr(49, 98, 64)
    spr(50, 104, 64)

    --row 3, box 1
    spr(16, 10, 80)
    spr(17, 18, 80)
    spr(18, 24, 80)
    spr(32, 10, 87)
    spr(34, 26, 87)
    spr(48, 10, 94)
    spr(49, 18, 94)
    spr(50, 24, 94)

    --row 3, box 2
    spr(16, 50, 80)
    spr(17, 58, 80)
    spr(18, 64, 80)
    spr(32, 50, 87)
    spr(34, 66, 87)
    spr(48, 50, 94)
    spr(49, 58, 94)
    spr(50, 64, 94)

    --row 3, box 3
    spr(16, 90, 80)
    spr(17, 98, 80)
    spr(18, 104, 80)
    spr(32, 90, 87)
    spr(34, 106, 87)
    spr(48, 90, 94)
    spr(49, 98, 94)
    spr(50, 104, 94)
    
end

-------------------------------------------
--game functions
-------------------------------------------
function show_game()
    x = 63
    y = 63

    game.upd = game_update
    game.drw = game_draw
end

--player movement implemented here
function game_update()

    if player.stun_counter < 25 then 
        player.stun_counter += 1

    elseif btn(1)  then
        player.x += player.speed
        move()

    elseif btn(2) then
        player.y -= player.speed
        move()

    elseif btn(3) then
        player.y += player.speed
        move()

    elseif btn(0) then
        player.x -= player.speed
        move()

    else 
        player.sprite = 0
    end

    if btn(5) then
        show_inventory()
    end

    move_enemies()
    render_plants()
    enemy_collide()
end

--camera panning
function game_draw()
    cls()
    camera(-64 + player.x + 4, -64 + player.y + 4)
    map()
    spr(spider.sprite, spider.x, spider.y, 1, 1, false, spider.flipped)
    spr(crab.sprite, crab.x, crab.y)
    spr(ghost.sprite, ghost.x, ghost.y)
    spr(scorpion.sprite, scorpion.x, scorpion.y, 1, 1, scorpion.flipped, false)
    spr(player.sprite, player.x, player.y)
    spr(cactus.sprite, cactus.x, cactus.y)
    camera() 
end

-------------------------------------------
--sprite animation
-------------------------------------------
function move()
    player.moving = true
    player.sprite += 1
    if player.sprite > 2 then
        player.sprite = 0
    end
    cls()
end

-------------------------------------------
--plant rendering
-------------------------------------------
function render_plants()
    if collide(player, cactus) then
        cactus.sprite = 255
        cactus.inventory_sprite = 70
    end
end

-------------------------------------------
--enemy collision
-------------------------------------------
function enemy_collide()
    if collide(player, crab) or collide(player, ghost) or collide(player, spider) or collide(player, scorpion)then
        player.stunned = true
        player.stun_counter = 0
        player.sprite = 0
    end
end

-------------------------------------------
--collision checking
-------------------------------------------
function collide(p, o)
    if (p.x < (o.x + o.width)) and (p.x > (o.x - o.width))
    and (p.y < (o.y + o.height)) and (p.y > (o.y - o.height)) then
        return true
    end
    return false
end

-------------------------------------------
--enemy animation
-------------------------------------------
function move_enemies()

    --spider
    if spider.y == 248 then
        spider.direction = -1
        spider.flipped = true

    elseif spider.y == 129 then
        spider.direction = 1
        spider.flipped = false
    end

    spider.y += spider.direction

    --crab
    if crab.x == 344 then
        crab.direction = -1

    elseif crab.x == 256 then
        crab.direction = 1
    end

    crab.x += crab.direction

    --ghost
    if ghost.y == 120 then
        ghost.direction = -1

    elseif ghost.y == 0 then
        ghost.direction = 1
    end

    ghost.y += ghost.direction

    --scorpion
    if scorpion.x == 200 then
        scorpion.direction = -1

    elseif scorpion.x == 128 then
        scorpion.direction = 1
        scorpion.flipped = true
    end

    scorpion.x += scorpion.direction

    cls()
end

-------------------------------------------
--main functions
-------------------------------------------

--update function
function _update()
  game.upd()
end

--draw function
function _draw()
  game.drw()
end


__gfx__
00044000000440000004400000000000000011100000001100000000d62222222222222200000000ffffffffcccccccc3333333306666660555555550dddddd0
0044440000444400004444000000000000000000011000000000000022222dd22222dd2200000000ffffffffcccccccc333333336000000633333335dddddddd
04ffff4004ffff4004ffff4000000000011100000000000000000000222222222222222200000000fffff7ffcccccccc333333336000000655555535dddddddd
44effe4444effe4444effe440000000000000000000000000000000022dd2dd22222222200000000ffffffffcccccccc333333336000000633333535dddddddd
077227700772277007722770000000001000011100011100000000002222dd222d22222200000000ffffffffcccccccc333333336000000633333535dddddddd
0f7227f00f7227f00f7227f0000000000000000000000000000000002222222222222222000000007fffffffcccccccc333333336000000633333535dddddddd
0050050000500200002005000000000000011110000000110000000022d2222222dd222200000000fffffffffccccccc333333336000000633333535dddddddd
00200200002000000000020000000000110000001110000000000000622222222222222200000000ff7ffffffccccccc3333333306666660333335350dddddd0
0000000000000000000000000000000066666666d1ffffff0000000007777770000000000000000088000088ffffffff0000000066666666333333332dddddd2
0000000000000000000000000000000066666666d122222f0000000077dddd77000000000000000008000080ff7fff7f000000006667776633333333dddddddd
0000000000000000000000000000000066666666d126662f000000007dddddd7000000000000000088800888ffffffff000000006766666633333333dddddddd
0000000000000000000000000000000066666666d126662f000000007d0dd0d7000000000000000000888800f7ffffff000000006666777633333333dddddddd
0000000000000000000000000000000066666666d122222f000000007dddddd7000000000000000000888800ffffffff000000006666666633333333dddddddd
000dddddddddddddddddd0000000000066666666d122222f000000007dddddd7000000000000000000800800ffff7fff000000007766666655555555dddddddd
000dd00000000000000dd0000000000066666666d122222f000000007d7dd7d7000000000000000000000000ffffffff000000006666666633333333dddddddd
000d0000000000000000d0000000000066666666d122222f0000000007777770000000000000000000000000ffffffff0000000066766666555555552dddddd2
000d00000000000000d00000000000000000000000000000000000002eee222203300000000000008000800000030030000000003333353555555555fddddddf
000d00000000000000d0000000000000000000000000000000000000ee8ee222333000000000000088008088b303b030000000003333353533333333dddddddd
000d00000000000000d0000000000000000000000000000000000000ee8ee2220033300000000000080080800303003b000000003333353555555555dddddddd
000d00000000000000d00000000000000000000000000000000000002eee222200330000000000000888888003030330000000003333353533333333dddddddd
000d00000000000000d00000000000000000000000000000000000002232222200300000000000000000880003033300000000003333353533333333dddddddd
000d00000000000000d000000000000000000000000000000000000022332222003000000000000008008008b3030000000000003333353533333333dddddddd
000d00000000000000d0000000000000000000000000000000000000222332220003000000000000080088880333b000000000003333353533333333dddddddd
000d00000000000000d00000000000000000000000000000000000002223222200030000000000000888800000030000000000003333353533333333fddddddf
000d0000000000000000d0000000000000000000000000000000000000000000000000000000000000000000cccccccc00000000333335356dddddd64dddddd4
000d0000000000000000d0000000000003333300033000000333003003333330000000000000000000000000cccccccc0000000033333535dddddddddddddddd
000d0000000000000000d0000000000003300330033000000333303003333330000000000000000000000000cccccccc0000000033333535dddddddddddddddd
000dd00000000000000dd0000000000003300030033000000330303000033000000000000000000000000000cccccccc0000000033333535dddddddddddddddd
000dddddddddddddddddd0000000000003333330033000000330333000033000000000000000000000000000cccccccc0000000033333535dddddddddddddddd
0000000000000000000000000000000003300000033000000330033000033000000000000000000000000000cccccccc0000000055555535dddddddddddddddd
0000000000000000000000000000000003300000033333000330033000033000000000000000000000000000cccccccc0000000033333335dddddddddddddddd
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccccc00000000555555556dddddd64dddddd4
3333333333333b334dddddd444444444000000000000000000000000000000000000000033333333000000000000000000000000000000000000000000000000
3bb33bb333b33333dddddddd4444444400000000000e000000033000000000000000000033773333000000000000000000000000000000000000000000000000
333333333b3b3333dddddddd444444440007700000eee00000033000000000000000000033773333000000000000000000000000000000000000000000000000
3333333333b33333dddddddd44444444007aa7000003000003033000000000000000000033773333000000000000000000000000000000000000000000000000
3b3bbbb333333333dddddddd44444444007aa7000033300003333000000000000000000033773333000000000000000000000000000000000000000000000000
3333333333333bb3dddddddd44444444000770000333330000033000000000000000000033777733000000000000000000000000000000000000000000000000
3333bb3333b33333dddddddd444444440000b0000033300000033000000000000000000033333333000000000000000000000000000000000000000000000000
33333333333333334dddddd4444444440000bb000000000000033000000000000000000033333333000000000000000000000000000000000000000000000000
33333333333333334444444444444444000000000000000000000000000000000000000033333333000000000000000000000000000000000000000000000000
333333b3333373334454444445444444404004040000000000000000000000000000000033777733000000000000000000000000000000000000000000000000
33b333333337a7334455445444444445044444400000000000000000000000000000000033733733000000000000000000000000000000000000000000000000
33333333333373334444444444444444004444000000000000000000000000000000000033777733000000000000000000000000000000000000000000000000
333333333b3333334444444444444444008448000000000000000000000000000000000033733733000000000000000000000000000000000000000000000000
3333bb33333333334444444444444444044444400000000000000000000000000000000033733733000000000000000000000000000000000000000000000000
3b333333333333b34454444444445444404004040000000000000000000000000000000033333333000000000000000000000000000000000000000000000000
33333333333333334444444444444444000000000000000000000000000000000000000033333333000000000000000000000000000000000000000000000000
3b333333333333330000555000000555000000000000000000000000404004040000000033333333000000000000000000000000000000000000000000000000
33333b33333333330000805000000805000000000000000000000000044444400000000033777333000000000000000000000000000000000000000000000000
3333333333333b330505005500505005000000000000000000000000004444000000000033733733000000000000000000000000000000000000000000000000
3373333333333b335555500555555005000000000000000000000000004444000000000033777733000000000000000000000000000000000000000000000000
37a73333333333335555555555555555000000000000000000000000008448000000000033733733000000000000000000000000000000000000000000000000
33733bb3333333330050500005050000000000000000000000000000044444400000000033777333000000000000000000000000000000000000000000000000
333333b33b3333330000000000000000000000000000000000000000404004040000000033333333000000000000000000000000000000000000000000000000
3b333333333333330000000000000000000000000000000000000000000000000000000033333333000000000000000000000000000000000000000000000000
3dddddd3333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd3bbb33330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd3333b3330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd33b333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd33b333b30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3dddddd3333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000020000020000000000000000000000000101000101000000000000000000000000000000000000000000000000010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
04040404040404040404040404040404070808070807080708070807080707080a0a0a0a0a0a0a0a0a0a0a0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404070807080708080807080807080708080a0a1b1b1b1b0a0a1b1b0a0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404080808070808070808080708080808070a1b1b2f2f2f2f2f2f0a0a0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040404040404040f0f0f0f1f1f1f1f1f07080708080708070708071b1b1b2f1b1b1b0a2f0a0a0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040404040404040f040404080808081f08080807080707070808081b0a1b2f1b0a0a0a2f0a0a1b0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040404040404040f040404070808071f07080808070808080807071b1b0a2f1b0a1b0a2f1b1b1b0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040414141404040f040404080808081f0807080808081f1f1f1f1f2f2f2f2f1b0a0a1b2f0a0a0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0f0f0f0f0f0f0f1415140f0f0f040404070708081f080708081f1f1f080707080a0a1b0a1b0a0a0a2f1b0a0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404141414040404040404080807081f070808071f0807070807080a0a0a0a1b1b0a1b2f0a0a0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404070808081f080707081f0808080808070a1b1b1b1b0a0a1b2f0a1b0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404080808081f1f1f1f1f1f0708080707081b0a1b1b0a0a1b0a2f0a0a0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404070808080808080807080707080708081b0a0a1b1b1b0a0a2f0a0a1b0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404080808070808070808080808080808071b1b0a1b1b1b0a0a2f0a0a1b0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404070807080807080708080808070708080a0a0a0a0a0a0a0a2f0a0a0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404080808070808070808080808080808070a0a0a0a0a0a1b0a2f1b1b0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404070807080807080708080708070708070a1b0a0a0a0a1b1b2f1b0a0a0b3b3b3b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d43434343434343434343435343434343504040414041405070504050504050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d43524353434343434343434343434343504040505060404170604050504050600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d43434343434353524353434343435243405140504050504070405040506141510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d43435353524343535353434343434343614140414140515070717171715040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d43434343534343434343434343434343414050505050714170514041615051500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d3e3e3e3e3e42424242424242424343534343434343405040506161504070715040616141400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d3e1d1d1d1d43434343534343424343535343525343406151616151404070415061516150510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2e2e2e0e1d1d1d1d1d1d1d3e1d1d1d1d43434353434352425343434343534343504040504041405070707070707050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0c0c2d1d1d1d1d1d1d1d3e1d1d1d1d43435353434352424343435343434343504040515060404150604050507050600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c490c2d1d1d1d1d1d1d1d3e1d1d1d1d43434353434343424353434343534352405140714050504041405040507041510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c590c2d3e3e3e3e3e3e3e3e1d1d1d1d53434343434343424242424242424242707070707040405050505050507040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c690c2d1d1d1d1d1d1d1d1d1d1d1d1d43435343435353434343434353434343414050717050414140514041507050400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0c0c2d1d1d1d1d1d1d1d1d1d1d1d1d43434343534353434352524352535343405040507071715150715151407041400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1e1e1e3d1d1d1d1d1d1d1d1d1d1d1d1d43434353434343434353434343434343406151507070707070707070707050510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d43534353525343435343434352434343504140414050715050404141404141410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d43434343535353434343434343434343504050505140505040715040404140510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100211805019050190501a0501c0501d0501f05020050200502205022050240502605027050290502b0502c0502c0502c0502c0502c0502b0502b0502a0502905026050240502205022050200501e0501c050
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000211a7401f54021710215102672026720255202673026030217201f72013020230101a710100101a7201e7200f0202652017720177201672015720225201072024730207201e720135201e730225202d720
00100020105101053013540165401254013530145501751022510115501c550125501e550155502554019530225302a52022520225102b5102251016530235401c5501c550225501955017550155201352012510
0010002035770387503575031750247302a7503175034770377603776036760377603b7603d7603f7703c7503a76034760317602975022730237102972031750387503975039750397503d7503e7503d75038770
0014002010220102500c350093300b2500d4500a2500a3500a33008350092500b4500b4500625006350083200a45007350093500b25010450104200b250093500b3500b3500a3500b370124501b2500f33000000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
03 04464304

