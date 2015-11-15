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
val COPPER_DUST = <IC2:itemDust:3>;
val TIN_NUGGET = <Thaumcraft:ItemNugget:2>;
val TIN_INGOT = <ThermalFoundation:material:65>;
val TIN_BLOCK = <TConstruct:MetalBlock:5>;
val TIN_DUST = <IC2:itemDust:7>;
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
val LEAD_BLOCK = <Railcraft:cube:11>;
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
val BRONZE_DUST = <IC2:itemDust:0>;
val STEEL_NUGGET = <Railcraft:nugget:1>;
val STEEL_INGOT = <Railcraft:ingot:0>;
val STEEL_BLOCK = <TConstruct:MetalBlock:9>;
val STEEL_MOLTEN = <liquid:steel.molten>;
val ELECTRUM_NUGGET = <ThermalFoundation:material:103>;
val ELECTRUM_INGOT = <ThermalFoundation:material:71>;
val ELECTRUM_BLOCK = <ThermalFoundation:Storage:7>;
val URANIUM_NUGGET = <aobd:nuggetUranium:0>;
val URANIUM_INGOT = <AdvancedSolarPanel:asp_crafting_items:11>;
val URANIUM_BLOCK = <IC2:blockMetal:3>;
val ENDIUM_NUGGET = <aobd:nuggetHeeEndium:0>;
val ENDIUM_INGOT = <HardcoreEnderExpansion:endium_ingot:0>;
val ENDIUM_BLOCK = <HardcoreEnderExpansion:endium_block:0>;
val PLATINUM_NUGGET = <ThermalFoundation:material:101>;
val PLATINUM_INGOT = <ThermalFoundation:material:69>;
val PLATINUM_BLOCK = <ThermalFoundation:Storage:5>;
val MITHRIL_NUGGET = <ThermalFoundation:material:102>;
val MITHRIL_INGOT = <ThermalFoundation:material:70>;
val MITHRIL_BLOCK = <ThermalFoundation:Storage:6>;
val YELLORIUM_NUGGET = <aobd:nuggetYellorium:0>;
val YELLORIUM_INGOT = <BigReactors:BRIngot:0>;
val YELLORIUM_BLOCK = <BigReactors:BRMetalBlock:0>;
val OSMIUM_NUGGET = <aobd:nuggetOsmium:0>;
val OSMIUM_INGOT = <Mekanism:Ingot:1>;
val OSMIUM_BLOCK = <Mekanism:BasicBlock:0>;


  ///////////////
 // FUNCTIONS //
///////////////

