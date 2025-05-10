# set scoreboards
scoreboard objectives remove update_item
scoreboard objectives add 310_rp_missing dummy
execute unless score .310_count 310_rp_missing matches -2147483648..2147483647 run scoreboard players set .310_count 310_rp_missing 0
scoreboard objectives add 310_slot_update dummy
scoreboard objectives add 310_operation dummy
scoreboard players set .310_40 310_operation 40

scoreboard objectives add 310_recipe dummy
scoreboard objectives add 310_combination dummy
scoreboard objectives add 310_template dummy

# detect resource pack
schedule function tooltrims:fixes/resource_pack_detect 10s

# reload message
tellraw @a [{"text":"Tool Trims v2.3.2","color":"#96F088", "underlined": true, "click_event": {"action": "open_url", "url": "https://modrinth.com/datapack/tool-trims"}},{"text":" was reloaded!","color":"#96F088", "underlined": false}]