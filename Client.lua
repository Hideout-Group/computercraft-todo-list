local SERVER_ID = 1;

rednet.open("back");

function ReceiveInput(message)
    print("What action do you want to do?")
    local Input = string.lower(read());
    if Input == "add" then
        print("What do you want to add?")
        local toAdd = read();
        rednet.send(SERVER_ID, {true, toAdd});
    elseif Input == "remove" then
        print("What line do you want to remove?")
        local index = tonumber(read());
        rednet.send(SERVER_ID, {false, index});
    else 
        Draw(message)
    end
end

function MainThread()
    local id, message = rednet.receive();

    if id ~= SERVER_ID or type(message) ~= "table" then return end

    Draw(message)

    MainThread()
end

function Draw(message)
    PrintList(message)
    ReceiveInput(message)
end

function PrintList(List)
    term.clear()
    for i, v in pairs(List) do
        print(i..". "..v)
    end
end

function RequestList()
    rednet.send(SERVER_ID, "list")
    MainThread()
end

RequestList()