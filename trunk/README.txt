Build Instructions:

1) download and install the "open source flex 3 SDK" from here:

http://opensource.adobe.com/wiki/display/flexsdk/Downloads

2) change directory to the one containing ob_flash.mxml and build using the MXML compiler, e.g.:

mxmlc ob_flash.mxml

If you don't have mxml in your path then you'll need to put the path at the beginning:

~/flex/bin/mxmlc ob_flash.mxml

This should produce a .swf (Shockwave Flash) file which you can open in your browser, or embed in web pages.

