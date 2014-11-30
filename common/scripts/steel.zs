val realNugget = <Railcraft:nugget:1>;
val realIngot = <Railcraft:ingot:0>;
val realBlock = <TConstruct:MetalBlock:9>;
val liquid = <liquid:steel.molten>;

// ingot -> nugget recipe
recipes.removeShaped(<ore:nuggetSteel> * 9, [[<ore:ingotSteel>]]);
recipes.removeShapeless(<ore:nuggetSteel> * 9, [<ore:ingotSteel>]);
recipes.addShapeless(realNugget * 9, [<ore:ingotSteel>]);

// nugget -> ingot recipe
recipes.removeShaped(<ore:ingotSteel>, [
    [<ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>],
    [<ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>],
    [<ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>]
]);
recipes.removeShapeless(<ore:ingotSteel>, [
    <ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>,
    <ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>,
    <ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>
]);
recipes.addShapeless(realIngot, [
    <ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>,
    <ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>,
    <ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>
]);

// block -> ingot recipe
recipes.removeShaped(<ore:ingotSteel> * 9, [[<ore:blockSteel>]]);
recipes.removeShapeless(<ore:ingotSteel> * 9, [<ore:blockSteel>]);
recipes.addShapeless(realIngot * 9, [<ore:blockSteel>]);

// ingot -> block recipe
recipes.removeShaped(<ore:blockSteel>, [
    [<ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>],
    [<ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>],
    [<ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>]
]);
recipes.removeShapeless(<ore:blockSteel>, [
    <ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>,
    <ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>,
    <ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>
]);
recipes.addShapeless(realBlock, [
    <ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>,
    <ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>,
    <ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>
]);

// smelting
furnace.remove(<ore:ingotSteel>, <ore:dustSteel>);
furnace.addRecipe(realIngot, <ore:dustSteel>);

// industrialcraft
<ore:ingotSteel>.remove(<IC2:itemIngot:3>);

// mariculture
mods.mariculture.Casting.addNuggetRecipe(liquid * 16, realNugget);
mods.mariculture.Casting.addIngotRecipe(liquid * 144, realIngot);
mods.mariculture.Casting.addBlockRecipe(liquid * 1296, realBlock);

// mekanism
mods.mekanism.Infuser.removeRecipe(<Mekanism:EnrichedIron:0>);
for item in <ore:dustSteel>.items {
    mods.mekanism.Infuser.removeRecipe(item);
}

// railcraft
mods.railcraft.BlastFurnace.removeRecipe(<Railcraft:tile.railcraft.cube:2>);
mods.railcraft.BlastFurnace.addRecipe(<minecraft:iron_block:0>, false, false, 11520, realBlock);

// tinker's construct
mods.tconstruct.Casting.removeTableRecipe(<IC2:itemIngot:3>);
mods.tconstruct.Casting.removeBasinRecipe(<IC2:blockMetal:5>);
mods.tconstruct.Casting.addTableRecipe(realIngot * 1, liquid * 144, <TConstruct:metalPattern>, false, 20);
mods.tconstruct.Casting.addBasinRecipe(realBlock * 1, liquid * 1296, null, false, 20);

// thermal expansion
for item in <ore:dustSteel>.items {
    mods.thermalexpansion.Furnace.removeRecipe(item);
    mods.thermalexpansion.Furnace.addRecipe(1000, item, realIngot);
}

// tinker's steelworks high oven controller
recipes.remove(<TSteelworks:HighOven:0>);
recipes.addShaped(<TSteelworks:HighOven:0>, [
    [<TSteelworks:Materials:0>, <TSteelworks:Materials:0>, <TSteelworks:Materials:0>],
    [<TSteelworks:Materials:0>, <minecraft:blaze_rod:0>, <TSteelworks:Materials:0>],
    [<TSteelworks:Materials:0>, <TSteelworks:Materials:0>, <TSteelworks:Materials:0>],
]);
