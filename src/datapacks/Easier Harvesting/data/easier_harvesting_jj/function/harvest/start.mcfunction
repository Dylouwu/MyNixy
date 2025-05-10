execute as @a[tag=easier_harvesting_jj.this,limit=1] run loot spawn ~ ~0.5 ~ mine ~ ~ ~ mainhand
execute as @e[type=minecraft:item,nbt={Age:0s,OnGround:0b},distance=..3,limit=1] run function easier_harvesting_jj:harvest/result/check
playsound minecraft:block.sweet_berry_bush.pick_berries block @a[distance=..10] ~ ~ ~
kill @s

# age 2
execute if block ~ ~ ~ #easier_harvesting_jj:age_2[age=2] run function easier_harvesting_jj:harvest/end/age_2
# age 3
execute if block ~ ~ ~ #easier_harvesting_jj:age_3[age=3] run return run function easier_harvesting_jj:harvest/end/age_3
# age 7
execute if block ~ ~ ~ #easier_harvesting_jj:age_7[age=7] run return run function easier_harvesting_jj:harvest/end/age_7