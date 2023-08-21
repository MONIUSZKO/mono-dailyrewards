Config         = {}

Config.Command = ''                     -- tutaj ustaw nazwę komendy za pomocą której odiera się nagrodę / here set the name of the command with which the reward is collected

Config.Locale  = ''                     -- tutaj ustaw język skryptu (pl - Polski, eng - Angielski) / set the language of the script here (en - Polish, eng - English)

Config.Rewards = {
    [1]         = {
        item    = 'money',
        count   = 750,
    },
}

--
-- E X A M P L E - ENG
--
--  [next_noumber] = {
--    item = "item_name",
--    count = "item_count",
--  },

--
-- E X A M P L E - PL
--
--  [kolejny_numer] = {
--    item = "nazwa_itemu",
--    count = "ilość",
--  },

