module("settings", package.seeall)

--loading application settings

local settings

--background music
local music = {}
--sounds
local sounds = {}

function load()
	settings = dataSaver.loadValue("sets")
	--if sets not define (first launch)
	--define defaults
	if(not settings) then
		settings = {}
		settings.sounds = true
		settings.soundfx = 1
		settings.sndVol = 1
		settings.music = true
		settings.musicChannel = 0
		settings.musicVol = 1
		settings.autosave = true
		settings.curLevel = 1
		settings.curPack = 1
		dataSaver.saveValue("sets", settings)
	end
	
	--play music if enabled
	if settings.music then
		music.channel = music.theme:play(0,1000000)
		music.channel:setVolume(settings.musicVol)
	end
	
	if settings.sounds then
		statusf=1;	
		print("status fx awal",statusf);
	else
		statusf=0;
		print("status fx awal",statusf);
	end

	
end
		

--load main theme
music.theme = Sound.new("asset/music1.mp3")
--music.channel = music.theme:play(0,1000000)
--turn music on
musicOn = function()
	if settings.musicChannel==0 then
		settings.musicChannel =1;
		music.channel = music.theme:play(0,1000000)
		music.channel:setVolume(settings.musicVol)
	end
	settings.music = true
	dataSaver.saveValue("sets", settings)
end

--turn music off
musicOff = function()
	if settings.musicChannel==1 then
		music.channel:stop(true)
		settings.musicChannel = 0
	end
	settings.music = false
	dataSaver.saveValue("sets", settings)
end

-- set sfx volume
musicSetVolume = function(vol)
	print("musicSetVolume("..vol..")")
	settings.musicVol = vol/100
	if settings.musicChannel==1 then
		music.channel:setVolume(settings.musicVol)
	end
	dataSaver.saveValue("sets", settings)
end	


--load all your sounds here
--after that you can simply play them as sounds.play("hit")
--sounds.complete = Sound.new("audio/complete.mp3")
soundhit = Sound.new("asset/fx1.mp3")
soundswap = Sound.new("asset/swap.mp3")
soundsplash = Sound.new("asset/splash.mp3")
soundcomplete = Sound.new("asset/lvlcomplete.mp3")
soundfail = Sound.new("asset/lvlfail.mp3")
--turn sounds on
soundOn = function()
	settings.sounds = true
	--settings.soundfx = 1
	statusfx=1
			--print("status fx",settings.soundfx)
	soundhit:play()
	dataSaver.save("sets", settings)
end

--turn sounds off
soundOff = function()
	settings.sounds = false
	--settings.soundfx = 0
	statusfx=0
		--print("status fx",settings.soundfx)

	dataSaver.saveValue("sets", settings)
end

--play sounds
soundPlay = function(sound)
	--check if sounds enabled
	if settings.sounds and sounds[sound] then
		settings.sndChannel = sounds[sound]:play()
		settings.sndChannel:setVolume(settings.sndVol)
	end
end

-- set sfx volume
soundSetVolume = function(vol)
	print("soundSetVolume("..vol..")")
	settings.sndVol = vol/100
	if settings.sndChannel then 
	--soundhit:play()
	settings.sndChannel:setVolume(settings.sndVol) end
	channel = soundhit:play()
	channel:setVolume(settings.sndVol)
	dataSaver.saveValue("sets", settings)
end	


getMusicState = function() return settings.music end
musicGetVolume = function() return settings.musicVol*100 end
getSoundState = function() return settings.sounds end
soundGetVolume = function() return settings.sndVol*100 end


