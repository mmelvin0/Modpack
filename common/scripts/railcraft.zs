import minetweaker.item.IIngredient;
import minetweaker.item.IItemStack;

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

// copper
fixRailcraftSlabsAndStairs(<TConstruct:MetalBlock:3>, <Railcraft:tile.railcraft.slab:39>, <Railcraft:tile.railcraft.stair:39>);

// tin
fixRailcraftSlabsAndStairs(<TConstruct:MetalBlock:5>, <Railcraft:tile.railcraft.slab:40>, <Railcraft:tile.railcraft.stair:40>);

// steel
fixRailcraftSlabsAndStairs(<TConstruct:MetalBlock:9>, <Railcraft:tile.railcraft.slab:42>, <Railcraft:tile.railcraft.stair:42>);