function unifyMetal(ore as IIngredient, oreNugget as IIngredient, oreIngot as IIngredient, oreBlock as IIngredient, oreCluster as IIngredient, oreDust as IIngredient, oreCrushed as IIngredient, oreCrushedPurified as IIngredient, liquid as ILiquidStack, realNugget as IItemStack, realIngot as IItemStack, realBlock as IItemStack, banIngots as IItemStack[], banBlocks as IItemStack[], xp as float) {
    // basic crafting
    unifyNuggetIngotBlock(oreNugget, oreIngot, oreBlock, realNugget, realIngot, realBlock);

    // smelting
    furnace.remove(oreIngot);
    furnace.addRecipe(realIngot, ore, xp);
    furnace.addRecipe(realIngot, oreDust, xp);
    furnace.addRecipe(realIngot, oreCrushed, xp);
    furnace.addRecipe(realIngot, oreCrushedPurified, xp);
    furnace.addRecipe(realIngot * 2, oreCluster, xp);

    // immersive engineering arc furance
    for item in oreIngot.items {
        mods.immersiveengineering.ArcFurnace.removeRecipe(item);
    }
    mods.immersiveengineering.ArcFurnace.addRecipe(realIngot * 2, ore, <ThermalExpansion:material:514>, 200, 512, []);
    mods.immersiveengineering.ArcFurnace.addRecipe(realIngot, oreDust, null, 100, 512, []);
    mods.immersiveengineering.ArcFurnace.addRecipe(realIngot, oreCrushed, null, 100, 512, []);
    mods.immersiveengineering.ArcFurnace.addRecipe(realIngot, oreCrushedPurified, null, 100, 512, []);
    mods.immersiveengineering.ArcFurnace.addRecipe(realIngot * 2, oreCluster, null, 200, 512, []);

    // mariculture
    mods.mariculture.Casting.removeNuggetRecipe(oreNugget);
    mods.mariculture.Casting.removeIngotRecipe(oreIngot);
    mods.mariculture.Casting.removeBlockRecipe(oreBlock);
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
        mods.mariculture.Crucible.addRecipe(1085, item, liquid * 288);
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
        mods.tconstruct.Smeltery.addMelting(item, liquid * 288, 200, realBlock);
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

function unifyNuggetIngotBlock(oreNugget as IIngredient, oreIngot as IIngredient, oreBlock as IIngredient, realNugget as IItemStack, realIngot as IItemStack, realBlock as IItemStack) {
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
}

function purgeBerries(berries as IIngredient, nuggets as IOreDictEntry) {
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



  ///////////////
 // RAILCRAFT //
///////////////

fixRailcraftSlabsAndStairs(COPPER_BLOCK, <Railcraft:slab:40>, <Railcraft:stair:40>);
fixRailcraftSlabsAndStairs(TIN_BLOCK, <Railcraft:slab:41>, <Railcraft:stair:41>);
fixRailcraftSlabsAndStairs(STEEL_BLOCK, <Railcraft:slab:43>, <Railcraft:stair:43>);


  ////////////
 // METALS //
////////////

// copper
unifyMetal(<ore:oreCopper>, <ore:nuggetCopper>, <ore:ingotCopper>, <ore:blockCopper>, <ore:clusterCopper>, <ore:dustCopper>, <ore:crushedCopper>, <ore:crushedPurifiedCopper>, <liquid:copper.molten>, COPPER_NUGGET, COPPER_INGOT, COPPER_BLOCK, [<IC2:itemIngot:0>], [<IC2:blockMetal:0>], 0.7);
unifyDusts(<ore:crushedCopper>, <ore:crushedPurifiedCopper>, <ore:clusterCopper>, COPPER_INGOT);
purgeBerries(<ore:oreberryCopper>, <ore:nuggetCopper>);
// slabs
recipes.addShaped(<ImmersiveEngineering:storage:0>, [
    [<ImmersiveEngineering:storageSlab:0>],
    [<ImmersiveEngineering:storageSlab:0>]
]);
recipes.addShaped(<TConstruct:MetalBlock:3>, [
    [<Railcraft:slab:40>],
    [<Railcraft:slab:40>]
]);

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
// slabs
recipes.remove(<ImmersiveEngineering:storageSlab:3> * 6);
recipes.addShaped(<ImmersiveEngineering:storageSlab:3>* 6, [
    [<ore:blockSilver>, <ore:blockSilver>, <ore:blockSilver>]
]);
recipes.addShaped(SILVER_BLOCK, [
    [<ImmersiveEngineering:storageSlab:3>],
    [<ImmersiveEngineering:storageSlab:3>]
]);

// gold
unifyMetal(<ore:oreGold>, <ore:nuggetGold>, <ore:ingotGold>, <ore:blockGold>, <ore:clusterGold>, <ore:dustGold>, <ore:crushedGold>, <ore:crushedPurifiedGold>, <liquid:gold.molten>, GOLD_NUGGET, GOLD_INGOT, GOLD_BLOCK, [], [], 1.0);
// hack: apparently gold oreberries aren't actually oreberries?
<ore:oreberryGold>.add(<TConstruct:oreBerries:1>);
purgeBerries(<ore:oreberryGold>, <ore:nuggetGold>);

// lead
unifyMetal(<ore:oreLead>, <ore:nuggetLead>, <ore:ingotLead>, <ore:blockLead>, <ore:clusterLead>, <ore:dustLead>, <ore:crushedLead>, <ore:crushedPurifiedLead>, <liquid:lead.molten>, LEAD_NUGGET, LEAD_INGOT, LEAD_BLOCK, [<IC2:itemIngot:5>], [<IC2:blockMetal:4>], 0.7);
unifyDusts(<ore:crushedLead>, <ore:crushedPurifiedLead>, <ore:clusterLead>, LEAD_INGOT);
// slabs
recipes.addShaped(<ImmersiveEngineering:storage:2>, [
    [<ImmersiveEngineering:storageSlab:2>],
    [<ImmersiveEngineering:storageSlab:2>]
]);
recipes.addShaped(LEAD_BLOCK, [
    [<Railcraft:slab:42>],
    [<Railcraft:slab:42>]
]);

// nickel (ferrous metal)
unifyMetal(<ore:oreNickel>, <ore:nuggetNickel>, <ore:ingotNickel>, <ore:blockNickel>, <ore:clusterNickel>, <ore:dustNickel>, <ore:crushedNickel>, <ore:crushedPurifiedNickel>, <liquid:nickel.molten>, NICKEL_NUGGET, NICKEL_INGOT, NICKEL_BLOCK, [], [], 0.7);
// slabs
recipes.remove(<ImmersiveEngineering:storageSlab:4> * 6);
recipes.addShaped(<ImmersiveEngineering:storageSlab:4>* 6, [
    [<ore:blockNickel>, <ore:blockNickel>, <ore:blockNickel>]
]);
recipes.addShaped(NICKEL_BLOCK, [
    [<ImmersiveEngineering:storageSlab:4>],
    [<ImmersiveEngineering:storageSlab:4>]
]);
// chisel
mods.chisel.Groups.addGroup("nickel_block");
for item in <ore:blockNickel>.items {
    mods.chisel.Groups.addVariation("nickel_block", item);
}

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
// slabs
recipes.remove(<ImmersiveEngineering:storageSlab:1> * 6);
recipes.addShaped(<ImmersiveEngineering:storageSlab:1> * 6, [
    [<ore:blockAluminum>, <ore:blockAluminum>, <ore:blockAluminum>]
]);
recipes.addShaped(ALUMINIUM_BLOCK, [
    [<ImmersiveEngineering:storageSlab:1>],
    [<ImmersiveEngineering:storageSlab:1>]
]);

// rutile (impure titantium)
unifyMetal(<ore:oreRutile>, <ore:nuggetRutile>, <ore:ingotRutile>, <ore:blockRutile>, <ore:clusterRutile>, <ore:dustRutile>, <ore:crushedRutile>, <ore:crushedPurifiedRutile>, <liquid:rutile.molten>, RUTILE_NUGGET, RUTILE_INGOT, RUTILE_BLOCK, [], [], 0.7);

// cobalt
unifyMetal(<ore:oreCobalt>, <ore:nuggetCobalt>, <ore:ingotCobalt>, <ore:blockCobalt>, <ore:clusterCobalt>, <ore:dustCobalt>, <ore:crushedCobalt>, <ore:crushedPurifiedCobalt>, <liquid:cobalt.molten>, COBALT_NUGGET, COBALT_INGOT, COBALT_BLOCK, [], [], 0.7);

// ardite
unifyMetal(<ore:oreArdite>, <ore:nuggetArdite>, <ore:ingotArdite>, <ore:blockArdite>, <ore:clusterArdite>, <ore:dustArdite>, <ore:crushedArdite>, <ore:crushedPurifiedArdite>, <liquid:ardite.molten>, ARDITE_NUGGET, ARDITE_INGOT, ARDITE_BLOCK, [], [], 0.7);

// uranium
unifyMetal(<ore:oreUranium>, <ore:nuggetUranium>, <ore:ingotUranium>, <ore:blockUranium>, <ore:clusterUranium>, <ore:dustUranium>, <ore:crushedUranium>, <ore:crushedPurifiedUranium>, <liquid:uranium>, URANIUM_NUGGET, URANIUM_INGOT, URANIUM_BLOCK, [], [], 0.7);

// endium
unifyMetal(<ore:oreHeeEndium>, <ore:nuggetHeeEndium>, <ore:ingotHeeEndium>, <ore:blockHeeEndium>, <ore:clusterHeeEndium>, <ore:dustHeeEndium>, <ore:crushedHeeEndium>, <ore:crushedPurifiedHeeEndium>, <liquid:heeendium>, ENDIUM_NUGGET, ENDIUM_INGOT, ENDIUM_BLOCK, [], [], 0.7);

// platinum
unifyMetal(<ore:orePlatinum>, <ore:nuggetPlatinum>, <ore:ingotPlatinum>, <ore:blockPlatinum>, <ore:clusterPlatinum>, <ore:dustPlatinum>, <ore:crushedPlatinum>, <ore:crushedPurifiedPlatinum>, <liquid:platinum.molten>, PLATINUM_NUGGET, PLATINUM_INGOT, PLATINUM_BLOCK, [], [], 0.7);

// mithril
unifyMetal(<ore:oreMithril>, <ore:nuggetMithril>, <ore:ingotMithril>, <ore:blockMithril>, <ore:clusterMithril>, <ore:dustMithril>, <ore:crushedMithril>, <ore:crushedPurifiedMithril>, <liquid:mithril.molten>, MITHRIL_NUGGET, MITHRIL_INGOT, MITHRIL_BLOCK, [], [], 0.7);

// yellorium
unifyMetal(<ore:oreYellorium>, <ore:nuggetYellorium>, <ore:ingotYellorium>, <ore:blockYellorium>, <ore:clusterYellorium>, <ore:dustYellorium>, <ore:crushedYellorium>, <ore:crushedPurifiedYellorium>, <liquid:yellorium>, YELLORIUM_NUGGET, YELLORIUM_INGOT, YELLORIUM_BLOCK, [], [], 0.7);

// osmium
unifyMetal(<ore:oreOsmium>, <ore:nuggetOsmium>, <ore:ingotOsmium>, <ore:blockOsmium>, <ore:clusterOsmium>, <ore:dustOsmium>, <ore:crushedOsmium>, <ore:crushedPurifiedOsmium>, <liquid:osmium>, OSMIUM_NUGGET, OSMIUM_INGOT, OSMIUM_BLOCK, [], [], 0.7);


  ////////////
 // BRONZE //
////////////

// basic crafting
unifyNuggetIngotBlock(<ore:nuggetBronze>, <ore:ingotBronze>, <ore:blockBronze>, BRONZE_NUGGET, BRONZE_INGOT, BRONZE_BLOCK);

// smelting
furnace.remove(<ore:ingotBronze>, <ore:dustBronze>);
furnace.addRecipe(BRONZE_INGOT, <ore:dustBronze>, 0.7);

// mariculture
mods.mariculture.Casting.removeNuggetRecipe(<ore:nuggetBronze>);
mods.mariculture.Casting.removeIngotRecipe(<ore:ingotBronze>);
mods.mariculture.Casting.removeBlockRecipe(<ore:blockBronze>);
mods.mariculture.Casting.addNuggetRecipe(BRONZE_MOLTEN * 16, BRONZE_NUGGET);
mods.mariculture.Casting.addIngotRecipe(BRONZE_MOLTEN * 144, BRONZE_INGOT);
mods.mariculture.Casting.addBlockRecipe(BRONZE_MOLTEN * 1296, BRONZE_BLOCK);

// tinker's construct
mods.tconstruct.Casting.removeTableRecipe(<IC2:itemIngot:2>);
mods.tconstruct.Casting.removeBasinRecipe(<IC2:blockMetal:2>);
mods.tconstruct.Casting.addTableRecipe(BRONZE_INGOT * 1, BRONZE_MOLTEN * 144, <TConstruct:metalPattern>, false, 80);
mods.tconstruct.Casting.addBasinRecipe(BRONZE_BLOCK * 1, BRONZE_MOLTEN * 1296, null, false, 100);

// thermal expansion
recipes.remove(<ThermalFoundation:material:41>); // bronze blend
mods.thermalexpansion.Furnace.removeRecipe(<ore:dustBronze>);
mods.thermalexpansion.Pulverizer.removeRecipe(<ore:ingotBronze>);
mods.thermalexpansion.Smelter.removeRecipe(<ore:sand>, <ore:dustBronze>);
mods.thermalexpansion.Smelter.removeRecipe(<ore:dustCopper> * 3, <ore:dustTin>);
mods.thermalexpansion.Smelter.removeRecipe(<ore:ingotCopper> * 3, <ore:ingotTin>);
mods.thermalexpansion.Furnace.addRecipe(1000, BRONZE_DUST, BRONZE_INGOT);
mods.thermalexpansion.Pulverizer.addRecipe(2400, BRONZE_INGOT, BRONZE_DUST);
mods.thermalexpansion.Smelter.addRecipe(800, BRONZE_DUST, <minecraft:sand>, BRONZE_INGOT, <ThermalExpansion:material:514>, 25); // slag
mods.thermalexpansion.Smelter.addRecipe(1600, TIN_DUST, COPPER_DUST * 3, BRONZE_INGOT * 4);
mods.thermalexpansion.Smelter.addRecipe(2400, TIN_INGOT, COPPER_INGOT * 3, BRONZE_INGOT * 4);

// mekanism
mods.mekanism.Infuser.removeRecipe(<ore:ingotBronze>);


// immersive engineering
mods.immersiveengineering.ArcFurnace.removeRecipe(<ThermalFoundation:material:73>);
mods.immersiveengineering.ArcFurnace.addRecipe(BRONZE_INGOT, <ore:dustBronze>, null, 100, 512, []);

  ///////////
 // STEEL //
///////////

// basic crafting
unifyNuggetIngotBlock(<ore:nuggetSteel>, <ore:ingotSteel>, <ore:blockSteel>, STEEL_NUGGET, STEEL_INGOT, STEEL_BLOCK);

// smelting
furnace.remove(<ore:ingotSteel>, <ore:dustSteel>);
furnace.addRecipe(STEEL_INGOT, <ore:dustSteel>);

// slabs
recipes.addShaped(<ImmersiveEngineering:storage:7>, [
    [<ImmersiveEngineering:storageSlab:7>],
    [<ImmersiveEngineering:storageSlab:7>]
]);
recipes.addShaped(STEEL_BLOCK, [
    [<Railcraft:slab:43>],
    [<Railcraft:slab:43>]
]);

// mariculture
mods.mariculture.Casting.removeNuggetRecipe(<ore:nuggetSteel>);
mods.mariculture.Casting.removeIngotRecipe(<ore:ingotSteel>);
mods.mariculture.Casting.removeBlockRecipe(<ore:blockSteel>);
mods.mariculture.Casting.addNuggetRecipe(STEEL_MOLTEN * 16, STEEL_NUGGET);
mods.mariculture.Casting.addIngotRecipe(STEEL_MOLTEN * 144, STEEL_INGOT);
mods.mariculture.Casting.addBlockRecipe(STEEL_MOLTEN * 1296, STEEL_BLOCK);

// mekanism
mods.mekanism.Infuser.removeRecipe(<Mekanism:EnrichedIron:0>);
for item in <ore:dustSteel>.items {
    mods.mekanism.Infuser.removeRecipe(item);
}

// railcraft
mods.railcraft.BlastFurnace.removeRecipe(<Railcraft:cube:2>);
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

// immersive engineering
mods.immersiveengineering.ArcFurnace.removeRecipe(<ImmersiveEngineering:metal:7>);
mods.immersiveengineering.ArcFurnace.addRecipe(STEEL_INGOT, <ore:ingotIron>, <ThermalExpansion:material:514>, 400, 512, [<ore:dustCoke>]);
mods.immersiveengineering.ArcFurnace.addRecipe(STEEL_INGOT, <ore:dustIron>, <ThermalExpansion:material:514>, 400, 512, [<ore:dustCoke>]);
mods.immersiveengineering.ArcFurnace.addRecipe(STEEL_INGOT, <ore:crushedIron>, <ThermalExpansion:material:514>, 400, 512, [<ore:dustCoke>]);
mods.immersiveengineering.ArcFurnace.addRecipe(STEEL_INGOT, <ore:crushedPurifiedIron>, <ThermalExpansion:material:514>, 400, 512, [<ore:dustCoke>]);
mods.immersiveengineering.ArcFurnace.addRecipe(STEEL_INGOT, <ore:dustSteel>, null, 100, 512, []);


  //////////////
 // ELECTRUM //
//////////////

// basic crafting
unifyNuggetIngotBlock(<ore:nuggetElectrum>, <ore:ingotElectrum>, <ore:blockElectrum>, ELECTRUM_NUGGET, ELECTRUM_INGOT, ELECTRUM_BLOCK);

// smelting
furnace.remove(<ore:ingotElectrum>, <ore:dustElectrum>);
furnace.addRecipe(ELECTRUM_INGOT, <ore:dustElectrum>);

// remove recipe for electrum grit
recipes.remove(<ImmersiveEngineering:metal:16>);

// immersive engineering crusher should produce electrum blend
mods.immersiveengineering.Crusher.removeRecipe(<ImmersiveEngineering:metal:16>);
mods.immersiveengineering.Crusher.addRecipe(<ThermalFoundation:material:39>, <ore:ingotElectrum>, 3600, null, 0.0);

// slabs
recipes.remove(<ImmersiveEngineering:storageSlab:6> * 6);
recipes.addShaped(<ImmersiveEngineering:storageSlab:6> * 6, [
    [<ore:blockElectrum>, <ore:blockElectrum>, <ore:blockElectrum>]
]);
recipes.addShaped(ELECTRUM_BLOCK, [
    [<ImmersiveEngineering:storageSlab:6>],
    [<ImmersiveEngineering:storageSlab:6>]
]);

// chisel
mods.chisel.Groups.addGroup("electrum_block");
for item in <ore:blockElectrum>.items {
    mods.chisel.Groups.addVariation("electrum_block", item);
}


  ////////////////////////
 // THERMAL FOUNDATION //
////////////////////////

// make TF and IE slag act the same
<ore:itemSlag>.add(<ThermalExpansion:material:514>);

// clay
recipes.removeShapeless(<minecraft:clay_ball> * 4, [
    <ThermalExpansion:material:514>, <ThermalExpansion:material:514>,
    <ore:dirt>, <minecraft:water_bucket>
]);
recipes.addShapeless(<minecraft:clay_ball> * 4, [
    <ore:itemSlag>, <ore:itemSlag>,
    <ore:dirt>, <minecraft:water_bucket>.giveBack(<minecraft:bucket>)
]);

// phyto-gro
recipes.removeShapeless(<ThermalExpansion:material:516> * 8, [
    <ore:dustWood>, <ore:dustWood>,
    <ore:dustSaltpeter>, <ThermalExpansion:material:514>
]);
recipes.addShapeless(<ThermalExpansion:material:516> * 8, [
    <ore:dustWood>, <ore:dustWood>,
    <ore:dustSaltpeter>, <ore:itemSlag>
]);
recipes.removeShapeless(<ThermalExpansion:material:516> * 32, [
    <ore:dustCharcoal>, <ore:dustSaltpeter>,
    <ThermalExpansion:material:514>
]);
recipes.addShapeless(<ThermalExpansion:material:516> * 32, [
    <ore:dustCharcoal>, <ore:dustSaltpeter>,
    <ore:itemSlag>
]);

// rockwool
furnace.remove(<ThermalExpansion:Rockwool:8>, <ThermalExpansion:material:514>);
furnace.addRecipe(<ThermalExpansion:Rockwool:8>, <ore:itemSlag>);
mods.thermalexpansion.Furnace.addRecipe(1600, <ImmersiveEngineering:material:13>, <ThermalExpansion:Rockwool:8>);


  ///////////////////////////
 // IMMERSIVE ENGINEERING //
///////////////////////////


// make coke oven work exactly like railcraft
mods.immersiveengineering.CokeOven.removeRecipe(<ImmersiveEngineering:material:6>);
mods.immersiveengineering.CokeOven.removeRecipe(<ImmersiveEngineering:stoneDecoration:3>);
mods.immersiveengineering.CokeOven.removeRecipe(<minecraft:coal:1>);
mods.immersiveengineering.CokeOven.addRecipe(<minecraft:coal:1>, 250, <ore:logWood>, 1800);
mods.immersiveengineering.CokeOven.addRecipe(<Railcraft:fuel.coke:0>, 500, <ore:coal>, 1800);
mods.immersiveengineering.CokeOven.addRecipe(<Railcraft:cube:0>, 4500, <ore:blockCoal>, 16200);

// make blast furnace work like railcraft
mods.immersiveengineering.BlastFurnace.removeRecipe(<ImmersiveEngineering:metal:7>);
mods.immersiveengineering.BlastFurnace.removeRecipe(<ImmersiveEngineering:storage:7>);
mods.immersiveengineering.BlastFurnace.addRecipe(STEEL_INGOT, <ore:ingotIron>, 1280);
mods.immersiveengineering.BlastFurnace.addRecipe(STEEL_BLOCK, <ore:blockIron>, 11520);

// crusher

// nether quartz
mods.immersiveengineering.Crusher.removeRecipe(<ImmersiveEngineering:metal:18>);
mods.immersiveengineering.Crusher.addRecipe(<appliedenergistics2:item.ItemMultiMaterial:3>, <ore:crystalNetherQuartz>, 4800, null, 0);
// blaze rod
mods.immersiveengineering.Crusher.removeRecipe(<minecraft:blaze_powder>);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:blaze_powder> * 4, <minecraft:blaze_rod>, 1600, <IC2:itemDust:13>, 0.5);
// coal
mods.immersiveengineering.Crusher.removeRecipe(<ThermalFoundation:material:2>);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:2>, <ore:coal>, 2400, null, 0);
// gold
mods.immersiveengineering.Crusher.removeRecipe(<ImmersiveEngineering:metal:9>);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:4>, <ore:ingotGold>, 3600, null, 0);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:4> * 2, <ore:oreGold>, 6000, <ThermalFoundation:material:20>, 0.05);
// iron
mods.immersiveengineering.Crusher.removeRecipe(<ImmersiveEngineering:metal:8>);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:5>, <ore:ingotIron>, 3600, null, 0);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:5> * 2, <ore:oreIron>, 6000, <ThermalFoundation:material:36>, 0.1);
// nether quartz ore
mods.immersiveengineering.Crusher.removeRecipe(<minecraft:quartz>);
mods.immersiveengineering.Crusher.addRecipe(<minecraft:quartz> * 3, <ore:oreQuartz>, 6000, <appliedenergistics2:item.ItemMultiMaterial:3>, 0.1);
// copper
mods.immersiveengineering.Crusher.removeRecipe(<ImmersiveEngineering:metal:10>);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:3>, <ore:ingotCopper>, 3600, null, 0);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:3> * 2, <ore:oreCopper>, 6000, <IC2:itemDust:4>, 0.1);
// tin
mods.immersiveengineering.Crusher.removeRecipe(<ThermalFoundation:material:33>);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:7>, <ore:ingotTin>, 3600, null, 0);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:7> * 2, <ore:oreTin>, 6000, <IC2:itemDust:5>, 0.1);
// lead
mods.immersiveengineering.Crusher.removeRecipe(<ImmersiveEngineering:metal:12>);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:10>, <ore:ingotLead>, 3600, null, 0);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:10> * 2, <ore:oreLead>, 6000, <IC2:itemDust:6>, 0.1);
// silver
mods.immersiveengineering.Crusher.removeRecipe(<ImmersiveEngineering:metal:13>);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:6>, <ore:ingotSilver>, 3600, null, 0);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:6> * 2, <ore:oreSilver>, 6000, <IC2:itemDust:10>, 0.1);
// nickel
mods.immersiveengineering.Crusher.removeRecipe(<ImmersiveEngineering:metal:14>);
mods.immersiveengineering.Crusher.addRecipe(<ThermalFoundation:material:36>, <ore:ingotNickel>, 3600, null, 0);
mods.immersiveengineering.Crusher.addRecipe(<ThermalFoundation:material:36> * 2, <ore:oreNickel>, 6000, <ThermalFoundation:material:37>, 0.1);
// yellorium
mods.immersiveengineering.Crusher.removeRecipe(<BigReactors:BRIngot:4>);
mods.immersiveengineering.Crusher.addRecipe(<BigReactors:BRIngot:4>, <ore:ingotYellorium>, 3600, null, 0);
mods.immersiveengineering.Crusher.addRecipe(<BigReactors:BRIngot:4> * 2, <ore:oreYellorite>, 6000, <BigReactors:BRIngot:4>, 0.1);
// sulfur
mods.immersiveengineering.Crusher.removeRecipe(<ThermalFoundation:material:16>);
mods.immersiveengineering.Crusher.addRecipe(<IC2:itemDust:13> * 6, <ore:oreSulfur>, 6000, null, 0);
// aluminium
mods.immersiveengineering.Crusher.removeRecipe(<ImmersiveEngineering:metal:11>);
mods.immersiveengineering.Crusher.addRecipe(<TConstruct:materials:40>, <ore:ingotAluminium>, 3600, null, 0);
mods.immersiveengineering.Crusher.addRecipe(<TConstruct:materials:40> * 2, <ore:oreAluminium>, 6000, null, 0);
// osmium
mods.immersiveengineering.Crusher.removeRecipe(<Mekanism:Dust:2>);
mods.immersiveengineering.Crusher.addRecipe(<Mekanism:Dust:2>, <ore:ingotOsmium>, 3600, null, 0);
mods.immersiveengineering.Crusher.addRecipe(<Mekanism:Dust:2> * 2, <ore:oreOsmium>, 6000, null, 0);


  ///////////
 // GEARS //
