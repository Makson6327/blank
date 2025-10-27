return {
    descriptions = {
        Back = {
            b_mksn_silver = {
                name = "Silver Deck",
                text = {
                    "All {C:attention}non-Enhanced{} played cards become",
                    "{C:attention}Sterling{} cards when scored",
                },
            },
            b_mksn_grimoire = {
                name = "Grimoire Deck",
                text = {
                    "Start run with",
                    "{C:attention}1{} random {C:tarot}Tarot{} card and",
                    "{C:attention}1{} random {C:planet}Planet{} card",
                },
            },
            b_mksn_sniper = {
                name = "Sniper Deck",
                text = {
                    "At end of each Round:",
                    "gives {C:money}$6{} if Blind",
                    "finished in one hand",
                    "Earn no {C:attention}Interest",
                },
            },
            b_mksn_prehistoric = {
                name = "Prehistoric Deck",
                text = {
                    "Start run with",
                    "{C:attention,T:v_hieroglyph}Hieroglyph{},",
                    "and {C:attention,T:v_petroglyph}Petroglyph",
                },
            },
            b_mksn_kuiper = {
                name = "Kuiper Deck",
                text = {
                    "After defeating each",
                    "{C:attention}Boss Blind{}, gain a",
                    "{C:spectral,T:c_black_hole}Black Hole{} card",
                    "{C:planet}Planet{} cards and vouchers",
                    "no longer appear in the {C:attention}shop",
                },
            },
            b_mksn_negativedeck = {
                name = "Negative Deck",
                text = {
                    "{C:green}1 in 7{} cards in deck are",
                    "{C:dark_edition}Negative{}",
                    "{C:attention}-1{} hand size,",
                },
            },
            b_mksn_radioactive = {
                name = "Radioactive Deck",
                text = {
                    "{X:mult,C:white}X3{} Mult",
                    "{C:green}#1# in 75{} chance to lose",
                    "after defeating each {C:attention}Blind{}",
                },
            },
            b_mksn_white_deck = {
                name = "White Deck",
                text = {
                    "{C:attention}-4{} Joker slots",
                    "After defeating each",
                    "{C:attention}Boss Blind{}, gain a",
                    "Joker slot",
                },
            },
            b_mksn_travel = {
                name = "Travel Deck",
                text = {
                    "{C:attention}-1{} Ante if",
                    "{C:attention}4{} Blinds skipped",
                },
            },
            b_mksn_traffic = {
                name = "Traffic Deck",
                text = {
                    "Only Joker Tags",
                    "may appear during run",
                },
            },
            b_mksn_maple = {
                name = "Maple Deck",
                text = {
                    "Cards give {C:mult}Mult",
                    "instead of {C:chips}chips",
                    "{C:red}X2{} base Blind size",
                },
            },
        },
        Blind = {
            bl_mksn_final_blade = {
                name = "Silver Blade",
                text = {
                    "Leftmost and rightmost",
                    "Jokers are disabled",
                },
            },
            bl_mksn_final_wand = {
                name = "Ivory Wand",
                text = {
                    "Playing hands spend discards",
                    "and vice versa",
                },
            },
            bl_mksn_final_pentacle = {
                name = "Golden Pentacle",
                text = {
                    "Played poker hand",
                    "counts as first level hand",
                },
            },
        },
        Enhanced = {
            m_mksn_sterling = {
                name = 'Sterling Card',
                text = {
                    "{C:green}#1# in 2{} chance",
                    "to win {C:money}$1",
                },
            },
            m_mksn_scratched = {
                name = 'Scratched Card',
                text = {
                    "{X:mult,C:white} X#1#{} Mult",
                    "no rank or suit",
                },
            },
            m_mksn_stained = {
                name = 'Stained Card',
                text = {
                    "May give {X:mult,C:white} X#1# {} Mult,",
                    "{C:mult}+#2#{} Mult or {C:chips}+#3#{} chips",
                }
            }
        },
        Spectral = {
            c_mksn_invisibility = {
                name = 'Invisible',
                text = {
                    "Add {C:dark_edition}Negative{} effect to",
                    "{C:attention}1{} selected card in hand",
                },
            },
            c_mksn_hope = {
                name = 'Hope',
                text = {
                    "Add a {C:inactive}White Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            }
        },
        Tarot = {
            c_mksn_breakthrough = {
                name = "Breakthrough",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}#2#s",
                },
            },
            c_mksn_courage = {
                name = "Courage",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}#2#s",
                },
            },
            c_mksn_existence = {
                name = "Existence",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}#2#s",
                },
            },
            c_mksn_completion = {
                name = "Completion",
                text = {
                    "Gives {C:money}$#1#{} for each",
                    "consumable held",
                    "(Max of {C:money}$#2#{C:inactive})",
                    "{C:inactive}(Currently {C:money}$#3#{C:inactive})",
                },
            },
            c_mksn_creativity = {
                name = "Creativity",
                text = {
                    "Add a random {C:attention}Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },
        },
        Other = {
            mksn_large = {
                name = "Large",
                text = {
                    "{C:attention}-1{} Joker slot",
                }
            },
            mksn_unstable = {
                name = "Unstable",
                text = {
                    "{C:green}#1# in 5{} chance",
                    "to be destroyed",
                    "after playing hand",
                }
            },
            mksn_indigo_sticker = {
                name = "Indigo Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Indigo",
                    "{C:attention}Stake{} difficulty",
                }
            },
            mksn_lime_sticker = {
                name = "Lime Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Lime",
                    "{C:attention}Stake{} difficulty",
                }
            },
            mksn_white_seal = {
                name = "White Seal",
                text = {
                    "This card",
                    "can't be debuffed",
                },
            }
        },
        Stake = {
            stake_mksn_indigo = {
                name = "Indigo Stake",
                text = {
                    "Shop can have {C:attention}Large{} Jokers",
                    "{C:inactive,s:0.8}(-1 Joker Slot)",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
            stake_mksn_lime = {
                name = "Lime Stake",
                text = {
                    "Shop can have {C:attention}Unstable{} Jokers",
                    "{C:inactive,s:0.8}(1 in 5 chance to be destroyed after playing hand)",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
        },
        Voucher = {
            v_mksn_storefront = {
                name = "Storefront",
                text = {
                    "{C:attention}+1{} booster slot",
                    "available in shop",
                }
            },
            v_mksn_tradehall = {
                name = "Tradehall",
                text = {
                    "Random booster pack in",
                    "shop is free",
                }
            },
            v_mksn_deviation = {
                name = "Deviation",
                text = {
                    "{C:attention}+1{} card available",
                    "in booster pack",
                }
            },
            v_mksn_regularity = {
                name = "Regularity",
                text = {
                    "{C:spectral,T:c_black_hole}Black Hole{} and {C:spectral,T:c_soul}Soul{} cards",
                    "have bigger chance",
                    "to appear",
                }
            },
        },
        Joker = {
            j_mksn_agent = {
                name = "007 Agent",
                text = {
                    "If {C:attention}played hand{} is",
                    "a single {C:attention}7{}, enhance it,",
                    "add random {C:dark_edition}Edition{}",
                    "and random {C:attention}Seal{}",
                },
            },
            j_mksn_ace_ace_baby = {
                name = "Ace Ace Baby",
                text = {
                    "This Joker gains",
                    "{C:mult}+#2#{} Mult when each",
                    "played {C:attention}Ace{} is scored",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                },
            },
            j_mksn_attorney = {
                name = "Ace Attorney",
                text = {
                    "If {C:attention}first hand{} of round",
                    "contains single card,",
                    "set rank to {C:attention}Ace{}",
                },
            },
            j_mksn_ambulance = {
                name = "Ambulance Siren",
                text = {
                    "Gain {C:blue}+1{} hand",
                    "or {C:red}+1{} discard",
                    "when {C:attention}Blind{} is selected",
                    "until end of Ante"
                },
            },
            j_mksn_artwork = {
                name = "Artwork",
                text = {
                    "May give {X:mult,C:white} X#4# {} Mult",
                    "{C:mult}+#6#{} Mult or {C:chips}+#5#{} Chips",
                    "when {C:attention}Stained{} card is scored",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult",
                    "{C:mult}+#3#{C:inactive} Mult and {C:chips}+#2#{C:inactive} Chips)",
                },
            },
            j_mksn_axe = {
                name = "Axe",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if played",
                    "hand contains only",
                    "scored {C:attention}7s{}",
                }
            },
            j_mksn_potato = {
                name = "Bag of Chips",
                text = {
                    "{C:chips}+#1#{} chips",
                    "This card is destroyed",
                    "after defeating Boss Blind",
                }
            },
            j_mksn_big_smoke = {
                name = "Big Joke",
                text = {
                    "Retrigger all played {C:attention}#1#{}",
                    "{C:attention}#2#{} additional times,",
                    "rank changes every round",
                }
            },
            j_mksn_bottlers = {
                name = "Bottle Caps",
                text = {
                    "{C:chips}+#1#{} chips for",
                    "each {C:money}$#4#{} you have",
                    "under {C:money}$#3#{}",
                }
            },
            j_mksn_brownies = {
                name = "Brownies",
                text = {
                    "Adds a random {C:dark_edition}Edition{} to",
                    "every scoring card",
                    "This card is destroyed",
                    "after {C:attention}#1#{} scored cards",
                },
            },
            j_mksn_cereals = {
                name = "Cereal Box",
                text = {
                    "{C:green}#1# in #2#{} chance this",
                    "card is destroyed",
                    "at end of round",
                    "Create a {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room)",
                },
            },
            j_mksn_cheese = {
                name = "Cheese",
                text = {
                    "Prevents Death for a cost of",
                    "{C:attention}-1{} hand size",
                    "{S:1.1,C:red,E:2}self destructs{}",
                },
            },
            j_mksn_clockwork_jaw = {
                name = "Clockwork Jaw",
                text = {
                    "Destroy {C:attention}first{} played",
                    "card used in scoring",
                },
            },
            j_mksn_compact_disc = {
                name = "Compact Disc",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "for each card {C:attention}sold",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                },
            },
            j_mksn_dealer = {
                name = "Dealer",
                text = {
                    "This Joker gains {X:mult,C:white} X#2# {} Mult",
                    "for each card {C:attention}played",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                },
            },
            j_mksn_magazine = {
                name = "Extra Magazine",
                text = {
                    "Score all cards",
                    "held in hand",
                    "{C:inactive}(Editions don't score)",
                },
            },
            j_mksn_firestarter = {
                name = "Firestarter",
                text = {
                    "This Joker gains {X:mult,C:white} X#2# {} Mult",
                    "after defeating Blind",
                    "in one hand",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                },
            },
            j_mksn_flamethrower = {
                name = "Flamethrower",
                text = {
                    "Removes {C:dark_edition}Editions{} from",
                    "cards held in hand",
                    "at the end of round",
                    "and gains {X:mult,C:white} X#2# {} Mult per",
                    "Edition removed",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                    "{C:inactive}(Can't remove Negative from card)",
                },
            },
            j_mksn_flare = {
                name = "Flare Gun",
                text = {
                    "If Blind was defeated",
                    "with no hands remaining",
                    "create random {C:attention}Tag{}",
                },
            },
            j_mksn_flushbang = {
                name = "Flushbang",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if played",
                    "hand contains a Flush",
                    "and has scoring cards",
                    "of two different {C:attention}suits",
                },
            },
            j_mksn_gardener = {
                name = "Gardener",
                text = {
                    "{C:red}+#1#{} Mult if",
                    "{C:attention}five{} or more",
                    "cards held in hand",
                },
            },
            j_mksn_graffiti = {
                name = "Graffiti",
                text = {
                    "{C:red}+1{} Mult for each",
                    "card with enhancement",
                    "in your full deck",
                    "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",
                },
            },
            j_mksn_gravel = {
                name = "Gravel",
                text = {
                    "Retrigger played cards",
                    "with {C:inactive}no{} suit",
                },
            },
            j_mksn_high_five = {
                name = "High Five",
                text = {
                    "Create a {C:tarot}Tarot{} card if",
                    "played hand has exactly",
                    "{C:attention}5{} cards and is a {C:attention}High Card{}",
                    "{C:inactive}(Must have room)",
                },
            },
            j_mksn_inharitance = {
                name = "Inharitance",
                text = {
                    "{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips",
                    "every time a {C:attention}Sterling{} card",
                    "{C:green}successfully{} triggers",
                    "Resets at the end of Ante",
                    "{C:inactive}(Currently {C:red}+#3#{C:inactive} Mult and {C:blue}+#4#{C:inactive} Chips)",
                },
            },
            j_mksn_jack_reaper = {
                name = "Jack the Reaper",
                text = {
                    "If played hand contains",
                    "scoring {C:attention}Jack{}, destroy all",
                    "non-Jack cards in played hand",
                },
            },
            j_mksn_pootis_engage = {
                name = "Jimbos Engage",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if",
                    "there's exactly",
                    "two Jokers other than",
                    "{C:attention}Jimbos Engage",
                },
            },
            j_mksn_artist = {
                name = "Joker Artist",
                text = {
                    "{C:attention}Stained{} cards always",
                    "gives {X:mult,C:white} X1.2 {} Mult",
                },
            },
            j_mksn_joker_doom = {
                name = "Joker Doom",
                text = {
                    "{C:chips}+#2#{} Chips if",
                    "played hand contains a {C:attention}7{}",
                    "{C:chips}-#3#{} Chips if",
                    "played hand contains a {C:attention}non-7{}",
                    "{C:inactive}(Currently {C:chips}#1#{C:inactive} Chips)",
                    "{C:inactive}(May go negative)",
                },
            },
            j_mksn_kaleidoscope = {
                name = "Kaleidoscope",
                text = {
                    "Upgrade level of",
                    "played {C:attention}poker hand{}",
                    "if it contains a",
                    "{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
                    "{C:hearts}Heart{} card, and {C:spades}Spade{} card",
                },
            },
            j_mksn_keycard = {
                name = "Keycard",
                text = {
                    "{X:mult,C:white} X#2# {} Mult per Ante",
                    "above Ante {C:attention}1{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                },
            },
            j_mksn_lightning = {
                name = "Lightning Joker",
                text = {
                    "{X:mult,C:white} X#2# {} Mult when",
                    "{C:attention}Mult{} card is scored",
                    "Resets at the end of round",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                },
            },
            j_mksn_lottery = {
                name = "Lottery Ticket",
                text = {
                    "{C:green}#1# in #2#{} chance",
                    "to win {C:money}$#3#{} when",
                    "{C:attention}Scratched{} card is scored",
                },
            },
            j_mksn_map = {
                name = "Map",
                text = {
                    "{C:mult}+#2#{} Mult when",
                    "{C:attention}Blind{} skipped",
                    "Resets at the end of round",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                },
            },
            j_mksn_merchant = {
                name = "Merchant",
                text = {
                    "{C:blue}+1{} hand each round,",
                    "{C:attention}-1{} consumable slot",
                },
            },
            j_mksn_mushroom = {
                name = "Mushroom",
                text = {
                    "Sell this card to",
                    "add {C:dark_edition}Polychrome{} to a",
                    "random {C:attention}Joker{}",
                }
            },
            j_mksn_divided_zero = {
                name = "Oops! Divided by 0",
                text = {
                    "Nullifies all {C:attention}listed",
                    "{C:green,E:1,S:1.1}probabilities",
                    "{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}0 in 3{C:inactive})",
                },
            },
            j_mksn_porcelain = {
                name = "Porcelain Joker",
                text = {
                    "Played {C:attention}Bonus{} cards",
                    "gives {X:chips,C:white} X#1# {} Chips when scored",
                },
            },
            j_mksn_postcard = {
                name = "Postcard",
                text = {
                    "Earn {C:money}$#2#{} at end of",
                    "round for each {C:attention}Blind{}",
                    "skipped this run",
                    "{C:inactive}(Currently {C:money}$#1#{C:inactive})",
                },
            },
            j_mksn_press_your_luck = {
                name = "Press Your Luck",
                text = {
                    "Sell this card to",
                    "{C:legendary,E:1}test your luck",
                },
            },
            j_mksn_pepper = {
                name = "Red Hot Pepper",
                text = {
                    "After defeating Blind in",
                    "one hand, destroy this card",
                    "and create a free",
                    "{C:attention}#1#",
                }
            },
            j_mksn_romantical = {
                name = "Romantical Joker",
                text = {
                    "Each played {C:attention}6{} or {C:attention}9{}",
                    "gives {C:mult}+#1#{} Mult when scored",
                },
            },
            j_mksn_scratched = {
                name = "Scratched Joker",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if played",
                    "hand contains scoring",
                    "{C:attention}Scratched{} card",
                },
            },
            j_mksn_cute_seal = {
                name = "Seal Joker",
                text = {
                    "Played cards with",
                    "{C:attention}Seal{} give {C:chips}+#2#{} chips",
                    "and {C:mult}+#1#{} Mult when scored",
                }
            },
            j_mksn_skyscraper = {
                name = "Skyscraper",
                text = {
                    "{C:chips}+#2#{} Chips when",
                    "played hand is a {C:attention}High Card{}",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                },
            },
            j_mksn_slothful = {
                name = "Slothful Joker",
                text = {
                    "Played cards with",
                    "{C:inactive}no{} suit give",
                    "{C:mult}+#1#{} Mult when scored",
                },
            },
            j_mksn_soldier = {
                name = "Soldier Joker",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:mult}-#2#{} Mult at the end",
                    "of each Small",
                    "and Big Blind"
                },
            },
            j_mksn_sommers = {
                name = "Sommers",
                text = {
                    "{X:mult,C:white} X#3# {} Mult for every",
                    "{C:money}$1{} you have",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                },
            },
            j_mksn_stain_glass = {
                name = "Stained Glass",
                text = {
                    "Add {C:dark_edition}Polychrome{}",
                    "to scored {C:attention}Glass{} cards"
                },
            },
            j_mksn_strangelet = {
                name = "Strange Matter",
                text = {
                    "{C:dark_edition}Negative{} consumables",
                    "may appear in a shop"
                },
            },
            j_mksn_the_suit = {
                name = "Suit",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "on Blinds with effects",
                },
            },
            j_mksn_suprematist = {
                name = "Suprematist",
                text = {
                    "{C:mult}+#1#{} Mult if",
                    "played hand doesn't contain",
                    "another poker hand",
                },
            },
            j_mksn_laboratory = {
                name = "The Laboratory",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if played",
                    "hand is a {C:attention}Five of a Kind",
                    "{C:attention}Flush House{} or {C:attention}Flush Five"
                },
            },
            j_mksn_survivalist = {
                name = "The Survivalist",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if played",
                    "hand is a {C:attention}High Card",
                },
            },
            j_mksn_toxic_waste = {
                name = "Toxic Waste",
                text = {
                    "Jokers each give {X:mult,C:white} X#3# {} Mult",
                    "{C:green}#1# in #2#{} chance this",
                    "card is destroyed",
                    "at end of round",
                },
            },
            j_mksn_train = {
                name = "Train",
                text = {
                    "{X:mult,C:white} X#2# {} Mult per same",
                    "{C:attention}consecutive{} poker hand",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                    "{C:inactive}(Last hand played is {C:attention}#3#{C:inactive})",
                },
            },
            j_mksn_ufo = {
                name = "UFO",
                text = {
                    "Played poker hands",
                    "has random levels",
                },
            },
            j_mksn_underdog = {
                name = "Underdog",
                text = {
                    "Create a {C:spectral}Spectral{} card",
                    "when probability check",
                    "fails {C:attention}3{} consecutive times",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive} fail)",
                },
            },
            j_mksn_wild = {
                name = "Wild Joker",
                text = {
                    "Retrigger played cards",
                    "with most frequent suit",
                    "in your full deck",
                    "{C:inactive}(Currently {C:attention}#3#{C:inactive})",
                },
            },
            j_mksn_wine = {
                name = "Wine",
                text = {
                    "Sell this card to",
                    "set money to {C:money}$20",
                }
            },
        }
    },
    misc = {
        labels = {
            mksn_large = "Large",
            mksn_unstable = "Unstable",
            mksn_white_seal = "White Seal"
        },
        dictionary = {
            mksn_osho_zen_tarot = 'Osho Zen Tarot',
            mksn_osho_zen_tarots = 'Osho Zen Tarots',

            k_mksn_unstable_ex = "BOOM!",

            k_mksn_zero_money_ex = "You Lose!",
            k_mksn_kill_destroy_ex = "Go Home!",
            k_mksn_consume_ex = "Your Pockets!",
            k_mksn_no_handy_ex = "Finger Cut!",
            k_mksn_launch_ex = "Boosting!",
            k_mksn_plus_money_ex = "Reward!",
            k_mksn_gift_tag_ex = "Prize!",
            k_mksn_gift_card_ex = "Huge Prize!!!",
            k_mksn_gift_edition_ex = "Shiny!",
            k_mksn_creature_guy_ex = "Crowd!",
            k_mksn_landing_ex = "Slowing!",

            k_mksn_soldier_dead_ex = "F",
            k_mksn_minus_five_ex = "-5",
            k_mksn_plus_tag = "+1 Tag",
            k_mksn_blu_hand = "+1 Hand",
            k_mksn_red_discard = "+1 Discard"
        },
    }
}