GM.Name = "Cops & Rapists"
GM.Author = "SixthSauce"
GM.Email = "N/A"
GM.Website = "N/A"

team.SetUp( 1, "Cops", Color(0, 0, 255) )
team.SetUp( 2, "Rapists", Color(255, 0, 0) )

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

--Models
util.PrecacheModel("models/player/riot.mdl")
util.PrecacheModel("models/player/phoenix.mdl")

CopScore = 0
RobScore = 0