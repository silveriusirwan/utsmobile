Play = gideros.class(Sprite)

function Play:touchesBegin(event)
	self.xtouch = event.touch.x
	self.ytouch = event.touch.y
	self.jMove= math.floor((self.xtouch-self.xMin)/50)+1
	self.iMove= math.floor((self.ytouch-self.yMin)/50)+1
	self.start = 1;
	--self:splashFruits(self.iMove,self.jMove,2,3)
	--self:arrangeVertical(self.iMove,self.jMove,3)
end

function Play:touchesEnd(event)
	if self.start==1 then
	if(self:inArea(self.xtouch,self.ytouch)==1) then
		dx = event.touch.x - self.xtouch;
		dy = event.touch.y - self.ytouch;
		local temp;
		local temp2;
		self.numSolution=0
		if (math.abs(dx) > math.abs(dy)) then --horizontal
			if(dx>0 and math.abs(dx)>20 and self.jMove<self.boardW) then --kanan
				self:swapFruit(self.iMove,self.jMove,1,0.2,0,1)
				--[[self:generateSolution()
				if(self.numSolution==0) then
					print("masuk:"..self.fruitList[self.iMove][self.jMove]:getBuah())
					self:swapFruit(self.iMove,self.jMove,1,0.2,0,1)
				end
				while(self.numSolution>0) do
					print("ada solusi")
					for i=1,self.numSolution do
						self:splashFruits(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getMode(),self.solutionList[i]:getN())
						self:arrangeVertical(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getN())
					end
					self:generateSolution()
				end--]]
			elseif(dx<0 and math.abs(dx)>30 and self.jMove>1) then --kiri
				self:swapFruit(self.iMove,self.jMove,2,0.2,0,1)
				self:generateSolution()
				--[[if(self.numSolution==0) then
					print("masuk:"..self.fruitList[self.iMove][self.jMove]:getBuah())
					self:swapFruit(self.iMove,self.jMove,2,0.2,0,1)
				end
				while(self.numSolution>0) do
					print("ada solusi")
					for i=1,self.numSolution do
						self:splashFruits(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getMode(),self.solutionList[i]:getN())
						self:arrangeVertical(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getN())
					end
					self:generateSolution()
				end--]]
			end
		else --vertical
			if(dy>0 and math.abs(dy)>20 and self.iMove<self.boardH) then --bawah
				self:swapFruit(self.iMove,self.jMove,3,0.2,0,1)
				--[[self:generateSolution()
				if(self.numSolution==0) then
					print("masuk:"..self.fruitList[self.iMove][self.jMove]:getBuah())
					self:swapFruit(self.iMove,self.jMove,3,0.2,0,1)
				end
				while(self.numSolution>0) do
					print("ada solusi")
					for i=1,self.numSolution do
						self:splashFruits(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getMode(),self.solutionList[i]:getN())
						self:arrangeVertical(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getN())
					end
					self:generateSolution()
				end--]]
			elseif(dy<0 and math.abs(dy)>20 and self.iMove>1) then --atas
				self:swapFruit(self.iMove,self.jMove,4,0.2,0,1)
				--[[self:generateSolution()
				if(self.numSolution==0) then
					print("masuk:"..self.fruitList[self.iMove][self.jMove]:getBuah())
					self:swapFruit(self.iMove,self.jMove,4,0.2,0,1)
				end
				while(self.numSolution>0) do
					print("ada solusi")
					for i=1,self.numSolution do
						self:splashFruits(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getMode(),self.solutionList[i]:getN())
						self:arrangeVertical(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getN())
					end
					self:generateSolution()
				end--]]
			end
		end
	end
	end
end

