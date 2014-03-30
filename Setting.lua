Setting = gideros.class(Sprite)

function Setting:init()
	--bground
	local bground = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("settingbg.png"))
	bground:setPosition(270,0); 
	bground:setAnchorPoint(0.5,0)
	self:addChild(bground);
	
	--TITLE
	local settingtitle = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("settingtitle.png"))
	settingtitle:setPosition(300,50); 
	settingtitle:setAnchorPoint(0.5,0)
	self:addChild(settingtitle);
	
	--back button
	local backButton = Button.new(Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("backbtn.png")),Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("backbtn.png")))
	backButton:setPosition(10,30)
	self:addChild(backButton);
	
	backButton:addEventListener("click", 
		function()
			statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			print("status volume", statusvol)
			if statusfx==true then
				channelfx = settings.soundhit:play()
				channelfx:setVolume(statusvol/100)
			end
			
			sceneManager:changeScene("MainMenu",1,SceneManager.moveFromLeft,easing.outBack)
		end)
	
	local col = {r=243/255,g=206/255,b=0,a=1}
	local txtY = 200
	local checkX = 30
	local musicSlider
	-- Music On / Off
	musicChk = checkBox.new(checkX, txtY, "Music", col, 
		function(this)
			local state = this:getCheck()
			if state then settings.musicOn()
			else settings.musicOff()
			end
		end
	)
	self:addChild(musicChk)
	musicChk:setCheck(settings.getMusicState())
	
	local sliderX=30;
	-- Music Volume Slider
	musicSlider = slider.new(sliderX,txtY,settings.musicGetVolume(),"",col)
	musicSlider:addEventListener("click",  function() 
		settings.musicSetVolume(musicSlider:getPos())
		end)
	self:addChild(musicSlider)
	
	txtY = txtY + 150;
	--Sound off/on
	soundChk = checkBox.new(checkX, txtY, "Sound FX", col, 
		function(this)
			local state = this:getCheck()
				if state then 
					settings.soundOn()
				--soundfx=1;	
				else 
				settings.soundOff()
				--soundfx=0;
			end
		end
	)
	self:addChild(soundChk)
	soundChk:setCheck(settings.getSoundState())
	
	-- Sound Volume Slider
	fxSlider = slider.new(sliderX,txtY,settings.soundGetVolume(),"",col)
	fxSlider:addEventListener("click",  function() 
		settings.soundSetVolume(fxSlider:getPos())
		end)
	self:addChild(fxSlider)
	
	self:removeEventListener("exitEnd", self.onExitEnd)
end

function Setting:onExitEnd()
	self:removeEventListener("exitEnd", self.onExitEnd)
	musicSlider:onExitEnd()
	fxSlider:onExitEnd()
	soundChk:onExitEnd()
	musicChk:onExitEnd()

	collectgarbage()
end