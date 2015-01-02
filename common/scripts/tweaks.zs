import minetweaker.data.IData;
import minetweaker.item.IIngredient;
import minetweaker.item.IItemStack;
import minetweaker.liquid.ILiquidStack;
import minetweaker.oredict.IOreDictEntry;
import mods.nei.NEI;


  ///////////////
 // CONSTANTS //
///////////////

val COPPER_NUGGET = <Thaumcraft:ItemNugget:1>;
val COPPER_INGOT = <ThermalFoundation:material:64>;
val COPPER_BLOCK = <TConstruct:MetalBlock:3>;
val TIN_NUGGET = <Thaumcraft:ItemNugget:2>;
val TIN_INGOT = <ThermalFoundation:material:65>;
val TIN_BLOCK = <TConstruct:MetalBlock:5>;
val IRON_NUGGET = <Thaumcraft:ItemNugget:0>;
val IRON_INGOT = <minecraft:iron_ingot:0>;
val IRON_BLOCK = <minecraft:iron_block:0>;
val SILVER_NUGGET = <Thaumcraft:ItemNugget:3>;
val SILVER_INGOT = <ThermalFoundation:material:66>;
val SILVER_BLOCK = <ThermalFoundation:Storage:2>;
val GOLD_NUGGET = <minecraft:gold_nugget:0>;
val GOLD_INGOT = <minecraft:gold_ingot:0>;
val GOLD_BLOCK = <minecraft:gold_block:0>;
val LEAD_NUGGET = <Thaumcraft:ItemNugget:4>;
val LEAD_INGOT = <ThermalFoundation:material:67>;
val LEAD_BLOCK = <Railcraft:tile.railcraft.cube:11>;
val NICKEL_NUGGET = <ThermalFoundation:material:100>;
val NICKEL_INGOT = <ThermalFoundation:material:68>;
val NICKEL_BLOCK = <ThermalFoundation:Storage:4>;
val ALUMINIUM_NUGGET = <TConstruct:materials:22>;
val ALUMINIUM_INGOT = <TConstruct:materials:11>;
val ALUMINIUM_BLOCK = <TConstruct:MetalBlock:6>;
val RUTILE_NUGGET = <Mariculture:materials:37>;
val RUTILE_INGOT = <Mariculture:materials:3>;
val RUTILE_BLOCK = <Mariculture:metals:2>;
val COBALT_NUGGET = <TConstruct:materials:28>;
val COBALT_INGOT = <TConstruct:materials:3>;
val COBALT_BLOCK = <TConstruct:MetalBlock:0>;
val ARDITE_NUGGET = <TConstruct:materials:29>;
val ARDITE_INGOT = <TConstruct:materials:4>;
val ARDITE_BLOCK = <TConstruct:MetalBlock:1>;
val BRONZE_NUGGET = <TConstruct:materials:31>;
val BRONZE_INGOT = <TConstruct:materials:13>;
val BRONZE_BLOCK = <TConstruct:MetalBlock:4>;
val BRONZE_MOLTEN = <liquid:bronze.molten>;
val STEEL_NUGGET = <Railcraft:nugget:1>;
val STEEL_INGOT = <Railcraft:ingot:0>;
val STEEL_BLOCK = <TConstruct:MetalBlock:9>;
val STEEL_MOLTEN = <liquid:steel.molten>;


  ///////////////
 // FUNCTIONS //
///////////////

function unifyMetal(ore as IIngredient, oreNugget as IIngredient, oreIngot as IIngredient, oreBlock as IIngredient, oreCluster as IIngredient, oreDust as IIngredient, oreCrushed as IIngredient, oreCrushedPurified as IIngredient, liquid as ILiquidStack, realNugget as IItemStack, realIngot as IItemStack, realBlock as IItemStack, banIngots as IItemStack[], banBlocks as IItemStack[], xp as float) {
    // ingot -> nugget recipe
    recipes.removeShaped(oreNugget * 9, [[oreIngot]]);
    recipes.removeShapeless(oreNugget * 9, [oreIngot]);
    recipes.addShapeless(realNugget * 9, [oreIngot]);

    // nugget -> ingot recipe
    recipes.removeShaped(oreIngot, [
        [oreNugget, oreNugget, oreNugget],
        [oreNugget, oreNugget, oreNugget],
        [oreNugget, oreNugget, oreNugget]
    ]);
    recipes.removeShapeless(oreIngot, [
        oreNugget, oreNugget, oreNugget,
        oreNugget, oreNugget, oreNugget,
        oreNugget, oreNugget, oreNugget
    ]);
    recipes.addShapeless(realIngot, [
        oreNugget, oreNugget, oreNugget,
        oreNugget, oreNugget, oreNugget,
        oreNugget, oreNugget, oreNugget
    ]);

    // block -> ingot recipe
    recipes.removeShaped(oreIngot * 9, [[oreBlock]]);
    recipes.removeShapeless(oreIngot * 9, [oreBlock]);
    recipes.addShapeless(realIngot * 9, [oreBlock]);

    // ingot -> block recipe
    recipes.removeShaped(oreBlock, [
        [oreIngot, oreIngot, oreIngot],
        [oreIngot, oreIngot, oreIngot],
        [oreIngot, oreIngot, oreIngot]
    ]);
    recipes.removeShapeless(oreBlock, [
        oreIngot, oreIngot, oreIngot,
        oreIngot, oreIngot, oreIngot,
        oreIngot, oreIngot, oreIngot
    ]);
    recipes.addShapeless(realBlock, [
        oreIngot, oreIngot, oreIngot,
        oreIngot, oreIngot, oreIngot,
        oreIngot, oreIngot, oreIngot
    ]);

    // smelting
    furnace.remove(oreIngot);
    furnace.addRecipe(realIngot, ore, xp);
    furnace.addRecipe(realIngot, oreDust, xp);
    furnace.addRecipe(realIngot, oreCrushed, xp);
    furnace.addRecipe(realIngot, oreCrushedPurified, xp);
    furnace.addRecipe(realIngot * 2, oreCluster, xp);

    // mariculture
    mods.mariculture.Casting.addNuggetRecipe(liquid * 16, realNugget);
    mods.mariculture.Casting.addIngotRecipe(liquid * 144, realIngot);
    mods.mariculture.Casting.addBlockRecipe(liquid * 1296, realBlock);
    for item in oreCrushed.items {
        mods.mariculture.Crucible.addRecipe(1085, item, liquid * 144);
    }
    for item in oreCrushedPurified.items {
        mods.mariculture.Crucible.addRecipe(1085, item, liquid * 144);
    }
    for item in oreCluster.items {
        mods.mariculture.Crucible.addRecipe(1085, item, liquid * 144 * 2);
    }

    // tinker's construct
    for item in banIngots {
        mods.tconstruct.Casting.removeTableRecipe(item);
    }
    for item in banBlocks {
        mods.tconstruct.Casting.removeBasinRecipe(item);
    }
    mods.tconstruct.Casting.addTableRecipe(realIngot * 1, liquid * 144, <TConstruct:metalPattern>, false, 80);
    mods.tconstruct.Casting.addBasinRecipe(realBlock * 1, liquid * 1296, null, false, 100);
    for item in oreCrushed.items {
        mods.tconstruct.Smeltery.addMelting(item, liquid * 144, 200, realBlock);
    }
    for item in oreCrushedPurified.items {
        mods.tconstruct.Smeltery.addMelting(item, liquid * 144, 200, realBlock);
    }
    for item in oreCluster.items {
        mods.tconstruct.Smeltery.addMelting(item, liquid * 144 * 2, 200, realBlock);
    }
}

