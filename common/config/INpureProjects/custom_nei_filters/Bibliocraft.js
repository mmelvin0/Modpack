if (Bibliocraft_enabled) {
    if (FML.isModLoaded('BiblioCraft')) {
        NEI.override("BiblioCraft:*", [0]);
    }
    if (FML.isModLoaded('BiblioWoodsBoP')) {
        NEI.hide("BiblioWoodsBoP:*");
    }
    if (FML.isModLoaded('BiblioWoodsForestry')) {
        NEI.hide("BiblioWoodsForestry:*");
    }
}
