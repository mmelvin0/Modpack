<?php

$apis = [
    'appeng.api',
    'baubles.api',
    'buildcraft.api',
    'cofh.api',
    'ic2.api',
    'thaumcraft.api'
];

foreach (glob(dirname(__DIR__) . '\{client,common,server}\mods{\1.7.10,}\*.jar', GLOB_BRACE) as $file) {
    $zip = new ZipArchive();
    $zip->open($file);
    for ($i = 0; $i < $zip->numFiles; $i++) {
        $name = $zip->getNameIndex($i);
        if (substr($name, -1) === '/') {
            $api = str_replace('/', '.', rtrim($name, '/'));
            if (in_array($api, $apis)) {
                print basename($file) . ': ' . $api . PHP_EOL;
            }
        }
    }
}
