AddCSLuaFile()

ENT.Name	=	"Flag"
ENT.Type	=	"anim"

function ENT:Initialize()
	self:SetModel("models/flag/briefcase.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
end

function ENT:Touch(entity, teamID)
	local team = entity:Team()
	local point = ents.FindByClass( 'info_player_blue' )[ 1 ]
	local setpoint = point:GetPos()
	
	if ( entity:IsPlayer() ) and team == 1 then
		self:SetPos( setpoint + Vector ( 40, 5, 0) )
	end
	
	if ( entity:IsPlayer() ) and team == 2 then
		entity:StripWeapons()
		entity:Give("weapon_flag")
		self:SetOwner(entity)
	end
end

function ENT:SetupPosition()
	
	owner = self:GetOwner()
	
	if ( IsValid(owner) ) then
	
		local attachment = owner:LookupAttachment("anim_attachment_RH")
		local position, angles
		
		if (attachment) then
			local data = owner:GetAttachment(attachment)
		
			position = data.Pos
			angles = data.Ang
		else
			position = owner:GetPos()
			angle = owner:EyeAngles()
		end
		
		self:SetPos(position)
		self:SetAngles(angles)
	
	end
	
	return true
end

function ENT:Think()
	
	self:SetupPosition()
	
	return true
end