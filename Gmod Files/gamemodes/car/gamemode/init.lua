
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
include( "player.lua" )


function GM:PlayerConnect( name, ip )

	print("Player: " .. name .. ", has joined the game.")
end

function GM:PlayerInitialSpawn( ply )
	print("Player: " .. ply:Nick() .. ", has spawned.")
	
	ply:SetModel("models/player/group01/male_07.mdl")
	
	ply:ConCommand( "team_menu" )
	
end



function GM:PlayerSpawn( ply )
	ply:StripWeapons()
	
	ply:GiveGamemodeWeapons()

	ply:GiveAmmo( 36, "Pistol", true )
	ply:GiveAmmo( 90, "SMG1", true )
	
	local COP = team.NumPlayers ( 1 )
	local ROB = team.NumPlayers ( 2 )
	
if COP == ROB then 
	concommand.Add( "team_1", team_1 )
	concommand.Add( "team_2", team_2 )
end

if COP > ROB then
	concommand.Remove( "team_1", team_1 )
	concommand.Add( "team_2", team_2 )
end

if ROB > COP then
	concommand.Remove( "team_2", team_2 )
	concommand.Add( "team_1", team_1 )
end

end

function GM:PlayerAuthed( ply, steamID, uniqueID )
	print("Player: " .. ply:Nick() .. ", has gotten authed.")
end

-- I don't know how this works, nor do I care. It just gives my gamemode hands! - Msg From Apple
function HandsSpawn(ply)
local oldhands = ply:GetHands()
if ( IsValid( oldhands ) ) then oldhands:Remove() end
local hands = ents.Create( "gmod_hands" )
if ( IsValid( hands ) ) then
ply:SetHands( hands )
hands:SetOwner( ply )

-- Which hands should we use?
local cl_playermodel = ply:GetInfo( "cl_playermodel" )
local info = player_manager.TranslatePlayerHands( cl_playermodel )
if ( info ) then
hands:SetModel( info.model )
hands:SetSkin( info.skin )
hands:SetBodyGroups( info.body )
end

-- Attach them to the viewmodel
local vm = ply:GetViewModel( 0 )
hands:AttachToViewmodel( vm )

vm:DeleteOnRemove( hands )
ply:DeleteOnRemove( hands )

hands:Spawn()
end 
end

hook.Add( "PlayerSpawn", "HandsSpawn", HandsSpawn )

function GM:PlayerSelectSpawn( pl )

local blue = ents.FindByClass("info_player_blue")
local red = ents.FindByClass("info_player_red")


    local random_1 = math.random(#blue)
	local random_2 = math.random(#red)
 
	if pl:Team() == 2 then
    return red[random_2]
	elseif pl:Team() == 1 then
	return blue[random_1]
	end
 
end

function team_1( ply ) 
 
     ply:SetTeam( 1 ) //Make the player join team 1 
	 ply:Spawn()
	 ply:SetGamemodeTeam( 1 )
	 ply:SetModel ("models/player/riot.mdl")
	 
 end 
 
 function team_2( ply ) 
 
     ply:SetTeam( 2 ) //Make the player join team 2 
	 ply:Spawn()
	 ply:SetGamemodeTeam( 2 )
	 ply:SetModel ("models/player/phoenix.mdl")
	 
 end 
 
 function GM:InitPostEntity( )
local copFlag = ents.Create( "ctf_flag" )
copFlag:SetColor( Color( 0, 0, 0 ) )
for k,v in ipairs(ents.FindByClass("info_player_blue")) do
    if !IsValid(v) then continue end
copFlag:SetPos(v:GetPos() + Vector ( 40, 5, 0))
end
copFlag:Spawn( )
end

function GM:PlayerDeath( victim, inflictor, attacker )
	local setpos = victim:GetPos()
	local flagent = ents.FindByClass( 'ctf_flag' )[ 1 ]
	local owner = flagent:GetOwner( )
	local entspawn = ents.FindByClass( 'info_player_blue' )[ 1 ]
	if ( victim == owner ) then
		flagent:SetOwner( entspawn )
		flagent:SetPos( setpos + Vector ( 40, 5, 0) )
	end
end
 
util.AddNetworkString( "Example1" ) 
util.AddNetworkString( "Example2" )
util.AddNetworkString( "Example3" )
util.AddNetworkString( "Example4" )
 
function NetExample1()      
	net.Start( "Example1" )         
	net.WriteFloat( RobScore )
	net.Broadcast()               
end
 
 function NetExample2()
	net.Start( "Example2" )
	net.WriteFloat( CopScore )
	net.Broadcast()
 end
 
  function NetExample3()
	net.Start( "Example3" )
	net.Broadcast()
 end
 
  function NetExample4()
	net.Start( "Example4" )
	net.Broadcast()
 end
 
 timer.Create( "ResetTimer", 600, 0, function()
for k,v in pairs(player.GetAll()) do
	v:Kill() end
	if CopScore or RobScore == 15 then
		NetExample3()
		NetExample4()
		RobScore = 0
		CopScore = 0
end
	game.CleanUpMap( false , { "ctf_flag" , "info_player_red" , "info_player_blue" } )
 end)
 
 timer.Create( "UnfreezeTimer", 10, 0, function()
	for _, ply in ipairs( player.GetAll() ) do
   ply:Freeze( false )
end
 end)
 
 timer.Create( "FreezeTimer", 600.01, 0, function()
	for _, ply in ipairs( player.GetAll() ) do
   ply:Freeze( true )
end
 end)
 
 timer.Create( "ScoreTimer", 600, 0, function()
	CopScore = CopScore + 1
	NetExample2()
 end)

 hook.Add("Think", "FlagCheck", function()
local spawn = ents.FindByClass( 'info_player_blue' )[ 1 ]
local setpoint = spawn:GetPos()
local flagent = ents.FindByClass( 'ctf_flag' )[ 1 ]

for _, flag in ipairs(ents.FindByClass("weapon_flag")) do
      if (!IsValid(flag)) then
         continue;
      end
      
      for _, ply in ipairs(ents.FindByClass("info_player_red")) do
         if (!IsValid(ply)) then
            continue;
         end
         
         if(ply:GetPos():Distance(flag:GetPos()) < 50) then
            RobScore = RobScore + 1;
			NetExample1()
            for k,v in pairs(player.GetAll()) do
               v:Kill();
            end
            flagent:SetPos( setpoint + Vector ( 40, 5, 0) )
			timer.Start( "FreezeTimer" )
			timer.Start( "UnfreezeTimer" )
			timer.Start( "ResetTimer" )
			timer.Start("ScoreTimer")
			for _, ply in ipairs( player.GetAll() ) do
			ply:Freeze( true )
			end
            break;
         end
      end
   end
end)

concommand.Add( "team_1", team_1 ) --Add the command to set the players team to team 1 
concommand.Add( "team_2", team_2 ) --Add the command to set the players team to team 2 