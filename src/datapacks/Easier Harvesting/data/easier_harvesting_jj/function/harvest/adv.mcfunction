tag @s add easier_harvesting_jj.this
execute if entity @s[advancements={easier_harvesting_jj:harvest/crops={interact=true}}] as @e[type=minecraft:interaction,tag=easier_harvesting_jj.crop] at @s if function easier_harvesting_jj:harvest/pre run function easier_harvesting_jj:harvest/start
execute if entity @s[advancements={easier_harvesting_jj:harvest/crops={attack=true}}] as @e[type=minecraft:interaction,tag=easier_harvesting_jj.crop] at @s if function easier_harvesting_jj:harvest/pre2 run function easier_harvesting_jj:harvest/start
tag @s remove easier_harvesting_jj.this
advancement revoke @s only easier_harvesting_jj:harvest/crops