///////////

// copper
recipes.remove(<ore:gearCopper>);
NEI.hide(<Forestry:gearCopper>);
mods.tconstruct.Smeltery.removeMelting(<ore:gearCopper>);
mods.tconstruct.Casting.removeTableRecipe(<ore:gearCopper>);
recipes.addShaped(<ThermalFoundation:material:128>, [
    [null, <ore:ingotCopper>, null],
    [<ore:ingotCopper>, <ore:gearStone>, <ore:ingotCopper>],
    [null, <ore:ingotCopper>, null],
]);
mods.tconstruct.Smeltery.addMelting(<ore:gearCopper>, <liquid:copper.molten> * 576, 650, COPPER_BLOCK);
mods.tconstruct.Casting.addTableRecipe(<ThermalFoundation:material:128>, <liquid:copper.molten> * 576, <TConstruct:gearCast>, false, 50);

// tin
recipes.remove(<ore:gearTin>);
NEI.hide(<Forestry:gearTin>);
mods.tconstruct.Smeltery.removeMelting(<ore:gearTin>);
mods.tconstruct.Casting.removeTableRecipe(<ore:gearTin>);
recipes.addShaped(<ThermalFoundation:material:129>, [
    [null, <ore:ingotTin>, null],
    [<ore:ingotTin>, <ore:gearStone>, <ore:ingotTin>],
    [null, <ore:ingotTin>, null],
]);
mods.tconstruct.Smeltery.addMelting(<ore:gearTin>, <liquid:tin.molten> * 576, 500, TIN_BLOCK);
mods.tconstruct.Casting.addTableRecipe(<ThermalFoundation:material:129>, <liquid:tin.molten> * 576, <TConstruct:gearCast>, false, 50);