function unifyDusts(crushed as IIngredient, purified as IIngredient, cluster as IIngredient, ingot as IItemStack) {
    for item in crushed.items {
        mods.thermalexpansion.Furnace.removeRecipe(item);
        mods.thermalexpansion.Furnace.addRecipe(1600, item, ingot);
    }
    for item in purified.items {
        mods.thermalexpansion.Furnace.removeRecipe(item);
        mods.thermalexpansion.Furnace.addRecipe(1600, item, ingot);
    }
    for item in cluster.items {
        mods.thermalexpansion.Furnace.removeRecipe(item);
        mods.thermalexpansion.Furnace.addRecipe(1600, item, ingot * 2);
    }
}

function purgeBerries(berries as IIngredient, nuggets as IOreDictEntry) {
    furnace.remove(nuggets, berries);
    for item in berries.items {
        nuggets.remove(item);
        mods.mariculture.Crucible.removeRecipe(item);
        mods.tconstruct.Smeltery.removeMelting(item);
        mods.thermalexpansion.Furnace.removeRecipe(item);
    }
}

function fixRailcraftSlabsAndStairs(block as IItemStack, slab as IItemStack, stair as IItemStack) {
    recipes.remove(slab);
    recipes.addShaped(slab * 6, [
        [block, block, block],
        [null, null, null],
        [null, null, null]
    ]);
    recipes.remove(stair);
    recipes.addShaped(stair * 4, [
        [block, null, null],
        [block, block, null],
        [block, block, block]
    ]);
    mods.railcraft.RockCrusher.removeRecipe(stair);
    mods.railcraft.RockCrusher.addRecipe(stair, false, false, [block], [1.0]);
}

function addSaplingLoot(sapling as IItemStack) {
    vanilla.loot.addChestLoot("dungeonChest", sapling.weight(4), 1, 3);
    vanilla.loot.addChestLoot("mineshaftCorridor", sapling.weight(4), 1, 3);
    vanilla.loot.addChestLoot("pyramidJungleChest", sapling.weight(4), 1, 3);
    vanilla.loot.addChestLoot("strongholdCorridor", sapling.weight(4), 1, 3);
    vanilla.loot.addChestLoot("strongholdCrossing", sapling.weight(4), 1, 3);
    vanilla.loot.addChestLoot("villageBlacksmith", sapling.weight(4), 1, 3);
}

  ////////////
 // METALS //
////////////

// copper
unifyMetal(<ore:oreCopper>, <ore:nuggetCopper>, <ore:ingotCopper>, <ore:blockCopper>, <ore:clusterCopper>, <ore:dustCopper>, <ore:crushedCopper>, <ore:crushedPurifiedCopper>, <liquid:copper.molten>, COPPER_NUGGET, COPPER_INGOT, COPPER_BLOCK, [<IC2:itemIngot:0>], [<IC2:blockMetal:0>], 0.7);
unifyDusts(<ore:crushedCopper>, <ore:crushedPurifiedCopper>, <ore:clusterCopper>, COPPER_INGOT);
purgeBerries(<ore:oreberryCopper>, <ore:nuggetCopper>);

// tin
unifyMetal(<ore:oreTin>, <ore:nuggetTin>, <ore:ingotTin>, <ore:blockTin>, <ore:clusterTin>, <ore:dustTin>, <ore:crushedTin>, <ore:crushedPurifiedTin>, <liquid:tin.molten>, TIN_NUGGET, TIN_INGOT, TIN_BLOCK, [<IC2:itemIngot:1>], [<IC2:blockMetal:1>], 0.7);
unifyDusts(<ore:crushedTin>, <ore:crushedPurifiedTin>, <ore:clusterTin>, TIN_INGOT);
purgeBerries(<ore:oreberryTin>, <ore:nuggetTin>);

// iron
unifyMetal(<ore:oreIron>, <ore:nuggetIron>, <ore:ingotIron>, <ore:blockIron>, <ore:clusterIron>, <ore:dustIron>, <ore:crushedIron>, <ore:crushedPurifiedIron>, <liquid:iron.molten>, IRON_NUGGET, IRON_INGOT, IRON_BLOCK, [], [], 0.7);
purgeBerries(<ore:oreberryIron>, <ore:nuggetIron>);

// silver
unifyMetal(<ore:oreSilver>, <ore:nuggetSilver>, <ore:ingotSilver>, <ore:blockSilver>, <ore:clusterSilver>, <ore:dustSilver>, <ore:crushedSilver>, <ore:crushedPurifiedSilver>, <liquid:silver.molten>, SILVER_NUGGET, SILVER_INGOT, SILVER_BLOCK, [<IC2:itemIngot:6>], [], 1.0);
unifyDusts(<ore:crushedSilver>, <ore:crushedPurifiedSilver>, <ore:clusterSilver>, SILVER_INGOT);

// gold
unifyMetal(<ore:oreGold>, <ore:nuggetGold>, <ore:ingotGold>, <ore:blockGold>, <ore:clusterGold>, <ore:dustGold>, <ore:crushedGold>, <ore:crushedPurifiedGold>, <liquid:gold.molten>, GOLD_NUGGET, GOLD_INGOT, GOLD_BLOCK, [], [], 1.0);
// hack: apparently gold oreberries aren't actually oreberries?
<ore:oreberryGold>.add(<TConstruct:oreBerries:1>);
purgeBerries(<ore:oreberryGold>, <ore:nuggetGold>);

// lead
unifyMetal(<ore:oreLead>, <ore:nuggetLead>, <ore:ingotLead>, <ore:blockLead>, <ore:clusterLead>, <ore:dustLead>, <ore:crushedLead>, <ore:crushedPurifiedLead>, <liquid:lead.molten>, LEAD_NUGGET, LEAD_INGOT, LEAD_BLOCK, [<IC2:itemIngot:5>], [<IC2:blockMetal:4>], 0.7);
unifyDusts(<ore:crushedLead>, <ore:crushedPurifiedLead>, <ore:clusterLead>, LEAD_INGOT);

