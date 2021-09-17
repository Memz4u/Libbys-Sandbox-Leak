-- "addons\\slick\\lua\\sw_addons\\bluex11\\sound.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

sound.Add( 
{
    name = "sws_apc_engine_idle",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_idle_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_null",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "common/null.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_start",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_start_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_stop",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_stop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_rev",
    channel = CHAN_STATIC,
    volume = 0.9,
    soundlevel = 80,
    pitchstart = 98,
	pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_reverse",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_firstgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_secondgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_thirdgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_fourthgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_cruise_loop3.wav"
} )

sound.Add( 
{
    name = "sws_apc_firstgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_secondgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_thirdgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_fourthgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_cruise_loop3.wav"
} )

sound.Add( 
{
    name = "sws_apc_downshift_to_2nd",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_downshift_to_1st",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_throttleoff_slowspeed",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_slowdown_fast_loop5.wav"
} )

sound.Add( 
{
    name = "sws_apc_throttleoff_fastspeed",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_slowdown_fast_loop5.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_lowfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_lowfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_normalfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_normalfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_highfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_highfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_impact_heavy",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_impact_heavy1.wav",
	        "vehicles/v8/vehicle_impact_heavy2.wav",
			"vehicles/v8/vehicle_impact_heavy3.wav",
			"vehicles/v8/vehicle_impact_heavy4.wav"}
} )

sound.Add( 
{
    name = "sws_apc_impact_medium",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_impact_medium1.wav",
	        "vehicles/v8/vehicle_impact_medium2.wav",
			"vehicles/v8/vehicle_impact_medium3.wav",
			"vehicles/v8/vehicle_impact_medium4.wav"}
} )

sound.Add( 
{
    name = "sws_apc_rollover",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_rollover1.wav",
	        "vehicles/v8/vehicle_rollover2.wav"}
} )

sound.Add( 
{
    name = "sws_apc_turbo_on",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/sligwolf/blue-x11/FC_turbo_on_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_turbo_off",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/v8_turbo_off.wav"
} )

sound.Add( 
{
    name = "sws_apc_start_in_water",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/jetski/jetski_no_gas_start.wav"
} )

sound.Add( 
{
    name = "sws_apc_stall_in_water",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/jetski/jetski_off.wav"
} )

-- "addons\\slick\\lua\\sw_addons\\bluex11\\sound.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

sound.Add( 
{
    name = "sws_apc_engine_idle",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_idle_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_null",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "common/null.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_start",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_start_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_stop",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_stop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_rev",
    channel = CHAN_STATIC,
    volume = 0.9,
    soundlevel = 80,
    pitchstart = 98,
	pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_reverse",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_firstgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_secondgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_thirdgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_fourthgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_cruise_loop3.wav"
} )

sound.Add( 
{
    name = "sws_apc_firstgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_secondgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_thirdgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_fourthgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_cruise_loop3.wav"
} )

sound.Add( 
{
    name = "sws_apc_downshift_to_2nd",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_downshift_to_1st",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_throttleoff_slowspeed",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_slowdown_fast_loop5.wav"
} )

sound.Add( 
{
    name = "sws_apc_throttleoff_fastspeed",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_slowdown_fast_loop5.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_lowfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_lowfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_normalfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_normalfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_highfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_highfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_impact_heavy",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_impact_heavy1.wav",
	        "vehicles/v8/vehicle_impact_heavy2.wav",
			"vehicles/v8/vehicle_impact_heavy3.wav",
			"vehicles/v8/vehicle_impact_heavy4.wav"}
} )

sound.Add( 
{
    name = "sws_apc_impact_medium",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_impact_medium1.wav",
	        "vehicles/v8/vehicle_impact_medium2.wav",
			"vehicles/v8/vehicle_impact_medium3.wav",
			"vehicles/v8/vehicle_impact_medium4.wav"}
} )

sound.Add( 
{
    name = "sws_apc_rollover",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_rollover1.wav",
	        "vehicles/v8/vehicle_rollover2.wav"}
} )

sound.Add( 
{
    name = "sws_apc_turbo_on",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/sligwolf/blue-x11/FC_turbo_on_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_turbo_off",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/v8_turbo_off.wav"
} )

sound.Add( 
{
    name = "sws_apc_start_in_water",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/jetski/jetski_no_gas_start.wav"
} )

sound.Add( 
{
    name = "sws_apc_stall_in_water",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/jetski/jetski_off.wav"
} )

-- "addons\\slick\\lua\\sw_addons\\bluex11\\sound.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

sound.Add( 
{
    name = "sws_apc_engine_idle",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_idle_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_null",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "common/null.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_start",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_start_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_stop",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_stop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_rev",
    channel = CHAN_STATIC,
    volume = 0.9,
    soundlevel = 80,
    pitchstart = 98,
	pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_reverse",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_firstgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_secondgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_thirdgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_fourthgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_cruise_loop3.wav"
} )

sound.Add( 
{
    name = "sws_apc_firstgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_secondgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_thirdgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_fourthgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_cruise_loop3.wav"
} )

sound.Add( 
{
    name = "sws_apc_downshift_to_2nd",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_downshift_to_1st",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_throttleoff_slowspeed",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_slowdown_fast_loop5.wav"
} )

sound.Add( 
{
    name = "sws_apc_throttleoff_fastspeed",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_slowdown_fast_loop5.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_lowfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_lowfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_normalfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_normalfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_highfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_highfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_impact_heavy",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_impact_heavy1.wav",
	        "vehicles/v8/vehicle_impact_heavy2.wav",
			"vehicles/v8/vehicle_impact_heavy3.wav",
			"vehicles/v8/vehicle_impact_heavy4.wav"}
} )

