# toolsmithing table
execute as @e[tag=310_place_toolsmithing_table] at @s run function tooltrims:toolsmithing_table/placement/check
execute as @e[tag=310_toolsmithing_table] at @s run function tooltrims:toolsmithing_table/tick

# deactived hopper minecarts
execute as @e[tag=310_minecart_deactived] at @s unless entity @e[tag=310_toolsmithing_table, distance=..2] run function tooltrims:fixes/container/hopper_minecarts_active

# update from older version support
execute as @a[predicate=tooltrims:detect_custom_items] run function tooltrims:fixes/container/detect_outdated_custom_item

# gui items
clear @a minecraft:structure_block[custom_data={gui:1b}]
execute as @e[type=item, nbt={Item:{components:{"minecraft:custom_data":{gui:1b}}}}] run kill @s