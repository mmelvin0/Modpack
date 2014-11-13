recipes.remove(<chisel:cloudinabottle:0>);
mods.nei.NEI.hide(<chisel:cloudinabottle:0>);

furnace.remove(<chisel:concrete:*>);
for item in <ore:gravel>.items {
    mods.thermalexpansion.Furnace.removeRecipe(item);
}
mods.nei.NEI.hide(<chisel:concrete:*>);
