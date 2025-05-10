execute store result score #distance main_score run attribute @s minecraft:block_interaction_range get 10
execute if score #distance main_score matches 81.. run scoreboard players set #distance main_score 80
execute anchored eyes positioned ^ ^ ^ run function easier_harvesting_jj:search_crop/main