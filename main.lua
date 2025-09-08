Makson6327 = SMODS.current_mod
Makson6327_path = SMODS.current_mod.path
Makson6327_config = SMODS.current_mod.config



---------------- Sounds ----------------

SMODS.Sound({
    key = 'explosion',
    path = 'explosion.ogg'
})

SMODS.Sound({
    key = 'applause',
    path = 'applause.ogg'
})



---------------- Atlases ----------------

SMODS.Atlas {
    key = "modicon",
    path = "Icon.png",
    px = 32,
    py = 32
}

SMODS.Atlas {
    key = "Backs",
    path = "Backs.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Blinds",
    path = "Blinds.png",
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
}

SMODS.Atlas {
    key = 'Consumables',
    path = "Consumables.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Jokers",
    path = "Jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "CDJoker",
    path = "CDJoker.png",
    px = 95,
    py = 95
}

SMODS.Atlas {
    key = "Modifiers",
    path = "Modifiers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Stickers",
    path = "Stickers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Stakes",
    path = "Chips.png",
    px = 29,
    py = 29
}

SMODS.Atlas {
    key = "Stake_Stickers",
    path = "StickersStake.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Vouchers",
    path = "Vouchers.png",
    px = 71,
    py = 95
}



---------------- Backs ----------------

SMODS.Back {
	key = "silver",
    atlas = "Backs",
    pos = {
        x = 3,
        y = 0
    },
    calculate = function(self, card, context)
        if context.before then
            local not_silver = {}
            for k, v in ipairs(context.scoring_hand) do
                if v.ability.set == 'Default' then
                    not_silver[#not_silver+1] = v
                    v:set_ability(G.P_CENTERS.m_mksn_sterling, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
            if #not_silver > 0 then 
                return {
                    message = localize('k_gold'),
                    colour = G.C.MONEY,
                    ard = self
                }
            end
        end
    end
}

SMODS.Back {
	key = "grimoire",
    atlas = "Backs",
    pos = {
        x = 6,
        y = 0
    },
    apply = function (self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card_type = 'Tarot'
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'sup')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                    return true
                end)}))
                return {
                    message = localize('k_plus_tarot'),
                    colour = G.C.SECONDARY_SET.Tarot,
                    card = self
                }
            end  
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                local card_type = 'Planet'
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'sup')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                    return true
                end)}))
                return {
                    message = localize('k_plus_planet'),
                    colour = G.C.SECONDARY_SET.Planet,
                    card = self
                }
            end  
        }))
    end
}

SMODS.Back {
	key = "sniper",
    atlas = "Backs",
    pos = {
        x = 5,
        y = 0
    },
    config = {no_interest = true},
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
			if G.GAME.current_round.hands_played == 1 then
                return {
                    dollars = 6
                }
            end
        end
    end,
}

SMODS.Back {
	key = "prehistoric",
    atlas = "Backs",
    pos = {
        x = 0,
        y = 0
    },
    config = {vouchers = {"v_hieroglyph", "v_petroglyph"}},
}

SMODS.Back {
	key = "kuiper",
    atlas = "Backs",
    pos = {
        x = 1,
        y = 0
    },
    apply = function (self)
        local banned = {"v_planet_merchant","v_planet_tycoon"}
		for k,v in ipairs(banned) do
			G.GAME.banned_keys[v] = true
		end
		G.E_MANAGER:add_event(Event({func = function()
			G.GAME.planet_rate = 0
			return true 
		end}))
	end,
    calculate = function(self, card, context)
		if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual  then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card { key = 'c_black_hole', edition = "e_negative" }
					return true
				end
			}))
		end
    end,
}

SMODS.Back {
	key = "negativedeck",
    atlas = "Backs",
    pos = {
        x = 4,
        y = 0
    },
    config = {hand_size = -1},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.probabilities.normal
            }
        }
    end,
    apply = function (self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if pseudorandom("negative_thing") < G.GAME.probabilities.normal / 7 then
                        v:set_edition('e_negative', nil, true)
                    end
                end
            return true
            end
        }))
    end,
}



SMODS.Back {
    key = "radioactive",
    atlas = "Backs",
    pos = {
        x = 2,
        y = 0,
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.probabilities.normal
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
			G.E_MANAGER:add_event(Event({
				func = function()
					if SMODS.pseudorandom_probability(card, 'radioactive_hit', 1, 75) then
                        G.STATE = G.STATES.GAME_OVER
                        if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then 
                            G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
                        end
                        G:save_settings()
                        G.FILE_HANDLER.force = true
                        G.STATE_COMPLETE = false
                    end
                    return true
                end
			}))
		end
        if context.final_scoring_step then
			return {
				xmult = 3
			}
		end
    end,
}

SMODS.Back {
	key = "white_deck",
    atlas = "Backs",
    pos = {
        x = 1,
        y = 1
    },
    config = {joker_slot = -4},
    calculate = function(self, card, context)
		if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual  then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.jokers.config.card_limit = G.jokers.config.card_limit + 1
					return true
				end
			}))
		end
    end,
}

SMODS.Back {
	key = "travel",
    atlas = "Backs",
    pos = {
        x = 2,
        y = 1
    },
    config = {extra = {blinds_skipped = 0}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.extra.blinds_skipped
            }
        }
    end,
    apply = function (self)
        G.E_MANAGER:add_event(Event({func = function()
            self.config.extra.blinds_skipped = 0
			return true 
		end}))
    end,
    calculate = function(self, card, context)
		if context.skip_blind then
            self.config.extra.blinds_skipped = self.config.extra.blinds_skipped + 1
        end

        if self.config.extra.blinds_skipped == 4 then
            self.config.extra.blinds_skipped = 0
            ease_ante(-1)
        end
    end,
}

