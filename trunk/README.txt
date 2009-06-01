Build Instructions:
===================

1) Download and install the "open source flex 3 SDK" from here:

http://opensource.adobe.com/wiki/display/flexsdk/Downloads

Just unzip it into (e.g.) ~/flex

1b) (On linux) You may need to run dos2unix on the shell scripts in ~/flex/bin, else
you will get messages about /bin/sh bad filename

1b) Prepare the SDK for localization: 
cd ~/flex/bin
copylocale en_US fr_FR

2) Change directory to the one containing ob_flash.mxml and build using the MXML compiler, e.g.:

~/flex/bin/mxmlc -locale=en_US,fr_FR -source-path+=locale/{locale} ob_flash.mxml

This should produce a .swf (Shockwave Flash) file which you can open in your browser, or embed in web pages.

