pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
player = {}

player.alive = true
player.x = 64
player.y = 64
player.width = 4
player.height = 4
player.lives = 3
player.wobble_time = 0
wobble_buffer = 0

num_of_bullets = 100
max_delay = 8
-- how long the player sprite while flash on being hit (in frames)
wobble_duration = 30
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
	
	
	-- step down of delay towards next bullet spawn
	delay -= 1
	for i=1, num_of_bullets do
		if (not bullet_active[i]) then
			if delay > 0 then
				goto continue
			end
			respawn_bullet(i)
			delay = flr(rnd(max_delay))
		else
			move_bullet(i)
			if player.alive then
				if detect_collision(i) then
					if player.lives == 1 then 
						sfx(1)
						player.alive = false
					else 
						sfx(0)
						player.lives -= 1
						player.wobble_time = wobble_duration/2
					end
				end
			end
		end
		
		if bullet_progress[i] > 140 or bullet_progress[i] < -12 then
			bullet_active[i] = false
		end
		::continue::
	end
end

function _draw()
	draw_player()
	for i=1, num_of_bullets do
		draw_bullet(i)
	end
end


function update_player()
	if player.wobble_time > 0 then
			wobble_buffer -= 0.5
	end
	
	if wobble_buffer == -1 then
		player.wobble_time -= 1
		wobble_buffer = 0
	end
	
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
		if player.wobble_time > 0 then
			return false
		end
		if bullet_side[index] ==0 or bullet_side[index]==1 then 
			bullet_x = bullet_progress[index] 
			bullet_y = bullet_spawn[index]
		
		else	
			bullet_y = bullet_progress[index] 
			bullet_x = bullet_spawn[index]
		end
		
		if bullet_x >= (player.x-1) and bullet_x <= (player.x + player.width) and bullet_y >= (player.y-1) and bullet_y <= (player.y + player.width) then
			bullet_progress[index] = -10
			bullet_spawn[index] = -10
			bullet_active[index] = false
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
	if player.alive and (player.wobble_time % 2) ==0 then
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
000300000315005150081500b15008150041500215003100031000310003100031000310002100021002410024100241002410025100251002510026100271002910000100001000010000100001000010000100
000a0000241101f1501b150181501b15018150161501315016150131500f1500c150022500025014200102000d2000b2000a2000720005200022000a200082000520003200002000120000200032000220001200
