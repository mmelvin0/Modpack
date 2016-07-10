// facades and microblocks
BC.obliterate_facades(0);
ExtraUtilities.obliterate_microblocks([0, 1, 2, 3], 'tile.stone');
ForgeMicroblock.obliterate_microblocks([1, 2, 4, 257, 258, 260, 513, 514, 516, 769, 770, 772], 'tile.stone');
NEI.override(AE2.getFacadeItem(), [0]);

// liquid containers
NEI.override('extracells:pattern.fluid', [0]);
NEI.override("ExtraUtilities:drum", [0, 1]);
NEI.override('ForbiddenMagic:MobCrystal', [0]);
NEI.override('IC2:itemFluidCell', [0]);
NEI.override('ThermalExpansion:florb', [0, 1]);

// bibliocraft
NEI.hide('BiblioWoodsBoP:*');
NEI.hide('BiblioWoodsForestry:*');

// growthcraft
NEI.hide('Growthcraft|Apples:grc.appleCiderFluid.*');
NEI.hide('Growthcraft|Grapes:grc.grapeWineFluid.*');
NEI.hide('Growthcraft|Hops:grc.lagerFluid.*');
NEI.hide('Growthcraft|Hops:grc.hopAleFluid.*');
NEI.hide('Growthcraft|Rice:grc.riceSakeFluid.*');

// fluid blocks
NEI.hide('Automagy:blockFluid*');
NEI.hide('AWWayofTime:lifeEssence');
NEI.hide('BigReactors:tile.fluid.*');
NEI.hide('BiomesOPlenty:hell_blood');
NEI.hide('BiomesOPlenty:honey');
NEI.hide('BiomesOPlenty:poison');
NEI.hide('BuildCraft|Energy:blockFuel');
NEI.hide('BuildCraft|Energy:blockOil');
NEI.hide('EnderIO:blockCloud_seed');
NEI.hide('EnderIO:blockCloud_seed_concentrated');
NEI.hide('EnderIO:blockFire_water');
NEI.hide('EnderIO:blockHootch');
NEI.hide('EnderIO:blockLiquid_sunshine');
NEI.hide('EnderIO:blockNutrient_distillation');
NEI.hide('EnderIO:blockRocket_fuel');
NEI.hide('Forestry:fluid.*');
NEI.hide('GalacticraftMars:tile.sludge');
NEI.hide('HardcoreEnderExpansion:ender_goo');
NEI.hide('IC2:fluid*');
NEI.hide('Mariculture:chlorophyll');
NEI.hide('Mariculture:custard');
NEI.hide('Mariculture:fish_oil');
NEI.hide('Mariculture:flux_molten');
NEI.hide('Mariculture:gunpowder_molten');
NEI.hide('Mariculture:highPressureWater');
NEI.hide('minecraft:flowing_lava');
NEI.hide('minecraft:flowing_water');
NEI.hide('minecraft:lava');
NEI.hide('minecraft:water');
NEI.hide('PneumaticCraft:diesel');
NEI.hide('PneumaticCraft:fuel');
NEI.hide('PneumaticCraft:kerosene');
NEI.hide('PneumaticCraft:lpg');
NEI.hide('PneumaticCraft:lubricant');
NEI.hide('PneumaticCraft:oil');
NEI.hide('Railcraft:fluid.creosote');
NEI.hide('TConstruct:fluid.ender');
NEI.hide('TConstruct:fluid.molten.*');
NEI.hide('TConstruct:liquid.*');
NEI.hide('TConstruct:molten.*');
NEI.hide('Thaumcraft:blockFluidDeath');
NEI.hide('Thaumcraft:blockFluidPure');
NEI.hide('Thaumcraft:blockFluxGas');
NEI.hide('Thaumcraft:blockFluxGoo');
NEI.hide('ThermalFoundation:Fluid*');
NEI.hide('TSteelworks:liquid.cement');
NEI.hide('TSteelworks:molten.limestone');
NEI.hide('witchery:disease');
NEI.hide('witchery:hollowtears');
NEI.hide('witchery:spiritflowing');
