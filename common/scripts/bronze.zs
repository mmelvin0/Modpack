val realNugget = <TConstruct:materials:31>;
val realIngot = <TConstruct:materials:13>;
val realBlock = <TConstruct:MetalBlock:4>;
val liquid = <liquid:bronze.molten>;

// ingot -> nugget recipe
recipes.removeShaped(<ore:nuggetBronze> * 9, [[<ore:ingotBronze>]]);
recipes.removeShapeless(<ore:nuggetBronze> * 9, [<ore:ingotBronze>]);
recipes.addShapeless(realNugget * 9, [<ore:ingotBronze>]);

// nugget -> ingot recipe
recipes.removeShaped(<ore:ingotBronze>, [
    [<ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>],
    [<ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>],
    [<ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>]
]);
recipes.removeShapeless(<ore:ingotBronze>, [
    <ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>,
    <ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>,
    <ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>
]);
recipes.addShapeless(realIngot, [
    <ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>,
    <ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>,
    <ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>
]);

// block -> ingot recipe
recipes.removeShaped(<ore:ingotBronze> * 9, [[<ore:blockBronze>]]);
recipes.removeShapeless(<ore:ingotBronze> * 9, [<ore:blockBronze>]);
recipes.addShapeless(realIngot * 9, [<ore:blockBronze>]);

// ingot -> block recipe
recipes.removeShaped(<ore:blockBronze>, [
    [<ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>],
    [<ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>],
    [<ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>]
]);
recipes.removeShapeless(<ore:blockBronze>, [
    <ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>,
    <ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>,
    <ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>
]);
recipes.addShapeless(realBlock, [
    <ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>,
    <ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>,
    <ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>
]);

// smelting
furnace.remove(<ore:ingotBronze>, <ore:dustBronze>);
furnace.addRecipe(realIngot, <ore:dustBronze>);

// mariculture
mods.mariculture.Casting.addNuggetRecipe(liquid * 16, realNugget);
mods.mariculture.Casting.addIngotRecipe(liquid * 144, realIngot);
mods.mariculture.Casting.addBlockRecipe(liquid * 1296, realBlock);

// tinker's construct
mods.tconstruct.Casting.removeTableRecipe(<IC2:itemIngot:2>);
mods.tconstruct.Casting.removeBasinRecipe(<IC2:blockMetal:2>);
mods.tconstruct.Casting.addTableRecipe(realIngot * 1, liquid * 144, <TConstruct:metalPattern>, false, 20);
mods.tconstruct.Casting.addBasinRecipe(realBlock * 1, liquid * 1296, null, false, 20);

// thermal expansion
for item in <ore:dustBronze>.items {
    mods.thermalexpansion.Furnace.removeRecipe(item);
    mods.thermalexpansion.Furnace.addRecipe(1000, item, realIngot);
}
recipes.remove(<ThermalFoundation:material:41>);
for item in <ore:ingotBronze>.items {
    mods.thermalexpansion.Pulverizer.removeRecipe(item);
    mods.thermalexpansion.Pulverizer.addRecipe(2400, item, <IC2:itemDust:0>);
}
for dust in <ore:dustBronze>.items {
    for sand in <ore:blockSand>.items {
        mods.thermalexpansion.Smelter.removeRecipe(dust, sand);
        mods.thermalexpansion.Smelter.addRecipe(800, dust, sand, realIngot, <ThermalExpansion:material:514>, 25);
    }
}
for tin in <ore:dustTin>.items {
    for copper in <ore:dustCopper>.items {
        mods.thermalexpansion.Smelter.removeRecipe(tin, copper * 3);
        mods.thermalexpansion.Smelter.addRecipe(1600, tin, copper * 3, realIngot * 4);
    }
}
for tin in <ore:ingotTin>.items {
    for copper in <ore:ingotCopper>.items {
        mods.thermalexpansion.Smelter.removeRecipe(tin, copper * 3);
        mods.thermalexpansion.Smelter.addRecipe(2400, tin, copper * 3, realIngot * 4);
    }
}
