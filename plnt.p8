pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

game = {}

--initialize
function _init()
    show_menu()
end

-->8
--player object
player = {}

--starting position
player.x = 5
player.y = 54

--used for character animation
player.sprite = 0
player.speed = 2
player.moving = false

--menu function
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

--menu
function menu_draw()
    cls()
    
    --draw PLNT
    spr(52, 55, 20)
    spr(53, 65, 20)
    spr(54, 75, 20)
    spr(55, 85, 20)

    --draw plot text
    print("Be weary traveler, ", 40, 50, 15)
    print("for this tale may ", 40, 60, 15)
    print("become a true one...", 40, 70, 15) --8+(t/4)%8)

    --user instructions
    print("Press Z to Start", 42, 100, 7)
end

--inventory function
function show_inventory()
    game.upd = inventory_update
    game.drw = inventory_draw
end

--if X is pressed, show the inventory
function inventory_update()
    if btn(5) then
        show_inventory()
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
    spr(32, 26, 27)
    spr(48, 10, 34)
    spr(49, 18, 34)
    spr(50, 24, 34)

    --row 1, box 2
    spr(16, 50, 20)
    spr(17, 58, 20)
    spr(18, 64, 20)
    spr(32, 50, 27)
    spr(32, 66, 27)
    spr(48, 50, 34)
    spr(49, 58, 34)
    spr(50, 64, 34)

    --row 1, box 3
    spr(16, 90, 20)
    spr(17, 98, 20)
    spr(18, 104, 20)
    spr(32, 90, 27)
    spr(32, 106, 27)
    spr(48, 90, 34)
    spr(49, 98, 34)
    spr(50, 104, 34)

    --row 2, box 1
    spr(16, 10, 50)
    spr(17, 18, 50)
    spr(18, 24, 50)
    spr(32, 10, 57)
    spr(32, 26, 57)
    spr(48, 10, 64)
    spr(49, 18, 64)
    spr(50, 24, 64)

    --row 2, box 2
    spr(16, 50, 50)
    spr(17, 58, 50)
    spr(18, 64, 50)
    spr(32, 50, 57)
    spr(32, 66, 57)
    spr(48, 50, 64)
    spr(49, 58, 64)
    spr(50, 64, 64)

    --row 2, box 3
    spr(16, 90, 50)
    spr(17, 98, 50)
    spr(18, 104, 50)
    spr(32, 90, 57)
    spr(32, 106, 57)
    spr(48, 90, 64)
    spr(49, 98, 64)
    spr(50, 104, 64)

    --row 3, box 1
    spr(16, 10, 80)
    spr(17, 18, 80)
    spr(18, 24, 80)
    spr(32, 10, 87)
    spr(32, 26, 87)
    spr(48, 10, 94)
    spr(49, 18, 94)
    spr(50, 24, 94)

    --row 3, box 2
    spr(16, 50, 80)
    spr(17, 58, 80)
    spr(18, 64, 80)
    spr(32, 50, 87)
    spr(32, 66, 87)
    spr(48, 50, 94)
    spr(49, 58, 94)
    spr(50, 64, 94)

    --row 3, box 3
    spr(16, 90, 80)
    spr(17, 98, 80)
    spr(18, 104, 80)
    spr(32, 90, 87)
    spr(32, 106, 87)
    spr(48, 90, 94)
    spr(49, 98, 94)
    spr(50, 104, 94)
    
end

--game function
function show_game()
    x = 63 
    y = 63

    game.upd = game_update
    game.drw = game_draw
end

--player movement implemented here
function game_update()
    if btn(0) then
        player.x -= player.speed
        move()
    end

    if btn(1)  then
        player.x += player.speed
        move()
    end

    if btn(2) then
        player.y -= player.speed
        move()
    end

    if btn(3) then
        player.y += player.speed
        move()
    end

    if not player.moving then
        player.sprite = 0
    end

    if btn(5) then
        show_inventory()
    end
end

--camera panning
function game_draw()
    cls()
    camera(-64 + player.x + 4, -64 + player.y + 4)
    map() 
    spr(player.sprite, player.x, player.y)
    camera()

end

--sprite animation
function move()
    player.moving = true
    player.sprite += 1
    if player.sprite > 2 then
                player.sprite = 0
    end
    cls()
end

--update function
function _update()
  game.upd()

end

--draw function
function _draw()
  game.drw()
end


