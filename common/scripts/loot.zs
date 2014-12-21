import minetweaker.item.IItemStack;

// copper ingots
vanilla.loot.removeChestLoot("dungeonChest", <IC2:itemIngot:0>);
vanilla.loot.removeChestLoot("mineshaftCorridor", <IC2:itemIngot:0>);
vanilla.loot.removeChestLoot("pyramidDesertyChest", <IC2:itemIngot:0>);
vanilla.loot.removeChestLoot("pyramidJungleChest", <IC2:itemIngot:0>);
vanilla.loot.removeChestLoot("strongholdCorridor", <IC2:itemIngot:0>);
vanilla.loot.removeChestLoot("strongholdCrossing", <IC2:itemIngot:0>);
vanilla.loot.removeChestLoot("villageBlacksmith", <IC2:itemIngot:0>);
vanilla.loot.addChestLoot("dungeonChest", <ThermalFoundation:material:64>.weight(100), 1, 5);
vanilla.loot.addChestLoot("mineshaftCorridor", <ThermalFoundation:material:64>.weight(9), 1, 6);
vanilla.loot.addChestLoot("pyramidDesertyChest", <ThermalFoundation:material:64>.weight(9), 1, 6);
vanilla.loot.addChestLoot("pyramidJungleChest", <ThermalFoundation:material:64>.weight(9), 1, 6);
vanilla.loot.addChestLoot("strongholdCorridor", <ThermalFoundation:material:64>.weight(9), 1, 6);
vanilla.loot.addChestLoot("strongholdCrossing", <ThermalFoundation:material:64>.weight(9), 1, 6);
vanilla.loot.addChestLoot("villageBlacksmith", <ThermalFoundation:material:64>.weight(9), 1, 6);

// tin ingots
vanilla.loot.removeChestLoot("dungeonChest", <IC2:itemIngot:1>);
vanilla.loot.removeChestLoot("mineshaftCorridor", <IC2:itemIngot:1>);
vanilla.loot.removeChestLoot("pyramidDesertyChest", <IC2:itemIngot:1>);
vanilla.loot.removeChestLoot("pyramidJungleChest", <IC2:itemIngot:1>);
vanilla.loot.removeChestLoot("strongholdCorridor", <IC2:itemIngot:1>);
vanilla.loot.removeChestLoot("strongholdCrossing", <IC2:itemIngot:1>);
vanilla.loot.removeChestLoot("villageBlacksmith", <IC2:itemIngot:1>);
vanilla.loot.addChestLoot("dungeonChest", <ThermalFoundation:material:65>.weight(100), 1, 5);
vanilla.loot.addChestLoot("mineshaftCorridor", <ThermalFoundation:material:65>.weight(8), 1, 5);
vanilla.loot.addChestLoot("pyramidDesertyChest", <ThermalFoundation:material:65>.weight(8), 1, 5);
vanilla.loot.addChestLoot("pyramidJungleChest", <ThermalFoundation:material:65>.weight(8), 1, 5);
vanilla.loot.addChestLoot("strongholdCorridor", <ThermalFoundation:material:65>.weight(8), 1, 5);
vanilla.loot.addChestLoot("strongholdCrossing", <ThermalFoundation:material:65>.weight(8), 1, 5);
vanilla.loot.addChestLoot("villageBlacksmith", <ThermalFoundation:material:65>.weight(8), 1, 5);

// bronze ingots
vanilla.loot.removeChestLoot("villageBlacksmith", <IC2:itemIngot:2>);
vanilla.loot.addChestLoot("villageBlacksmith", <TConstruct:materials:13>.weight(5), 2, 4);

// bop saplings

function addSaplingLoot(sapling as IItemStack) {
    vanilla.loot.addChestLoot("dungeonChest", sapling.weight(4), 1, 3);
    vanilla.loot.addChestLoot("mineshaftCorridor", sapling.weight(4), 1, 3);
    vanilla.loot.addChestLoot("pyramidJungleChest", sapling.weight(4), 1, 3);
    vanilla.loot.addChestLoot("strongholdCorridor", sapling.weight(4), 1, 3);
    vanilla.loot.addChestLoot("strongholdCrossing", sapling.weight(4), 1, 3);
    vanilla.loot.addChestLoot("villageBlacksmith", sapling.weight(4), 1, 3);
}

// no apple trees (use growthcraft)
//addSaplingLoot(<BiomesOPlenty:saplings:0>);
addSaplingLoot(<BiomesOPlenty:saplings:1>);
addSaplingLoot(<BiomesOPlenty:saplings:2>);
addSaplingLoot(<BiomesOPlenty:saplings:3>);
// no willow saplines (find in wetlands)
//addSaplingLoot(<BiomesOPlenty:saplings:4>);
// no dying saplings
//addSaplingLoot(<BiomesOPlenty:saplings:5>);
addSaplingLoot(<BiomesOPlenty:saplings:7>);
addSaplingLoot(<BiomesOPlenty:saplings:8>);
addSaplingLoot(<BiomesOPlenty:saplings:9>);
// no cherry saplings (find in cherry grove)
//addSaplingLoot(<BiomesOPlenty:saplings:10>);
// no maple saplings (find in maple woods)
addSaplingLoot(<BiomesOPlenty:saplings:11>);
// no cherry saplings (find in cherry grove)
//addSaplingLoot(<BiomesOPlenty:saplings:12>);
addSaplingLoot(<BiomesOPlenty:saplings:13>);
addSaplingLoot(<BiomesOPlenty:saplings:14>);
addSaplingLoot(<BiomesOPlenty:saplings:15>);
// no sacred oak saplings (find in sacred springs)
//addSaplingLoot(<BiomesOPlenty:colorizedSaplings:0>);
addSaplingLoot(<BiomesOPlenty:colorizedSaplings:1>);
addSaplingLoot(<BiomesOPlenty:colorizedSaplings:2>);
addSaplingLoot(<BiomesOPlenty:colorizedSaplings:3>);
addSaplingLoot(<BiomesOPlenty:colorizedSaplings:4>);
// no pine saplines (find in canyon)
//addSaplingLoot(<BiomesOPlenty:colorizedSaplings:5>);
addSaplingLoot(<BiomesOPlenty:colorizedSaplings:6>);