// nickel (ferrous metal)
unifyMetal(<ore:oreNickel>, <ore:nuggetNickel>, <ore:ingotNickel>, <ore:blockNickel>, <ore:clusterNickel>, <ore:dustNickel>, <ore:crushedNickel>, <ore:crushedPurifiedNickel>, <liquid:nickel.molten>, NICKEL_NUGGET, NICKEL_INGOT, NICKEL_BLOCK, [], [], 0.7);

// aluminium
// make sure things called "aluminum" also count as "aluminium"
<ore:oreAluminium>.addAll(<ore:oreAluminum>);
<ore:nuggetAluminium>.addAll(<ore:nuggetAluminum>);
<ore:ingotAluminium>.addAll(<ore:ingotAluminum>);
<ore:blockAluminium>.addAll(<ore:blockAluminum>);
unifyMetal(<ore:oreAluminium>, <ore:nuggetAluminium>, <ore:ingotAluminium>, <ore:blockAluminium>, <ore:clusterAluminium>, <ore:dustAluminium>, <ore:crushedAluminium>, <ore:crushedPurifiedAluminium>, <liquid:aluminum.molten>, ALUMINIUM_NUGGET, ALUMINIUM_INGOT, ALUMINIUM_BLOCK, [], [], 0.7);
// this removal gets stuck
//for item in <ore:oreAluminium>.items {
//    mods.thermalexpansion.Furnace.removeRecipe(item);
//    mods.thermalexpansion.Furnace.addRecipe(1600, item, ALUMINIUM_INGOT);
//}
purgeBerries(<ore:oreberryAluminium>, <ore:nuggetAluminium>);
recipes.remove(<GalacticraftCore:tile.gcBlockCore:11>);

// rutile (impure titantium)
unifyMetal(<ore:oreRutile>, <ore:nuggetRutile>, <ore:ingotRutile>, <ore:blockRutile>, <ore:clusterRutile>, <ore:dustRutile>, <ore:crushedRutile>, <ore:crushedPurifiedRutile>, <liquid:rutile.molten>, RUTILE_NUGGET, RUTILE_INGOT, RUTILE_BLOCK, [], [], 0.7);

// cobalt
unifyMetal(<ore:oreCobalt>, <ore:nuggetCobalt>, <ore:ingotCobalt>, <ore:blockCobalt>, <ore:clusterCobalt>, <ore:dustCobalt>, <ore:crushedCobalt>, <ore:crushedPurifiedCobalt>, <liquid:cobalt.molten>, COBALT_NUGGET, COBALT_INGOT, COBALT_BLOCK, [], [], 0.7);

// ardite
unifyMetal(<ore:oreArdite>, <ore:nuggetArdite>, <ore:ingotArdite>, <ore:blockArdite>, <ore:clusterArdite>, <ore:dustArdite>, <ore:crushedArdite>, <ore:crushedPurifiedArdite>, <liquid:ardite.molten>, ARDITE_NUGGET, ARDITE_INGOT, ARDITE_BLOCK, [], [], 0.7);


  ////////////
 // BRONZE //
////////////

// ingot -> nugget recipe
recipes.removeShaped(<ore:nuggetBronze> * 9, [[<ore:ingotBronze>]]);
recipes.removeShapeless(<ore:nuggetBronze> * 9, [<ore:ingotBronze>]);
recipes.addShapeless(BRONZE_NUGGET * 9, [<ore:ingotBronze>]);

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
recipes.addShapeless(BRONZE_INGOT, [
    <ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>,
    <ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>,
    <ore:nuggetBronze>, <ore:nuggetBronze>, <ore:nuggetBronze>
]);

// block -> ingot recipe
recipes.removeShaped(<ore:ingotBronze> * 9, [[<ore:blockBronze>]]);
recipes.removeShapeless(<ore:ingotBronze> * 9, [<ore:blockBronze>]);
recipes.addShapeless(BRONZE_INGOT * 9, [<ore:blockBronze>]);

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
recipes.addShapeless(BRONZE_BLOCK, [
    <ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>,
    <ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>,
    <ore:ingotBronze>, <ore:ingotBronze>, <ore:ingotBronze>
]);

// smelting
furnace.remove(<ore:ingotBronze>, <ore:dustBronze>);
furnace.addRecipe(BRONZE_INGOT, <ore:dustBronze>, 0.7);

// mariculture
mods.mariculture.Casting.addNuggetRecipe(BRONZE_MOLTEN * 16, BRONZE_NUGGET);
mods.mariculture.Casting.addIngotRecipe(BRONZE_MOLTEN * 144, BRONZE_INGOT);
mods.mariculture.Casting.addBlockRecipe(BRONZE_MOLTEN * 1296, BRONZE_BLOCK);

// tinker's construct
mods.tconstruct.Casting.removeTableRecipe(<IC2:itemIngot:2>);
mods.tconstruct.Casting.removeBasinRecipe(<IC2:blockMetal:2>);
mods.tconstruct.Casting.addTableRecipe(BRONZE_INGOT * 1, BRONZE_MOLTEN * 144, <TConstruct:metalPattern>, false, 80);
mods.tconstruct.Casting.addBasinRecipe(BRONZE_BLOCK * 1, BRONZE_MOLTEN * 1296, null, false, 100);

// thermal expansion
for item in <ore:dustBronze>.items {
    mods.thermalexpansion.Furnace.removeRecipe(item);
    mods.thermalexpansion.Furnace.addRecipe(1000, item, BRONZE_INGOT);
}
recipes.remove(<ThermalFoundation:material:41>);
for item in <ore:ingotBronze>.items {
    mods.thermalexpansion.Pulverizer.removeRecipe(item);
    mods.thermalexpansion.Pulverizer.addRecipe(2400, item, <IC2:itemDust:0>);
}
for dust in <ore:dustBronze>.items {
    for sand in <ore:blockSand>.items {
        mods.thermalexpansion.Smelter.removeRecipe(dust, sand);
        mods.thermalexpansion.Smelter.addRecipe(800, dust, sand, BRONZE_INGOT, <ThermalExpansion:material:514>, 25);
    }
}
for tin in <ore:dustTin>.items {
    for copper in <ore:dustCopper>.items {
        mods.thermalexpansion.Smelter.removeRecipe(tin, copper * 3);
        mods.thermalexpansion.Smelter.addRecipe(1600, tin, copper * 3, BRONZE_INGOT * 4);
    }
}
for tin in <ore:ingotTin>.items {
    for copper in <ore:ingotCopper>.items {
        mods.thermalexpansion.Smelter.removeRecipe(tin, copper * 3);
        mods.thermalexpansion.Smelter.addRecipe(2400, tin, copper * 3, BRONZE_INGOT * 4);
    }
}


  ///////////
 // STEEL //
///////////

// ingot -> nugget recipe
recipes.removeShaped(<ore:nuggetSteel> * 9, [[<ore:ingotSteel>]]);
recipes.removeShapeless(<ore:nuggetSteel> * 9, [<ore:ingotSteel>]);
recipes.addShapeless(STEEL_NUGGET * 9, [<ore:ingotSteel>]);

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
recipes.addShapeless(STEEL_INGOT, [
    <ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>,
    <ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>,
    <ore:nuggetSteel>, <ore:nuggetSteel>, <ore:nuggetSteel>
]);