// bronze
recipes.remove(<ore:gearBronze>);
NEI.hide(<Forestry:gearBronze>);
mods.tconstruct.Smeltery.removeMelting(<ore:gearBronze>);
mods.tconstruct.Casting.removeTableRecipe(<ore:gearBronze>);
recipes.addShaped(<ThermalFoundation:material:137>, [
    [null, <ore:ingotBronze>, null],
    [<ore:ingotBronze>, <ore:gearStone>, <ore:ingotBronze>],
    [null, <ore:ingotBronze>, null],
]);
mods.tconstruct.Smeltery.addMelting(<ore:gearBronze>, <liquid:bronze.molten> * 576, 600, BRONZE_BLOCK);
mods.tconstruct.Casting.addTableRecipe(<ThermalFoundation:material:137>, <liquid:bronze.molten> * 576, <TConstruct:gearCast>, false, 50);

// iron
recipes.remove(<Railcraft:part.gear:1>);
recipes.remove(<ThermalFoundation:material:12>);
NEI.hide(<Railcraft:part.gear:1>);
NEI.hide(<ThermalFoundation:material:12>);
mods.tconstruct.Smeltery.removeMelting(<ore:gearIron>);
mods.tconstruct.Casting.removeTableRecipe(<ore:gearIron>);
mods.tconstruct.Smeltery.addMelting(<ore:gearIron>, <liquid:iron.molten> * 576, 700, IRON_BLOCK);
mods.tconstruct.Casting.addTableRecipe(<BuildCraft|Core:ironGearItem>, <liquid:iron.molten> * 576, <TConstruct:gearCast>, false, 50);

