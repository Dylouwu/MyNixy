# prevent the open sound to be played and set the open tag
execute if entity @s[tag=!310_toolsmithing_table_open] run function tooltrims:fixes/barrel_open

# dectect if the content of the barrel changed
execute store success score @s 310_slot_update run data modify entity @s equipment.mainhand.components."minecraft:custom_data".Items set from block ~ ~ ~ Items
execute if entity @s[scores={310_slot_update=1}] run function tooltrims:toolsmithing_table/slots_open_update