SMODS.Back {
	key = "traffic",
    atlas = "Backs",
    pos = {
        x = 4,
        y = 1
    },
    apply = function (self)
        local banned = {
            "tag_boss",
            "tag_investment",
            "tag_voucher",
            "tag_standard",
            "tag_charm",
            "tag_meteor",
            "tag_buffoon",
            "tag_ethereal",
            "tag_handy",
            "tag_garbage",
            "tag_double",
            "tag_coupon",
            "tag_d_six",
            "tag_juggle",
            "tag_top_up",
            "tag_skip",
            "tag_orbital",
            "tag_economy"
        }
		for k,v in ipairs(banned) do
			G.GAME.banned_keys[v] = true
		end
	end,
}

SMODS.Back {
	key = "maple",
    atlas = "Backs",
    pos = {
        x = 5,
        y = 1
    },
    config = {ante_scaling = 2},
    apply = function(self, back)
        G.GAME.modifiers.mksn_maple_mult = true
    end
}



---------------- Blinds ----------------

SMODS.Blind{
    key = 'final_blade',
    boss = {showdown = true, min = 10, max = 10},
    dollars = 8,
    pos = {y = 0},
    atlas = "Blinds",
    boss_colour = HEX('8f8f8f'),

    set_blind = function(self)
        for i = 1, #G.jokers.cards do
            if i == 1 then
                local debuffed_joker = G.jokers.cards[i]
                debuffed_joker.debuffed_by_blind = true
                self.triggered = true
                debuffed_joker:set_debuff(true)
            end
            if i == #G.jokers.cards then
                local debuffed_joker = G.jokers.cards[i]
                debuffed_joker.debuffed_by_blind = true
                self.triggered = true
                debuffed_joker:set_debuff(true)
            end
        end
    end,
    recalc_debuff = function(self, card, from_blind)
        if card.debuffed_by_blind then
            return true
        else
            return false
        end
    end,
    disable = function(self)
        for k, v in pairs(G.jokers.cards) do
            if v.debuffed_by_blind then
                v:set_debuff(); v.debuffed_by_blind = nil
            end
        end
        self.triggered = false
    end,
    defeat = function(self)
        for k, v in pairs(G.jokers.cards) do
            if v.debuffed_by_blind then
                v:set_debuff(); v.debuffed_by_blind = nil
            end
        end
        self.triggered = false
    end
}

SMODS.Blind{
    key = 'final_wand',
    boss = {showdown = true, min = 10, max = 10},
    dollars = 8,
    pos = {y = 1},
    atlas = "Blinds",
    boss_colour = HEX('cfc298'),

    calculate = function(self, card, context)
        if context.before and not G.GAME.blind.disabled then
            if G.GAME.current_round.discards_left ~= 0 then
                ease_discard(-1)
            end
        elseif context.pre_discard and not G.GAME.blind.disabled then
            if G.GAME.current_round.hands_left ~= 1 then
                ease_hands_played(-1)
            end
        end
    end
}

SMODS.Blind{
    key = 'final_pentacle',
    boss = {showdown = true, min = 10, max = 10},
    dollars = 8,
    pos = {y = 2},
    atlas = "Blinds",
    boss_colour = HEX('e2c412'),

    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        self.triggered = true
        return math.min(mult, G.GAME.hands[text].s_mult),
            math.min(hand_chips, G.GAME.hands[text].s_chips),
            true
    end
}



---------------- Consumables ----------------

SMODS.Consumable {
    key = 'invisibility',
    set = 'Spectral',
    atlas = 'Consumables',
    pos = {
        x = 0,
        y = 0
    },
    config = {},
    cost = 4,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, 
            func = function()
                local over = false
                conv_card:set_edition('e_negative', true)
                card:juice_up(0.3, 0.5)
                return true 
            end 
        }))
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == 1 and not G.hand.highlighted[1].edition
    end
}

SMODS.Consumable {
    key = 'hope',
    set = 'Spectral',
    atlas = 'Consumables',
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = 'mksn_white'
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS['mksn_white']
        return {
            vars = {
                colours = {
                    G.C.WHITE
                }
            }
        }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra, nil, true)
                return true
            end
        }))
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == 1
    end
}

