local dns = require("suricata.dns")

function init (args)
   return {}
end

function count(t)
   local count = 0
   for _ in pairs(t) do
      count = count + 1
   end
   return count
end

function match(args)
   local tx = dns.get_tx()

   if tx:txid() ~= 36146 then
      return 0
   end

   -- The requested name.
   local rrname = tx:rrname()
   if rrname ~= "www.suricata-ids.org" then
      return 0
   end

   -- Queries
   local queries = tx:queries()
   if queries == nil then return 0 end

   -- There should only be one query.
   if count(queries) ~= 1 then return 0 end

   local query = queries[0]

   if query["type"] ~= "A" then
      return 0
   end
   
   if query["rrname"] ~= "www.suricata-ids.org" then
      return 0
   end

   local rcode = tx:rcode()
   if rcode ~= 0 then
      return 0
   end

   local rcode_string = tx:rcode_string()
   if rcode_string ~= "NOERROR" then
      return 0
   end

   local answers = tx:answers()
   if answers == nil then return 0 end
   if count(answers) ~= 3 then return 0 end

   local authorities = tx:authorities()
   if authorities == nil then return 0 end
   if count(authorities) ~= 0 then return 0 end

   -- TODO: Look at the answers.

   return 1
end
