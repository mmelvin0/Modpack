BC.obliterate_facades(0);
ForgeMicroblock.obliterate_microblocks([1, 2, 4, 257, 258, 260, 513, 514, 516, 769, 770, 772], ForgeMicroblock.getRandomMaterial());

NEI.hide('BiblioWoodsBoP:*');
NEI.hide('BiblioWoodsForestry:*');
NEI.hide('minecraft:end_portal');
NEI.hide('minecraft:fire');
NEI.hide('minecraft:portal');
NEI.override('BiblioCraft:*', [0]);
NEI.override('Mekanism:GasTank', [100]);
NEI.override('minecraft:potion', [0]);
NEI.override('ThermalExpansion:florb', [0, 1]);
NEI.override(AE2.getFacadeItem(), [java.random(AE2.getNumberOfTypes())]);