// block -> ingot recipe
recipes.removeShaped(<ore:ingotSteel> * 9, [[<ore:blockSteel>]]);
recipes.removeShapeless(<ore:ingotSteel> * 9, [<ore:blockSteel>]);
recipes.addShapeless(STEEL_INGOT * 9, [<ore:blockSteel>]);

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
recipes.addShapeless(STEEL_BLOCK, [
    <ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>,
    <ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>,
    <ore:ingotSteel>, <ore:ingotSteel>, <ore:ingotSteel>
]);

// smelting
furnace.remove(<ore:ingotSteel>, <ore:dustSteel>);
furnace.addRecipe(STEEL_INGOT, <ore:dustSteel>);

// industrialcraft
<ore:ingotSteel>.remove(<IC2:itemIngot:3>);

// mariculture
mods.mariculture.Casting.addNuggetRecipe(STEEL_MOLTEN * 16, STEEL_NUGGET);
mods.mariculture.Casting.addIngotRecipe(STEEL_MOLTEN * 144, STEEL_INGOT);
mods.mariculture.Casting.addBlockRecipe(STEEL_MOLTEN * 1296, STEEL_BLOCK);

// mekanism
mods.mekanism.Infuser.removeRecipe(<Mekanism:EnrichedIron:0>);
for item in <ore:dustSteel>.items {
    mods.mekanism.Infuser.removeRecipe(item);
}

// railcraft
mods.railcraft.BlastFurnace.removeRecipe(<Railcraft:tile.railcraft.cube:2>);
mods.railcraft.BlastFurnace.addRecipe(<minecraft:iron_block:0>, false, false, 11520, STEEL_BLOCK);

// tinker's construct
mods.tconstruct.Casting.removeTableRecipe(<IC2:itemIngot:3>);
mods.tconstruct.Casting.removeBasinRecipe(<IC2:blockMetal:5>);
mods.tconstruct.Casting.addTableRecipe(STEEL_INGOT * 1, STEEL_MOLTEN * 144, <TConstruct:metalPattern>, false, 80);
mods.tconstruct.Casting.addBasinRecipe(STEEL_BLOCK * 1, STEEL_MOLTEN * 1296, null, false, 100);

// thermal expansion
for item in <ore:dustSteel>.items {
    mods.thermalexpansion.Furnace.removeRecipe(item);
    mods.thermalexpansion.Furnace.addRecipe(1000, item, STEEL_INGOT);
}

// tinker's steelworks high oven controller
recipes.remove(<TSteelworks:HighOven:0>);
recipes.addShaped(<TSteelworks:HighOven:0>, [
    [<TSteelworks:Materials:0>, <TSteelworks:Materials:0>, <TSteelworks:Materials:0>],
    [<TSteelworks:Materials:0>, <minecraft:blaze_rod:0>, <TSteelworks:Materials:0>],
    [<TSteelworks:Materials:0>, <TSteelworks:Materials:0>, <TSteelworks:Materials:0>],
]);


  //////////
 // LOOT //
//////////

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

// biomes o plenty saplings
// no apple trees (use growthcraft)
//addSaplingLoot(<BiomesOPlenty:saplings:0>);
addSaplingLoot(<BiomesOPlenty:saplings:1>);
addSaplingLoot(<BiomesOPlenty:saplings:2>);
addSaplingLoot(<BiomesOPlenty:saplings:3>);
// no willow saplings (find in wetlands)
//addSaplingLoot(<BiomesOPlenty:saplings:4>);
// no dying saplings
//addSaplingLoot(<BiomesOPlenty:saplings:5>);
// no mahgonay saplings (find in tropical rainforest)
//addSaplingLoot(<BiomesOPlenty:saplings:6>);
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
// no pine saplings (find in canyon)
//addSaplingLoot(<BiomesOPlenty:colorizedSaplings:5>);
addSaplingLoot(<BiomesOPlenty:colorizedSaplings:6>);


  ///////////////
 // RAILCRAFT //
///////////////

fixRailcraftSlabsAndStairs(COPPER_BLOCK, <Railcraft:tile.railcraft.slab:39>, <Railcraft:tile.railcraft.stair:39>);
fixRailcraftSlabsAndStairs(TIN_BLOCK, <Railcraft:tile.railcraft.slab:40>, <Railcraft:tile.railcraft.stair:40>);
fixRailcraftSlabsAndStairs(STEEL_BLOCK, <Railcraft:tile.railcraft.slab:42>, <Railcraft:tile.railcraft.stair:42>);


  ////////////
 // CHISEL //
////////////

// disable chisel cloud in a bottle
recipes.remove(<chisel:cloudinabottle:0>);
NEI.hide(<chisel:cloudinabottle:0>);

// disable chisel concrete
furnace.remove(<chisel:concrete:*>);
for item in <ore:gravel>.items {
    mods.thermalexpansion.Furnace.removeRecipe(item);
}
NEI.hide(<chisel:concrete:*>);


  /////////
 // NEI //
/////////

// oreberries
NEI.hide(<TConstruct:ore.berries.one:8>);
NEI.hide(<TConstruct:ore.berries.one:9>);
NEI.hide(<TConstruct:ore.berries.one:10>);
NEI.hide(<TConstruct:ore.berries.one:11>);
NEI.hide(<TConstruct:ore.berries.two:8>);
NEI.hide(<TConstruct:ore.berries.two:9>);
NEI.hide(<TConstruct:oreBerries:0>);
NEI.hide(<TConstruct:oreBerries:1>);
NEI.hide(<TConstruct:oreBerries:2>);
NEI.hide(<TConstruct:oreBerries:3>);
NEI.hide(<TConstruct:oreBerries:4>);
NEI.hide(<TConstruct:oreBerries:5>);

// gravel ore
NEI.hide(<TConstruct:GravelOre:0>);
NEI.hide(<TConstruct:GravelOre:1>);
NEI.hide(<TConstruct:GravelOre:2>);
NEI.hide(<TConstruct:GravelOre:3>);
NEI.hide(<TConstruct:GravelOre:4>);
NEI.hide(<TConstruct:GravelOre:5>);

// extra copper ores
NEI.hide(<Forestry:resources:1>);
NEI.hide(<GalacticraftCore:tile.gcBlockCore:5>);
NEI.hide(<IC2:blockOreCopper:0>);
NEI.hide(<Mariculture:rocks:1>);
NEI.hide(<Mekanism:OreBlock:1>);
NEI.hide(<Railcraft:tile.railcraft.ore:9>);
NEI.hide(<TConstruct:SearedBrick:3>);

// extra copper nuggets
NEI.hide(<Mariculture:materials:38>);
NEI.hide(<Railcraft:nugget:2>);
NEI.hide(<ThermalFoundation:material:96>);