sound.Add( 
{
    name = "sws_apc_impact_medium",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_impact_medium1.wav",
	        "vehicles/v8/vehicle_impact_medium2.wav",
			"vehicles/v8/vehicle_impact_medium3.wav",
			"vehicles/v8/vehicle_impact_medium4.wav"}
} )

sound.Add( 
{
    name = "sws_apc_rollover",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_rollover1.wav",
	        "vehicles/v8/vehicle_rollover2.wav"}
} )

sound.Add( 
{
    name = "sws_apc_turbo_on",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/sligwolf/blue-x11/FC_turbo_on_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_turbo_off",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/v8_turbo_off.wav"
} )

sound.Add( 
{
    name = "sws_apc_start_in_water",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/jetski/jetski_no_gas_start.wav"
} )

sound.Add( 
{
    name = "sws_apc_stall_in_water",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/jetski/jetski_off.wav"
} )

-- "addons\\slick\\lua\\sw_addons\\bluex11\\sound.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

sound.Add( 
{
    name = "sws_apc_engine_idle",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_idle_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_null",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "common/null.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_start",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_start_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_stop",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_stop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_rev",
    channel = CHAN_STATIC,
    volume = 0.9,
    soundlevel = 80,
    pitchstart = 98,
	pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_reverse",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_firstgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_secondgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_thirdgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_fourthgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_cruise_loop3.wav"
} )

sound.Add( 
{
    name = "sws_apc_firstgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_secondgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_thirdgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_fourthgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_cruise_loop3.wav"
} )

sound.Add( 
{
    name = "sws_apc_downshift_to_2nd",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_downshift_to_1st",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_throttleoff_slowspeed",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_slowdown_fast_loop5.wav"
} )

sound.Add( 
{
    name = "sws_apc_throttleoff_fastspeed",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_slowdown_fast_loop5.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_lowfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_lowfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_normalfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_normalfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_highfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_highfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_impact_heavy",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_impact_heavy1.wav",
	        "vehicles/v8/vehicle_impact_heavy2.wav",
			"vehicles/v8/vehicle_impact_heavy3.wav",
			"vehicles/v8/vehicle_impact_heavy4.wav"}
} )

sound.Add( 
{
    name = "sws_apc_impact_medium",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_impact_medium1.wav",
	        "vehicles/v8/vehicle_impact_medium2.wav",
			"vehicles/v8/vehicle_impact_medium3.wav",
			"vehicles/v8/vehicle_impact_medium4.wav"}
} )

sound.Add( 
{
    name = "sws_apc_rollover",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_rollover1.wav",
	        "vehicles/v8/vehicle_rollover2.wav"}
} )

sound.Add( 
{
    name = "sws_apc_turbo_on",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/sligwolf/blue-x11/FC_turbo_on_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_turbo_off",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/v8_turbo_off.wav"
} )

sound.Add( 
{
    name = "sws_apc_start_in_water",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/jetski/jetski_no_gas_start.wav"
} )

sound.Add( 
{
    name = "sws_apc_stall_in_water",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/jetski/jetski_off.wav"
} )

-- "addons\\slick\\lua\\sw_addons\\bluex11\\sound.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

sound.Add( 
{
    name = "sws_apc_engine_idle",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_idle_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_null",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "common/null.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_start",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_start_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_engine_stop",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    sound = "vehicles/sligwolf/blue-x11/FC_stop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_rev",
    channel = CHAN_STATIC,
    volume = 0.9,
    soundlevel = 80,
    pitchstart = 98,
	pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_reverse",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_firstgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_secondgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_thirdgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_fourthgear",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_cruise_loop3.wav"
} )

sound.Add( 
{
    name = "sws_apc_firstgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_secondgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_thirdgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_fourthgear_noshift",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 105,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_cruise_loop3.wav"
} )

sound.Add( 
{
    name = "sws_apc_downshift_to_2nd",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_downshift_to_1st",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_firstgear_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_throttleoff_slowspeed",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_slowdown_fast_loop5.wav"
} )

sound.Add( 
{
    name = "sws_apc_throttleoff_fastspeed",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 105,
    sound = "vehicles/sligwolf/blue-x11/FC_slowdown_fast_loop5.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_lowfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_lowfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_normalfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_normalfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_skid_highfriction",
    channel = CHAN_BODY,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/skid_highfriction.wav"
} )

sound.Add( 
{
    name = "sws_apc_impact_heavy",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_impact_heavy1.wav",
	        "vehicles/v8/vehicle_impact_heavy2.wav",
			"vehicles/v8/vehicle_impact_heavy3.wav",
			"vehicles/v8/vehicle_impact_heavy4.wav"}
} )

sound.Add( 
{
    name = "sws_apc_impact_medium",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_impact_medium1.wav",
	        "vehicles/v8/vehicle_impact_medium2.wav",
			"vehicles/v8/vehicle_impact_medium3.wav",
			"vehicles/v8/vehicle_impact_medium4.wav"}
} )

sound.Add( 
{
    name = "sws_apc_rollover",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 95,
    pitchend = 110,
    sound = {"vehicles/v8/vehicle_rollover1.wav",
	        "vehicles/v8/vehicle_rollover2.wav"}
} )

sound.Add( 
{
    name = "sws_apc_turbo_on",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/sligwolf/blue-x11/FC_turbo_on_loop1.wav"
} )

sound.Add( 
{
    name = "sws_apc_turbo_off",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 90,
    pitchend = 110,
    sound = "vehicles/v8/v8_turbo_off.wav"
} )

sound.Add( 
{
    name = "sws_apc_start_in_water",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/jetski/jetski_no_gas_start.wav"
} )

sound.Add( 
{
    name = "sws_apc_stall_in_water",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 80,
    pitchstart = 100,
    sound = "vehicles/jetski/jetski_off.wav"
} )

