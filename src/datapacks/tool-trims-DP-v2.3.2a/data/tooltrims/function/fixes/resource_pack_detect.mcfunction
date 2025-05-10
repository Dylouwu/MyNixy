execute at @r run summon minecraft:marker ~ ~ ~ {CustomName:{translate:tooltrims.id}, Tags:["301_rp_detector"]}
execute if entity @e[type=marker, name=tool_trims] run scoreboard players set .310_count 310_rp_missing 0
execute unless entity @e[type=marker, name=tool_trims] run function tooltrims:fixes/resource_pack_missing
kill @e[type=marker, tag=301_rp_detector]