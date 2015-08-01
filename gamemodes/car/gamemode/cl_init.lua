include("shared.lua")

timer.Create( "RoundTimer", 600, 0, function()

 end)
 
   net.Receive( "Example1", function( len )

    RobScoreC = RobScoreC + 1
	timer.Start( "RoundTimer" )

end) 

 net.Receive( "Example2", function( len )

    CopScoreC = CopScoreC + 1

end) 

 net.Receive( "Example3", function( len )

    CopScoreC = 0

end)

 net.Receive( "Example4", function( len )

    RobScoreC = 0

end)

RobScoreC = 0
CopScoreC = 0
 
hook.Add( "HUDPaint", "robscoretext", function()
	local R = tostring ( RobScoreC )
	surface.SetFont( "CloseCaption_Bold" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( ScrW()/2 - 200, 20 ) 
	surface.DrawText( "Robbers: "..R )
end)

hook.Add( "HUDPaint", "copscoretext", function()
	local C = tostring ( CopScoreC )
	surface.SetFont( "CloseCaption_Bold" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( ScrW()/2 + 43, 20 ) 
	surface.DrawText( "Cops: "..C )
end)

hook.Add( "HUDPaint", "drawroundtext", function()
	local roundtimer = timer.TimeLeft( "RoundTimer" )
	local timeleft = tostring( roundtimer )
	local roundtime = math.floor ( timeleft )
	surface.SetFont( "CloseCaption_Bold" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( ScrW()/2 - 40, 0 ) 
	surface.DrawText( roundtime )
end )

function set_team() 
 
 frame = vgui.Create( "DFrame" ) 
 frame:Center() --Set the window in the middle of the players screen/game window 
 frame:SetSize( 200, 210 ) --Set the size 
 frame:SetTitle( "Change Team" ) --Set title 
 frame:SetVisible( true ) 
 frame:SetDraggable( false ) 
 frame:ShowCloseButton( true ) 
 frame:MakePopup() 
 
 team_1 = vgui.Create( "DButton", frame ) 
 team_1:SetPos( 30, 30 )
 team_1:SetSize( 100, 50 ) 
 team_1:SetText( "Cops" ) 
 team_1.DoClick = function() --Make the player join team 1 
 
     RunConsoleCommand( "team_1" ) 
 
 end 
 
 team_2 = vgui.Create( "DButton", frame ) 
 team_2:SetPos( 30, 85 ) --Place it next to our previous one 
 team_2:SetSize( 100, 50 ) 
 team_2:SetText( "Robbers" ) 
 team_2.DoClick = function() --Make the player join team 2 
 
     RunConsoleCommand( "team_2" ) 
 
 end 
 
 end 
 concommand.Add( "team_menu", set_team ) 
 
 -- I don't know how this works, nor do I care. It just gives my gamemode hands! - Msg From Apple
function GM:PostDrawViewModel( vm, ply, weapon )
if ( weapon.UseHands || !weapon:IsScripted() ) then
local hands = LocalPlayer():GetHands()
if ( IsValid( hands ) ) then hands:DrawModel() end
end
end

