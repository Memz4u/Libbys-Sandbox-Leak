-- "lua\\autorun\\mkmlua.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
concommand.Add("sysfunc_check", function()
    if ( system.IsLinux() ) then
    	RunConsoleCommand(PlayerSay, "[IsSys] This user is using a linux OS!")
    elseif ( system.IsWindows() ) then
    	RunConsoleCommand("say", "[IsSys] This user is using a windows OS!")
    else
    	RunConsoleCommand("say", "[IsSys] This user is using some gay OS that is not windows or linux!!!")
    end
    timer.Simple( 2, function()
    if ( system.BatteryPower() )  == 255 then
        RunConsoleCommand("say", "[SysCheck] This user is using a Device with no battery, or their laptop is at 100%")
        print("YUR battery power is at..", system.BatteryPower() )
    else
        timer.Simple( 2, function() RunConsoleCommand("say", "[SysCheck] This user is using a device with a battery!" ) end)
        RunConsoleCommand("say", ( system.BatteryPower() ))
    end
    end)


    print("CheckPoint!")


    timer.Simple( 6, function() RunConsoleCommand("say", "[SysLocate] This User's Country is..", ( system.GetCountry() )) end)


    timer.Simple( 8, function() RunConsoleCommand("say", "[SysCheck] It has been", ( system.UpTime() ), " Seconds since this user moved their mouse") end)

    timer.Simple( 10, function() 
        if ( system.IsWindowed() ) then 
            RunConsoleCommand("say", "[SysCheck] My gmod.exe is windowed" ) 
        else 
            RunConsoleCommand("say", "[SysCheck] I am running my gmod.exe in fullscreen!") 
        end
        
    end)

    timer.Simple( 12, function() RunConsoleCommand("say", "[SysGameUpTime] This user's game has been up for", ( system.AppTime() ), "Seconds!") end)

end)

-- "lua\\autorun\\mkmlua.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
concommand.Add("sysfunc_check", function()
    if ( system.IsLinux() ) then
    	RunConsoleCommand(PlayerSay, "[IsSys] This user is using a linux OS!")
    elseif ( system.IsWindows() ) then
    	RunConsoleCommand("say", "[IsSys] This user is using a windows OS!")
    else
    	RunConsoleCommand("say", "[IsSys] This user is using some gay OS that is not windows or linux!!!")
    end
    timer.Simple( 2, function()
    if ( system.BatteryPower() )  == 255 then
        RunConsoleCommand("say", "[SysCheck] This user is using a Device with no battery, or their laptop is at 100%")
        print("YUR battery power is at..", system.BatteryPower() )
    else
        timer.Simple( 2, function() RunConsoleCommand("say", "[SysCheck] This user is using a device with a battery!" ) end)
        RunConsoleCommand("say", ( system.BatteryPower() ))
    end
    end)


    print("CheckPoint!")


    timer.Simple( 6, function() RunConsoleCommand("say", "[SysLocate] This User's Country is..", ( system.GetCountry() )) end)


    timer.Simple( 8, function() RunConsoleCommand("say", "[SysCheck] It has been", ( system.UpTime() ), " Seconds since this user moved their mouse") end)

    timer.Simple( 10, function() 
        if ( system.IsWindowed() ) then 
            RunConsoleCommand("say", "[SysCheck] My gmod.exe is windowed" ) 
        else 
            RunConsoleCommand("say", "[SysCheck] I am running my gmod.exe in fullscreen!") 
        end
        
    end)

    timer.Simple( 12, function() RunConsoleCommand("say", "[SysGameUpTime] This user's game has been up for", ( system.AppTime() ), "Seconds!") end)

end)

