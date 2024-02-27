Config = {
    proggressbarTime = 2500,

    farmcoords = {
        {
            Coords = {1686.8137207031,2185.8103027344,82.254470825195}, -- 1686.8137207031, 2185.8103027344, 82.254470825195
            Item = "kokainblade",
            itemname = "Kokainblade"
        }, 
        {
            Coords = {1956.1011962891,4861.7158203125,45.467292785645}, -- 1956.1011962891,4861.7158203125,45.467292785645
            Item = "hampblade",
            itemname = "Hampblade"
        },  
    },

    omdancoords = {
        {
            Coords = {1336.0220947266,4306.5756835938,38.110527038574},
            Item = "kokain",
            sekitem = "kokainblade",
            itemname = "Kokain"
        },
        {
            Coords = {1606.5166015625,6625.513671875,15.677891731262},
            Item = "kokain",
            sekitem = "kokainblade",
            itemname = "Kokain"
        },
    },


    -- Items du kan bruge med scriptet hvis du laver en ny farm med et item så ikke er i dette table så ville scriptet ikke give personen itemen.
    ValidItems = {
        ["kokainblade"] = true,
        ["hampblade"] = true,
        ["kokain"] = true,
        ["skunk"] = true
    }
}