SMODS.Consumable{
    key = 'breakthrough',
    set = 'Tarot',
    atlas = 'Consumables',
    pos = {
        x = 0,
        y = 1
    },

    effect = 'Enhance',
    config = {mod_conv = 'm_mksn_scratched', max_highlighted = 1},

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(G.localization.misc.dictionary.mksn_osho_zen_tarot, get_type_colour(self or card.config, card), nil, 1.2)
    end,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_mksn_scratched
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

SMODS.Consumable{
    key = 'courage',
    set = 'Tarot',
    atlas = 'Consumables',
    pos = {
        x = 1,
        y = 1
    },

    effect = 'Enhance',
    config = {mod_conv = 'm_mksn_sterling', max_highlighted = 2},

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(G.localization.misc.dictionary.mksn_osho_zen_tarot, get_type_colour(self or card.config, card), nil, 1.2)
    end,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_mksn_sterling
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

SMODS.Consumable{
    key = 'existence',
    set = 'Tarot',
    atlas = 'Consumables',
    pos = {
        x = 2,
        y = 1
    },

    effect = 'Enhance',
    config = {mod_conv = 'm_mksn_stained', max_highlighted = 2},

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(G.localization.misc.dictionary.mksn_osho_zen_tarot, get_type_colour(self or card.config, card), nil, 1.2)
    end,

    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_mksn_stained
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}



---------------- Enhancements ----------------

SMODS.Enhancement {
    key = "sterling",
    atlas = "mksn_Modifiers",
    pos = {
        x = 0,
        y = 0
    },
    config = {extra = {odds = 2, money = 1}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            if SMODS.pseudorandom_probability(card, 'silver_money', 1, card.ability.extra.odds) then
                return {
                    dollars = card.ability.extra.money
                }
            end
        end
    end
}

SMODS.Enhancement {
    key = "stained",
    atlas = "mksn_Modifiers",
    pos = {
        x = 3,
        y = 0
    },
    config = {extra = {xmult = 1.2, mult = 3, chips = 25}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.mult,
                card.ability.extra.chips,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            local opt = pseudorandom("stained_card", 1, 4)
            if opt == 1 then
                return {
                    xmult = card.ability.extra.xmult
                }
            elseif opt == 2 then
                return {
                    mult = card.ability.extra.mult
                }
            elseif opt == 3 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

SMODS.Enhancement {
    key = "scratched",
    atlas = "mksn_Modifiers",
    pos = {
        x = 2,
        y = 0
    },
    no_rank = true,
    no_suit = true,
    always_scores = true,
    replace_base_card = true,
    config = {extra = {x_mult = 2}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
    end
}



---------------- Seals ----------------

SMODS.Seal {
    key = "white",
    atlas = 'mksn_Modifiers',
    pos = {
        x = 4,
        y = 0
    },
    badge_colour = HEX("c5ceda")
}


---------------- Stickers ----------------

SMODS.Sticker {
    key = "large",
    atlas = "Stickers",
    pos = {
        x = 0,
        y = 0
    },
    badge_colour = HEX('749511'),

    apply = function(self, card, val)
        card.ability[self.key] = val
    end,
}

SMODS.Sticker {
    key = "unstable",
    atlas = "Stickers",
    pos = {
        x = 1,
        y = 0
    },
    badge_colour = HEX('a63c3f'),
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.probabilities.normal,
            }
        }
    end,

    apply = function(self, card, val)
        if card.ability.eternal or card.ability.perishable then return end
        card.ability[self.key] = val
    end,
    calculate = function(self, card, context)
        if context.after and SMODS.pseudorandom_probability(card, 'unstable_hit', 1, 5) then
            card:calculate_unstable()
            return {
                card = card,
                message = localize('k_mksn_unstable_ex'),
                colour = G.C.RED
            }
        end
    end,
}



---------------- Stakes ----------------

SMODS.Stake {
    key = "indigo",
    atlas = "Stakes",
    sticker_atlas = "mksn_Stake_Stickers",
    pos = {
        x = 2,
        y = 1
    },
    sticker_pos = {
        x = 0,
        y = 0
    },
    colour = HEX('5761d2'),
    unlocked_stake = 'orange',
    applied_stakes = {'purple'},
    above_stake = 'purple',
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
    modifiers = function()
        G.GAME.modifiers.enable_large_in_shop = true
    end
}

SMODS.Stake:take_ownership('orange', {
    applied_stakes = {'mksn_indigo'},
    above_stake = 'mksn_indigo'
})

SMODS.Stake {
    key = "lime",
    atlas = "Stakes",
    sticker_atlas = "mksn_Stake_Stickers",
    pos = {
        x = 1,
        y = 1
    },
    sticker_pos = {
        x = 1,
        y = 0
    },
    colour = HEX('9ac615'),
    unlocked_stake = 'gold',
    applied_stakes = {'orange'},
    above_stake = 'orange',
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}},
    modifiers = function()
        G.GAME.modifiers.enable_unstable_in_shop = true
    end
}

SMODS.Stake:take_ownership('gold', {
    applied_stakes = {'mksn_lime'},
    above_stake = 'mksn_lime'
})



---------------- Vouchers ----------------

SMODS.Voucher{
    key = "storefront",
    atlas = "Vouchers",
    pos = {
        x = 0,
        y = 0
    },
    redeem = function(self)
        G.GAME.modifiers.extra_boosters = (G.GAME.modifiers.extra_boosters or 0) + 1
        SMODS.add_booster_to_shop()
    end,
}

SMODS.Voucher{
    key = "tradehall",
    atlas = "Vouchers",
    pos = {
        x = 0,
        y = 1
    },
    requires = {'v_mksn_storefront'},
    redeem = function(self)
        if G.shop_booster and G.shop_booster.cards then
            for k, v in pairs(G.shop_booster.cards) do
                if k == 2 then 
                    v.cost = 0
                end
            end
        end
    end,
}

SMODS.Voucher{
    key = "deviation",
    atlas = "Vouchers",
    pos = {
        x = 1,
        y = 0
    },
}

SMODS.Voucher{
    key = "regularity",
    atlas = "Vouchers",
    pos = {
        x = 1,
        y = 1
    },
    requires = {'v_mksn_deviation'},
}



---------------- Jokers ----------------
SMODS.Joker {
    key = "cute_seal",
    rarity = 1,
    pos = {
        x = 0,
        y = 0
    },
    atlas = "Jokers",
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {mult = 5, chips = 15}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_seal() then
                return {
                    mult = card.ability.extra.mult,
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

SMODS.Joker {
    key = "big_smoke",
    rarity = 1,
    pos = {
        x = 1,
        y = 0
    },
    atlas = "Jokers",
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {repetitions = 2}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.current_round.mksn_big_smoke.rank,
                card.ability.extra.repetitions
            }
        }
    end,

    calculate = function(self, card, context)
        if not card.debuff then
            if context.repetition and context.cardarea == G.play then
                if context.other_card:get_id() == G.GAME.current_round.mksn_big_smoke.id then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra.repetitions,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker {
    key = "merchant",
    rarity = 1,
    pos = {
        x = 2,
        y = 0
    },
    atlas = "Jokers",
    cost = 4,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {slots = 1}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.slots
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
    end
}

SMODS.Joker {
    key = "ace_ace_baby",
    rarity = 2,
    pos = {
        x = 3,
        y = 0
    },
    atlas = "Jokers",
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {mult = 0, plus_mult = 1}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.plus_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                mult = card.ability.extra.mult,
            }
        end

        if not context.blueprint and context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                card.ability.extra.scored = true
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.plus_mult
                return {
                    extra = {
                        focus = card,
                        message = localize('k_upgrade_ex'),
                        colour = G.C.MULT,
                    },
                    card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = "axe",
    rarity = 2,
    pos = {
        x = 4,
        y = 0
    },
    atlas = "Jokers",
    cost = 7,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {xmult = 3}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local seven = true
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() ~= 7 then
                    seven = false
                end
            end
            if seven then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

SMODS.Joker {
    key = "wine",
    rarity = 1,
    pos = {
        x = 5,
        y = 0
    },
    atlas = "Jokers",
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_dollars(20 - G.GAME.dollars, true)
                    return true
                end
            }))
        end
    end
}

SMODS.Joker {
    key = "potato",
    rarity = 1,
    pos = {
        x = 6,
        y = 0
    },
    atlas = "Jokers",
    cost = 4,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    soul_pos = nil,

    config = {extra = {chips = 160}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.ability.extra.chips,
            }
        end

        if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual and not context.blueprint then
			G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot2')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers:remove_card(card)
                            card:remove()
                            card = nil
                            return true;
                        end
                    }))
                    return true
                end
            }))
            return {
                card = card,
                message = localize('k_eaten_ex'),
                colour = G.C.FILTER
            }
		end
    end
}

