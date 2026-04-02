-- Adopt Me Pet CDN Lookup + Discord Webhook Inventory Sender
-- Run this in your executor

-- =====================
--    YOUR WEBHOOK URL
-- =====================
local WEBHOOK_URL = "https://discord.com/api/webhooks/1454419132371042358/U45TbmAIksgoEDwC8fXrhlMe0w6lEVQ2KRjOCL2OeI_eiy4ZZA6Lfi7J280unr5vgXo1"

-- =====================
--    CDN BASE URL
-- =====================
local CDN = "https://cdn.playadopt.me/items/"

-- =====================
--  FULL PET CDN TABLE
-- =====================
local PetCDN = {
    -- A
    ["2021 Uplift Butterfly"]          = "2021_uplift_butterfly",
    ["2022 Uplift Butterfly"]          = "birthday_2022_uplift_butterfly",
    ["2025 Birthday Butterfly"]        = "birthday_2025_butterfly",
    ["2D Kitty"]                       = "2d_tuesdays_2025_2d_kitty",
    ["Abyssinian Cat"]                 = "desert_2022_abyssinian_cat",
    ["Admin Abuse Egg"]                = "admin_abuse_egg_2026_egg",
    ["African Wild Dog"]               = "ugc_refresh_2023_african_wild_dog",
    ["Albatross"]                      = "snow_2022_albatross",
    ["Albino Bat"]                     = "albino_bat",
    ["Albino Gorilla"]                 = "gorilla_fair_2023_albino_gorilla",
    ["Albino Monkey"]                  = "albino_monkey",
    ["Alicorn"]                        = "basic_egg_2022_alicorn",
    ["Alley Cat"]                      = "urban_2023_alley_cat",
    ["Alpaca"]                         = "farm_2023_alpaca",
    ["Amami Rabbit"]                   = "lny_2023_amami_rabbit",
    ["Amber Butterfly"]                = "butterfly_2025_amber_butterfly",
    ["Ancient Dragon"]                 = "basic_egg_2022_ancient_dragon",
    ["Angelfish"]                      = "jungle_2023_angelfish",
    ["Angler Fish"]                    = "danger_2023_angler_fish",
    ["Angus Bull"]                     = "winter_2025_angus_bull",
    ["Angus Calf"]                     = "winter_2025_angus_calf",
    ["Angus Cow"]                      = "winter_2025_angus_cow",
    ["Ankylosaurus"]                   = "fossil_2024_ankylosaurus",
    ["Ant"]                            = "basic_egg_2022_ant",
    ["Apple Owl"]                      = "food_pets_2026_apple_owl",
    ["Arctic Dusk Dragon"]             = "winter_2025_arctic_dusk_dragon",
    ["Arctic Fox"]                     = "arctic_fox",
    ["Arctic Hare"]                    = "winter_2023_arctic_hare",
    ["Arctic Reindeer"]                = "arctic_reindeer",
    ["Arctic Tern"]                    = "summerfest_2023_arctic_tern",
    ["Armadillo"]                      = "desert_2024_armadillo",
    ["Ash Zebra"]                      = "lures_2023_ash_zebra",
    ["Astronaut Gorilla"]              = "gorilla_fair_2023_astronaut_gorilla",
    ["Aurora Fox"]                     = "winter_2024_aurora_fox",
    ["Aussie Egg"]                     = "aussie_egg",
    ["Australian Kelpie"]              = "kelpie",
    ["Axolotl"]                        = "axolotl",
    ["Aye Aye"]                        = "halloween_2025_aye_aye",
    ["Aztec Egg"]                      = "aztec_egg_2025_aztec_egg",
    -- B
    ["Badger"]                         = "fall_2022_badger",
    ["Bakeneko"]                       = "spring_2025_bakeneko",
    ["Baku"]                           = "japan_2022_baku",
    ["Bald Eagle"]                     = "summerfest_2024_bald_eagle",
    ["Bali Starling"]                  = "seasia_2023_bali_starling",
    ["Balloon Unicorn"]                = "summerfest_2024_balloon_unicorn",
    ["Banded Palm Civet"]              = "seasia_2023_banded_palm_civet",
    ["Bandicoot"]                      = "bandicoot",
    ["Basic Egg"]                      = "pet_recycler_2025_basic_egg",
    ["Basilisk"]                       = "halloween_2022_basilisk",
    ["Bat"]                            = "bat",
    ["Bat Dragon"]                     = "bat_dragon",
    ["Bauble Buddies"]                 = "winter_2024_bauble_buddies",
    ["Beaver"]                         = "beaver",
    ["Bee"]                            = "bee",
    ["Beluga Whale"]                   = "winter_2023_beluga_whale",
    ["Berry Cool Cube"]                = "winter_2024_berry_cool_cube",
    ["Billy Goat"]                     = "urban_2023_billy_goat",
    ["Binturong"]                      = "seasia_2023_binturong",
    ["Bird of Paradise"]               = "jungle_2023_bird_of_paradise",
    ["Birthday Butterfly 2023"]        = "birthday_2023_birthday_butterfly",
    ["Birthday Butterfly 2024"]        = "birthday_2024_butterfly",
    ["Black Chow-Chow"]                = "vip_2022_chow_chow_black",
    ["Black Kite"]                     = "urban_2023_black_kite",
    ["Black Macaque"]                  = "seasia_2023_black_macaque",
    ["Black Marlin"]                   = "sunshine_2024_black_marlin",
    ["Black Moon Bear"]                = "lny_2023_moon_bear",
    ["Black Panther"]                  = "black_panther",
    ["Black Rhino"]                    = "endangered_2026_black_rhino",
    ["Black Springer Spaniel"]         = "easter_2022_springer_spaniel_black",
    ["Black Tiger"]                    = "endangered_2026_black_tiger",
    ["Black Widow"]                    = "halloween_2025_spider_4",
    ["Black-Chested Pheasant"]         = "fall_2022_pheasant_black",
    ["Black-Footed Ferret"]            = "endangered_2026_black_footed_ferret",
    ["Blazing Lion"]                   = "lures_2023_blazing_lion",
    ["Bloodhound"]                     = "jan_refresh_2023_bloodhound",
    ["Blossom Snake"]                  = "lunar_2025_blossom_snake",
    ["Blue Betta Fish"]                = "summerfest_2024_blue_betta_fish",
    ["Blue Butterfly"]                 = "butterfly_2025_blue_butterfly",
    ["Blue Dog"]                       = "blue_dog",
    ["Blue Egg"]                       = "pet_egg",
    ["Blue Jay"]                       = "garden_2024_blue_jay",
    ["Blue Ringed Octopus"]            = "danger_2023_blue_ringed_octopus",
    ["Blue Whale"]                     = "endangered_2026_blue_whale",
    ["Bluebottle Fly"]                 = "urban_2023_fly",
    ["Border Collie"]                  = "springfest_2023_border_collie",
    ["Borhyaena Gigantica"]            = "danger_2023_borhyaena_gigantica",
    ["Brachiosaurus"]                  = "fossil_2024_brachiosaurus",
    ["Brown Bear"]                     = "brown_bear",
    ["Brown Springer Spaniel"]         = "easter_2022_springer_spaniel_brown",
    ["Brown-Chested Pheasant"]         = "fall_2022_pheasant_brown",
    ["Buffalo"]                        = "buffalo",
    ["Bullfrog"]                       = "woodland_2022_bullfrog",
    ["Bunny"]                          = "bunny",
    ["Bunny Swirl"]                    = "winter_2025_bunny_swirl",
    ["Burning Bunny"]                  = "fire_dimension_2024_burning_bunny",
    ["Bush Elephant"]                  = "sunshine_2024_bush_elephant",
    ["Business Monkey"]                = "business_monkey",
    -- C
    ["Cabbit"]                         = "spring_2025_cabbit",
    ["Cactus Friend"]                  = "desert_2024_cactus_friend",
    ["Caelum Cervi"]                   = "pride_2023_caelum_cervi",
    ["California Condor"]              = "endangered_2026_california_condor",
    ["Camel"]                          = "basic_egg_2022_camel",
    ["Canadian Goose"]                 = "farm_2023_canada_goose",
    ["Candicorn"]                      = "sugarfest_2026_candicorn",
    ["Candy Cane Snail"]               = "easter_2024_candy_cane_snail",
    ["Candy Hare"]                     = "winter_2023_candy_hare",
    ["Candyfloss Chick"]               = "easter_2024_candyfloss_chick",
    ["Capricorn"]                      = "space_house_2022_capricorn",
    ["Capuchin Monkey"]                = "capuchin_2024_capuchin_monkey",
    ["Capybara"]                       = "capybara",
    ["Cassowary"]                      = "jungle_2023_cassowary",
    ["Castle Hermit Crab"]             = "summerfest_2023_castle_hermit_crab",
    ["Cat"]                            = "cat",
    ["Caterpillar"]                    = "farm_2023_caterpillar",
    ["Cerberus"]                       = "cerberus",
    ["Chameleon"]                      = "rgb_chameleon",
    ["Chanekeh"]                       = "aztec_egg_2025_xiucohtl",
    ["Cheetah"]                        = "sunshine_2024_cheetah",
    ["Chef Gorilla"]                   = "gorilla_fair_2023_chef_gorilla",
    ["Cherub Chipmunk"]                = "valentines_2026_cherub_chipmunk",
    ["Chick"]                          = "chick",
    ["Chickatrice"]                    = "halloween_2022_chickatrice",
    ["Chicken"]                        = "chicken",
    ["Chilling Spider"]                = "halloween_2025_spider_5",
    ["Chimera"]                        = "halloween_2022_chimera",
    ["Chipmunk"]                       = "chiprac_2023_chipmunk",
    ["Choco Penguin"]                  = "penguins_2025_choco_penguin",
    ["Chocolate Chip Bat Dragon"]      = "winter_2023_chocolate_chip_bat_dragon",
    ["Chocolate Chow-Chow"]            = "vip_2022_chow_chow_dark_brown",
    ["Chocolate Labrador"]             = "chocolate_labrador",
    ["Christmas Egg"]                  = "christmas_egg",
    ["Christmas Future Egg"]           = "winter_2023_story_game_egg",
    ["Christmas Pudding Pup"]          = "winter_2023_christmas_pudding_pup",
    ["Christmas Spirit"]               = "winter_2025_christmas_spirit",
    ["Classic Teapot"]                 = "roblox_classic_2024_teapot",
    ["Clementine Owl"]                 = "food_pets_2026_clementine_owl",
    ["Clover Cow"]                     = "st_patricks_2025_clover_cow",
    ["Clownfish"]                      = "clownfish",
    ["Cobra"]                          = "cobra",
    ["Cockroach"]                      = "urban_2023_cockroach",
    ["Cocoadile"]                      = "sugarfest_2026_cocoadile",
    ["Coconut Friend"]                 = "summerfest_2025_coconut_friend",
    ["Cold Cube"]                      = "winter_2024_cold_cube",
    ["Corgi"]                          = "basic_egg_2022_corgi",
    ["Corn Doggo"]                     = "summerfest_2024_corn_doggo",
    ["Cow"]                            = "cow",
    ["Cow Calf"]                       = "summerfest_2024_cow_calf",
    ["Coyote"]                         = "desert_2024_coyote",
    ["Cozy Mistletroll"]               = "winter_2025_cozy_mistletroll",
    ["Crab"]                           = "crab",
    ["Cracked Egg"]                    = "cracked_egg",
    ["Criosphinx"]                     = "desert_2024_criosphinx",
    ["Crocodile"]                      = "crocodile",
    ["Crow"]                           = "crow",
    ["Cryptid"]                        = "halloween_2025_cryptid",
    ["Crystal Egg"]                    = "pet_recycler_2025_crystal_egg",
    ["Cuddly Candle"]                  = "sky_ux_2023_cuddly_candle",
    ["Cupid Dragon"]                   = "valentines_2025_cupid_dragon",
    ["Cute-A-Cabra"]                   = "halloween_2023_cuteacabra",
    -- D
    ["Dalmatian"]                      = "santa_dog",
    ["Dancing Dragon"]                 = "lny_2022_dragon",
    ["Danger Egg"]                     = "danger_2023_egg",
    ["Dango Penguins"]                 = "penguins_2025_dango_penguins",
    ["Deathstalker Scorpion"]          = "desert_2024_deathstalker_scorpion",
    ["Deinonychus"]                    = "deinonychus",
    ["Desert Egg"]                     = "desert_2024_egg",
    ["Diamond Albatross"]              = "snow_2022_diamond_albatross",
    ["Diamond Amazon"]                 = "rain_2023_diamond_amazon",
    ["Diamond Butterfly"]              = "sanctuary_2022_diamond_premium_butterfly",
    ["Diamond Dragon"]                 = "diamond_dragon",
    ["Diamond Egg"]                    = "diamond_egg",
    ["Diamond Griffin"]                = "diamond_griffin",
    ["Diamond Hamster"]                = "hamstertime_2024_diamond_hamster",
    ["Diamond Hummingbird"]            = "subscription_2024_diamond_hummingbird",
    ["Diamond King Penguin"]           = "ice_cream_refresh_2022_diamond_king_penguin",
    ["Diamond Ladybug"]                = "diamond_ladybug",
    ["Diamond Mahi Mahi"]              = "beach_2024_diamond_mahi_mahi",
    ["Diamond Unicorn"]                = "diamond_unicorn",
    ["Dilophosaurus"]                  = "dilophosaurus",
    ["Dimension Drifter"]              = "moon_2025_dimension_drifter",
    ["Dimorphodon"]                    = "fossil_2024_dimorphodon",
    ["Dingo"]                          = "dingo",
    ["Dire Stag"]                      = "halloween_2023_dire_stag",
    ["Dire Wolf"]                      = "egg_teaser_2026_dire_wolf",
    ["DJ Snooze"]                      = "halloween_2025_dj_snooze",
    ["Dodo"]                           = "dodo",
    ["Dog"]                            = "dog",
    ["Dolphin"]                        = "dolphin",
    ["Donkey"]                         = "basic_egg_2022_donkey",
    ["Dotted Eggy"]                    = "easter_2024_dotted_eggy",
    ["Dracula Fish"]                   = "ocean_2024_dracula_fish",
    ["Dracula Parrot"]                 = "halloween_2024_dracula_parrot",
    ["Dragon"]                         = "dragon",
    ["Dragonfly"]                      = "basic_egg_2022_dragonfly",
    ["Dragonfruit Fox"]                = "food_pets_2026_dragonfruit_fox",
    ["Drake"]                          = "drake",
    ["Dugong"]                         = "japan_2022_dugong",
    ["Dylan"]                          = "dolls_2023_dylan",
    -- E
    ["Easter 2020 Egg"]                = "easter_2020_egg",
    ["Eel"]                            = "random_pets_sept_2023_eel",
    ["Eggnog Dog"]                     = "winter_2023_eggnog_dog",
    ["Eggnog Hare"]                    = "winter_2023_eggnog_hare",
    ["Ehecatl"]                        = "aztec_egg_2025_ehecatl",
    ["Elasmosaurus"]                   = "fossil_2024_elasmosaurus",
    ["Elephant"]                       = "elephant",
    ["Emberlight"]                     = "pet_recycler_2025_emberlight",
    ["Emperor Gorilla"]                = "gorilla_fair_2023_emperor_gorilla",
    ["Emperor Shrimp"]                 = "summer_2025_emperor_shrimp",
    ["Emu"]                            = "emu",
    ["Endangered Egg"]                 = "endangered_2026_endangered_egg",
    ["English Sheepdog"]               = "farm_2023_sheepdog",
    ["Ermine"]                         = "winter_2022_ermine",
    ["Evil Basilisk"]                  = "halloween_2022_evil_basilisk",
    ["Evil Chick"]                     = "halloween_2024_evil_chick",
    ["Evil Chickatrice"]               = "halloween_2022_evil_chickatrice",
    ["Evil Rock"]                      = "halloween_2023_evil_rock",
    ["Evil Unicorn"]                   = "evil_unicorn",
    -- F
    ["Fairy Bat Dragon"]               = "winter_2024_fairy_bat_dragon",
    ["Fallow Deer"]                    = "woodland_2022_fallow_deer",
    ["Fanghorn Tortoise"]              = "lunar_2024_fanghorn_tortoise",
    ["Farm Egg"]                       = "farm_egg",
    ["Feesh"]                          = "meme_2023_feesh",
    ["Fennec Fox"]                     = "fennec",
    ["Field Mouse"]                    = "springfest_2023_field_mouse",
    ["Fire Foal"]                      = "lny_2026_fire_foal",
    ["Fire Mare"]                      = "lny_2026_fire_mare",
    ["Fire Stallion"]                  = "lny_2026_fire_stallion",
    ["Firefighter Gibbon"]             = "gibbon_2025_firefighter_gibbon",
    ["Firefly"]                        = "camping_2023_firefly",
    ["Flaming Fox"]                    = "fire_dimension_2024_flaming_fox",
    ["Flaming Zebra"]                  = "lures_2023_flaming_zebra",
    ["Flamingo"]                       = "flamingo",
    ["Fleur De Ice"]                   = "winter_2023_fleur_de_ice",
    ["Floral Eggy"]                    = "easter_2024_floral_eggy",
    ["Flower Power Duckling"]          = "springfest_2023_flower_power_duckling",
    ["Flying Fish"]                    = "summerfest_2023_flying_fish",
    ["Fool Egg"]                       = "april_fools_2023_fool_egg",
    ["Fossa"]                          = "jungle_2023_fossa",
    ["Fossil Egg"]                     = "fossil_egg",
    ["Frankenfeline"]                  = "halloween_2024_franken_feline",
    ["French Bulldog"]                 = "house_pets_2025_french_bulldog",
    ["Frog"]                           = "frog",
    ["Frogspawn"]                      = "meme_2023_frogspawn",
    ["Frost Dragon"]                   = "frost_dragon",
    ["Frost Fury"]                     = "frost_fury",
    ["Frost Phoenix"]                  = "winter_2025_frost_phoenix",
    ["Frost Unicorn"]                  = "modular_castles_2023_frost_unicorn",
    ["Frostbite Bear"]                 = "ice_dimension_2025_frostbite_bear",
    ["Frostbite Cub"]                  = "winter_2024_frostbite_cub",
    ["Frostclaw"]                      = "winter_2024_frostclaw",
    ["Frozen Penguin"]                 = "ice_dimension_2025_chilly_penguin",
    -- G
    ["Gaelic Fae"]                     = "st_patricks_2025_gaelic_fae",
    ["Galapagos Sea Lion"]             = "endangered_2026_galapagos_sea_lion",
    ["Garden Egg"]                     = "garden_2024_egg",
    ["Garden Snake"]                   = "garden_2024_garden_snake",
    ["Gargoyle"]                       = "urban_2023_gargoyle",
    ["Gecko"]                          = "seasia_2023_gecko",
    ["German Shepherd"]                = "inspector_shepherd_2026_german_shepherd",
    ["Ghost"]                          = "halloween_2023_ghost",
    ["Ghost Bunny"]                    = "ghost_bunny",
    ["Ghost Chick"]                    = "halloween_2024_ghost_chick",
    ["Ghost Dog"]                      = "halloween_2023_ghost_dog",
    ["Ghost Wolf"]                     = "halloween_2022_ghost_wolf",
    ["Ghostly Cat"]                    = "halloween_2025_ghostly_cat",
    ["Giant Anteater"]                 = "jungle_2023_anteater",
    ["Giant Black Scarab"]             = "desert_2022_black_scarab",
    ["Giant Blue Scarab"]              = "desert_2022_blue_scarab",
    ["Giant Gold Scarab"]              = "desert_2022_gold_scarab",
    ["Giant Panda"]                    = "pet_recycler_2025_giant_panda",
    ["Gibbon"]                         = "gibbon_2025_gibbon",
    ["Gila Monster"]                   = "desert_2024_gila_monster",
    ["Gilded Snake"]                   = "lunar_2025_gilded_snake",
    ["Ginger Cat"]                     = "ginger_cat",
    ["Gingerbread Hare"]               = "winter_2023_gingerbread_hare",
    ["Gingerbread Mouse"]              = "winter_2023_gingerbread_mouse",
    ["Gingerbread Reindeer"]           = "winter_2022_gingerbread_reindeer",
    ["Giraffe"]                        = "giraffe",
    ["Glacier Kitsune"]                = "winter_2023_glacier_kitsune",
    ["Glacier Moth"]                   = "ugc_rewards_2023_glacier_moth",
    ["Glormy Dolphin"]                 = "moon_2025_glormy_dolphin",
    ["Glormy Hound"]                   = "celestial_2024_glormy_hound",
    ["Glormy Leo"]                     = "celestial_2024_glormy_leo",
    ["Glyptodon"]                      = "glyptodon",
    ["Goat"]                           = "pride_2022_goat",
    ["Gold Mahi Mahi"]                 = "beach_2024_gold_mahi_mahi",
    ["Golden Albatross"]               = "snow_2022_golden_albatross",
    ["Golden Chow-Chow"]               = "vip_2022_chow_chow_gold",
    ["Golden Dragon"]                  = "golden_dragon",
    ["Golden Egg"]                     = "golden_egg",
    ["Golden Griffin"]                 = "golden_griffin",
    ["Golden Hamster"]                 = "hamstertime_2024_golden_hamster",
    ["Golden Hummingbird"]             = "subscription_2024_gold_hummingbird",
    ["Golden Jaguar"]                  = "ddlm_2024_golden_jaguar",
    ["Golden King Penguin"]            = "ice_cream_refresh_2022_golden_king_penguin",
    ["Golden Ladybug"]                 = "golden_ladybug",
    ["Golden Penguin"]                 = "golden_penguin",
    ["Golden Rat"]                     = "golden_rat",
    ["Golden Tortoise Beetle"]         = "garden_2024_golden_tortoise_beetle",
    ["Golden Unicorn"]                 = "golden_unicorn",
    ["Golden Walrus"]                  = "winter_2021_golden_walrus",
    ["Goldfish"]                       = "pool_2023_goldfish",
    ["Goldhorn"]                       = "goldhorn",
    ["Goose"]                          = "springfest_2023_goose",
    ["Gorilla"]                        = "gorilla_fair_2023_gorilla",
    ["Grave Owl"]                      = "ddlm_2024_grave_owl",
    ["Great Pyrenees"]                 = "winter_2024_great_pyrenees",
    ["Green Amazon"]                   = "rain_2023_green_amazon",
    ["Green Butterfly"]                = "sanctuary_2022_green_premium_butterfly",
    ["Green-Chested Pheasant"]         = "fall_2022_pheasant_green",
    ["Griffin"]                        = "griffin",
    ["Grim Dragon"]                    = "halloween_2024_grim_dragon",
    ["Grinmoire"]                      = "sky_ux_2023_grinmoire",
    ["Ground Sloth"]                   = "ground_sloth",
    ["Groundhog"]                      = "sofahog_2024_groundhog",
    ["Guardian Lion"]                  = "guardian_lion",
    ["Gumball Caterpillar"]            = "sugarfest_2026_gumball_caterpillar",
    ["Gummy Guana"]                    = "sugarfest_2026_gummy_guana",
    -- H
    ["Haetae"]                         = "lunar_2025_haetae",
    ["Halloween Black Mummy Cat"]      = "halloween_2021_black_mummy_cat",
    ["Halloween Blue Scorpion"]        = "halloween_2021_scorpion",
    ["Halloween Evil Dachshund"]       = "halloween_2021_evil_dachshund",
    ["Halloween Golden Mummy Cat"]     = "halloween_2021_golden_mummy_cat",
    ["Halloween White Ghost Dragon"]   = "halloween_2021_ghost_dragon",
    ["Halloween White Mummy Cat"]      = "halloween_2021_white_mummy_cat",
    ["Halloween White Skeleton Dog"]   = "halloween_2021_skele_dog",
    ["Hammerhead Shark"]               = "summerfest_2025_hammerhead_shark",
    ["Hamster"]                        = "hamstertime_2024_hamster",
    ["Happy Clam"]                     = "summerfest_2023_happy_clam",
    ["Happy Duckling"]                 = "springfest_2023_happy_duckling",
    ["Hare"]                           = "springfest_2023_hare",
    ["Harp Seal"]                      = "winter_2023_harp_seal",
    ["Hawk"]                           = "woodland_2022_hawk",
    ["Headless Horse"]                 = "halloween_2024_headless_horse",
    ["Hedgehog"]                       = "elf_hedgehog",
    ["Hermit Crab"]                    = "summerfest_2023_hermit_crab",
    ["Hero Gibbon"]                    = "gibbon_2025_hero_gibbon",
    ["Highland Cow"]                   = "scottish_2023_highland_cow",
    ["Hippo"]                          = "danger_2023_hippo",
    ["Hippogriff"]                     = "gifthat_november_2024_hippogriff",
    ["Honey Badger"]                   = "ugc_refresh_2024_honey_badger",
    ["Hopbop"]                         = "moon_2025_hopbop",
    ["Horse"]                          = "horse",
    ["Hot Doggo"]                      = "summerfest_2023_hotdog_dog",
    ["Humbug"]                         = "winter_2025_humbug",
    ["Hummingbird"]                    = "subscription_2024_hummingbird",
    ["Husky"]                          = "winter_2021_husky",
    ["Hydra"]                          = "hydra",
    ["Hyena"]                          = "hyena",
    -- I
    ["Ibex"]                           = "random_pets_2022_ibex",
    ["Ibis"]                           = "japan_2022_ibis",
    ["Ice Cream Hermit Crab"]          = "summerfest_2023_ice_cream_crab",
    ["Ice Cube"]                       = "winter_2024_ice_cube",
    ["Ice Golem"]                      = "winter_2021_ice_golem",
    ["Ice Moth Dragon"]                = "winter_2022_ice_moth_dragon",
    ["Ice Wolf"]                       = "winter_2022_ice_wolf",
    ["Icy Porcupine"]                  = "ice_dimension_2025_icy_porcupine",
    ["Indian Flying Fox"]              = "halloween_2024_indian_flying_fox",
    ["Indian Leopard"]                 = "urban_2023_indian_leopard",
    ["Influencer Gibbon"]              = "gibbon_2025_influencer_gibbon",
    ["Inmate Capuchin Monkey"]         = "capuchin_2024_inmate_capuchin_monkey",
    ["Irish Elk"]                      = "winter_2022_irish_elk",
    ["Irish Water Spaniel"]            = "ugc_rewards_2022_irish_water_spaniel",
    ["Island Tarsier"]                 = "summerfest_2025_island_tarsier",
    -- J
    ["Japan Egg"]                      = "japan_2022_egg",
    ["Japanese Snow Fairy"]            = "winter_2025_japanese_snow_fairy",
    ["Jekyll Hydra"]                   = "halloween_2024_jekyll_hydra",
    ["Jellyfish"]                      = "ugc_refresh_2024_jellyfish",
    ["Jousting Horse"]                 = "halloween_2022_jousting_horse",
    ["Jumping Spider"]                 = "halloween_2025_spider",
    ["Jungle Egg"]                     = "jungle_egg",
    -- K
    ["Kage Crow"]                      = "spring_2025_kage_crow",
    ["Kaijunior"]                      = "spring_2025_spotted_kaijunior",
    ["Kakapo"]                         = "endangered_2026_kakapo",
    ["Kangaroo"]                       = "kangaroo",
    ["Kappakid"]                       = "spring_2025_kappakid",
    ["Karate Gorilla"]                 = "gorilla_fair_2023_karate_gorilla",
    ["Kelp Captain"]                   = "summerfest_2025_kelp_captain",
    ["Kelp Crewmate"]                  = "summerfest_2025_kelp_crewmate",
    ["Kelp Hunter"]                    = "summerfest_2025_kelp_hunter",
    ["Kelp Raider"]                    = "summerfest_2025_kelp_raider",
    ["Kid Goat"]                       = "summerfest_2024_kid_goat",
    ["King Bee"]                       = "king_bee",
    ["King Penguin"]                   = "ice_cream_refresh_2022_king_penguin",
    ["Kirin"]                          = "kirin",
    ["Kitsune"]                        = "kitsune",
    ["Kitty Bat"]                      = "halloween_2025_bat_cat",
    ["Kiwi"]                           = "kiwi_2023_kiwi",
    ["Koala"]                          = "koala",
    ["Koi Carp"]                       = "japan_2022_koi_carp",
    ["Komodo Dragon"]                  = "seasia_2023_komodo_dragon",
    ["Kookaburra"]                     = "aussie_2024_kookaburra",
    ["Kraken"]                         = "ocean_2024_kraken",
    -- L
    ["Ladybug"]                        = "ladybug",
    ["Lamb"]                           = "lamb",
    ["Lammergeier"]                    = "danger_2023_lammergeier",
    ["Lava Dragon"]                    = "halloween_2022_lava_dragon",
    ["Lava Wolf"]                      = "halloween_2022_lava_wolf",
    ["Lavender Dragon"]                = "lavender_dragon",
    ["Leopard Cat"]                    = "japan_2022_leopard_cat",
    ["Leopard Shark"]                  = "summerfest_2023_leopard_shark",
    ["Leviathan"]                      = "summerfest_2023_leviathan",
    ["Liger"]                          = "danger_2023_liger",
    ["Lion"]                           = "lion",
    ["Lion Cub"]                       = "ugc_refresh_2023_lion_cub",
    ["Lionfish"]                       = "ocean_2024_lionfish",
    ["Llama"]                          = "llama",
    ["Lobster"]                        = "summerfest_2023_lobster",
    ["Longhorn Cow"]                   = "farm_2023_longhorn_cow",
    ["Love Bird"]                      = "valentines_2025_love_bird",
    ["Lunar Gold Tiger"]               = "lny_2022_tiger_gold",
    ["Lunar Moon Bear"]                = "lny_2023_moon_moon_bear",
    ["Lunar Ox"]                       = "lunar_ox",
    ["Lunar Tiger"]                    = "lny_2022_tiger",
    ["Lunar White Tiger"]              = "lny_2022_tiger_white",
    ["Lynx"]                           = "lynx",
    -- M
    ["Magma Moose"]                    = "lures_2023_magma_moose",
    ["Magma Snail"]                    = "lures_2023_magma_snail",
    ["Magpie"]                         = "inspector_shepherd_2026_magpie",
    ["Mahi Mahi"]                      = "beach_2024_mahi_mahi",
    ["Maine Coon"]                     = "winter_2025_maine_coon",
    ["Majestic Pony"]                  = "summerfest_2024_majestic_pony",
    ["Malayan Tapir"]                  = "seasia_2023_malaysian_tapir",
    ["Maleo Bird"]                     = "seasia_2023_maleo_bird",
    ["Maneki-Neko"]                    = "japan_2022_maneki_neko",
    ["Manta Ray"]                      = "summerfest_2025_manta_ray",
    ["Many Mackerel"]                  = "summerfest_2023_mackerel_shoal",
    ["Marabou Stork"]                  = "halloween_2024_marabou_stork",
    ["Mecha Meow"]                     = "bfriday_2023_mecha_meow",
    ["Mecha R4BBIT"]                   = "spring_2025_mechapips",
    ["Mechapup"]                       = "april_fools_2022_mechapup",
    ["Meerkat"]                        = "meerkat",
    ["Merhorse"]                       = "merhorse",
    ["Mermicorn"]                      = "summerfest_2025_mermicorn",
    ["Merry Mistletroll"]              = "winter_2024_merry_mistletroll",
    ["Metal Ox"]                       = "metal_ox",
    ["Mexican Wolf"]                   = "endangered_2026_mexican_wolf",
    ["Midnight Dragon"]                = "lunar_2024_midnight_dragon",
    ["Mini Pig"]                       = "summerfest_2024_minipig",
    ["Mini Schnauzer"]                 = "house_pets_2025_mini_schnauzer",
    ["Mirai Moth"]                     = "spring_2025_mirai_moth",
    ["Mistletroll"]                    = "winter_2024_mistletroll",
    ["Mochi Meow"]                     = "sugarfest_2026_mochi_meow",
    ["Mole"]                           = "garden_2024_mole",
    ["Momma Moose"]                    = "camping_2025_mama_moose",
    ["Mongoose"]                       = "urban_2023_mongoose",
    ["Monkey"]                         = "monkey",
    ["Monkey King"]                    = "monkey_king",
}

