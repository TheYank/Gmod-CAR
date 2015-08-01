AddCSLuaFile()

ENT.Name	=	"van"

function ENT:Initialize()
	self:SetModel("models/LoneWolfie/merc_sprinter_boxtruck.mdl")
end


function ENT:Think()
	
	self:SetupPosition()
	
	return true
end