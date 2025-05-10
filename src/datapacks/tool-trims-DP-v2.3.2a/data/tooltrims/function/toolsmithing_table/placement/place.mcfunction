tag @s remove 310_place_toolsmithing_table

# place the barrel and setup the armor stand
data merge entity @s {equipment:{head:{id:"minecraft:rabbit_spawn_egg", count:1, components:{"minecraft:custom_model_data":{floats:[314001.0f]}}}, mainhand:{id: "minecraft:structure_block", count: 1, components:{"minecraft:custom_model_data":{floats:[312002.0f]}}}}}
setblock ~ ~ ~ barrel{Items:[{Slot:26b, id:"minecraft:structure_block", count:1, components:{"minecraft:custom_model_data":{floats:[312001.0f]}, "minecraft:custom_data":{gui:1b}, "minecraft:tooltip_display":{hide_tooltip:1b}, "minecraft:item_name":'{"text":""}'}}]}
function tooltrims:toolsmithing_table/slots_open_update

# detect if the entity is outside of the height limit
execute if block ~ ~ ~ barrel run tag @s add 320_barrel_detected
execute unless entity @s[tag=320_barrel_detected] run function tooltrims:toolsmithing_table/placement/check_stop

# set tags and play sound
execute at @s if entity @s[tag=320_barrel_detected] run playsound block.wood.place block @a[distance=..10] ~ ~ ~
tag @s remove 320_barrel_detected
tag @s add 310_toolsmithing_table