MainMenu = gideros.class(Sprite)

function MainMenu:init()
	
	--bground
	local bground = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("mainmenubg.png"))
	bground:setPosition(270,0); 
	bground:setAnchorPoint(0.5,0)
	self:addChild(bground);
	
	--TITLE
	local maintitle = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("maintitle.png"))
	maintitle:setPosition(380,150); 
	maintitle:setAnchorPoint(0.5,0)
	self:addChild(maintitle);
	
	--play button
	local playButton = Button.new(Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("playbtn.png")),Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("playbtn.png")))
	playButton:setPosition(340,400)
	self:addChild(playButton);
	
	--setting button
	local settingButton = Button.new(Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("settingbtn.png")),Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("settingbtn.png")))
	settingButton:setPosition(320,600)
	self:addChild(settingButton);
	
	--credit button
	local creditButton = Button.new(Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("creditbtn.png")),Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("creditbtn.png")))
	creditButton:setPosition(345,800)
	self:addChild(creditButton);
	
	playButton:addEventListener("click", 
		function()
			statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			print("status volume", statusvol)
			if statusfx==true then
				channelfx = settings.soundhit:play()
				channelfx:setVolume(statusvol/100)
			end
			sceneManager:changeScene("LevelSelect",1,SceneManager.moveFromRight,easing.outBack)
		end)

	settingButton:addEventListener("click", 
		function()
			statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			print("status volume", statusvol)
			if statusfx==true then
				channelfx = settings.soundhit:play()
				channelfx:setVolume(statusvol/100)
			end
			sceneManager:changeScene("Setting",1,SceneManager.moveFromRight,easing.outBack)
		end)

	creditButton:addEventListener("click", 
		function()
			statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			print("status volume", statusvol)
			if statusfx==true then
				channelfx = settings.soundhit:play()
				channelfx:setVolume(statusvol/100)
			end
			sceneManager:changeScene("Credit",1,SceneManager.moveFromRight,easing.outBack)
		end)
	

end