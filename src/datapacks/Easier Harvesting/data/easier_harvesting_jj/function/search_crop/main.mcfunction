scoreboard players remove #distance main_score 1
execute align xyz if block ~ ~ ~ #easier_harvesting_jj:supported_crops if function easier_harvesting_jj:search_crop/check/crop run function easier_harvesting_jj:search_crop/end
execute if score #distance main_score matches 1.. positioned ^ ^ ^0.1 run function easier_harvesting_jj:search_crop/main