__gfx__
00044000000440000004400000000000000011100000001100000000d62222222222222200000000ffffffffcccccccc0000000006666660000000000dddddd0
0044440000444400004444000000000000000000011000000000000022222dd22222dd2200000000ffffffffcccccccc000000006000000600000000dddddddd
04ffff4004ffff4004ffff4000000000011100000000000000000000222222222222222200000000fffff7ffcccccccc000000006000000600000000dddddddd
44effe4444effe4444effe440000000000000000000000000000000022dd2dd22222222200000000ffffffffcccccccc000000006000000600000000dddddddd
077227700772277007722770000000001000011100011100000000002222dd222d22222200000000ffffffffcccccccc000000006000000600000000dddddddd
0f7227f00f7227f00f7227f0000000000000000000000000000000002222222222222222000000007fffffffcccccccc000000006000000600000000dddddddd
0050050000500200002005000000000000011110000000110000000022d2222222dd222200000000fffffffffccccccc000000006000000600000000dddddddd
00200200002000000000020000000000110000001110000000000000622222222222222200000000ff7ffffffccccccc0000000006666660000000000dddddd0
0000000000000000000000000000000066666666d1ffffff0000000007777770000000000000000088000088ffffffff0000000000000000000000002dddddd2
0000000000000000000000000000000066666666d122222f0000000077dddd77000000000000000008000080ff7fff7f000000000000000000000000dddddddd
0000000000000000000000000000000066666666d126662f000000007dddddd7000000000000000088800888ffffffff000000000000000000000000dddddddd
0000000000000000000000000000000066666666d126662f000000007d0dd0d7000000000000000000888800f7ffffff000000000000000000000000dddddddd
0000000000000000000000000000000066666666d122222f000000007dddddd7000000000000000000888800ffffffff000000000000000000000000dddddddd
000dddddddddddddddddd0000000000066666666d122222f000000007dddddd7000000000000000000800800ffff7fff000000000000000000000000dddddddd
000dd00000000000000dd0000000000066666666d122222f000000007d7dd7d7000000000000000000000000ffffffff000000000000000000000000dddddddd
000d0000000000000000d0000000000066666666d122222f0000000007777770000000000000000000000000ffffffff0000000000000000000000002dddddd2
000d0000000000000000d00000000000000000000000000000000000deee2dddd3322ddd000000008ff78fffff73ff3f000000000000000000000000fddddddf
000d0000000000000000d00000000000000000000000000000000000ee8ee226333222260000000088ff8f88b3f3bf3f000000000000000000000000dddddddd
000d0000000000000000d00000000000000000000000000000000000ee8eed2222333d2200000000f8ff8f87f3f3ff3b000000000000000000000000dddddddd
000d0000000000000000d000000000000000000000000000000000002eee22222233222200000000f888888ff3f3f33f000000000000000000000000dddddddd
000d0000000000000000d000000000000000000000000000000000002232222222322222000000007fff88fff3f333ff000000000000000000000000dddddddd
000d0000000000000000d00000000000000000000000000000000000223322222232222200000000f8ff8ff8b3f3ffff000000000000000000000000dddddddd
000d0000000000000000d00000000000000000000000000000000000ddd3d222ddd3d22200000000f8f78888f333bff7000000000000000000000000dddddddd
000d0000000000000000d00000000000000000000000000000000000622322dd622322dd00000000f8888ff77ff3f7ff000000000000000000000000fddddddf
000d0000000000000000d0000000000000000000000000000000000000000000000000000000000000000000cccccccc00000000000000000000000000000000
000d0000000000000000d0000000000003333300033000000333003003333330000000000000000000000000cccccccc00000000000000000000000000000000
000d0000000000000000d0000000000003300330033000000333303003333330000000000000000000000000cccccccc00000000000000000000000000000000
000dd00000000000000dd0000000000003300030033000000330303000033000000000000000000000000000cccccccc00000000000000000000000000000000
000dddddddddddddddddd0000000000003333330033000000330333000033000000000000000000000000000cccccccc00000000000000000000000000000000
0000000000000000000000000000000003300000033000000330033000033000000000000000000000000000cccccccc00000000000000000000000000000000
0000000000000000000000000000000003300000033333000330033000033000000000000000000000000000cccccccc00000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccccc00000000000000000000000000000000
3333333333333b334dddddd444444444333333334444444444444444000000000000000000000000000000000000000000000000000000000000000000000000
3bb33bb333b33333dddddddd4444444433333333444e444444433444000000000000000000000000000000000000000000000000000000000000000000000000
333333333b3b3333dddddddd444444443337733344eee44444433444000000000000000000000000000000000000000000000000000000000000000000000000
3333333333b33333dddddddd44444444337aa7334443444443433444000000000000000000000000000000000000000000000000000000000000000000000000
3b3bbbb333333333dddddddd44444444337aa7334433344443333444000000000000000000000000000000000000000000000000000000000000000000000000
3333333333333bb3dddddddd44444444333773334333334444433444000000000000000000000000000000000000000000000000000000000000000000000000
3333bb3333b33333dddddddd444444443333b3334433344444433444000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333334dddddd4444444443333bb334444444444433444000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333334444444444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
333333b3333373334454444445444444404004040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33b333333337a7334455445444444445044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333373334444444444444444004444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
333333333b3333334444444444444444008448000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3333bb33333333334444444444444444044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3b333333333333b34454444444445444404004040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333334444444444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3b333333333333330000555000000555000000000000000000000000404004040000000000000000000000000000000000000000000000000000000000000000
33333b33333333330000805000000805000000000000000000000000044444400000000000000000000000000000000000000000000000000000000000000000
3333333333333b330505005500505005000000000000000000000000004444000000000000000000000000000000000000000000000000000000000000000000
3373333333333b335555500555555005000000000000000000000000004444000000000000000000000000000000000000000000000000000000000000000000
37a73333333333335555555555555555000000000000000000000000008448000000000000000000000000000000000000000000000000000000000000000000
33733bb3333333330050500005050000000000000000000000000000044444400000000000000000000000000000000000000000000000000000000000000000
333333b33b3333330000000000000000000000000000000000000000404004040000000000000000000000000000000000000000000000000000000000000000
3b333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3dddddd3333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd3bbb33330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd3333b3330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd33b333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd33b333b30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddd333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3dddddd3333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
34343434343434343425346424343434000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000020000020000000000000000000000000101000101000000000000000000000000000000000000000000000000010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0404040404040404040404040404040407080807080708070807080708070708000000161616130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040404040404040404040407080728070808080708080708070808000000161616000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040404040404040404040408080807080807080808070808080807000000161610111210111210111200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040404040404040404040407080708080708070808072707070807000000000020162220002220002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040404040404040404040408080808080808080708080707080808000000000030313230313230313200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040404040404040404040404040407080807080708080807080808080707000000000010111210111210111200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040404041414140404040f0f0f1f1f1f1f1f1f1f080808080708070808000000000020002220002220002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0f0f0f0f0f0f0f1415140f0f0f0f04040707080808081f080807080808070708000000000030313230313230313200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040404041414140404040404040808070808071f080707080707080707000000000010111210111210111200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040404040404040404040404040708080808081f1f1f1f1f0808080807000000000020002220002220002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404070808080808080808081f0708070708000000000030313230313230313200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404070808080808080807081f0708070808090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404080808070808070808081f0808080807090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040404040404040404040404040404070807080807080708081f0807070807000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
504040414041405050504050504050500a0a0a0a0a0a0a0a0a0a2f0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
504040505060404150604050504050600a0a1b1b1b1b0a0a1b1b2f0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
405140504050504041405040506141510a1b1b1b1b1b0a1b0a0a2f0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
614140414440707070707070705040401b1b1b1b1b1b1b2f2f2f2f0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
414050507150704150514041705150401b2b1b1b1b1b0a2f0a0a0a1b0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
405040707070704040715040704041401b1b0a1b1b1b0a2f1b1b1b1b0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
406151704051404051415061707070702f2f2f2f2f0a0a2f0a0a0a0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
504040704041405050504050504050500a0a0a0a2f0a0a2f0a1b0a0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
504040705060404150604050504050600a0a0a0a2f2f2f2f1b1b0a0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
405140704050504041405040506141510a1b1b1b1b1b0a1b0a0a0a0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
614140704440405050505050505040401b1b1b1b1b1b1b0a0a0a0a0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
414050707150414140514041505150401b0a0a1b1b1b0a0a0a2a0a1b0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
405040707070707070707070704041401b1b0a1b1b1b0a0a0a0a0a1b0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
406151504051404051415061704150510a0a0a0a0a0a0a0a0a0a0a0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
504140414050715050405060704141410a0a0a0a0a0a1b0a0a1b1b0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
504050505140505040715040704140510a1b0a0a0a0a1b1b1b1b0a0a0b3b3b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4343434343434343434343534243434300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4352434343454343434343434243434300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
