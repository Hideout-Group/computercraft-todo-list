local list = {}
local moden_side = "bottom"

rednet.open(moden_side)



function Main()
    local id,message = rednet.receive()
    if type(message) == "string" then message = string.lower(message) end
    if message == "list" then --When client first connects to server send lsit (Come up with better message later retard)
        rednet.send(id,list)
    elseif message[1] == true then
        AddItem(message[2])
    elseif  message[1] == false  then
        RemoveItem(message[2])
    end
    Main()
end

function AddItem(ItemContents)
    table.insert(list,ItemContents)
    rednet.broadcast(list)
end


function RemoveItem(ItemID)
    table.remove(list,ItemID)
    rednet.broadcast(list)
end

Main()
