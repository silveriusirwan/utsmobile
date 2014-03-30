Level = Core.class(Sprite)

function Level:init(i,j,id)
	self.id = id
	self.levelimg= Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("levelbtn.png"))
	self:addChild(self.levelimg)
	self.levelimg:addEventListener(Event.TOUCHES_BEGIN, self.touchesEnd, self)
end

function Level:touchesEnd(event)
	if self:hitTestPoint(event.touch.x, event.touch.y) then
		local func = assert(loadfile("level/level"..self.id..".txt")) -- load the chunk as a function
		local data = func()  -- call the function to get the data
		for k,v in pairs(data) do
			level = {v[1],v[2],v[3],v[4],v[5]}
		end
		--print(level[1]..","..level[2]..","..level[3])
		gridH = tonumber(level[1])
		gridW = tonumber(level[2])
		variasi = tonumber(level[3])
		maxmove = tonumber(level[4])
		minscore = tonumber(level[5])
		lvl = self.id
		print("level="..lvl)
		sceneManager:changeScene("Play",1,SceneManager.fade,easing.outBack)
		
		statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			print("status volume", statusvol)
			if statusfx==true then
				channelfx = settings.soundhit:play()
				channelfx:setVolume(statusvol/100)
			end
	end
end