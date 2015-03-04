// facades and microblocks
BC.obliterate_facades(0);
ForgeMicroblock.obliterate_microblocks([1, 2, 4, 257, 258, 260, 513, 514, 516, 769, 770, 772], 'tile.stone');
NEI.override(AE2.getFacadeItem(), [0]);

// liquid containers
NEI.override('extracells:pattern.fluid', [0]);
NEI.override('IC2:itemFluidCell', [0]);
NEI.override('Mekanism:GasTank', [100]);
NEI.override('ThermalExpansion:florb', [0, 1]);

// bibliocraft
NEI.override('BiblioCraft:*', [0]);
NEI.hide('BiblioWoodsBoP:*');
NEI.hide('BiblioWoodsForestry:*');