// gold
recipes.remove(<ThermalFoundation:material:13>);
NEI.hide(<ThermalFoundation:material:13>);
mods.tconstruct.Smeltery.removeMelting(<ore:gearGold>);
mods.tconstruct.Casting.removeTableRecipe(<ore:gearGold>);
mods.tconstruct.Smeltery.addMelting(<ore:gearGold>, <liquid:gold.molten> * 576, 500, GOLD_BLOCK);
mods.tconstruct.Casting.addTableRecipe(<BuildCraft|Core:goldGearItem>, <liquid:gold.molten> * 576, <TConstruct:gearCast>, false, 50);

// compressed iron
recipes.removeShaped(<PneumaticCraft:compressedIronGear>, [
    [null, <ore:ingotIronCompressed>, null],
    [<ore:ingotIronCompressed>, <ore:ingotIron>, <ore:ingotIronCompressed>],
    [null, <ore:ingotIronCompressed>, null]
]);

// silver
recipes.remove(<ThermalFoundation:material:130>);
recipes.addShaped(<ThermalFoundation:material:130>, [
    [null, <ore:ingotSilver>, null],
    [<ore:ingotSilver>, <ore:gearIron>, <ore:ingotSilver>],
    [null, <ore:ingotSilver>, null]
]);

// lead
recipes.remove(<ThermalFoundation:material:131>);
recipes.addShaped(<ThermalFoundation:material:131>, [
    [null, <ore:ingotLead>, null],
    [<ore:ingotLead>, <ore:gearStone>, <ore:ingotLead>],
    [null, <ore:ingotLead>, null]
]);

// ferrous (nickel)
recipes.remove(<ThermalFoundation:material:132>);
recipes.addShaped(<ThermalFoundation:material:132>, [
    [null, <ore:ingotNickel>, null],
    [<ore:ingotNickel>, <ore:gearStone>, <ore:ingotNickel>],
    [null, <ore:ingotNickel>, null]
]);

// shiny (platinum)
recipes.remove(<ThermalFoundation:material:133>);
recipes.addShaped(<ThermalFoundation:material:133>, [
    [null, <ore:ingotPlatinum>, null],
    [<ore:ingotPlatinum>, <ore:gearDiamond>, <ore:ingotPlatinum>],
    [null, <ore:ingotPlatinum>, null]
]);

// mana infused (mithril)
recipes.remove(<ThermalFoundation:material:134>);
recipes.addShaped(<ThermalFoundation:material:134>, [
    [null, <ore:ingotMithril>, null],
    [<ore:ingotMithril>, <ore:gearPlatinum>, <ore:ingotMithril>],
    [null, <ore:ingotMithril>, null]
]);

// electrum
recipes.remove(<ThermalFoundation:material:135>);
recipes.addShaped(<ThermalFoundation:material:135>, [
    [null, <ore:ingotElectrum>, null],
    [<ore:ingotElectrum>, <ore:gearIron>, <ore:ingotElectrum>],
    [null, <ore:ingotElectrum>, null]
]);

// invar
recipes.remove(<ThermalFoundation:material:136>);
recipes.addShaped(<ThermalFoundation:material:136>, [
    [null, <ore:ingotInvar>, null],
    [<ore:ingotInvar>, <ore:gearIron>, <ore:ingotInvar>],
    [null, <ore:ingotElectrum>, null]
]);

// signalum
recipes.remove(<ThermalFoundation:material:138>);
recipes.addShaped(<ThermalFoundation:material:138>, [
    [null, <ore:ingotSignalum>, null],
    [<ore:ingotSignalum>, <ore:gearGold>, <ore:ingotSignalum>],
    [null, <ore:ingotSignalum>, null]
]);

// lumium
recipes.remove(<ThermalFoundation:material:139>);
recipes.addShaped(<ThermalFoundation:material:139>, [
    [null, <ore:ingotLumium>, null],
    [<ore:ingotLumium>, <ore:gearGold>, <ore:ingotLumium>],
    [null, <ore:ingotLumium>, null]
]);

// enderium
recipes.remove(<ThermalFoundation:material:140>);
recipes.addShaped(<ThermalFoundation:material:140>, [
    [null, <ore:ingotEnderium>, null],
    [<ore:ingotEnderium>, <ore:gearDiamond>, <ore:ingotEnderium>],
    [null, <ore:ingotEnderium>, null]
]);


  ////////////////////
 // PNEUMATICCRAFT //
////////////////////

// black dye instead of ink sacs
recipes.removeShapeless(<minecraft:dye:0>, [<PneumaticCraft:plasticPlant:0>]);
recipes.addShapeless(<BiomesOPlenty:misc:9>, [<PneumaticCraft:plasticPlant:0>]);

// green dye instead of cactus green
recipes.removeShapeless(<minecraft:dye:2>, [<PneumaticCraft:plasticPlant:2>]);
recipes.addShapeless(<BiomesOPlenty:misc:7>, [<PneumaticCraft:plasticPlant:2>]);

// brown dye instead of cocoa beans
recipes.removeShapeless(<minecraft:dye:3>, [<PneumaticCraft:plasticPlant:3>]);
recipes.addShapeless(<BiomesOPlenty:misc:6>, [<PneumaticCraft:plasticPlant:3>]);

// blue dye instead of lapis
recipes.removeShapeless(<minecraft:dye:4>, [<PneumaticCraft:plasticPlant:4>]);
// for some reason the lapis block -> 9 dye recipe gets clobbered by the above
recipes.addShapeless(<minecraft:dye:4> * 9, [<minecraft:lapis_block>]);
recipes.addShapeless(<BiomesOPlenty:misc:5>, [<PneumaticCraft:plasticPlant:4>]);

// white dye instead of bone meal
recipes.removeShapeless(<minecraft:dye:15>, [<PneumaticCraft:plasticPlant:15>]);
recipes.addShapeless(<BiomesOPlenty:misc:8>, [<PneumaticCraft:plasticPlant:15>]);


  //////////////////
 // GALACTICRAFT //
//////////////////

// tin canister requires one compressed tin at bottom
// not neccessary, but for consistency
recipes.remove(<GalacticraftCore:item.canister:0>);
recipes.addShaped(<GalacticraftCore:item.canister:0> * 2, [
    [<ore:ingotTin>, null, <ore:ingotTin>],
    [<ore:ingotTin>, null, <ore:ingotTin>],
    [<ore:ingotTin>, <ore:compressedTin>, <ore:ingotTin>]
]);

