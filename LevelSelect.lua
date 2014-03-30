LevelSelect = gideros.class(Sprite)

function LevelSelect:init()
	--bground
	local bground = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("levelbg.png"))
	bground:setPosition(270,0); 
	bground:setAnchorPoint(0.5,0)
	self:addChild(bground);
	
	--TITLE
	local leveltitle = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("leveltitle.png"))
	leveltitle:setPosition(300,20); 
	leveltitle:setAnchorPoint(0.5,0)
	self:addChild(leveltitle);
	
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
		
	local boardbg={}
	local myButton = {};
	local k=1;
	--level buttons
	for i=1,4 do
		boardbg[i]={}
		for j=1,3 do
			boardbg[i][j] = Level.new(i,j,k)
			boardbg[i][j]:setPosition((j-1)*190+10,i*200); 
			self:addChild(boardbg[i][j])
			
			teksbtn = TextField.new(fontFormat2,k);
			if i==4 then
				teksbtn:setPosition((j-1)*190+30,i*200+110)
			else
				teksbtn:setPosition((j-1)*190+50,i*200+110)
			end
			self:addChild(teksbtn)
			k=k+1
		end
	end
end