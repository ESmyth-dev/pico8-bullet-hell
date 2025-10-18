pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
player_x = 64
player_y = 64

num_of_bullets = 100
max_delay = 8
delay = 0

function init_bullets(num_of_bullets)
	bullet_active = {}
	bullet_side = {}
	bullet_spawn = {}
	bullet_progress = {}
	
	for i=1,num_of_bullets do
		bullet_active[i] = false
		bullet_side[i] = 0
		bullet_spawn[i] = 0
		bullet_progress[i] = -10
	end
end


init_bullets(num_of_bullets)

function _update()
	update_player()
	
	for i=1, num_of_bullets do
		if (not bullet_active[i]) then
			if delay > 0 then
				delay -= 1
				goto continue
			end
			respawn_bullet(i)
		else
			move_bullet(i)
		end
		
		if bullet_progress[i] > 140 or bullet_progress[i] < -12 then
		bullet_active[i] = false
		end
		::continue::
		if delay <= 0 then
			delay = flr(rnd(max_delay))
		end
	end
end

function _draw()
	draw_player()
	for i=1, num_of_bullets do
		draw_bullet(i)
	end
end


function update_player()
	if (btn(0) and player_x > 0) then player_x -= 1 end
	if (btn(1) and player_x < 120) then player_x += 1 end
	if (btn(2) and player_y > 0) then player_y -= 1 end
	if (btn(3) and player_y < 120) then player_y += 1 end
end


function respawn_bullet(index)
	bullet_side[index] = flr(rnd(4))
	bullet_spawn[index] = flr(rnd(128))
	bullet_active[index] = true
	if bullet_side[index] == 1 or bullet_side[index] ==3 then
	bullet_progress[index] = 135
	else
		bullet_progress[index] = -10
	end
end


function move_bullet(index)
	if bullet_side[index] == 0 or bullet_side[index]==2 then
				bullet_progress[index] += 1

	elseif bullet_side[index]==1 or bullet_side[index] ==3 then
			bullet_progress[index] -= 1
	end
end


function draw_bullet(index)
	if bullet_side[index] ==0
		then spr(2, bullet_progress[index], bullet_spawn[index])

	elseif bullet_side[index]==1
		then spr(2, bullet_progress[index], bullet_spawn[index])

	elseif bullet_side[index]==2
		then spr(2, bullet_spawn[index], bullet_progress[index])
		
	else
		spr(2, bullet_spawn[index], bullet_progress[index])
	end
end


function draw_player()
	cls(1)
	spr(1, player_x, player_y)
end
__gfx__
00000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700077777700008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000777777770088800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000777777770888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700077777700088800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077777700008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
