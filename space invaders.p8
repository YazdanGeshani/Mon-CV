pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
	p={x=60,y=90,speed=1.5}
	bullets={}
	enemies={}
	explosions={}
	create_stars()
	spawn_enemies()
end

function _update60()
	if (btn(➡️)) p.x+=p.speed
	if (btn(⬅️)) p.x-=p.speed
	if (btn(⬆️)) p.y-=p.speed
	if (btn(⬇️)) p.y+=p.speed
	if (btnp(❎)) shoot()
	update_bullets()
	update_stars()
	if #enemies==0 then
		spawn_enemies()	
	end
	update_enemies()
	update_explosions() 
end

function _draw()
		cls()
--affichage des ennemies
for e in all(enemies) do
		spr(3,e.x,e.y)
end
--affichage des etoiles
for s in all(stars) do
		pset(s.x,s.y,s.col)
end
--affichage des explosions
draw_explosions()
--affichage des balles
for b in all(bullets) do
		spr(2,b.x,b.y)
end
--affichege de vaisseau
		spr(1,p.x,p.y)
end


-->8
--bullets
function shoot()
	new_bullet={
	x=p.x,
	y=p.y,
	speed=3
	}
	add(bullets, new_bullet)
	sfx(0)
end

function update_bullets()
	for b in all(bullets) do
	b.y-=b.speed
	if b.y < -8 then
	del(bullets,b)
	end
end
end
-->8
--stars
function create_stars()
	stars={}
	for i=1,13 do
	 new_star={
	 x=rnd(128),
	 y=rnd(128),
	 col=1,
	 speed=0.5+rnd(1)
	 }
	 add (stars,new_star)
	end
	for i=1,9 do
	 new_star={
	 x=rnd(128),
	 y=rnd(128),
	 col=6,
	 speed=1+rnd(2)
	 }
	 add (stars,new_star)
	end
		for i=1,15 do
	 new_star={
	 x=rnd(128),
	 y=rnd(128),
	 col=10,
	 speed=1.5+rnd(2)
	 }
	 add (stars,new_star)
end	
end

function update_stars()
	for s in all(stars) do
		s.y+=s.speed
		if s.y > 128 then
			s.y=0
			s.x=rnd(128)
		end
	end
end
-->8
--enemies

function spawn_enemies()
for i=1,8 do
	new_enemy={
		x=rnd(128),
		y=-20,
		life=4
	}
		add(enemies,new_enemy)
	end
end
	
function update_enemies()
	for e in all(enemies) do
		e.y+=0.25
			if e.y > 128 then
				del(enemies,e)	
		end


--collision
for b in all(bullets) do
	if collision(e,b) then
		create_explosion(b.x+4,b.y+2)
		del(bullets,b)
		e.life-=1
			if e.life==0 then
			del(enemies,e)
			end
		end
	end	
end
end

for e in all(enemies) do
	if collision(e,p) then
		create_explosion(e.x+4,e.x+2)
		del(enemies,e)
		end
		end
-->8
--collision

function collision(a,b)
	if a.x > b.x+8
	or a.y > b.y+8
	or a.x+8 < b.x
	or a.y+8 < b.y then
		return false
	else
		return true
	end
end


-->8
--explosion

function create_explosion(_x,_y)
	add(explosions,{x=_x,
																	y=_y,
																	timer=0})
	sfx(1)
		
	end
	
function update_explosions()
	for e in all(explosions) do
		e.timer+=1
	if e.timer==13 then
		del (explosions,e)
		end
	end
end

function draw_explosions()
	circ(x,y,rayon,couleur)
	
	for e in all(explosions)	do
		circ(e.x,e.y,e.timer/3,
						8+e.timer%3)							
	end
end
	
	
__gfx__
000000000000000000a00a00000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000a00a00000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000080080000a00a0000bbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000480084000b00b000cb88bc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770004489984400b00b0000bbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007004499994400000000000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000099449900000000000c00c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000a44a000000000000c00c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000032550305502a5501f55016550115500e5500d5500d5500d5500e55011550125500f5500c5502b5001d50003500065000b5000f50012500155001b5001c50020500235002550026500275002950000500
00010000000000000000000290002900029000270002400015600166001760019600126001e600316502965031650336502d6502965000600196500165004650206001b6300d6400000000000000000000000000
