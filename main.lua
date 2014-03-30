fontFormat = TTFont.new("asset/fs.ttf",40);
fontFormat2 = TTFont.new("asset/number.ttf",100);
fontFormat3 = TTFont.new("asset/vintage.ttf",40);
--music1 = Sound.new("asset/music1.mp3")
--mchannel1 = music1:play()
--mchannel1:setVolume(0)
statusmusic=1;

fx1 = Sound.new("asset/fx1.mp3")
fchannel1 = fx1:play()
fchannel1:stop()
statusvolfx=0.9
statusfx=1;

gridH = 0
gridW = 0
variasi = 0
maxmove = 0
minscore = 0
rslt = 0
move = 0
score = 0
lvl = 0
hs = {}
local i
for i=1,12 do
	hs[i] = 0
end

sceneManager = SceneManager.new({
	["MainMenu"] = MainMenu;
	["LevelSelect"] = LevelSelect;
	["Play"] = Play;
	["Setting"] = Setting;
	["result"] = result;
	["Credit"] = Credit;
})
stage:addChild(sceneManager)
transition = SceneManager.fade;
sceneManager:changeScene("MainMenu",1,transition,easing.outBack)

actionButton = function(tex, xp, yp)
	local bmp = Bitmap.new(tex)
	bmp:setAnchorPoint(0.5, 0)
	local newButton = Button.new(bmp)
	newButton:setPosition(xp, yp)
	return newButton;
end 

loadsettings = settings.load()