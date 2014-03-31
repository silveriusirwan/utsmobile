result = gideros.class(Sprite)

function result:init()
	self.bgimage = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("levelplay.png"))
	self:addChild(self.bgimage)
	self.bgimage:setPosition(270,0)
	self.bgimage:setAnchorPoint(0.5,0)
	self.sadimg = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("sad.png"))
	self.sadimg:setPosition(270,200)
	self.sadimg:setAnchorPoint(0.5,0.5)
	self.happyimg = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("happy.png"))
	self.happyimg:setPosition(270,200)
	self.happyimg:setAnchorPoint(0.5,0.5)
	self.hsimg = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("highscore.png"))
	self.hsimg:setPosition(270,570)
	self.hsimg:setAnchorPoint(0.5,0.5)
	self.resultText = TextField.new(fontFormat3," ")
	self.resultText:setPosition(120,350)
	self:addChild(self.resultText)
	self.scoreText = TextField.new(fontFormat3,"Your Score : "..score)
	self.scoreText:setPosition(70,450)
	self:addChild(self.scoreText)
	--[[self.scoreText = TextField.new(fontFormat3,"Target score:"..minscore)
	self.scoreText:setPosition(50,500)
	self:addChild(self.scoreText)-]]
	if(rslt==1) then
		statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			if statusfx==true then
				channelfx = settings.soundcomplete:play()
				channelfx:setVolume(statusvol/100)
			end
		self.resultText:setText("Level Complete")
		self:addChild(self.happyimg)
	else
		statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			if statusfx==true then
				channelfx = settings.soundfail:play()
				channelfx:setVolume(statusvol/100)
			end
		self.resultText:setText("Level Failed")
		self.scoreText:setText("Your Score : "..score.."/"..minscore)
		self:addChild(self.sadimg)
	end
	
	--button to main menu
	local backButtonimg = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("backbtn.png"))
	backButtonimg:setAnchorPoint(0.5,0.5)
	local backButton = Button.new(backButtonimg)
	
	--button to play/retry
	local retryButtonimg = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("retry.png"))
	retryButtonimg:setAnchorPoint(0.5,0.5)
	local retryButton = Button.new(retryButtonimg)
	
	backButton:addEventListener("click", 
		function()
			statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			if statusfx==true then
				channelfx = settings.soundhit:play()
				channelfx:setVolume(statusvol/100)
			end
			sceneManager:changeScene("LevelSelect",1,SceneManager.moveFromLeft,easing.outBack)
	end)
	
	retryButton:addEventListener("click", 
		function()
			statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			if statusfx==true then
				channelfx = settings.soundhit:play()
				channelfx:setVolume(statusvol/100)
			end
			sceneManager:changeScene("Play",1,SceneManager.moveFromLeft,easing.outBack)
	end)
		
	local highscore = {}
	highscore.level = {}
	if(score>hs[lvl] and rslt==1) then
		highscore.level[lvl] = score
		self:addChild(self.hsimg)
		self.highScoreText = TextField.new(fontFormat3," ")
		self.highScoreText:setText("High Score Level "..lvl.." : "..highscore.level[lvl])
		self.highScoreText:setPosition(50,700)
		self:addChild(self.highScoreText)
		backButton:setPosition(150,800)
		retryButton:setPosition(380,800)
		else
		highscore.level[lvl] = hs[lvl]
		backButton:setPosition(150,700)
		retryButton:setPosition(380,700)
	end
	if(score<=hs[lvl] and rslt==1) then
		self.highScoreText = TextField.new(fontFormat3," ")
		self.highScoreText:setText("High Score Level "..lvl.." : "..highscore.level[lvl])
		self.highScoreText:setPosition(50,570)
		self:addChild(self.highScoreText)
		backButton:setPosition(150,680)
		retryButton:setPosition(380,680)
	end
	self:addChild(backButton)
	self:addChild(retryButton)
	local i
	for i=1,12 do
		if(i~=lvl) then
			highscore.level[i] = hs[i]
		end
	end
	dataSaver.save("|D|highscore", highscore)
	
end