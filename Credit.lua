Credit = gideros.class(Sprite)

function Credit:init()

		--bground
	local bground = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("creditbg.png"))
	bground:setPosition(270,0); 
	bground:setAnchorPoint(0.5,0)
	self:addChild(bground);
	
	--[[local About = Sprite.new();
	local Aboutbg = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("scroll.png"))
	Aboutbg:setPosition(270,200)
	Aboutbg:setAnchorPoint(0.5,0)
	--local Aboutbtn = Button.new();
	About:addChild(Aboutbg);
	self:addChild(About);]]
	
	-- init visual home
	local homeImage = Button.new(Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("backbtn.png")),Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("backbtn.png")))
	homeImage:setPosition(10,30)
	self:addChild(homeImage);
	--listener button home
	homeImage:addEventListener("click", 
	function()	
		statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			print("status volume", statusvol)
			if statusfx==true then
				channelfx = settings.soundhit:play()
				channelfx:setVolume(statusvol/100)
			end
			sceneManager:changeScene("MainMenu",1,SceneManager.moveFromLeft,easing.outBack)
	end
	)
	
	-- Include Library Box @D
require "box2d"
local world = b2.World.new(0, 5, true)

-- Init Visual Bola
local ballImage = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("creditname.png"))
ballImage:setAnchorPoint(0.5,0.5)
ballImage:setPosition(270,100)
self:addChild(ballImage)

--get radius Bola
local radiusBola = ballImage:getWidth()/2;

--create  physical Body of  Bola
local bodyBola = world:createBody{type = b2.DYNAMIC_BODY}
local bodyShape = b2.CircleShape.new(0, 0, radiusBola)
local bodyCharacteristic = bodyBola:createFixture{
		shape = bodyShape, 
		density = 1.0, 
		friction = 0.1, 
		restitution = 0.7
}
bodyBola:setPosition(270,100)
ballImage.body = bodyBola;

-- Create physical body of lantai
local lantai = world:createBody{type = b2.STATIC_BODY}
local kotak = b2.PolygonShape.new()
kotak:setAsBox(100, 10)
local fixture = lantai:createFixture{shape = kotak, density = 1.0, friction = 0.1, restitution = 0.2}
lantai:setPosition(200, 925)

world:setGravity(0,9.8)

local mainkanSimulasi = function()
	world:step(1/60, 8, 3)
	ballImage:setPosition(ballImage.body:getPosition())
	ballImage:setRotation(math.rad(ballImage.body:getAngle()))	
end
self:addEventListener(Event.ENTER_FRAME, mainkanSimulasi, self)

end