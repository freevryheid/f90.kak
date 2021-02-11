# f90.kak
modern fortran syntax for kakoune editor

just copy or link f90.kak to your autoload folder

preferably use a colorscheme that distinguishes functions and keywords e.g. palenight

this provides syntax for how i prefer to code fortran, so, for example, i would code this:

(x1 - -3.1*sin(x)) as ( x1 - -3.1 * sin( x ) )

i.e spaces before and after parenthesis and spaces between operators (+-/*)

2 spaces are used for indentation and gnu-fortran keywords and function are included.

these defaults and behaviours, of course, can easily be changed be editing the .kak file
using kakoune scripting.