SMODS.Joker {
    key = "mushroom",
    rarity = 3,
    pos = {
        x = 7,
        y = 0
    },
    atlas = "Jokers",
    cost = 8,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            local jokers = {}
            for k, v in ipairs(G.jokers.cards) do
                if not v.edition then
                    jokers[#jokers + 1] = v
                end
            end
            if #jokers > 0 then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    local chosen_joker = pseudorandom_element(jokers, pseudoseed("mushroom"))
                    chosen_joker:set_edition("e_polychrome", true)
                return true end }))
            end
        end
    end
}

SMODS.Joker {
    key = "pepper",
    rarity = 2,
    pos = {
        x = 8,
        y = 0
    },
    atlas = "Jokers",
    cost = 6,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    soul_pos = nil,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize{type = 'name_text', set = 'Tag', key = 'tag_rare', nodes = {}}
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
			if G.GAME.current_round.hands_played == 1 then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_rare'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                       return true
                   end)
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        play_sound('tarot2')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            end
        end
    end
}

SMODS.Joker {
    key = "toxic_waste",
    rarity = 3,
    pos = {
        x = 9,
        y = 0
    },
    atlas = "Jokers",
    cost = 8,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {odds = 4, xmult = 2}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.other_joker then
			G.E_MANAGER:add_event(Event({
                func = function()
                    context.other_joker:juice_up(0.5, 0.5)
                    return true
                end
            })) 
            return {
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.xmult}},
                Xmult_mod = card.ability.extra.xmult
            }
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'toxic_waste', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        play_sound('tarot2')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            else
                return {
                    card = card,
                    message = localize('k_safe_ex'),
                    colour = G.C.FILTER
                }
            end
        end
    end
}

SMODS.Joker {
    key = "slothful",
    rarity = 1,
    pos = {
        x = 0,
        y = 1
    },
    atlas = "Jokers",
    cost = 5,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {mult = 6}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') or
            SMODS.has_enhancement(context.other_card, 'm_mksn_scratched') then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

SMODS.Joker {
    key = "gravel",
    rarity = 2,
    pos = {
        x = 1,
        y = 1
    },
    atlas = "Jokers",
    cost = 7,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {repetitions = 1}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') or
            SMODS.has_enhancement(context.other_card, 'm_mksn_scratched') then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.repetitions,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = "porcelain",
    rarity = 2,
    pos = {
        x = 2,
        y = 1
    },
    atlas = "Jokers",
    cost = 7,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {xchips = 1.25}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        return {
            vars = {
                card.ability.extra.xchips
            }
        }
    end,

    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_bonus') then
                return true
            end
        end
        return false
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_bonus') then
                return {
                    x_chips = card.ability.extra.xchips
                }
            end
        end
    end
}

SMODS.Joker {
    key = "wild",
    rarity = 2,
    pos = {
        x = 3,
        y = 1
    },
    atlas = "Jokers",
    cost = 7,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return nil
    end,

    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_wild') then
                return true
            end
        end
        return false
    end,

    calculate = function(self, card, context)
        if context.before then
            if context.scoring_hand then
                local wilds = {}
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i]:get_edition() == nil and SMODS.has_enhancement(context.scoring_hand[i], 'm_wild') then
                        table.insert(wilds, context.scoring_hand[i])
                    end
                end
                if #wilds > 0 then 
                    for i = 1, #wilds do
                        local other_card = wilds[i]
                        other_card:set_edition({polychrome = true})
                    end
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.DARK_EDITION,
                        ard = self
                    }
                end
            end
        end
    end
}

