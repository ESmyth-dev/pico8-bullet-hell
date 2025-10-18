pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
player = {}

player.alive = true
player.x = 64
player.y = 64
player.width = 4
player.height = 4

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

-- main update function
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
			if player.alive then
				if detect_collision(i) then
					sfx(o)
					player.alive = false
				end
			end
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
	if (btn(0) and player.x > 0) then player.x -= 1 end
	if (btn(1) and player.x < 120) then player.x += 1 end
	if (btn(2) and player.y > 0) then player.y -= 1 end
	if (btn(3) and player.y < 120) then player.y += 1 end
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

function detect_collision(index)
		if bullet_side[index] ==0 or bullet_side[index]==1 then 
			bullet_x = bullet_progress[index] 
			bullet_y = bullet_spawn[index]
		
		else	
			bullet_y = bullet_progress[index] 
			bullet_x = bullet_spawn[index]
		end
		
		if bullet_x >= (player.x-1) and bullet_x <= (player.x + player.width) and bullet_y >= (player.y-1) and bullet_y <= (player.y + player.width) then
			return true
		else
			return false
		end
end


function draw_bullet(index)
	if bullet_side[index] == 0 or bullet_side[index] == 1 then
		spr(2, bullet_progress[index], bullet_spawn[index])

	else
		spr(2, bullet_spawn[index], bullet_progress[index])
	end
end


function draw_player()
	cls(1)
	if player.alive then
		spr(1, player.x, player.y)
	end
end
__gfx__
00000000777700008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777700008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0004000000100001000b2500d2500d2501025013250102500c2500a2500b2500b2500b2500a250072502470024700247002470025700257002570026700277002970000100001000010000100001000010000100