// copper canister requires one compressed copper at bottom
// fixes conflict with mariculture vat
recipes.remove(<GalacticraftCore:item.canister:1>);
recipes.addShaped(<GalacticraftCore:item.canister:1> * 2, [
    [<ore:ingotCopper>, null, <ore:ingotCopper>],
    [<ore:ingotCopper>, null, <ore:ingotCopper>],
    [<ore:ingotCopper>, <ore:compressedCopper>, <ore:ingotCopper>]
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


  //////////
 // L18N //
//////////

game.setLocalization("tile.archimedes.balloon.lightBlue.name", "Light Blue Air Balloon");
game.setLocalization("tile.chisel.aluminum_stairs.0.name", "Aluminum Stairs");
game.setLocalization("tile.chisel.aluminum_stairs.1.name", "Aluminum Stairs");
game.setLocalization("tile.chisel.aluminum_stairs.2.name", "Aluminum Stairs");
game.setLocalization("tile.chisel.sandstone2.name", "Sandstone");
game.setLocalization("tile.sandstone.16.desc", "Sandstone");
game.setLocalization("tile.sandstone.17.desc", "Sandstone");
game.setLocalization("tile.railcraft.post.metal.unpainted.platform.name", "Metal Platform");


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
NEI.hide(<ImmersiveEngineering:ore:0>);
NEI.hide(<Mariculture:rocks:1>);
NEI.hide(<Mekanism:OreBlock:1>);
NEI.hide(<Railcraft:ore:9>);
NEI.hide(<TConstruct:SearedBrick:3>);

// extra copper nuggets
NEI.hide(<ImmersiveEngineering:metal:22>);
NEI.hide(<Mariculture:materials:38>);
NEI.hide(<Railcraft:nugget:2>);
NEI.hide(<ThermalFoundation:material:96>);

// extra copper ingots
NEI.hide(<Forestry:ingotCopper:0>);
NEI.hide(<GalacticraftCore:item.basicItem:3>);
NEI.hide(<IC2:itemIngot:0>);
NEI.hide(<ImmersiveEngineering:metal:0>);
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
NEI.hide(<Railcraft:cube:9>);
NEI.hide(<ThermalFoundation:Storage:0>);

// extra tin ores
NEI.hide(<Forestry:resources:2>);
NEI.hide(<IC2:blockOreTin:0>);
NEI.hide(<Mekanism:OreBlock:2>);
NEI.hide(<Railcraft:ore:10>);
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
NEI.hide(<Railcraft:cube:10>);
NEI.hide(<GalacticraftCore:tile.gcBlockCore:10>);
NEI.hide(<IC2:blockMetal:1>);
NEI.hide(<Mekanism:BasicBlock:13>);
NEI.hide(<ThermalFoundation:Storage:1>);

// extra iron nuggets
NEI.hide(<ImmersiveEngineering:metal:21>);
NEI.hide(<Mariculture:materials:33>);
NEI.hide(<OpenComputers:item:16>);
NEI.hide(<Railcraft:nugget:0>);
NEI.hide(<ThermalFoundation:material:8>);

// extra silver ores
NEI.hide(<ImmersiveEngineering:ore:3>);

// extra silver nuggets
NEI.hide(<ImmersiveEngineering:metal:25>);
NEI.hide(<ThermalFoundation:material:98>);

// extra silver ingots
NEI.hide(<IC2:itemIngot:6>);
NEI.hide(<ImmersiveEngineering:metal:3>);

// extra lead ores
NEI.hide(<IC2:blockOreLead:0>);
NEI.hide(<ImmersiveEngineering:ore:2>);
NEI.hide(<Railcraft:ore:11>);

// extra lead nuggets
NEI.hide(<ImmersiveEngineering:metal:24>);
NEI.hide(<Railcraft:nugget:4>);
NEI.hide(<ThermalFoundation:material:99>);

// extra lead ingots
NEI.hide(<IC2:itemIngot:5>);
NEI.hide(<ImmersiveEngineering:metal:2>);
NEI.hide(<Railcraft:ingot:3>);

// extra lead blocks
NEI.hide(<IC2:blockMetal:4>);
NEI.hide(<ThermalFoundation:Storage:3>);

// extra aluminum ores
NEI.hide(<GalacticraftCore:tile.gcBlockCore:7>);
NEI.hide(<ImmersiveEngineering:ore:1>);

// extra aluminum nuggets
NEI.hide(<Mariculture:materials:34>);

// extra aluminum ingots
NEI.hide(<GalacticraftCore:item.basicItem:5>);
NEI.hide(<ImmersiveEngineering:metal:1>);
NEI.hide(<Mariculture:materials:0>);

// extra aluminum blocks
NEI.hide(<GalacticraftCore:tile.gcBlockCore:11>);
NEI.hide(<Mariculture:metals:1>);

// extra nickel ores
NEI.hide(<ImmersiveEngineering:ore:4>);

// extra nickel ingots
NEI.hide(<ImmersiveEngineering:metal:26>);

// extra nickel ingots
NEI.hide(<ImmersiveEngineering:metal:4>);

// extra electrum nuggets
NEI.hide(<ImmersiveEngineering:metal:28>);

// extra electrum ingots
NEI.hide(<ImmersiveEngineering:metal:6>);

// extra steel nuggets
NEI.hide(<ImmersiveEngineering:metal:29>);
NEI.hide(<TConstruct:materials:33>);

// extra steel ingots
NEI.hide(<ImmersiveEngineering:metal:7>);
NEI.hide(<Mekanism:Ingot:4>);
NEI.hide(<TConstruct:materials:16>);

// extra bronze nuggets
NEI.hide(<ThermalFoundation:material:105>);

// extra bronze ingots
NEI.hide(<Forestry:ingotBronze:0>);
NEI.hide(<IC2:itemIngot:2>);
NEI.hide(<Mekanism:Ingot:2>);
NEI.hide(<ThermalFoundation:material:73>);

// extra dusts
NEI.hide(<ImmersiveEngineering:metal:8>);
NEI.hide(<ImmersiveEngineering:metal:9>);
NEI.hide(<ImmersiveEngineering:metal:10>);
NEI.hide(<ImmersiveEngineering:metal:12>);
NEI.hide(<ImmersiveEngineering:metal:13>);
NEI.hide(<ImmersiveEngineering:metal:14>);
NEI.hide(<ImmersiveEngineering:metal:16>);
NEI.hide(<ImmersiveEngineering:metal:18>);

// uncraftable/obsolete/unnamed items
NEI.hide(<appliedenergistics2:tile.BlockCableBus:0>);
NEI.hide(<appliedenergistics2:tile.BlockMatrixFrame:0>);
NEI.hide(<appliedenergistics2:tile.BlockPaint:0>);
NEI.hide(<AWWayofTime:blockDemonChest:0>);
NEI.hide(<AWWayofTime:blockMimic:0>);
NEI.hide(<AWWayofTime:blockSchemSaver:0>);
NEI.hide(<AWWayofTime:bloodLight:0>);
NEI.hide(<AWWayofTime:demonPortalMain:0>);
NEI.hide(<AWWayofTime:spectralBlock:0>);
NEI.hide(<AWWayofTime:spectralContainer:0>);
NEI.hide(<BiblioCraft:BiblioClipboard>);
NEI.hide(<Botania:bifrost:0>);
NEI.hide(<Botania:biomeStoneA0SlabFull:0>);
NEI.hide(<Botania:biomeStoneA10SlabFull:0>);
NEI.hide(<Botania:biomeStoneA11SlabFull:0>);
NEI.hide(<Botania:biomeStoneA12SlabFull:0>);
NEI.hide(<Botania:biomeStoneA13SlabFull:0>);
NEI.hide(<Botania:biomeStoneA14SlabFull:0>);
NEI.hide(<Botania:biomeStoneA15SlabFull:0>);
NEI.hide(<Botania:biomeStoneA1SlabFull:0>);
NEI.hide(<Botania:biomeStoneA2SlabFull:0>);
NEI.hide(<Botania:biomeStoneA3SlabFull:0>);
NEI.hide(<Botania:biomeStoneA4SlabFull:0>);
NEI.hide(<Botania:biomeStoneA5SlabFull:0>);
NEI.hide(<Botania:biomeStoneA6SlabFull:0>);
NEI.hide(<Botania:biomeStoneA7SlabFull:0>);
NEI.hide(<Botania:biomeStoneA8SlabFull:0>);
NEI.hide(<Botania:biomeStoneA9SlabFull:0>);
NEI.hide(<Botania:biomeStoneB0SlabFull:0>);
NEI.hide(<Botania:biomeStoneB1SlabFull:0>);
NEI.hide(<Botania:biomeStoneB2SlabFull:0>);
NEI.hide(<Botania:biomeStoneB3SlabFull:0>);
NEI.hide(<Botania:biomeStoneB4SlabFull:0>);
NEI.hide(<Botania:biomeStoneB5SlabFull:0>);
NEI.hide(<Botania:biomeStoneB6SlabFull:0>);
NEI.hide(<Botania:biomeStoneB7SlabFull:0>);
NEI.hide(<Botania:buriedPetals:*>);
NEI.hide(<Botania:customBrick0SlabFull:0>);
NEI.hide(<Botania:customBrick1SlabFull:0>);
NEI.hide(<Botania:customBrick2SlabFull:0>);
NEI.hide(<Botania:customBrick3SlabFull:0>);
NEI.hide(<Botania:dirtPath0SlabFull:0>);
NEI.hide(<Botania:dreamwood0SlabFull:0>);
NEI.hide(<Botania:dreamwood1SlabFull:0>);
NEI.hide(<Botania:endStoneBrick0SlabFull:0>);
NEI.hide(<Botania:endStoneBrick2SlabFull:0>);
NEI.hide(<Botania:fakeAir:0>);
NEI.hide(<Botania:livingrock0SlabFull:0>);
NEI.hide(<Botania:livingrock1SlabFull:0>);
NEI.hide(<Botania:livingwood0SlabFull:0>);
NEI.hide(<Botania:livingwood1SlabFull:0>);
NEI.hide(<Botania:pavement0SlabFull:0>);
NEI.hide(<Botania:pavement1SlabFull:0>);
NEI.hide(<Botania:pavement2SlabFull:0>);
NEI.hide(<Botania:pavement3SlabFull:0>);
NEI.hide(<Botania:prismarine0SlabFull:0>);
NEI.hide(<Botania:prismarine1SlabFull:0>);
NEI.hide(<Botania:prismarine2SlabFull:0>);
NEI.hide(<Botania:quartzSlabBlazeFull:0>);
NEI.hide(<Botania:quartzSlabDarkFull:0>);
NEI.hide(<Botania:quartzSlabElfFull:0>);
NEI.hide(<Botania:quartzSlabLavenderFull:0>);
NEI.hide(<Botania:quartzSlabManaFull:0>);
NEI.hide(<Botania:quartzSlabRedFull:0>);
NEI.hide(<Botania:quartzSlabSunnyFull:0>);
NEI.hide(<Botania:reedBlock0SlabFull:0>);
NEI.hide(<Botania:solidVine:0>);
NEI.hide(<Botania:stone0SlabFull:0>);
NEI.hide(<Botania:stone10SlabFull:0>);
NEI.hide(<Botania:stone11SlabFull:0>);
NEI.hide(<Botania:stone1SlabFull:0>);
NEI.hide(<Botania:stone2SlabFull:0>);
NEI.hide(<Botania:stone3SlabFull:0>);
NEI.hide(<Botania:stone8SlabFull:0>);
NEI.hide(<Botania:stone9SlabFull:0>);
NEI.hide(<Botania:thatch0SlabFull:0>);
NEI.hide(<BuildCraft|Energy:blockRedPlasma:0>);
NEI.hide(<BuildCraft|Transport:pipeBlock:0>);
NEI.hide(<CarpentersBlocks:blockCarpentersBed:0>);
NEI.hide(<CarpentersBlocks:blockCarpentersDoor:0>);
NEI.hide(<CarpentersBlocks:blockCarpentersSlope:1>);
NEI.hide(<CarpentersBlocks:blockCarpentersSlope:2>);
NEI.hide(<CarpentersBlocks:blockCarpentersSlope:3>);
NEI.hide(<CarpentersBlocks:blockCarpentersSlope:4>);
NEI.hide(<chisel:aluminum_stairs.3:0>);
NEI.hide(<chisel:aluminum_stairs.3:8>);
NEI.hide(<chisel:aluminum_stairs.4:0>);
NEI.hide(<chisel:aluminum_stairs.4:8>);
NEI.hide(<chisel:aluminum_stairs.5:0>);
NEI.hide(<chisel:aluminum_stairs.5:8>);
NEI.hide(<chisel:aluminum_stairs.6:0>);
NEI.hide(<chisel:aluminum_stairs.6:8>);
NEI.hide(<chisel:aluminum_stairs.7:0>);
NEI.hide(<chisel:aluminum_stairs.7:8>);
NEI.hide(<chisel:amber:0>);
NEI.hide(<chisel:bloodBrick:0>);
NEI.hide(<chisel:limestone_slab_top:10>);
NEI.hide(<chisel:limestone_slab_top:11>);
NEI.hide(<chisel:limestone_slab_top:12>);
NEI.hide(<chisel:limestone_slab_top:13>);
NEI.hide(<chisel:limestone_slab_top:14>);
NEI.hide(<chisel:limestone_slab_top:15>);
NEI.hide(<chisel:limestone_slab_top:1>);
NEI.hide(<chisel:limestone_slab_top:2>);
NEI.hide(<chisel:limestone_slab_top:3>);
NEI.hide(<chisel:limestone_slab_top:4>);
NEI.hide(<chisel:limestone_slab_top:5>);
NEI.hide(<chisel:limestone_slab_top:6>);
NEI.hide(<chisel:limestone_slab_top:7>);
NEI.hide(<chisel:limestone_slab_top:8>);
NEI.hide(<chisel:limestone_slab_top:9>);
NEI.hide(<chisel:marble_pillar_slab_top:10>);
NEI.hide(<chisel:marble_pillar_slab_top:11>);
NEI.hide(<chisel:marble_pillar_slab_top:12>);
NEI.hide(<chisel:marble_pillar_slab_top:13>);
NEI.hide(<chisel:marble_pillar_slab_top:14>);
NEI.hide(<chisel:marble_pillar_slab_top:15>);
NEI.hide(<chisel:marble_pillar_slab_top:1>);
NEI.hide(<chisel:marble_pillar_slab_top:2>);
NEI.hide(<chisel:marble_pillar_slab_top:3>);
NEI.hide(<chisel:marble_pillar_slab_top:4>);
NEI.hide(<chisel:marble_pillar_slab_top:5>);
NEI.hide(<chisel:marble_pillar_slab_top:6>);
NEI.hide(<chisel:marble_pillar_slab_top:7>);
NEI.hide(<chisel:marble_pillar_slab_top:8>);
NEI.hide(<chisel:marble_pillar_slab_top:9>);
NEI.hide(<chisel:marble_slab_top:10>);
NEI.hide(<chisel:marble_slab_top:11>);
NEI.hide(<chisel:marble_slab_top:12>);
NEI.hide(<chisel:marble_slab_top:13>);
NEI.hide(<chisel:marble_slab_top:14>);
NEI.hide(<chisel:marble_slab_top:15>);
NEI.hide(<chisel:marble_slab_top:1>);
NEI.hide(<chisel:marble_slab_top:2>);
NEI.hide(<chisel:marble_slab_top:3>);
NEI.hide(<chisel:marble_slab_top:4>);
NEI.hide(<chisel:marble_slab_top:5>);
NEI.hide(<chisel:marble_slab_top:6>);
NEI.hide(<chisel:marble_slab_top:7>);
NEI.hide(<chisel:marble_slab_top:8>);
NEI.hide(<chisel:marble_slab_top:9>);
NEI.hide(<EnderIO:blockLightNode:0>);
NEI.hide(<EnderZoo:enderZooIcon:0>);
NEI.hide(<extracells:ecbaseblock:1>);
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
NEI.hide(<IC2:blockBarrel:0>);
NEI.hide(<IC2:blockCable:0>);
NEI.hide(<IC2:blockDoorAlloy:0>);
NEI.hide(<IC2:blockDynamite:0>);
NEI.hide(<IC2:blockDynamiteRemote:0>);
NEI.hide(<IC2:blockGenerator:4>);
NEI.hide(<IC2:blockLuminator:0>);
NEI.hide(<IC2:blockWall:*>);
NEI.hide(<malisisdoors:curtain:0>);
NEI.hide(<malisisdoors:door_acacia:0>);
NEI.hide(<malisisdoors:door_birch:0>);
NEI.hide(<malisisdoors:door_dark_oak:0>);
NEI.hide(<malisisdoors:door_jungle:0>);
NEI.hide(<malisisdoors:door_spruce>);
NEI.hide(<malisisdoors:factory_door:0>);
NEI.hide(<malisisdoors:forcefieldDoor:0>);
NEI.hide(<malisisdoors:iron_sliding_door:0>);
NEI.hide(<malisisdoors:item.custom_door:0>);
NEI.hide(<malisisdoors:jail_door:0>);
NEI.hide(<malisisdoors:laboratory_door:0>);
NEI.hide(<malisisdoors:null:0>);
NEI.hide(<malisisdoors:saloon:0>);
NEI.hide(<malisisdoors:shoji_door:0>);
NEI.hide(<malisisdoors:vanishing_block_diamond:0>);
NEI.hide(<malisisdoors:wood_sliding_door:0>);
NEI.hide(<Mantle:mantleBook:0>);
NEI.hide(<PneumaticCraft:droneRedstoneEmitter:0>);
NEI.hide(<PneumaticCraft:etchingAcid:0>);
NEI.hide(<ProjRed|Illumination:projectred.illumination.airousLight:0>);
NEI.hide(<statues:statues.showcase:0>);
NEI.hide(<statues:statues.statue:0>);
NEI.hide(<StevesCarts:ModularCart:0>);
NEI.hide(<TConstruct:BattleSignBlock:0>);
NEI.hide(<TConstruct:HeldItemBlock:0>);
NEI.hide(<TConstruct:potionLauncher>.withTag({InfiTool: {Loaded: 0 as byte}}));
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
NEI.hide(<ThermalFoundation:armor.bootsBronze>);
NEI.hide(<ThermalFoundation:armor.bootsCopper>);
NEI.hide(<ThermalFoundation:armor.bootsElectrum>);
NEI.hide(<ThermalFoundation:armor.bootsInvar>);
NEI.hide(<ThermalFoundation:armor.bootsLead>);
NEI.hide(<ThermalFoundation:armor.bootsNickel>);
NEI.hide(<ThermalFoundation:armor.bootsPlatinum>);
NEI.hide(<ThermalFoundation:armor.bootsSilver>);
NEI.hide(<ThermalFoundation:armor.bootsTin>);
NEI.hide(<ThermalFoundation:armor.helmetBronze>);
NEI.hide(<ThermalFoundation:armor.helmetCopper>);
NEI.hide(<ThermalFoundation:armor.helmetElectrum>);
NEI.hide(<ThermalFoundation:armor.helmetInvar>);
NEI.hide(<ThermalFoundation:armor.helmetLead>);
NEI.hide(<ThermalFoundation:armor.helmetNickel>);
NEI.hide(<ThermalFoundation:armor.helmetPlatinum>);
NEI.hide(<ThermalFoundation:armor.helmetSilver>);
NEI.hide(<ThermalFoundation:armor.helmetTin>);
NEI.hide(<ThermalFoundation:armor.legsBronze>);
NEI.hide(<ThermalFoundation:armor.legsCopper>);
NEI.hide(<ThermalFoundation:armor.legsElectrum>);
NEI.hide(<ThermalFoundation:armor.legsInvar>);
NEI.hide(<ThermalFoundation:armor.legsLead>);
NEI.hide(<ThermalFoundation:armor.legsNickel>);
NEI.hide(<ThermalFoundation:armor.legsPlatinum>);
NEI.hide(<ThermalFoundation:armor.legsSilver>);
NEI.hide(<ThermalFoundation:armor.legsTin>);
NEI.hide(<ThermalFoundation:armor.plateBronze>);
NEI.hide(<ThermalFoundation:armor.plateCopper>);
NEI.hide(<ThermalFoundation:armor.plateElectrum>);
NEI.hide(<ThermalFoundation:armor.plateInvar>);
NEI.hide(<ThermalFoundation:armor.plateLead>);
NEI.hide(<ThermalFoundation:armor.plateNickel>);
NEI.hide(<ThermalFoundation:armor.platePlatinum>);
NEI.hide(<ThermalFoundation:armor.plateSilver>);
NEI.hide(<ThermalFoundation:armor.plateTin>);
NEI.hide(<ThermalFoundation:lexicon:1>);
NEI.hide(<ThermalFoundation:tool.axeBronze>);
NEI.hide(<ThermalFoundation:tool.axeCopper>);
NEI.hide(<ThermalFoundation:tool.axeElectrum>);
NEI.hide(<ThermalFoundation:tool.axeInvar>);
NEI.hide(<ThermalFoundation:tool.axeLead>);
NEI.hide(<ThermalFoundation:tool.axeNickel>);
NEI.hide(<ThermalFoundation:tool.axePlatinum>);
NEI.hide(<ThermalFoundation:tool.axeSilver>);
NEI.hide(<ThermalFoundation:tool.axeTin>);
NEI.hide(<ThermalFoundation:tool.bowBronze>);
NEI.hide(<ThermalFoundation:tool.bowCopper>);
NEI.hide(<ThermalFoundation:tool.bowElectrum>);
NEI.hide(<ThermalFoundation:tool.bowInvar>);
NEI.hide(<ThermalFoundation:tool.bowLead>);
NEI.hide(<ThermalFoundation:tool.bowNickel>);
NEI.hide(<ThermalFoundation:tool.bowPlatinum>);
NEI.hide(<ThermalFoundation:tool.bowSilver>);
NEI.hide(<ThermalFoundation:tool.bowTin>);
NEI.hide(<ThermalFoundation:tool.fishingRodBronze>);
NEI.hide(<ThermalFoundation:tool.fishingRodCopper>);
NEI.hide(<ThermalFoundation:tool.fishingRodElectrum>);
NEI.hide(<ThermalFoundation:tool.fishingRodInvar>);
NEI.hide(<ThermalFoundation:tool.fishingRodLead>);
NEI.hide(<ThermalFoundation:tool.fishingRodNickel>);
NEI.hide(<ThermalFoundation:tool.fishingRodPlatinum>);
NEI.hide(<ThermalFoundation:tool.fishingRodSilver>);
NEI.hide(<ThermalFoundation:tool.fishingRodTin>);
NEI.hide(<ThermalFoundation:tool.hoeBronze>);
NEI.hide(<ThermalFoundation:tool.hoeCopper>);
NEI.hide(<ThermalFoundation:tool.hoeElectrum>);
NEI.hide(<ThermalFoundation:tool.hoeInvar>);
NEI.hide(<ThermalFoundation:tool.hoeLead>);
NEI.hide(<ThermalFoundation:tool.hoeNickel>);
NEI.hide(<ThermalFoundation:tool.hoePlatinum>);
NEI.hide(<ThermalFoundation:tool.hoeSilver>);
NEI.hide(<ThermalFoundation:tool.hoeTin>);
NEI.hide(<ThermalFoundation:tool.pickaxeBronze>);
NEI.hide(<ThermalFoundation:tool.pickaxeCopper>);
NEI.hide(<ThermalFoundation:tool.pickaxeElectrum>);
NEI.hide(<ThermalFoundation:tool.pickaxeInvar>);
NEI.hide(<ThermalFoundation:tool.pickaxeLead>);
NEI.hide(<ThermalFoundation:tool.pickaxeNickel>);
NEI.hide(<ThermalFoundation:tool.pickaxePlatinum>);
NEI.hide(<ThermalFoundation:tool.pickaxeSilver>);
NEI.hide(<ThermalFoundation:tool.pickaxeTin>);
NEI.hide(<ThermalFoundation:tool.shearsBronze>);
NEI.hide(<ThermalFoundation:tool.shearsCopper>);
NEI.hide(<ThermalFoundation:tool.shearsElectrum>);
NEI.hide(<ThermalFoundation:tool.shearsInvar>);
NEI.hide(<ThermalFoundation:tool.shearsLead>);
NEI.hide(<ThermalFoundation:tool.shearsNickel>);
NEI.hide(<ThermalFoundation:tool.shearsPlatinum>);
NEI.hide(<ThermalFoundation:tool.shearsSilver>);
NEI.hide(<ThermalFoundation:tool.shearsTin>);
NEI.hide(<ThermalFoundation:tool.shovelBronze>);
NEI.hide(<ThermalFoundation:tool.shovelCopper>);
NEI.hide(<ThermalFoundation:tool.shovelElectrum>);
NEI.hide(<ThermalFoundation:tool.shovelInvar>);
NEI.hide(<ThermalFoundation:tool.shovelLead>);
NEI.hide(<ThermalFoundation:tool.shovelNickel>);
NEI.hide(<ThermalFoundation:tool.shovelPlatinum>);
NEI.hide(<ThermalFoundation:tool.shovelSilver>);
NEI.hide(<ThermalFoundation:tool.shovelTin>);
NEI.hide(<ThermalFoundation:tool.sickleBronze>);
NEI.hide(<ThermalFoundation:tool.sickleCopper>);
NEI.hide(<ThermalFoundation:tool.sickleElectrum>);
NEI.hide(<ThermalFoundation:tool.sickleInvar>);
NEI.hide(<ThermalFoundation:tool.sickleLead>);
NEI.hide(<ThermalFoundation:tool.sickleNickel>);
NEI.hide(<ThermalFoundation:tool.sicklePlatinum>);
NEI.hide(<ThermalFoundation:tool.sickleSilver>);
NEI.hide(<ThermalFoundation:tool.sickleTin>);
NEI.hide(<ThermalFoundation:tool.swordBronze>);
NEI.hide(<ThermalFoundation:tool.swordCopper>);
NEI.hide(<ThermalFoundation:tool.swordElectrum>);
NEI.hide(<ThermalFoundation:tool.swordInvar>);
NEI.hide(<ThermalFoundation:tool.swordLead>);
NEI.hide(<ThermalFoundation:tool.swordNickel>);
NEI.hide(<ThermalFoundation:tool.swordPlatinum>);
NEI.hide(<ThermalFoundation:tool.swordSilver>);
NEI.hide(<ThermalFoundation:tool.swordTin>);
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