SMODS.Joker {
    key = "lightning",
    rarity = 2,
    pos = {
        x = 4,
        y = 1
    },
    atlas = "Jokers",
    cost = 7,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {xmult = 1, plus_xmult = 0.25}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.plus_xmult
            }
        }
    end,

    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_mult') then
                return true
            end
        end
        return false
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if card.ability.extra.xmult ~= 1 then
                return {
                    xmult = card.ability.extra.xmult,
                }
            end
        end

        if not context.blueprint and context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_mult') then
                card.ability.extra.scored = true
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.plus_xmult
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            if card.ability.extra.xmult ~= 1 then
                card.ability.extra.xmult = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Joker {
    key = "romantical",
    rarity = 1,
    pos = {
        x = 5,
        y = 1
    },
    atlas = "Jokers",
    cost = 5,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {mult = 5}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 6 or context.other_card:get_id() == 9 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

SMODS.Joker {
    key = "compact_disc",
    rarity = 2,
    pos = {
        x = 0,
        y = 0
    },
    atlas = "CDJoker",
    cost = 5,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {mult = 0, plus_mult = 2}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.plus_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                mult = card.ability.extra.mult,
            }
        end

        if context.selling_card and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.plus_mult
            return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        if self.discovered or card.bypass_discovery_center then
            card.T.w = G.CARD_W * 1.338028169014
            card.T.h = G.CARD_H * 1
        end
    end,
    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            card.children.center.scale = {x = 95, y = 95}
            card.children.center:reset()
        end
    end,
    load = function(self, card, card_table, other_card)
        return self.set_ability(self, card)
    end
}

SMODS.Joker {
    key = "high_five",
    rarity = 2,
    pos = {
        x = 7,
        y = 1
    },
    atlas = "Jokers",
    cost = 5,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if #context.full_hand == 5 and context.scoring_name == 'High Card' then
                local card_type = 'Tarot'
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'sup')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                    return true
                end)}))
                return {
                    message = localize('k_plus_tarot'),
                    colour = G.C.SECONDARY_SET.Tarot
                }
            end
        end
    end
}

SMODS.Joker {
    key = "train",
    rarity = 3,
    pos = {
        x = 8,
        y = 1
    },
    atlas = "Jokers",
    cost = 8,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {start_xmult = 1, plus_xmult = 0.25, hand_type = nil}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.start_xmult,
                card.ability.extra.plus_xmult,
                card.ability.extra.hand_type
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if not card.ability.extra.hand_type then
                card.ability.extra.hand_type = context.scoring_name
                card.ability.extra.start_xmult = card.ability.extra.start_xmult + card.ability.extra.plus_xmult
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            elseif card.ability.extra.hand_type == context.scoring_name then
                card.ability.extra.start_xmult = card.ability.extra.start_xmult + card.ability.extra.plus_xmult
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            else
                card.ability.extra.hand_type = context.scoring_name
                card.ability.extra.start_xmult = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main and context.cardarea == G.jokers then
            return {
                xmult = card.ability.extra.start_xmult,
            }
        end
    end
}

SMODS.Joker {
    key = "skyscraper",
    rarity = 1,
    pos = {
        x = 9,
        y = 1
    },
    atlas = "Jokers",
    cost = 5,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {start_chips = 0, plus_chips = 8}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.start_chips,
                card.ability.extra.plus_chips
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if context.scoring_name == 'High Card' then
                card.ability.extra.start_chips = card.ability.extra.start_chips + card.ability.extra.plus_chips
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.ability.extra.start_chips,
            }
        end
    end
}

SMODS.Joker {
    key = "firestarter",
    rarity = 2,
    pos = {
        x = 0,
        y = 2
    },
    atlas = "Jokers",
    cost = 7,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {start_xmult = 1, plus_xmult = 0.2}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.start_xmult,
                card.ability.extra.plus_xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
			if G.GAME.current_round.hands_played == 1 then
                card.ability.extra.start_xmult = card.ability.extra.start_xmult + card.ability.extra.plus_xmult
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main and context.cardarea == G.jokers then
            return {
                xmult = card.ability.extra.start_xmult,
            }
        end
    end
}

SMODS.Joker {
    key = "postcard",
    rarity = 1,
    pos = {
        x = 1,
        y = 2
    },
    atlas = "Jokers",
    cost = 4,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {start_dollars = 0, plus_dollars = 2}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.start_dollars,
                card.ability.extra.plus_dollars
            }
        }
    end,

    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint then
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MONEY
            }
        end

        if context.end_of_round and not context.repetition and not context.individual then
            if card.ability.extra.start_dollars ~= 0 then
                return {
                    dollars = card.ability.extra.start_dollars
                }
            end
        end
    end,
    update = function(self, card, front)
        card.ability.extra.start_dollars = card.ability.extra.plus_dollars * G.GAME.skips
    end
}

SMODS.Joker {
    key = "graffiti",
    rarity = 1,
    pos = {
        x = 2,
        y = 2
    },
    atlas = "Jokers",
    cost = 5,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {tally = 0, mult = 0}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.tally,
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                mult = card.ability.extra.tally
            }
        end
    end,
    update = function(self, card)
        if G.playing_cards ~= nil then
            card.ability.extra.tally = 0

            for k, v in pairs(G.playing_cards) do
                if v.config.center ~= G.P_CENTERS.c_base then
                    card.ability.extra.tally = card.ability.extra.tally + 1 
                end
            end
            
            card.ability.extra.mult = card.ability.extra.tally
        end
    end
}

