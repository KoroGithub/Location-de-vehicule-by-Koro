RegisterCommand("co", function(source, args, rawcommand)
    local pos = GetEntityCoords(PlayerPedId())
    print (pos.x..", "..pos.y..", "..pos.z)
end, false)

RMenu.Add("koroteste", "koro_main", RageUI.CreateMenu("Location By koro","location"))
RMenu:Get("koroteste", "koro_main").Closed = function()
    print("Vous avez fermer le menu")
end

Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(232.8660, -859.7254, 29.9217)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 30 then
            interval = 200
        else
            interval = 1
            DrawMarker(2, 232.8660, -859.7254, 29.9217, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5,255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
            if distance < 1 then
                 AddTextEntry("HELP", "Appuyer sur ~o~E ~s~pour acceder au menu")
                 DisplayHelpTextThisFrame("HELP", false)
                 if IsControlJustPressed(1, 51) then     
                    RageUI.Visible(RMenu:Get("koroteste","koro_main"), true)
                 end
            end
        end  

        Citizen.Wait(interval)
    end
end)

local array = {
    "Panto",
    "faggio",
    "Blista",
    "blista2"
}

local arrayIndex = 1

Citizen.CreateThread(function()
    cooldown = false
    while true do
        

        RageUI.IsVisible(RMenu:Get("koroteste","koro_main"),true,true,true,function()

            RageUI.List("Vehicules", array, arrayIndex, "Voici les vehicules !", {}, true, function(h, a, s, i) arrayIndex = i end)

            RageUI.ButtonWithStyle("faire Apparaitre ~r~"..array[arrayIndex], "Location", {RightBadge = RageUI.BadgeStyle.Car}, true,function(h,a,s)
                if s then
                    RageUI.CloseAll()
                    local model = GetHashKey(array[arrayIndex])
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    local vehicle = CreateVehicle(model, 247.5844,-859.0595,29.4794 , true, false)
                   TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                end
            end)
        end,function()end, 1)

        Citizen.Wait(0)
        end
    end)