// extra copper ingots
NEI.hide(<Forestry:ingotCopper:0>);
NEI.hide(<GalacticraftCore:item.basicItem:3>);
NEI.hide(<IC2:itemIngot:0>);
NEI.hide(<Mariculture:materials:4>);
NEI.hide(<Mekanism:Ingot:5>);
NEI.hide(<Railcraft:ingot:1>);
NEI.hide(<TConstruct:materials:9>);

// extra copper blocks
NEI.hide(<Forestry:resourceStorage:1>);
NEI.hide(<GalacticraftCore:tile.gcBlockCore:9>);
NEI.hide(<IC2:blockMetal:0>);
NEI.hide(<Mariculture:metals:0>);
NEI.hide(<Mekanism:BasicBlock:12>);
NEI.hide(<Railcraft:tile.railcraft.cube:9>);
NEI.hide(<ThermalFoundation:Storage:0>);

// extra tin ores
NEI.hide(<Forestry:resources:2>);
NEI.hide(<IC2:blockOreTin:0>);
NEI.hide(<Mekanism:OreBlock:2>);
NEI.hide(<Railcraft:tile.railcraft.ore:10>);
NEI.hide(<TConstruct:SearedBrick:4>);

// extra tin nuggets
NEI.hide(<Railcraft:nugget:3>);
NEI.hide(<ThermalFoundation:material:97>);

// extra tin ingots
NEI.hide(<Forestry:ingotTin:0>);
NEI.hide(<GalacticraftCore:item.basicItem:4>);
NEI.hide(<IC2:itemIngot:1>);
NEI.hide(<Mekanism:Ingot:6>);
NEI.hide(<Railcraft:ingot:2>);
NEI.hide(<TConstruct:materials:10>);

// extra tin blocks
NEI.hide(<Forestry:resourceStorage:2>);
NEI.hide(<Railcraft:tile.railcraft.cube:10>);
NEI.hide(<GalacticraftCore:tile.gcBlockCore:10>);
NEI.hide(<IC2:blockMetal:1>);
NEI.hide(<Mekanism:BasicBlock:13>);
NEI.hide(<ThermalFoundation:Storage:1>);

// extra iron nuggets
NEI.hide(<Mariculture:materials:33>);
NEI.hide(<OpenComputers:item:16>);
NEI.hide(<Railcraft:nugget:0>);
NEI.hide(<ThermalFoundation:material:8>);

// extra silver nuggets
NEI.hide(<ThermalFoundation:material:98>);

// extra silver ingots
NEI.hide(<IC2:itemIngot:6>);

// extra lead ores
NEI.hide(<IC2:blockOreLead:0>);
NEI.hide(<Railcraft:tile.railcraft.ore:11>);

// extra lead nuggets
NEI.hide(<Railcraft:nugget:4>);
NEI.hide(<ThermalFoundation:material:99>);

// extra lead ingots
NEI.hide(<IC2:itemIngot:5>);
NEI.hide(<Railcraft:ingot:3>);

// extra lead blocks
NEI.hide(<IC2:blockMetal:4>);
NEI.hide(<ThermalFoundation:Storage:3>);

// extra aluminum ores
NEI.hide(<GalacticraftCore:tile.gcBlockCore:7>);

// extra aluminum nuggets
NEI.hide(<Mariculture:materials:34>);

// extra aluminum ingots
NEI.hide(<GalacticraftCore:item.basicItem:5>);
NEI.hide(<Mariculture:materials:0>);

// extra aluminum blocks
NEI.hide(<GalacticraftCore:tile.gcBlockCore:11>);
NEI.hide(<Mariculture:metals:1>);