SMODS.Joker {
    key = "suprematist",
    rarity = 1,
    pos = {
        x = 3,
        y = 2
    },
    atlas = "Jokers",
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {mult = 18}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if (context.scoring_name == 'Flush' and not next(context.poker_hands['Pair'])) or
                (context.scoring_name == 'Straight') or
                (context.scoring_name == 'Pair') or
                (context.scoring_name == 'High Card') then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

SMODS.Joker {
    key = "kaleidoscope",
    rarity = 2,
    pos = {
        x = 4,
        y = 2
    },
    atlas = "Jokers",
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.before then
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do
                if not SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            for i = 1, #context.scoring_hand do
                if SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            if suits["Hearts"] > 0 and
            suits["Diamonds"] > 0 and
            suits["Spades"] > 0 and
            suits["Clubs"] > 0 then
                return {
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
}

SMODS.Joker {
    key = "press_your_luck",
    rarity = 1,
    pos = {
        x = 5,
        y = 2
    },
    atlas = "Jokers",
    cost = 5,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            local opt = pseudorandom("guess_ur_lucky_enough", 1, 100)
            if opt >= 1 and opt <= 8 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mksn_applause')
                        ease_dollars(- G.GAME.dollars, true)
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_mksn_zero_money_ex'),
                    colour = G.C.RED
                }
            elseif opt >= 9 and opt <= 12 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mksn_applause')
                        local _first_dissolve = nil
                        for k, v in pairs(G.jokers.cards) do
                            v:start_dissolve(nil, _first_dissolve);_first_dissolve = true
                        end
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_mksn_kill_destroy_ex'),
                    colour = G.C.RED
                }
            elseif opt >= 13 and opt <= 20 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mksn_applause')
                        G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_mksn_consume_ex'),
                    colour = G.C.RED
                }
            elseif opt >= 21 and opt <= 28 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mksn_applause')
                        G.hand:change_size(-1)
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_mksn_no_handy_ex'),
                    colour = G.C.RED
                }
            elseif opt >= 29 and opt <= 32 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mksn_applause')
                        ease_ante(1)
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_mksn_launch_ex'),
                    colour = G.C.RED
                }
            elseif opt >= 33 and opt <= 40 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mksn_applause')
                        ease_dollars(40, true)
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_mksn_plus_money_ex'),
                    colour = G.C.RED
                }
            elseif opt >= 41 and opt <= 56 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mksn_applause')
                        add_tag(Tag('tag_double'))
                        add_tag(Tag('tag_double'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_mksn_gift_tag_ex'),
                    colour = G.C.RED
                }
            elseif opt >= 57 and opt <= 72 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mksn_applause')
                        local card_type
                        local type = pseudorandom("consumable_type", 1, 3)
                        if type == 1 then
                            card_type = 'Tarot'
                        elseif type == 2 then
                            card_type = 'Planet'
                        elseif type == 3 then
                            card_type = 'Spectral'
                        end
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'sup')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    return true
                    end  
                }))
                return {
                    card = card,
                    message = localize('k_mksn_gift_card_ex'),
                    colour = G.C.RED
                }
            elseif opt >= 73 and opt <= 80 then
                local jokers_to_create = math.max(0, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        play_sound('mksn_applause')
                        for i = 1, jokers_to_create do
                            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'freak')
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))   
                return {
                    card = card,
                    message = localize('k_mksn_creature_guy_ex'),
                    colour = G.C.RED
                }
            elseif opt >= 81 and opt <= 92 then
                local jokers = {}
                for k, v in ipairs(G.jokers.cards) do
                    if not v.edition then
                        jokers[#jokers + 1] = v
                    end
                end
                local edition = poll_edition('edition', nil, true, true)
                if #jokers > 0 then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        play_sound('mksn_applause')
                        local chosen_joker = pseudorandom_element(jokers, pseudoseed("mushroom"))
                        chosen_joker:set_edition(edition, true)
                    return true end }))
                end
                return {
                    card = card,
                    message = localize('k_mksn_gift_edition_ex'),
                    colour = G.C.RED
                }
            elseif opt >= 93 and opt <= 100 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mksn_applause')
                        ease_ante(-1)
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_mksn_landing_ex'),
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker {
    key = "strangelet",
    rarity = 3,
    pos = {
        x = 6,
        y = 2
    },
    atlas = "Jokers",
    cost = 7,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,
}

SMODS.Joker {
    key = "flushbang",
    rarity = 1,
    pos = {
        x = 7,
        y = 2
    },
    atlas = "Jokers",
    cost = 3,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {xmult = 2}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if next(context.poker_hands['Flush']) then
                local suits = {
                    ['Hearts'] = 0,
                    ['Diamonds'] = 0,
                    ['Spades'] = 0,
                    ['Clubs'] = 0
                }
                for i = 1, #context.scoring_hand do
                    if not SMODS.has_any_suit(context.scoring_hand[i]) then
                        if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                        elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                        elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                        elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                    end
                end
                for i = 1, #context.scoring_hand do
                    if SMODS.has_any_suit(context.scoring_hand[i]) then
                        if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                        elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                        elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                        elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                    end
                end
                local suit_counter = 0
                if suits["Hearts"] > 0 then
                    suit_counter = suit_counter + 1
                end
                if suits["Diamonds"] > 0 then
                    suit_counter = suit_counter + 1
                end
                if suits["Spades"] > 0 then
                    suit_counter = suit_counter + 1
                end
                if suits["Clubs"] > 0 then
                    suit_counter = suit_counter + 1
                end
                if suit_counter > 1 then
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    end
}