-- =====================
--   GET IMAGE URL
-- =====================
local function getImage(petName)
    local file = PetCDN[petName]
    if file then
        return CDN .. file .. ".png"
    end
    -- fallback: try snake_case guess
    local guess = petName:lower():gsub("[%-%s]+", "_"):gsub("[^%w_]", "")
    return CDN .. guess .. ".png"
end

-- =====================
--  SEND WEBHOOK
-- =====================
local function sendWebhook(payload)
    local ok, err = pcall(function()
        request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = game:GetService("HttpService"):JSONEncode(payload)
        })
    end)
    if not ok then
        warn("[Webhook] Failed: " .. tostring(err))
    end
end

-- =====================
--  INVENTORY SCAN
-- =====================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function scanAndSend()
    local petList = {}

    -- scan backpack
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, item in backpack:GetChildren() do
            table.insert(petList, item.Name)
        end
    end

    -- scan equipped (character)
    local char = LocalPlayer.Character
    if char then
        for _, item in char:GetChildren() do
            if item:IsA("Tool") then
                table.insert(petList, item.Name)
            end
        end
    end

    if #petList == 0 then
        print("[Webhook] No pets found in inventory.")
        return
    end

    -- Build embeds (max 10 per message due to Discord limits)
    local embeds = {}
    for i, petName in ipairs(petList) do
        if i > 10 then break end -- Discord max 10 embeds

        local imgUrl = getImage(petName)
        local found = PetCDN[petName] ~= nil

        table.insert(embeds, {
            title = petName,
            color = found and 0x00ff88 or 0xff8800,
            thumbnail = { url = imgUrl },
            footer = { text = found and "✅ CDN Match" or "⚠️ Guessed URL" },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        })
    end

    local payload = {
        username = "Adopt Me Pet Scanner",
        avatar_url = "https://cdn.playadopt.me/items/cat.png",
        content = ("📦 **%s's Inventory** — **%d** pet(s) found"):format(
            LocalPlayer.Name, #petList
        ),
        embeds = embeds
    }

    sendWebhook(payload)
    print(("[Webhook] Sent %d pets to webhook!"):format(#petList))
end

-- =====================
--     RUN TEST
-- =====================
print("[AdoptMe CDN] Script loaded! Scanning inventory...")
task.wait(1)
scanAndSend()
