pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
player_x = 64
player_y = 64
bullet_active = false

function _update()
	update_player()
	
	if (not bullet_active) then
		respawn_bullet()
		
	else
		move_bullet()
	end
	
	if bullet_progress > 130 or bullet_progress < -5 then
		bullet_active = false
	end
end

function _draw()
	draw_player()
	draw_bullet()
end


function update_player()
	if (btn(0) and player_x > 0) then player_x -= 1 end
	if (btn(1) and player_x < 120) then player_x += 1 end
	if (btn(2) and player_y > 0) then player_y -= 1 end
	if (btn(3) and player_y < 120) then player_y += 1 end
end

function respawn_bullet()
	bullet_side = flr(rnd(4))
	bulletspawn_pos = flr(rnd(128))
	bullet_active = true
	if bullet_side==1 or bullet_side ==3 then
	bullet_progress = 127
	else
		bullet_progress = 0
	end
end

function move_bullet()
	if bullet_side==0 or bullet_side==2 then
				bullet_progress += 1

	elseif bullet_side==1 or bullet_side==3 then
			bullet_progress -= 1
	end
end

function draw_bullet()
	if bullet_side==0
		then spr(2, bullet_progress, bulletspawn_pos)

	elseif bullet_side==1
		then spr(2, bullet_progress, bulletspawn_pos)

	elseif bullet_side==2
		then spr(2, bulletspawn_pos, bullet_progress)
		
	else
		spr(2, bulletspawn_pos, bullet_progress)
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
