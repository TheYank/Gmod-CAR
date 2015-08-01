GM.Name = "Cops & Robbers"
GM.Author = "DerpSquad"
GM.Email = "N/A"
GM.Website = "https://github.com/TheYank/Gmod-CAR"

team.SetUp( 1, "Cops", Color(0, 0, 255) )
team.SetUp( 2, "Robbers", Color(255, 0, 0) )

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

--Models
util.PrecacheModel("models/player/riot.mdl")
util.PrecacheModel("models/player/phoenix.mdl")

CopScore = 0
RobScore = 0