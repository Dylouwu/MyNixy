#particle poof ~ ~1 ~ .3 .5 .3 .05 20 force @a[distance=..32]
playsound minecraft:block.shulker_box.open block @a[distance=..20] ~ ~ ~ 1 .8
playsound minecraft:block.spawner.break block @a[distance=..20] ~ ~ ~ 1 .8

summon silverfish ~ ~ ~-.5 {PersistenceRequired:1b}
summon silverfish ~ ~ ~.5 {PersistenceRequired:1b}


