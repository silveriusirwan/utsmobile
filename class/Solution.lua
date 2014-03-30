Solution = Core.class()

function Solution:init(i,j,mode,n)
	self.i = i
	self.j = j
	self.mode = mode
	self.n = n
	self.flag = 1
end

function Solution:getI()
	return self.i
end

function Solution:setI(i)
	self.i = i
end

function Solution:getJ()
	return self.j
end

function Solution:setJ(j)
	self.j = j
end

function Solution:getMode()
	return self.mode
end

function Solution:setMode(mode)
	self.mode = mode
end

function Solution:getN()
	return self.n
end

function Solution:setN(n)
	self.n = n
end

function Solution:getFlag()
	return self.flag
end

function Solution:setFlag(flag)
	self.flag = flag
end

