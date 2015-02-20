count = 0
measure = 0
bpm = 160
bps = bpm/60
tsig = 3

accum = 0
tcount = -1
lcount = 1
function updateTime(dt)
	--add to time
	accum = accum + dt


	--count/measure update
	tcount = tcount + (bps * dt)
	ccount = tcount % tsig
	count = math.floor(ccount)+1
	if (count ~= lcount) then
		if (count == 1) then
			measure = measure + 1
		end
		lcount = count
	end
end

function seek(m, c)
	measure = m
	count = c
	song:seek((((m-1)*tsig)+c)/bps)
end



function love.load()
	song = love.audio.newSource("theme.mp3", "static")
end

function love.update(dt)
	--start music
	if accum == 0 then
		love.audio.play(song)
	end

	updateTime(dt)

	if (measure == 17) then seek(37, 1) end
	if (measure == 55) then seek(38, 1) end

	if (measure == 38) then tsig = 4 end

end

function love.draw()
	love.graphics.print(measure)
	love.graphics.print(count, 20)
end