SMODS.Joker {
    key = "survivalist",
    rarity = 3,
    pos = {
        x = 8,
        y = 2
    },
    atlas = "Jokers",
    cost = 8,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {xmult = 2}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if context.scoring_name == 'High Card' then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

SMODS.Joker {
    key = "laboratory",
    rarity = 3,
    pos = {
        x = 9,
        y = 2
    },
    atlas = "Jokers",
    cost = 8,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {xmult = 5}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if context.scoring_name == 'Five of a Kind' or
             context.scoring_name == 'Flush Five' or
             context.scoring_name == 'Flush House' then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

SMODS.Joker {
    key = "scratched",
    rarity = 2,
    pos = {
        x = 0,
        y = 3
    },
    atlas = "Jokers",
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {xmult = 3}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mksn_scratched
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_mksn_scratched') then
                return true
            end
        end
        return false
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if context.scoring_hand then
                local scratches = {}
                for i = 1, #context.scoring_hand do
                    if SMODS.has_enhancement(context.scoring_hand[i], 'm_mksn_scratched') then
                        table.insert(scratches, context.scoring_hand[i])
                    end
                end
                if #scratches > 0 then 
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    end
}

SMODS.Joker {
    key = "artwork",
    rarity = 2,
    pos = {
        x = 1,
        y = 3
    },
    atlas = "Jokers",
    cost = 7,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {xmult = 1, chips = 0, mult = 0, plus_xmult = 0.1, plus_chips = 10, plus_mult = 2}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mksn_stained
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.chips,
                card.ability.extra.mult,
                card.ability.extra.plus_xmult,
                card.ability.extra.plus_chips,
                card.ability.extra.plus_mult
            }
        }
    end,

    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_mksn_stained') then
                return true
            end
        end
        return false
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                xmult = card.ability.extra.xmult,
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
            }
        end

        if not context.blueprint and context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_mksn_stained') then
                card.ability.extra.scored = true
                local opt = pseudorandom('stained', 1, 4)
                if opt == 1 then
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.plus_xmult
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.XMULT,
                    }
                elseif opt == 2 then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.plus_mult
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.MULT,
                    }
                elseif opt == 3 then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.plus_chips
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.CHIPS,
                    }
                end
            end
        end
    end
}

SMODS.Joker {
    key = "lottery",
    rarity = 2,
    pos = {
        x = 2,
        y = 3
    },
    atlas = "Jokers",
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {dollars = 10, odds = 6}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mksn_scratched
        return {
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                card.ability.extra.dollars
            }
        }
    end,

    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_mksn_scratched') then
                return true
            end
        end
        return false
    end,

    calculate = function(self, card, context)
        if not context.blueprint and context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_mksn_scratched') then
                if SMODS.pseudorandom_probability(card, 'lottery_money', 1, card.ability.extra.odds) then
                    return {
                        dollars = card.ability.extra.dollars
                    }
                end
            end
        end
    end
}

SMODS.Joker {
    key = "divided_zero",
    rarity = 1,
    pos = {
        x = 3,
        y = 3
    },
    atlas = "Jokers",
    cost = 3,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    add_to_deck = function(self, card, from_debuff)
       for k, v in pairs(G.GAME.probabilities) do 
            G.GAME.probabilities[k] = v * 0
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do 
            G.GAME.probabilities[k] = 1
        end
        for k, v in ipairs(G.jokers.cards) do
            if v.ability.name == 'Oops! All 6s'  then
                for k, v in pairs(G.GAME.probabilities) do 
                    G.GAME.probabilities[k] = v * 2
                end
            end
        end
    end
}

SMODS.Joker {
    key = "jack_reaper",
    rarity = 3,
    pos = {
        x = 4,
        y = 3
    },
    atlas = "Jokers",
    cost = 7,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {trash_list = {}}},

    calculate = function(self, card, context)
        if context.after then
            local jacks = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 11 then
                    jacks = true
                end
            end
            if jacks == true then
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i]:get_id() ~= 11 then
                        table.insert(card.ability.extra.trash_list, context.scoring_hand[i])
                    end
                end
                local trash_list = card.ability.extra.trash_list
                if #trash_list > 0 then 
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.7,
                        func = function()
                            for _, card_to_trash in ipairs(trash_list) do
                                if not card_to_trash.removed then
                                    card_to_trash:start_dissolve(nil, nil)
                                end
                            end
                            return true
                        end
                    }))
                    for _, card_to_trash in ipairs(trash_list) do
                        card_to_trash.destroyed = true
                    end
                    SMODS.calculate_context({remove_playing_cards = true, removed = trash_list})
                    card.ability.extra.trash_list = {}
                end
            end
        end
    end
}

SMODS.Joker {
    key = "cheese",
    rarity = 3,
    pos = {
        x = 5,
        y = 3
    },
    atlas = "Jokers",
    cost = 10,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            if context.game_over then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card:start_dissolve()
                        G.hand:change_size(-1)
                        return true
                    end
                })) 
                return {
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker {
    key = "cereals",
    rarity = 1,
    pos = {
        x = 6,
        y = 3
    },
    atlas = "Jokers",
    cost = 4,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {odds = 4}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.odds
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'rarity_in_box', 1, card.ability.extra.odds) then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card_type = 'Spectral'
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'sup')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)}))
                            return {
                                message = localize('k_plus_spectral'),
                                colour = G.C.SECONDARY_SET.Spectral,
                                card = self
                            }
                        end  
                    }))
                end
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        play_sound('tarot2')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            else
                return {
                    card = card,
                    message = localize('k_safe_ex'),
                    colour = G.C.FILTER
                }
            end
        end
    end
}

SMODS.Joker {
    key = "brownies",
    rarity = 1,
    pos = {
        x = 7,
        y = 3
    },
    atlas = "Jokers",
    cost = 5,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {cards = 4}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_edition() == nil and card.ability.extra.cards > 0 then
                    local other_card = context.scoring_hand[i]
                    other_card:set_edition(poll_edition('gas_station_brownies', nil, true, true))
                    card.ability.extra.cards = card.ability.extra.cards - 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            other_card:juice_up()
                            card:juice_up()
                            return true
                        end
                    }))

                    if card.ability.extra.cards <= 0 then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.2,
                            func = function()
                                play_sound('tarot2')
                                card.T.r = -0.2
                                card:juice_up(0.3, 0.4)
                                card.states.drag.is = true
                                card.children.center.pinch.x = true
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.3,
                                    blockable = false,
                                    func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                        return true;
                                    end
                                }))
                                return true
                            end
                        }))
                        return {
                            card = card,
                            message = localize('k_eaten_ex'),
                            colour = G.C.FILTER
                        }
                    end
                end
            end
        end
    end
}

