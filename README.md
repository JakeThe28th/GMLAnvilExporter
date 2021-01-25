# GMLAnvilExporter

You can click to button on the top of the screen and select a level.dat in a world folder to start loading a world.

---------------------------------

(When i add exporting chunks via GUI):

You have to put the assets in "AppData\Local\AnvilExporter\pack".
For example, you extract 1.16.4.jar, you copy the assets folder into "AppData\Local\AnvilExporter\pack",
so the path would be "AppData\Local\AnvilExporter\pack\assets\minecraft\..." etc.

---------------------------------

For using custom resource packs, you'll have to merge them manually. 
So paste the resource pack's assets folder into the same place, and have windows replace any files that exist there already. 
If it's done right, then everything in the folder should be vanilla other than whatever your resource pack specifically changes.


# some credits

Thanks to the developers of Mine-Imator, the developers of MCASelector, and the creators of 7Zip.

I used file.dll from Mine-Imator to decompress gzip compressed files,
I used code from MCASelector to read block indexes
I used 7Zip to save compressed files.
