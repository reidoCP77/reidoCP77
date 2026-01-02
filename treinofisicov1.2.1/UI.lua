local ui = require("main")
local port = ui:mainport(3000)
local stats = ui:stats(0)
local data = ui:data()
local server = ui:server(data, port)
while stats == 0 then
   ui:RunServer(server)
end