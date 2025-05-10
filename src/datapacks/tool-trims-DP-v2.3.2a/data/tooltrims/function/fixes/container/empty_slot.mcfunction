# add gui
$execute unless block ~ ~ ~ barrel{Items:[{Slot:$(slot)b}]} run item replace block ~ ~ ~ container.$(slot) with minecraft:structure_block[minecraft:custom_model_data={floats:[31200$(type).0]}, minecraft:custom_data={gui:1b}, minecraft:tooltip_display={"hide_tooltip":1b}, minecraft:item_name='{"text":""}'] 1
$execute unless block ~ ~ ~ barrel{Items:[{Slot:$(slot)b, components:{"minecraft:custom_data":{gui:1b}}}]} run execute at @p run summon item ~ ~ ~ {Tags:["310_detected_slot_item"], Item:{id:"minecraft:structure_block", count:1b}}

$data modify entity @e[type=item, limit=1, tag=310_detected_slot_item] Item.id set from block ~ ~ ~ Items[{Slot:$(slot)b}].id
$data modify entity @e[type=item, limit=1, tag=310_detected_slot_item] Item.count set from block ~ ~ ~ Items[{Slot:$(slot)b}].count
$data modify entity @e[type=item, limit=1, tag=310_detected_slot_item] Item.components set from block ~ ~ ~ Items[{Slot:$(slot)b}].components

$item replace block ~ ~ ~ container.$(slot) with minecraft:structure_block[minecraft:custom_model_data={floats:[31200$(type).0]}, minecraft:custom_data={gui:1b}, minecraft:tooltip_display={"hide_tooltip":1b}, minecraft:item_name='{"text":""}'] 1
tag @e[limit=1, tag=310_detected_slot_item] remove 310_detected_slot_item