SMODS.Joker {
    key = "map",
    rarity = 1,
    pos = {
        x = 8,
        y = 3
    },
    atlas = "Jokers",
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {mult = 0, plus_mult = 20}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.plus_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if card.ability.extra.mult > 0 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end

        if context.skip_blind and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.plus_mult
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            card.ability.extra.mult = 0
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
    end
}

SMODS.Joker {
    key = "ufo",
    rarity = 2,
    pos = {
        x = 9,
        y = 3
    },
    atlas = "Jokers",
    cost = 6,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,
}

SMODS.Joker {
    key = "pootis_engage",
    rarity = 2,
    pos = {
        x = 0,
        y = 4
    },
    atlas = "Jokers",
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {xmult = 5}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            local pootis = 0
            for k, v in ipairs(G.jokers.cards) do
                if v.ability.name ~= 'j_mksn_pootis_engage'  then
                    for k, v in pairs(G.GAME.probabilities) do 
                        pootis = pootis + 1
                    end
                end
            end
            if pootis == 2 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

SMODS.Joker {
    key = "bottlers",
    rarity = 1,
    pos = {
        x = 1,
        y = 4
    },
    atlas = "Jokers",
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {plus_chips = 40, start_dollars = 25, sub_dollars = 5}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.plus_chips,
                card.ability.extra.plus_chips * math.floor((card.ability.extra.start_dollars - G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.sub_dollars),
                card.ability.extra.start_dollars,
                card.ability.extra.sub_dollars,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if G.GAME.dollars < card.ability.extra.start_dollars then
                return {
                    chips = card.ability.extra.plus_chips * math.floor((card.ability.extra.start_dollars - G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.sub_dollars)
                }
            end
        end
    end
}

SMODS.Joker {
    key = "soldier",
    rarity = 1,
    pos = {
        x = 2,
        y = 4
    },
    atlas = "Jokers",
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {mult = 25, sub_mult = 5}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.sub_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                mult = card.ability.extra.mult
            }
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint and not G.GAME.blind.boss then
            if card.ability.extra.mult - card.ability.extra.sub_mult <= 0 then 
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        play_sound('tarot2')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    card = card,
                    message = localize('k_mksn_soldier_dead_ex'),
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.sub_mult
                return {
                    card = card,
                    message = localize('k_mksn_minus_five_ex'),
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker {
    key = "underdog",
    rarity = 2,
    pos = {
        x = 3,
        y = 4
    },
    atlas = "Jokers",
    cost = 7,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soul_pos = nil,

    config = {extra = {unluck = 0}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.unluck
            }
        }
    end,

    calculate = function(self, card, context)
        if context.pseudorandom_result and not context.result and not context.blueprint then
            local trigger_time = 0
            card.ability.extra.unluck = card.ability.extra.unluck + 1
            if card.ability.extra.unluck >= 3 then
                card.ability.extra.unluck = 0
                trigger_time = trigger_time + 1
                if trigger_time == 1 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card_type = 'Spectral'
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'sup')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)}))
                            return {
                                message = localize('k_plus_spectral'),
                                colour = G.C.SECONDARY_SET.Spectral,
                                card = self
                            }
                        end  
                    }))
                end
            else
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.ORANGE
                }
            end
        end
        if context.pseudorandom_result and context.result and not context.blueprint then
            card.ability.extra.unluck = 0
            return {
                message = localize('k_reset'),
                colour = G.C.ORANGE
            }
        end
    end
}

SMODS.Joker {
    key = "sommers",
    rarity = 4,
    pos = {
        x = 0,
        y = 5
    },
    soul_pos = {
        x = 0,
        y = 6
    },
    atlas = "Jokers",
    cost = 20,
    unlocked = true,
    blueprint_compat = true,

    config = {extra = {xmult = 1, plus_xmult = 0.075}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmult + card.ability.extra.plus_xmult * math.max(0,(G.GAME.dollars) or 0),
                card.ability.extra.plus_xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if (G.GAME.dollars + (G.GAME.dollar_buffer or 0)) > 0 then
                return {
                    xmult = card.ability.extra.xmult + card.ability.extra.plus_xmult * math.max(0,(G.GAME.dollars + (G.GAME.dollar_buffer or 0)))
                }
            end
        end
    end
}



---------------- func ----------------
function SMODS.current_mod.reset_game_globals(run_start)
    -- Big Joke
    G.GAME.current_round.mksn_big_smoke.rank = '9'
    local valid_cards = {}
    for k, v in ipairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            if not SMODS.has_no_rank(v) then
                valid_cards[#valid_cards+1] = v
            end
        end
    end
    if valid_cards[1] then 
        local big_smoke = pseudorandom_element(valid_cards, pseudoseed('two_number_nine'..G.GAME.round_resets.ante))
        G.GAME.current_round.mksn_big_smoke.rank = big_smoke.base.value
        G.GAME.current_round.mksn_big_smoke.id = big_smoke.base.id
    end
end

local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    ret.current_round.mksn_big_smoke = {
        rank = 9,
    }
    return ret
end

function SMODS.current_mod.set_debuff(card)
    if card.seal and card.seal == "mksn_white" then
        return 'prevent_debuff'
    end
    return false
end

local cgcb = Card.get_chip_bonus
function Card:get_chip_bonus()
    local ret = cgcb(self)
    if G.GAME.modifiers.mksn_maple_mult then
        ret = ret - self.base.nominal
    end
    return ret
end

local cgcm = Card.get_chip_mult
function Card:get_chip_mult()
    local ret = cgcm(self)
    if G.GAME.modifiers.mksn_maple_mult then
        ret = ret + self.base.nominal
    end
    return ret
end