function Play:init()
	--bground
	local bground = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("levelplay.png"))
	bground:setPosition(270,0); 
	bground:setAnchorPoint(0.5,0)
	self:addChild(bground);
	
	rslt = 0
	self.board={}
	score = 0
	move = 0
	self.numSolution = 0
	self.solutionList = {}
	local boardbg={}
	self.fruitList={}
	local fruitimg
	local i,j
	self.boardW = gridW
	self.boardH = gridH
	self.xMin = (540-gridW*50)/2
	self.yMin = 150
	self.xMax = self.xMin + tonumber(gridW)*50
	self.yMax = self.yMin + tonumber(gridH)*50
	self.start = 0;	
	for i=1,self.boardH do
		self.board[i]={}
		self.fruitList[i]={}
		boardbg[i]={}
		for j=1,self.boardW do
			boardbg[i][j]= Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("block.png"))
			boardbg[i][j]:setAnchorPoint(0.5,0.5)
			boardbg[i][j]:setPosition(self.xMin+(j-1)*50+25,self.yMin+(i-1)*50+25); 
			self:addChild(boardbg[i][j])
			buah=math.random(1,tonumber(variasi))
			if backbuah2==buah and backbuah1==buah then
				buah=math.random(1,variasi)
			end
			self.fruitList[i][j] = Fruit.new(buah,i,j)
			self.fruitList[i][j]:setPosition(self.xMin+(j-1)*50+25,self.yMin+(i-1)*50+25);
			self:addChild(self.fruitList[i][j])
			self.board[i][j]=buah;
			--print(self.board[i][j])
			backbuah2=buah;
			backbuah1=buah;
		end
	end
	--[[self:generateSolution()
	while(self.numSolution>0) do
		print("sebelum displash:")
		self:printBoard()
		for i=1,self.numSolution do
			print("solusi["..i.."]:"..self.solutionList[i]:getI()..","..self.solutionList[i]:getJ()..","..self.solutionList[i]:getN())
			self:splashFruits(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getMode(),self.solutionList[i]:getN())
			self:arrangeVertical(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getN())
		end
		self:arrangeAll()
		print("setelah displash:")
		self:printBoard()
		--self:printPosition()
		self:generateSolution()
	end--]]
	self.scoreText = TextField.new(fontFormat3,"Score:"..score.."/"..minscore)
	self.scoreText:setPosition(250,800)
	self:addChild(self.scoreText)
	self.moveText = TextField.new(fontFormat3,"Move:"..move.."/"..maxmove)
	self.moveText:setPosition(250,720)
	self:addChild(self.moveText)
	self:genSolRec()
	self:addEventListener(Event.TOUCHES_BEGIN, self.touchesBegin, self);
	self:addEventListener(Event.TOUCHES_END, self.touchesEnd, self);
	

	
	--button to main menu
	local backButtonimg = Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("backbtn.png")),Bitmap.new(TexturePack.new("asset/texture.txt","asset/texture.png",true):getTextureRegion("backbtn.png"))
	backButtonimg:setAnchorPoint(0.5,0.5)
	local backButton = Button.new(backButtonimg)
	backButton:setPosition(90,850)
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
			sceneManager:changeScene("LevelSelect",1,SceneManager.moveFromLeft,easing.outBack)
		end)
		
	local highscore = dataSaver.load("|D|highscore")
	if highscore ~= nil then
		local i
		for i=1,12 do
			hs[i] = highscore.level[i]
		end
		--print("highscore:"..hs)
	end
	
end;

function Play:inArea(x,y)
	--print("in area:")
	--print(self.xMax..","..self.xMin..","..self.yMax..","..self.yMin)
	if(x<=self.xMax and x>=self.xMin and y<=self.yMax and y>=self.yMin) then
		return 1
	else
		return 0
	end
end


