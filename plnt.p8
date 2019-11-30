pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--initialize
function _init()
    --variables
    scene="menu"
    x=63
    y=63
end

-->8
--canvas size
x = 125  y = 125

--player object
player = {}

--starting position
player.x = 5
player.y = 5

player.sprite = 0
player.speed = 2
player.moving = false

--sprite animation
function move()
		player.moving = true
		player.sprite += 1
		if player.sprite > 1 then
					player.sprite = 0
		end
end
--movement
function _update()
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
  
end

--draw function
function _draw()
  camera(5,-35)
  map() 
  spr(player.sprite, player.x, player.y)
end

-->8
--updates

function update_menu()
    if btnp(❎) then
        scene="game"
    end
end

function update_game()
 if btn(⬅️) then x-=1 end
    if btn(➡️) then x+=1 end
    if btn(⬆️) then y-=1 end
    if btn(⬇️) then y+=1 end

    if btnp(❎) then
        scene="menu"
    end
end

-->8
--draws

function draw_menu()
    cls()
    print("press ❎ to start",30,63)
end

function draw_game()
    cls()
    spr(0, 50, 50)
end
__gfx__
00044000000440000004400000000000000000000000044000000000d6222ddd6666666600000000ffffffffcccccccc00000000066666600000000000000000
00444400004444000044440000000000000000000004444440000000222222266777777600000000ffffffffcccccccc00000000600000060000000000000000
04ffff4004ffff4004ffff400000000000000000004ffffff400000022dddd2267eeee7600000000fffff7ffcccccccc00000000600000060000000000000000
44effe4444effe4444effe440000000000000000044fcffcf440000022dd62226666666600000000ffffffffcccccccc00000000600000060000000000000000
0772277007722770077227700000000000000000444effffe4440000222222227776777700000000ffffffffcccccccc00000000600000060000000000000000
0f7227f00f7227f00f7227f00000000000000000000772277000000022222222ee767eee000000007fffffffcccccccc00000000600000060000000000000000
0050050000500f0000f0050000000000000000000077722777000000ddddd222eee6eeee00000000fffffffffccccccc00000000600000060000000000000000
00f00f0000f0000000000f00000000000000000000f772277f000000622222dd6666666600000000ff7ffffffccccccc00000000066666600000000000000000
00000000ff73ff3f00000000000000000000000000077227700000000dddddd00000001100001110ffffffffcccccccc00000000000000000000000000000000
00000000b3f3bf3f0000000000000000000000000005500550000000dddddddd0110000000000000ffffffffcccccccc00000000000000000000000000000000
00000000f3f3ff3b0000000000000000000000000005500550000000dddddddd0000000001110000f7ffffffcccccccc00000000000000000000000000000000
00000000f3f3f33f000000000000000000000000000ff00ff0000000dddddddd0000000000000000ffffffffcccccccc00000000000000000000000000000000
00000000f3f333ff0000000000000000000000000000000000000000dddddddd0001110010000111ffffffffcccccccc00000000000000000000000000000000
00000000b3f3ffff0000000000000000000000000000000000000000dddddddd0000000000000000ff7ffffffccccccc00000000000000000000000000000000
00000000f333bff70000000000000000000000000000000000000000dddddddd0000001100011110fffffffffccccccc00000000000000000000000000000000
000000007ff3f7ff00000000000000000000000000000000000000000dddddd01110000011000000fffffffffccccccc00000000000000000000000000000000
000000000000000000000000ffffffff8ff78fff0000000066666666ddddddddd1ffffff0000000000eee0000000000000000000000000000000000000000000
000000000000000000000000ffffffff88ff8f880000000066666666ddddddddd122222f000000000ee8ee000000000000000000000000000000000000000000
000000000000000000000000fffffffff8ff8f870000000066666666ddddddddd126662f000000000ee8ee000000000000000000000000000000000000000000
000000000000000000000000fffffffff888888f0000000066666666ddddddddd126662f0000000000eee0000000000000000000000000000000000000000000
000000000000000000000000ffffffff7fff88ff0000000066666666ddddddddd122222f00000000000300000000000000000000000000000000000000000000
000000000000000000000000fffffffff8ff8ff80000000066666666ddddddddd122222f00000000000330000000000000000000000000000000000000000000
000000000000000000000000fffffffff8f788880000000066666666ddddddddd122222f00000000000030000000000000000000000000000000000000000000
000000000000000000000000fffffffff8888ff70000000066666666ddddddddd122222f00000000000030000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066666666000000007777777700000000deee2ddd0000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000666666660000000077dddd7700000000ee8ee2260000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066666666000000007dddddd700000000ee8eed220000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066666666000000007d0dd0d7000000002eee22220000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066666666000000007dddddd700000000223222220000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066666666000000007dddddd700000000223322220000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066666666000000007d7dd7d700000000ddd3d2220000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066666666000000007777777700000000622322dd0000000000000000000000000000000000000000
__map__
1a1a1a1a1a1a1a1a1a1a1a1a0b0c0c0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1a0a0a0a0a0a0a1a1a1a1a0a1b0c1d0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1a0a0a1a1a1a0a0a0a111a1a1b0c1d0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0a0a0a0a0a0a0a0a1a1a1a1b0c1d0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0a0a0a0a0a1a0a1a1a0a0a1b0c1d07070707070707070707073a0707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0a0a0a0a0a0a1a1a0a0a0a1b0c1d0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0a0a0a0a240a0a0a0a0a0a1b0c1d0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0a0a0a0a0a0a0a0a0a0a0a1b0c1d0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1a1a1a1a1a1a1a1a1a1a1a1a1b0c1d0707070707070707070707070707070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191919191919191919190d1e0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191919191919191919190d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191919191919191919191919090d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191919191919191919191919090d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191919191919191919272727090d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
171717171717171717272827090d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191919191919191919272727090d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191919191919191919191919090d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191919191919191919190d0d0d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191919191919191919190d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
