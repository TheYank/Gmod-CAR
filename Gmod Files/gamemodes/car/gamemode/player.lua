local ply = FindMetaTable("Player")

local teams = {}

teams[1] = {name = "Cops", color = Vector( .2, .2, 1.0 ), weapons = {"weapon_smg1", "weapon_pistol", "weapon_crowbar", "weapon_frag", "weapon_frag"} }
teams[2] = {name = "Rapists", color = Vector( 1.0, .2, .2 ), weapons = {"weapon_smg1", "weapon_pistol", "weapon_crowbar", "weapon_frag", "weapon_frag"} }

function ply:SetGamemodeTeam( n )
	if not teams[n] then return end
	
	self:SetTeam( n )
	
	self:GiveGamemodeWeapons()
	
	return true
end

function ply:GiveGamemodeWeapons()
	local n = self:Team()
	self:StripWeapons()
	
	for k, v in pairs(teams[n].weapons) do
		self:Give(v)
	end
end
