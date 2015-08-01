AddCSLuaFile()

SWEP.PrintName = "Flag"
SWEP.Author = "SixthSauce"
SWEP.Purpose = "Cap it!"
SWEP.ViewModel = "models/flag/briefcase.mdl"
SWEP.WorldModel = ""


function SWEP:Initialize()
	self:SetWeaponHoldType("melee")
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:GetViewModelPosition(position, angle)
	local owner = self.Owner
	
	if ( IsValid(owner) ) then
		position = position + owner:GetRight()*50 + owner:GetAimVector()*15 - owner:GetUp()*9
	end
	return position, angle
end

function SWEP:ViewModelDrawn(viewModel)
	
end
