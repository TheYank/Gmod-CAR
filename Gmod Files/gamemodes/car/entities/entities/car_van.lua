AddCSLuaFile()

ENT.Name	=	"van"

function ENT:Initialize()
	self:SetModel("models/LoneWolfie/merc_sprinter_boxtruck.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
end


function ENT:Think()
	
	self:SetupPosition()
	
	return true
end