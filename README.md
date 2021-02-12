# f90.kak
modern fortran syntax for kakoune editor

STILL UNDER CONSTRUCTION !!!

just copy or link f90.kak to your autoload folder.

preferably use a colorscheme that distinguishes functions and keywords e.g. palenight.

2 spaces are used for indentation and gnu-fortran keywords and functions are included. both lower- and upper-case supported. this is strictly free-form format and I don't have plans right now to develop kak syntax for pre-f90 or fixed format files.

these defaults and behaviours, of course, can easily be changed by editing the .kak file
using kakoune's very flexible scripting. https://github.com/mawww/kakoune/tree/master/rc/filetype provides examples of syntax for other built-in languages.

i'll continue to update this file as i come across missing elements. PR's welcome.

an example showing the syntax using the palenight colorscheme is shown below:

<img src="example.png" alt="kak fortran syntax" />
