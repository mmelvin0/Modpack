import minetweaker.data.IData;
import minetweaker.item.IItemStack;
import minetweaker.item.IIngredient;
import minetweaker.liquid.ILiquidStack;

function unifyMetal(ore as IIngredient, oreNugget as IIngredient, oreIngot as IIngredient, oreBlock as IIngredient, oreCluster as IIngredient,
                    oreDust as IIngredient, oreCrushed as IIngredient, oreCrushedPurified as IIngredient, liquid as ILiquidStack,
                    realNugget as IItemStack, realIngot as IItemStack, realBlock as IItemStack,
                    banIngots as IItemStack[], banBlocks as IItemStack[])
{
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
    furnace.addRecipe(realIngot, ore);
    furnace.addRecipe(realIngot, oreDust);
    furnace.addRecipe(realIngot, oreCrushed);
    furnace.addRecipe(realIngot, oreCrushedPurified);
    furnace.addRecipe(realIngot * 2, oreCluster);

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
        mods.mariculture.Crucible.addRecipe(1085, item, liquid * 288);
    }

    // tinker's construct
    for item in banIngots {
        mods.tconstruct.Casting.removeTableRecipe(item);
    }
    for item in banBlocks {
        mods.tconstruct.Casting.removeBasinRecipe(item);
    }
    mods.tconstruct.Casting.addTableRecipe(realIngot * 1, liquid * 144, <TConstruct:metalPattern>, false, 20);
    mods.tconstruct.Casting.addBasinRecipe(realBlock * 1, liquid * 1296, null, false, 20);
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

unifyMetal(<ore:oreCopper>, <ore:nuggetCopper>, <ore:ingotCopper>, <ore:blockCopper>, <ore:clusterCopper>,
           <ore:dustCopper>, <ore:crushedCopper>, <ore:crushedPurifiedCopper>, <liquid:copper.molten>,
           <Thaumcraft:ItemNugget:1>, <ThermalFoundation:material:64>, <TConstruct:MetalBlock:3>,
           [<IC2:itemIngot:0>], [<IC2:blockMetal:0>]);

unifyMetal(<ore:oreTin>, <ore:nuggetTin>, <ore:ingotTin>, <ore:blockTin>, <ore:clusterTin>,
           <ore:dustTin>, <ore:crushedTin>, <ore:crushedPurifiedTin>, <liquid:tin.molten>,
           <Thaumcraft:ItemNugget:2>, <ThermalFoundation:material:65>, <TConstruct:MetalBlock:5>,
           [<IC2:itemIngot:1>], [<IC2:blockMetal:1>]);

unifyMetal(<ore:oreIron>, <ore:nuggetIron>, <ore:ingotIron>, <ore:blockIron>, <ore:clusterIron>,
           <ore:dustIron>, <ore:crushedIron>, <ore:crushedPurifiedIron>, <liquid:iron.molten>,
           <Thaumcraft:ItemNugget:0>, <minecraft:iron_ingot:0>, <minecraft:iron_block:0>,
           [], []);

unifyMetal(<ore:oreSilver>, <ore:nuggetSilver>, <ore:ingotSilver>, <ore:blockSilver>, <ore:clusterSilver>,
           <ore:dustSilver>, <ore:crushedSilver>, <ore:crushedPurifiedSilver>, <liquid:silver.molten>,
           <Thaumcraft:ItemNugget:3>, <ThermalFoundation:material:66>, <ThermalFoundation:Storage:2>,
           [<IC2:itemIngot:6>], []);

unifyMetal(<ore:oreGold>, <ore:nuggetGold>, <ore:ingotGold>, <ore:blockGold>, <ore:clusterGold>,
           <ore:dustGold>, <ore:crushedGold>, <ore:crushedPurifiedGold>, <liquid:gold.molten>,
           <minecraft:gold_nugget:0>, <minecraft:gold_ingot:0>, <minecraft:gold_block:0>,
           [], []);

unifyMetal(<ore:oreLead>, <ore:nuggetLead>, <ore:ingotLead>, <ore:blockLead>, <ore:clusterLead>,
           <ore:dustLead>, <ore:crushedLead>, <ore:crushedPurifiedLead>, <liquid:lead.molten>,
           <Thaumcraft:ItemNugget:4>, <ThermalFoundation:material:67>, <Railcraft:tile.railcraft.cube:11>,
           [<IC2:itemIngot:5>], [<IC2:blockMetal:4>]);

unifyMetal(<ore:oreNickel>, <ore:nuggetNickel>, <ore:ingotNickel>, <ore:blockNickel>, <ore:clusterNickel>,
           <ore:dustNickel>, <ore:crushedNickel>, <ore:crushedPurifiedNickel>, <liquid:nickel.molten>,
           <ThermalFoundation:material:100>, <ThermalFoundation:material:68>, <ThermalFoundation:Storage:4>,
           [], []);

unifyMetal(<ore:oreAluminium>, <ore:nuggetAluminium>, <ore:ingotAluminium>, <ore:blockAluminium>, <ore:clusterAluminium>,
           <ore:dustAluminium>, <ore:crushedAluminium>, <ore:crushedPurifiedAluminium>, <liquid:aluminum.molten>,
           <TConstruct:materials:22>, <TConstruct:materials:11>, <TConstruct:MetalBlock:6>,
           [], []);

unifyMetal(<ore:oreRutile>, <ore:nuggetRutile>, <ore:ingotRutile>, <ore:blockRutile>, <ore:clusterRutile>,
           <ore:dustRutile>, <ore:crushedRutile>, <ore:crushedPurifiedRutile>, <liquid:rutile.molten>,
           <Mariculture:materials:37>, <Mariculture:materials:3>, <Mariculture:metals:2>,
           [], []);

unifyMetal(<ore:orePlatinum>, <ore:nuggetPlatinum>, <ore:ingotPlatinum>, <ore:blockPlatinum>, <ore:clusterPlatinum>,
           <ore:dustPlatinum>, <ore:crushedPlatinum>, <ore:crushedPurifiedPlatinum>, <liquid:platinum.molten>,
           <ThermalFoundation:material:101>, <ThermalFoundation:material:69>, <ThermalFoundation:Storage:5>,
           [], []);

unifyMetal(<ore:oreCobalt>, <ore:nuggetCobalt>, <ore:ingotCobalt>, <ore:blockCobalt>, <ore:clusterCobalt>,
           <ore:dustCobalt>, <ore:crushedCobalt>, <ore:crushedPurifiedCobalt>, <liquid:cobalt.molten>,
           <TConstruct:materials:28>, <TConstruct:materials:3>, <TConstruct:MetalBlock:0>,
           [], []);

unifyMetal(<ore:oreArdite>, <ore:nuggetArdite>, <ore:ingotArdite>, <ore:blockArdite>, <ore:clusterArdite>,
           <ore:dustArdite>, <ore:crushedArdite>, <ore:crushedPurifiedArdite>, <liquid:ardite.molten>,
           <TConstruct:materials:29>, <TConstruct:materials:4>, <TConstruct:MetalBlock:1>,
           [], []);