function Play:swapFruit(i,j,mode,speed, delay,rpt)
	local iPair = 1
	local jPair = 1
	local temp
	local temp2
	local back
	--swap move pairs of fruit
	if(mode==1) then --kanan
		iPair = i
		jPair = j + 1
		temp2=self.board[i][j]
		self.board[i][j]=self.board[iPair][jPair]
		self.board[iPair][jPair]=temp2
		self:generateSolution()
		if(self.numSolution>0) then
			--print("solusi kanan")
			back = 0
		else
			back = 1
		end
		self.fruitList[i][j]:moveRight(1,speed,delay,rpt,back)
		self.fruitList[iPair][jPair]:moveLeft(1,speed,delay,rpt,back)
	elseif(mode==2) then --kiri
		iPair = i
		jPair = j - 1
		temp2=self.board[i][j]
		self.board[i][j]=self.board[iPair][jPair]
		self.board[iPair][jPair]=temp2
		self:generateSolution()
		if(self.numSolution>0) then
			--print("solusi kiri")
			back = 0
		else
			back = 1
		end
		self.fruitList[i][j]:moveLeft(1,speed,delay,rpt,back)
		self.fruitList[iPair][jPair]:moveRight(1,speed,delay,rpt,back)
	elseif(mode==3) then --bawah
		iPair = i + 1
		jPair = j
		temp2=self.board[i][j]
		self.board[i][j]=self.board[iPair][jPair]
		self.board[iPair][jPair]=temp2
		self:generateSolution()
		if(self.numSolution>0) then
			--print("solusi bawah")
			back = 0
		else
			back = 1
		end
		self.fruitList[i][j]:moveDown(1,speed,delay,rpt,back)
		self.fruitList[iPair][jPair]:moveUp(1,speed,delay,rpt,back)
	elseif(mode==4) then --atas
		iPair = i - 1
		jPair = j
		temp2=self.board[i][j]
		self.board[i][j]=self.board[iPair][jPair]
		self.board[iPair][jPair]=temp2
		self:generateSolution()
		if(self.numSolution>0) then
			--print("solusi atas")
			back = 0
		else
			back = 1
		end
		self.fruitList[i][j]:moveUp(1,speed,delay,rpt,back)
		self.fruitList[iPair][jPair]:moveDown(1,speed,delay,rpt,back)
	end
	--swap data value
	--print("sebelum swap board["..i.."]["..j.."]:"..self.board[i][j])
	--print("sebelum swap warna fruitList["..i.."]["..j.."]"..self.fruitList[i][j]:getBuah())
	if(back==0) then
		temp=self.fruitList[i][j]
		self.fruitList[i][j]=self.fruitList[iPair][jPair]
		self.fruitList[i][j]:setCol(j)
		self.fruitList[i][j]:setRow(i)
		self.fruitList[iPair][jPair]=temp;
		self.fruitList[iPair][jPair]:setCol(jPair)
		self.fruitList[iPair][jPair]:setRow(iPair)
		self:genSolRec()
		move = move + 1
		self.moveText:setText("Move:"..move.."/"..maxmove)
	else
		temp2=self.board[i][j]
		self.board[i][j]=self.board[iPair][jPair]
		--print("setelah swap board["..i.."]["..j.."]:"..self.board[i][j])
		--print("setelah swap warna fruitList["..i.."]["..j.."]"..self.fruitList[i][j]:getBuah())
		self.board[iPair][jPair]=temp2
	end
	
	statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			print("status volume", statusvol)
			if statusfx==true then
				channelfx = settings.soundswap:play()
				channelfx:setVolume(statusvol/100)
			end
end

function Play:splashFruits(iSplash,jSplash,mode,n)
	local i,j
	if(mode==1) then --horizontal
		for j=jSplash,jSplash+n-1 do
			self.fruitList[iSplash][j]:splash()
		end
	elseif (mode==2) then --vertical
		for i=iSplash,iSplash+n-1 do
			self.fruitList[i][jSplash]:splash()
		end
	end
end

function Play:arrangeVertical(iSplash, jSplash, n)
	local i
	for i=iSplash-1,1,-1 do
		self.fruitList[i][jSplash]:moveDownTo(self.fruitList[i][jSplash]:getRowPos()+(n*50),0.5,0.2,1)
		self.fruitList[i+n][jSplash] = self.fruitList[i][jSplash]
		self.fruitList[i+n][jSplash]:setRow(i+n)
		self.fruitList[i+n][jSplash]:setCol(jSplash)
		self.board[i+n][jSplash] = self.board[i][jSplash]
	end
	for i=n,1,-1 do
		buah=math.random(1,6)
		self.board[i][jSplash]=buah;
		self.fruitList[i][jSplash] = Fruit.new(buah,i,jSplash)
		self:addChild(self.fruitList[i][jSplash])
		self.fruitList[i][jSplash]:setPosition(self.xMin+(jSplash-1)*50+25,self.yMin+25); 
		self.board[i][jSplash]=buah
		GTween.new(self.fruitList[i][jSplash], 0.5, {y = 175+((i-1)*50)}, {delay = 0.2, ease = easing.outCircular, repeatCount = 1, reflect = false, timescale=20})
	end
	--print("after splash:")
	--[[for i=1,10 do
		print(self.board[i][jSplash]..","..self.fruitList[i][jSplash]:getBuah()..","..self.fruitList[i][jSplash]:getRowPos()..","..self.fruitList[i][jSplash]:getY())
	end--]]