// uncraftable/obsolete/unnamed items
NEI.hide(<appliedenergistics2:tile.BlockCableBus:0>);
NEI.hide(<appliedenergistics2:tile.BlockMatrixFrame:0>);
NEI.hide(<appliedenergistics2:tile.BlockPaint:0>);
NEI.hide(<AWWayofTime:blockDemonChest:0>);
NEI.hide(<AWWayofTime:blockSchemSaver:0>);
NEI.hide(<AWWayofTime:bloodLight:0>);
NEI.hide(<AWWayofTime:demonPortalMain:0>);
NEI.hide(<AWWayofTime:itemBloodMagicBook:0>);
NEI.hide(<AWWayofTime:spectralBlock:0>);
NEI.hide(<AWWayofTime:spectralContainer:0>);
NEI.hide(<Botania:bifrost:0>);
NEI.hide(<Botania:buriedPetals:*>);
NEI.hide(<Botania:customBrick0SlabFull:0>);
NEI.hide(<Botania:customBrick1SlabFull:0>);
NEI.hide(<Botania:customBrick2SlabFull:0>);
NEI.hide(<Botania:customBrick3SlabFull:0>);
NEI.hide(<Botania:dreamwood0SlabFull:0>);
NEI.hide(<Botania:dreamwood1SlabFull:0>);
NEI.hide(<Botania:livingrock0SlabFull:0>);
NEI.hide(<Botania:livingrock1SlabFull:0>);
NEI.hide(<Botania:livingwood0SlabFull:0>);
NEI.hide(<Botania:livingwood1SlabFull:0>);
NEI.hide(<Botania:prismarine0SlabFull:0>);
NEI.hide(<Botania:prismarine1SlabFull:0>);
NEI.hide(<Botania:prismarine2SlabFull:0>);
NEI.hide(<Botania:quartzSlabBlazeFull:0>);
NEI.hide(<Botania:quartzSlabDarkFull:0>);
NEI.hide(<Botania:quartzSlabElfFull:0>);
NEI.hide(<Botania:quartzSlabLavenderFull:0>);
NEI.hide(<Botania:quartzSlabManaFull:0>);
NEI.hide(<Botania:quartzSlabRedFull:0>);
NEI.hide(<Botania:reedBlock0SlabFull:0>);
NEI.hide(<Botania:solidVine:0>);
NEI.hide(<Botania:thatch0SlabFull:0>);
NEI.hide(<BuildCraft|Builders:buildToolBlock:0>);
NEI.hide(<BuildCraft|Energy:blockRedPlasma:0>);
NEI.hide(<BuildCraft|Transport:pipeBlock:0>);
NEI.hide(<CarpentersBlocks:blockCarpentersBed:0>);
NEI.hide(<CarpentersBlocks:blockCarpentersDoor:0>);
NEI.hide(<CarpentersBlocks:blockCarpentersSlope:1>);
NEI.hide(<CarpentersBlocks:blockCarpentersSlope:2>);
NEI.hide(<CarpentersBlocks:blockCarpentersSlope:3>);
NEI.hide(<CarpentersBlocks:blockCarpentersSlope:4>);
NEI.hide(<EnderIO:blockCapacitorBank:0>);
NEI.hide(<EnderIO:blockCapacitorBank:1>);
NEI.hide(<EnderIO:blockLightNode:0>);
NEI.hide(<EnderZoo:enderZooIcon:0>);
NEI.hide(<extracells:fluid.item:0>);
NEI.hide(<funkylocomotion:frame2:0>);
NEI.hide(<funkylocomotion:frame3:0>);
NEI.hide(<funkylocomotion:frame4:0>);
NEI.hide(<funkylocomotion:moving:0>);
NEI.hide(<Growthcraft:grc.fenceRope:0>);
NEI.hide(<Growthcraft:grc.ropeBlock:0>);
NEI.hide(<Growthcraft|Cellar:grc.chievItemDummy:0>);
NEI.hide(<Growthcraft|Cellar:grc.fruitPresser:0>);
NEI.hide(<Growthcraft|Grapes:grc.grapeBlock:0>);
NEI.hide(<Growthcraft|Grapes:grc.grapeVine0:0>);
NEI.hide(<Growthcraft|Grapes:grc.grapeVine1:0>);
NEI.hide(<Growthcraft|Hops:grc.hopVine:0>);
NEI.hide(<Growthcraft|Rice:grc.paddyField:0>);
NEI.hide(<Growthcraft|Rice:grc.riceBlock:0>);
NEI.hide(<HardcoreEnderExpansion:biome_core:0>);
NEI.hide(<HardcoreEnderExpansion:corrupted_energy_high:0>);
NEI.hide(<HardcoreEnderExpansion:corrupted_energy_low:0>);
NEI.hide(<HardcoreEnderExpansion:death_flower_pot:0>);
NEI.hide(<HardcoreEnderExpansion:enderman_head_block:0>);
NEI.hide(<HardcoreEnderExpansion:enhanced_brewing_stand_block:0>);
NEI.hide(<HardcoreEnderExpansion:item_special_effects:0>);
NEI.hide(<HardcoreEnderExpansion:laser_beam:0>);
NEI.hide(<HardcoreEnderExpansion:temple_end_portal:0>);
NEI.hide(<HardcoreEnderExpansion:temple_end_portal:0>);
NEI.hide(<IC2:blockBarrel:0>);
NEI.hide(<IC2:blockCable:0>);
NEI.hide(<IC2:blockDoorAlloy:0>);
NEI.hide(<IC2:blockDynamite:0>);
NEI.hide(<IC2:blockDynamiteRemote:0>);
NEI.hide(<IC2:blockGenerator:4>);
NEI.hide(<IC2:blockLuminator:0>);
NEI.hide(<IC2:blockWall:*>);
NEI.hide(<Mantle:mantleBook:0>);
NEI.hide(<PneumaticCraft:etchingAcid:0>);
NEI.hide(<ProjRed|Illumination:projectred.illumination.airousLight:0>);
NEI.hide(<statues:statues.showcase:0>);
NEI.hide(<statues:statues.statue:0>);
NEI.hide(<StevesCarts:ModularCart:0>);
NEI.hide(<TConstruct:BattleSignBlock:0>);
NEI.hide(<TConstruct:HeldItemBlock:0>);
NEI.hide(<TConstruct:potionLauncher>.withTag({InfiTool: {Loaded: 0 as byte}}));
NEI.hide(<TConstruct:TankAir:0>);
NEI.hide(<Thaumcraft:blockAlchemyFurnace:0>);
NEI.hide(<Thaumcraft:blockArcaneFurnace:0>);
NEI.hide(<Thaumcraft:blockCosmeticDoubleSlabStone:0>);
NEI.hide(<Thaumcraft:blockCosmeticDoubleSlabWood:0>);
NEI.hide(<Thaumcraft:blockEldritchNothing:0>);
NEI.hide(<Thaumcraft:blockHole:0>);
NEI.hide(<Thaumcraft:blockMagicBox:0>);
NEI.hide(<Thaumcraft:blockManaPod:0>);
NEI.hide(<Thaumcraft:blockPortalEldritch:0>);
NEI.hide(<Thaumcraft:blockWarded:0>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:10>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:11>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:12>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:13>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:14>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:15>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:5>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:6>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:7>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:8>);
NEI.hide(<TwilightForest:tile.TFBossSpawner:9>);
NEI.hide(<TwilightForest:tile.TFPortal:0>);
NEI.hide(<TwilightForest:tile.TFTowerTranslucent:10>);
NEI.hide(<TwilightForest:tile.TFTowerTranslucent:11>);
NEI.hide(<TwilightForest:tile.TFTowerTranslucent:12>);
NEI.hide(<TwilightForest:tile.TFTowerTranslucent:13>);
NEI.hide(<TwilightForest:tile.TFTowerTranslucent:14>);
NEI.hide(<TwilightForest:tile.TFTowerTranslucent:15>);
NEI.hide(<TwilightForest:tile.TFTowerTranslucent:8>);
NEI.hide(<TwilightForest:tile.TFTowerTranslucent:9>);
NEI.hide(<TwilightForest:tile.TFTrophy:0>);
NEI.hide(<witchery:spiritportal:0>);
NEI.hide(<witchery:tormentportal:0>);

