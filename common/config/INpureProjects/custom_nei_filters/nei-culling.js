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
