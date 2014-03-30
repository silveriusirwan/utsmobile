Fruit = Core.class(Sprite)

function Fruit:init(buah,i,j)
	self.row = i
	self.col = j
	self.buah=buah
	self.fruitimg= Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion(buah..".png"))
	self.fruitimg:setAnchorPoint(0.5,0.5)
	self.splashimg= Bitmap.new(Texture.new("asset/"..buah.."splash.png"))
	self.splashimg:setAnchorPoint(0.5,0.5)
	self:addChild(self.fruitimg)
end

function Fruit:getBuah()
	return self.buah
end

function Fruit:getRow()
	return self.row
end

function Fruit:getRowPos()
	return (self.row-1)*50+150+25
end

function Fruit:getCol()
	return self.col
end

function Fruit:getColPos()
	return (self.col-1)*50+(540-gridW*50)/2+25
end

function Fruit:setRow(i)
	self.row = i
end

function Fruit:setCol(j)
	self.col = j;
end

function Fruit:moveLeft(times, speed, dly, rpt, back)
	local twn = GTween.new(self, speed, {x = self:getColPos()-(times*50)}, {delay = dly, ease = easing.outBounce, repeatCount = rpt, reflect = false, timescale=20, dispatchEvents=true})
	twn:addEventListener("complete", function()
		if(back==1) then
			GTween.new(self, speed, {x = self:getColPos()}, {delay = dly, ease = easing.outBounce, repeatCount = rpt, reflect = false, timescale=20})
		end
	end)
end

function Fruit:moveRight(times, speed, dly, rpt, back)
	local twn = GTween.new(self, speed, {x = self:getColPos()+(times*50)}, {delay = dly, ease = easing.outBounce, repeatCount = rpt, reflect = false, timescale=20, dispatchEvents=true})
	twn:addEventListener("complete", function()
		if(back==1) then
			GTween.new(self, speed, {x = self:getColPos()}, {delay = dly, ease = easing.outBounce, repeatCount = rpt, reflect = false, timescale=20})
		end
	end)
end

function Fruit:moveUp(times,speed, dly,rpt, back)
	local twn = GTween.new(self, speed, {y = self:getRowPos()-(times*50)}, {delay = dly, ease = easing.outBounce, repeatCount = rpt, reflect = false, timescale=20, dispatchEvents=true})
	twn:addEventListener("complete", function()
		if(back==1) then
			GTween.new(self, speed, {y = self:getRowPos()}, {delay = dly, ease = easing.outBounce, repeatCount = rpt, reflect = false, timescale=20})
		end
	end)
end

function Fruit:moveDown(times,speed,dly,rpt, back)
	local twn = GTween.new(self, speed, {y = self:getRowPos()+(times*50)}, {delay = dly, ease = easing.outBounce, repeatCount = rpt, reflect = false, timescale=20, dispatchEvents=true})
	twn:addEventListener("complete", function()
		if(back==1) then
			GTween.new(self, speed, {y = self:getRowPos()}, {delay = dly, ease = easing.outBounce, repeatCount = rpt, reflect = false, timescale=20})
		end
	end)
end

function Fruit:moveDownTo(yfinal,speed,dly,rpt)
	local twn = GTween.new(self, speed, {y = yfinal}, {delay = dly, ease = easing.outBounce, repeatCount = rpt, reflect = false, timescale=20, dispatchEvents=true})
	twn:addEventListener("complete", function()
		--print(self:getRow()..","..self:getCol()..","..self:getBuah()..","..self:getRowPos()..","..self:getY())
		local twn2 = GTween.new(self, speed, {y = self:getRowPos()}, {delay = 0, ease = easing.outBounce, repeatCount = rpt, reflect = false, timescale=20, dispatchEvents=true})
		twn2:addEventListener("complete", function()
			if(move==maxmove) then
				if score>=minscore then
					rslt=1
					else
					rslt=0
				end
				sceneManager:changeScene("result",1,SceneManager.moveFromRight,easing.outBack)
			end
		end)
	end)
end

function Fruit:splash()
	self:removeChild(self.fruitimg)
	self:addChild(self.splashimg)
	local properties = {}
	properties.delay = 0
	properties.ease = easing.outBack
	properties.dispatchEvents = true
	local twn = GTween.new(self, 0.2, {scaleX = 1.5, scaleY = 1.5}, properties)
	twn:addEventListener("complete", function()
		self:removeChild(self.splashimg)	
	end)
end