// bibliocraft
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodBookcase:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodpotshelf:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodshelf:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodrack:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodcase:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodlabel:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWooddesk:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodtable:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodSeat:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodMapFrame:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancySign:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodFancyWorkbench:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodClock:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT0:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT1:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT2:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT3:13>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:0>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:1>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:2>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:3>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:4>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:5>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:6>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:7>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:8>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:9>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:10>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:11>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:12>);
NEI.hide(<BiblioWoodsBoP:BiblioWoodPaintingT4:13>);
NEI.hide(<BiblioWoodsBoP:seatBack1:0>);
NEI.hide(<BiblioWoodsBoP:seatBack1:1>);
NEI.hide(<BiblioWoodsBoP:seatBack1:2>);
NEI.hide(<BiblioWoodsBoP:seatBack1:3>);
NEI.hide(<BiblioWoodsBoP:seatBack1:4>);
NEI.hide(<BiblioWoodsBoP:seatBack1:5>);
NEI.hide(<BiblioWoodsBoP:seatBack1:6>);
NEI.hide(<BiblioWoodsBoP:seatBack1:7>);
NEI.hide(<BiblioWoodsBoP:seatBack1:8>);
NEI.hide(<BiblioWoodsBoP:seatBack1:9>);
NEI.hide(<BiblioWoodsBoP:seatBack1:10>);
NEI.hide(<BiblioWoodsBoP:seatBack1:11>);
NEI.hide(<BiblioWoodsBoP:seatBack1:12>);
NEI.hide(<BiblioWoodsBoP:seatBack1:13>);
NEI.hide(<BiblioWoodsBoP:seatBack2:0>);
NEI.hide(<BiblioWoodsBoP:seatBack2:1>);
NEI.hide(<BiblioWoodsBoP:seatBack2:2>);
NEI.hide(<BiblioWoodsBoP:seatBack2:3>);
NEI.hide(<BiblioWoodsBoP:seatBack2:4>);
NEI.hide(<BiblioWoodsBoP:seatBack2:5>);
NEI.hide(<BiblioWoodsBoP:seatBack2:6>);
NEI.hide(<BiblioWoodsBoP:seatBack2:7>);
NEI.hide(<BiblioWoodsBoP:seatBack2:8>);
NEI.hide(<BiblioWoodsBoP:seatBack2:9>);
NEI.hide(<BiblioWoodsBoP:seatBack2:10>);
NEI.hide(<BiblioWoodsBoP:seatBack2:11>);
NEI.hide(<BiblioWoodsBoP:seatBack2:12>);
NEI.hide(<BiblioWoodsBoP:seatBack2:13>);
NEI.hide(<BiblioWoodsBoP:seatBack3:0>);
NEI.hide(<BiblioWoodsBoP:seatBack3:1>);
NEI.hide(<BiblioWoodsBoP:seatBack3:2>);
NEI.hide(<BiblioWoodsBoP:seatBack3:3>);
NEI.hide(<BiblioWoodsBoP:seatBack3:4>);
NEI.hide(<BiblioWoodsBoP:seatBack3:5>);
NEI.hide(<BiblioWoodsBoP:seatBack3:6>);
NEI.hide(<BiblioWoodsBoP:seatBack3:7>);
NEI.hide(<BiblioWoodsBoP:seatBack3:8>);
NEI.hide(<BiblioWoodsBoP:seatBack3:9>);
NEI.hide(<BiblioWoodsBoP:seatBack3:10>);
NEI.hide(<BiblioWoodsBoP:seatBack3:11>);
NEI.hide(<BiblioWoodsBoP:seatBack3:12>);
NEI.hide(<BiblioWoodsBoP:seatBack3:13>);
NEI.hide(<BiblioWoodsBoP:seatBack4:0>);
NEI.hide(<BiblioWoodsBoP:seatBack4:1>);
NEI.hide(<BiblioWoodsBoP:seatBack4:2>);
NEI.hide(<BiblioWoodsBoP:seatBack4:3>);
NEI.hide(<BiblioWoodsBoP:seatBack4:4>);
NEI.hide(<BiblioWoodsBoP:seatBack4:5>);
NEI.hide(<BiblioWoodsBoP:seatBack4:6>);
NEI.hide(<BiblioWoodsBoP:seatBack4:7>);
NEI.hide(<BiblioWoodsBoP:seatBack4:8>);
NEI.hide(<BiblioWoodsBoP:seatBack4:9>);
NEI.hide(<BiblioWoodsBoP:seatBack4:10>);
NEI.hide(<BiblioWoodsBoP:seatBack4:11>);
NEI.hide(<BiblioWoodsBoP:seatBack4:12>);
NEI.hide(<BiblioWoodsBoP:seatBack4:13>);
NEI.hide(<BiblioWoodsBoP:seatBack5:0>);
NEI.hide(<BiblioWoodsBoP:seatBack5:1>);
NEI.hide(<BiblioWoodsBoP:seatBack5:2>);
NEI.hide(<BiblioWoodsBoP:seatBack5:3>);
NEI.hide(<BiblioWoodsBoP:seatBack5:4>);
NEI.hide(<BiblioWoodsBoP:seatBack5:5>);
NEI.hide(<BiblioWoodsBoP:seatBack5:6>);
NEI.hide(<BiblioWoodsBoP:seatBack5:7>);
NEI.hide(<BiblioWoodsBoP:seatBack5:8>);
NEI.hide(<BiblioWoodsBoP:seatBack5:9>);
NEI.hide(<BiblioWoodsBoP:seatBack5:10>);
NEI.hide(<BiblioWoodsBoP:seatBack5:11>);
NEI.hide(<BiblioWoodsBoP:seatBack5:12>);
NEI.hide(<BiblioWoodsBoP:seatBack5:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstBookcase2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstpotshelf2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstshelf2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstrack2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase0:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase1:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase1:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase1:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase1:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase1:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase1:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase1:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstcase1:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstlabel2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFstdesk2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFsttable2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodSeat2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodMapFrame2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancySign2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodFancyWorkbench2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodClock2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0b:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0b:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0b:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0b:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0b:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0b:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0b:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT0b:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1b:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1b:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1b:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1b:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1b:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1b:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1b:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT1b:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2b:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2b:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2b:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2b:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2b:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2b:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2b:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT2b:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3b:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3b:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3b:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3b:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3b:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3b:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3b:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT3b:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:7>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:8>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:9>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:10>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:11>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:12>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:13>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:14>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4:15>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4b:0>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4b:1>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4b:2>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4b:3>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4b:4>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4b:5>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4b:6>);
NEI.hide(<BiblioWoodsForestry:BiblioWoodPaintingT4b:7>);
NEI.hide(<BiblioWoodsForestry:seatBack1:0>);
NEI.hide(<BiblioWoodsForestry:seatBack1:1>);
NEI.hide(<BiblioWoodsForestry:seatBack1:2>);
NEI.hide(<BiblioWoodsForestry:seatBack1:3>);
NEI.hide(<BiblioWoodsForestry:seatBack1:4>);
NEI.hide(<BiblioWoodsForestry:seatBack1:5>);
NEI.hide(<BiblioWoodsForestry:seatBack1:6>);
NEI.hide(<BiblioWoodsForestry:seatBack1:7>);
NEI.hide(<BiblioWoodsForestry:seatBack1:8>);
NEI.hide(<BiblioWoodsForestry:seatBack1:9>);
NEI.hide(<BiblioWoodsForestry:seatBack1:10>);
NEI.hide(<BiblioWoodsForestry:seatBack1:11>);
NEI.hide(<BiblioWoodsForestry:seatBack1:12>);
NEI.hide(<BiblioWoodsForestry:seatBack1:13>);
NEI.hide(<BiblioWoodsForestry:seatBack1:14>);
NEI.hide(<BiblioWoodsForestry:seatBack1:15>);
NEI.hide(<BiblioWoodsForestry:seatBack1:16>);
NEI.hide(<BiblioWoodsForestry:seatBack1:17>);
NEI.hide(<BiblioWoodsForestry:seatBack1:18>);
NEI.hide(<BiblioWoodsForestry:seatBack1:19>);
NEI.hide(<BiblioWoodsForestry:seatBack1:20>);
NEI.hide(<BiblioWoodsForestry:seatBack1:21>);
NEI.hide(<BiblioWoodsForestry:seatBack1:22>);
NEI.hide(<BiblioWoodsForestry:seatBack1:23>);
NEI.hide(<BiblioWoodsForestry:seatBack2:0>);
NEI.hide(<BiblioWoodsForestry:seatBack2:1>);
NEI.hide(<BiblioWoodsForestry:seatBack2:2>);
NEI.hide(<BiblioWoodsForestry:seatBack2:3>);
NEI.hide(<BiblioWoodsForestry:seatBack2:4>);
NEI.hide(<BiblioWoodsForestry:seatBack2:5>);
NEI.hide(<BiblioWoodsForestry:seatBack2:6>);
NEI.hide(<BiblioWoodsForestry:seatBack2:7>);
NEI.hide(<BiblioWoodsForestry:seatBack2:8>);
NEI.hide(<BiblioWoodsForestry:seatBack2:9>);
NEI.hide(<BiblioWoodsForestry:seatBack2:10>);
NEI.hide(<BiblioWoodsForestry:seatBack2:11>);
NEI.hide(<BiblioWoodsForestry:seatBack2:12>);
NEI.hide(<BiblioWoodsForestry:seatBack2:13>);
NEI.hide(<BiblioWoodsForestry:seatBack2:14>);
NEI.hide(<BiblioWoodsForestry:seatBack2:15>);
NEI.hide(<BiblioWoodsForestry:seatBack2:16>);
NEI.hide(<BiblioWoodsForestry:seatBack2:17>);
NEI.hide(<BiblioWoodsForestry:seatBack2:18>);
NEI.hide(<BiblioWoodsForestry:seatBack2:19>);
NEI.hide(<BiblioWoodsForestry:seatBack2:20>);
NEI.hide(<BiblioWoodsForestry:seatBack2:21>);
NEI.hide(<BiblioWoodsForestry:seatBack2:22>);
NEI.hide(<BiblioWoodsForestry:seatBack2:23>);
NEI.hide(<BiblioWoodsForestry:seatBack3:0>);
NEI.hide(<BiblioWoodsForestry:seatBack3:1>);
NEI.hide(<BiblioWoodsForestry:seatBack3:2>);
NEI.hide(<BiblioWoodsForestry:seatBack3:3>);
NEI.hide(<BiblioWoodsForestry:seatBack3:4>);
NEI.hide(<BiblioWoodsForestry:seatBack3:5>);
NEI.hide(<BiblioWoodsForestry:seatBack3:6>);
NEI.hide(<BiblioWoodsForestry:seatBack3:7>);
NEI.hide(<BiblioWoodsForestry:seatBack3:8>);
NEI.hide(<BiblioWoodsForestry:seatBack3:9>);
NEI.hide(<BiblioWoodsForestry:seatBack3:10>);
NEI.hide(<BiblioWoodsForestry:seatBack3:11>);
NEI.hide(<BiblioWoodsForestry:seatBack3:12>);
NEI.hide(<BiblioWoodsForestry:seatBack3:13>);
NEI.hide(<BiblioWoodsForestry:seatBack3:14>);
NEI.hide(<BiblioWoodsForestry:seatBack3:15>);
NEI.hide(<BiblioWoodsForestry:seatBack3:16>);
NEI.hide(<BiblioWoodsForestry:seatBack3:17>);
NEI.hide(<BiblioWoodsForestry:seatBack3:18>);
NEI.hide(<BiblioWoodsForestry:seatBack3:19>);
NEI.hide(<BiblioWoodsForestry:seatBack3:20>);
NEI.hide(<BiblioWoodsForestry:seatBack3:21>);
NEI.hide(<BiblioWoodsForestry:seatBack3:22>);
NEI.hide(<BiblioWoodsForestry:seatBack3:23>);
NEI.hide(<BiblioWoodsForestry:seatBack4:0>);
NEI.hide(<BiblioWoodsForestry:seatBack4:1>);
NEI.hide(<BiblioWoodsForestry:seatBack4:2>);
NEI.hide(<BiblioWoodsForestry:seatBack4:3>);
NEI.hide(<BiblioWoodsForestry:seatBack4:4>);
NEI.hide(<BiblioWoodsForestry:seatBack4:5>);
NEI.hide(<BiblioWoodsForestry:seatBack4:6>);
NEI.hide(<BiblioWoodsForestry:seatBack4:7>);
NEI.hide(<BiblioWoodsForestry:seatBack4:8>);
NEI.hide(<BiblioWoodsForestry:seatBack4:9>);
NEI.hide(<BiblioWoodsForestry:seatBack4:10>);
NEI.hide(<BiblioWoodsForestry:seatBack4:11>);
NEI.hide(<BiblioWoodsForestry:seatBack4:12>);
NEI.hide(<BiblioWoodsForestry:seatBack4:13>);
NEI.hide(<BiblioWoodsForestry:seatBack4:14>);
NEI.hide(<BiblioWoodsForestry:seatBack4:15>);
NEI.hide(<BiblioWoodsForestry:seatBack4:16>);
NEI.hide(<BiblioWoodsForestry:seatBack4:17>);
NEI.hide(<BiblioWoodsForestry:seatBack4:18>);
NEI.hide(<BiblioWoodsForestry:seatBack4:19>);
NEI.hide(<BiblioWoodsForestry:seatBack4:20>);
NEI.hide(<BiblioWoodsForestry:seatBack4:21>);
NEI.hide(<BiblioWoodsForestry:seatBack4:22>);
NEI.hide(<BiblioWoodsForestry:seatBack4:23>);
NEI.hide(<BiblioWoodsForestry:seatBack5:0>);
NEI.hide(<BiblioWoodsForestry:seatBack5:1>);
NEI.hide(<BiblioWoodsForestry:seatBack5:2>);
NEI.hide(<BiblioWoodsForestry:seatBack5:3>);
NEI.hide(<BiblioWoodsForestry:seatBack5:4>);
NEI.hide(<BiblioWoodsForestry:seatBack5:5>);
NEI.hide(<BiblioWoodsForestry:seatBack5:6>);
NEI.hide(<BiblioWoodsForestry:seatBack5:7>);
NEI.hide(<BiblioWoodsForestry:seatBack5:8>);
NEI.hide(<BiblioWoodsForestry:seatBack5:9>);
NEI.hide(<BiblioWoodsForestry:seatBack5:10>);
NEI.hide(<BiblioWoodsForestry:seatBack5:11>);
NEI.hide(<BiblioWoodsForestry:seatBack5:12>);
NEI.hide(<BiblioWoodsForestry:seatBack5:13>);
NEI.hide(<BiblioWoodsForestry:seatBack5:14>);
NEI.hide(<BiblioWoodsForestry:seatBack5:15>);
NEI.hide(<BiblioWoodsForestry:seatBack5:16>);
NEI.hide(<BiblioWoodsForestry:seatBack5:17>);
NEI.hide(<BiblioWoodsForestry:seatBack5:18>);
NEI.hide(<BiblioWoodsForestry:seatBack5:19>);
NEI.hide(<BiblioWoodsForestry:seatBack5:20>);
NEI.hide(<BiblioWoodsForestry:seatBack5:21>);
NEI.hide(<BiblioWoodsForestry:seatBack5:22>);
NEI.hide(<BiblioWoodsForestry:seatBack5:23>);