-- "lua\\autorun\\mkmlua.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
concommand.Add("sysfunc_check", function()
    if ( system.IsLinux() ) then
    	RunConsoleCommand(PlayerSay, "[IsSys] This user is using a linux OS!")
    elseif ( system.IsWindows() ) then
    	RunConsoleCommand("say", "[IsSys] This user is using a windows OS!")
    else
    	RunConsoleCommand("say", "[IsSys] This user is using some gay OS that is not windows or linux!!!")
    end
    timer.Simple( 2, function()
    if ( system.BatteryPower() )  == 255 then
        RunConsoleCommand("say", "[SysCheck] This user is using a Device with no battery, or their laptop is at 100%")
        print("YUR battery power is at..", system.BatteryPower() )
    else
        timer.Simple( 2, function() RunConsoleCommand("say", "[SysCheck] This user is using a device with a battery!" ) end)
        RunConsoleCommand("say", ( system.BatteryPower() ))
    end
    end)


    print("CheckPoint!")


    timer.Simple( 6, function() RunConsoleCommand("say", "[SysLocate] This User's Country is..", ( system.GetCountry() )) end)


    timer.Simple( 8, function() RunConsoleCommand("say", "[SysCheck] It has been", ( system.UpTime() ), " Seconds since this user moved their mouse") end)

    timer.Simple( 10, function() 
        if ( system.IsWindowed() ) then 
            RunConsoleCommand("say", "[SysCheck] My gmod.exe is windowed" ) 
        else 
            RunConsoleCommand("say", "[SysCheck] I am running my gmod.exe in fullscreen!") 
        end
        
    end)

    timer.Simple( 12, function() RunConsoleCommand("say", "[SysGameUpTime] This user's game has been up for", ( system.AppTime() ), "Seconds!") end)

end)

-- "lua\\autorun\\mkmlua.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
concommand.Add("sysfunc_check", function()
    if ( system.IsLinux() ) then
    	RunConsoleCommand(PlayerSay, "[IsSys] This user is using a linux OS!")
    elseif ( system.IsWindows() ) then
    	RunConsoleCommand("say", "[IsSys] This user is using a windows OS!")
    else
    	RunConsoleCommand("say", "[IsSys] This user is using some gay OS that is not windows or linux!!!")
    end
    timer.Simple( 2, function()
    if ( system.BatteryPower() )  == 255 then
        RunConsoleCommand("say", "[SysCheck] This user is using a Device with no battery, or their laptop is at 100%")
        print("YUR battery power is at..", system.BatteryPower() )
    else
        timer.Simple( 2, function() RunConsoleCommand("say", "[SysCheck] This user is using a device with a battery!" ) end)
        RunConsoleCommand("say", ( system.BatteryPower() ))
    end
    end)


    print("CheckPoint!")


    timer.Simple( 6, function() RunConsoleCommand("say", "[SysLocate] This User's Country is..", ( system.GetCountry() )) end)


    timer.Simple( 8, function() RunConsoleCommand("say", "[SysCheck] It has been", ( system.UpTime() ), " Seconds since this user moved their mouse") end)

    timer.Simple( 10, function() 
        if ( system.IsWindowed() ) then 
            RunConsoleCommand("say", "[SysCheck] My gmod.exe is windowed" ) 
        else 
            RunConsoleCommand("say", "[SysCheck] I am running my gmod.exe in fullscreen!") 
        end
        
    end)

    timer.Simple( 12, function() RunConsoleCommand("say", "[SysGameUpTime] This user's game has been up for", ( system.AppTime() ), "Seconds!") end)

end)

-- "lua\\autorun\\mkmlua.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
concommand.Add("sysfunc_check", function()
    if ( system.IsLinux() ) then
    	RunConsoleCommand(PlayerSay, "[IsSys] This user is using a linux OS!")
    elseif ( system.IsWindows() ) then
    	RunConsoleCommand("say", "[IsSys] This user is using a windows OS!")
    else
    	RunConsoleCommand("say", "[IsSys] This user is using some gay OS that is not windows or linux!!!")
    end
    timer.Simple( 2, function()
    if ( system.BatteryPower() )  == 255 then
        RunConsoleCommand("say", "[SysCheck] This user is using a Device with no battery, or their laptop is at 100%")
        print("YUR battery power is at..", system.BatteryPower() )
    else
        timer.Simple( 2, function() RunConsoleCommand("say", "[SysCheck] This user is using a device with a battery!" ) end)
        RunConsoleCommand("say", ( system.BatteryPower() ))
    end
    end)


    print("CheckPoint!")


    timer.Simple( 6, function() RunConsoleCommand("say", "[SysLocate] This User's Country is..", ( system.GetCountry() )) end)


    timer.Simple( 8, function() RunConsoleCommand("say", "[SysCheck] It has been", ( system.UpTime() ), " Seconds since this user moved their mouse") end)

    timer.Simple( 10, function() 
        if ( system.IsWindowed() ) then 
            RunConsoleCommand("say", "[SysCheck] My gmod.exe is windowed" ) 
        else 
            RunConsoleCommand("say", "[SysCheck] I am running my gmod.exe in fullscreen!") 
        end
        
    end)

    timer.Simple( 12, function() RunConsoleCommand("say", "[SysGameUpTime] This user's game has been up for", ( system.AppTime() ), "Seconds!") end)

end)

