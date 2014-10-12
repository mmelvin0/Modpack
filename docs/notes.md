Client-Side-Only Mods
=====================

+ BetterTitleScreen


Server Notes
============

Seems like the server unloads the overworld after it starts the first time?
DIdn't happen the second time I tried to start the server...
Nope, happens every time, must bisect
Common mods: AsieLib, CodeChickenCore, CoFHCore, Mantle, TConstruct, Thaumcraft
It was cased by the TooMuchTime mode (setting keepLoaded for WorldProvider 0 to false)

For Biomes'O'Plenty, set level-type in server.properties to BIOMESOP


Miscelany
=========

AWWayofTime.cfg = Blood Magic


RandomThings
============

This mod randomizes the menu screen backgrounds. Can be disabled via config.

Hardcore Darkness makes it dark EVERYWHERE there is light level 0, not just underground.
Makes night time something to avoid like the plague.


RotaryCraft
============

Change "Freeze Potion ID" to avoid conflict with Ars Magicka and Biomes'o'Plenty
Potion IDs 1 - 110 are used, and also 288