end

function Play:arrangeAll()
	local i,j
	for i=1,self.boardH do
		for j=1,self.boardW do
			self.fruitList[i][j]:moveDownTo(self.fruitList[i][j]:getRowPos(),0.5,0.2,1)
		end
	end
end

function Play:arrangeHorizontal(iSplash, jSplash, n)
	local j
	for j=jSplash,jSplash+n-1 do
		self:arrangeVertical(iSplash,j,1)
	end
end

function Play:generateSolution()
	local i,j,k
	local counter
	self.solutionList = {}
	self.numSolution = 0
	--enumerate vertical solution
	for j=1,self.boardW do
		i=1
		while i<=self.boardH-2 do
			counter = 0
			while i+1+counter<=self.boardH and self.board[i][j] == self.board[i+1+counter][j] and counter < 4 do
				counter = counter+1
			end
			if(counter >= 2) then
				self.numSolution = self.numSolution + 1;
				self.solutionList[self.numSolution] = Solution.new(i,j,2,counter+1)
			end
			i = i+counter+1
		end
	end
	--enumerate horizontal solution
	for i=1,self.boardH do
		j=1
		while j<=self.boardW-2 do
			counter = 0
			while j+1+counter<=self.boardW and self.board[i][j] == self.board[i][j+1+counter] and counter < 4  do
				counter = counter+1
			end
			if(counter >= 2) then
				for k=j,j+counter do
					if (self:checkIntersect(i,k)~=1) then
						self.numSolution = self.numSolution + 1
						self.solutionList[self.numSolution] = Solution.new(i,k,2,1)
					end
				end
			end
			j = j+counter+1
		end
	end
	return solutionList
end

function Play:checkIntersect(isol,jsol)
	local i
	local found
	found = 0
	i = 1
	while i<=self.numSolution do
		if (self.solutionList[i]:getJ()==jsol) then
			if(isol>=self.solutionList[i]:getI() and isol<=self.solutionList[i]:getI()+self.solutionList[i]:getN()-1) then
				found = 1
			end
		end
		i = i + 1
	end
end

function Play:genSolRec()
	self:generateSolution()
	while(self.numSolution>0) do
		--print("sebelum displash:")
		self:printBoard()
		for i=1,self.numSolution do
			--print("solusi["..i.."]:"..self.solutionList[i]:getI()..","..self.solutionList[i]:getJ()..","..self.solutionList[i]:getN())
			self:splashFruits(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getMode(),self.solutionList[i]:getN())
			score = score + self.solutionList[i]:getN()
			self:arrangeVertical(self.solutionList[i]:getI(),self.solutionList[i]:getJ(),self.solutionList[i]:getN())
		end
		self:arrangeAll()
		--print("setelah displash:")
		--self:printBoard()
		--self:printPosition()
		self:generateSolution()
	end
	statusfx = settings.getSoundState();
			statusvol = settings.soundGetVolume();
			print("status volume", statusvol)
			if statusfx==true then
				channelfx = settings.soundsplash:play()
				channelfx:setVolume(statusvol/100)
			end
	self.scoreText:setText("Score:"..score.."/"..minscore)
end

function Play:printBoard()
	local i,j
	for i=1,self.boardH do
		--print(self.board[i][1]..self.board[i][2]..self.board[i][3]..self.board[i][4]..self.board[i][5]..self.board[i][6]..self.board[i][7]..self.board[i][8]..self.board[i][9]..self.board[i][10])
	end
end

function Play:printPosition()
	local i,j
	for j=1,self.boardW do
		for i=1, self.boardH do
			--print(i..","..j..","..self.board[i][j]..","..self.fruitList[i][j]:getBuah()..","..self.fruitList[i][j]:getRowPos()..","..self.fruitList[i][j]:getY())
		end
	end
end