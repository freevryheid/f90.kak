# https://fortran-lang.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*\.(f90|f95|f03|f08) %{
    set-option buffer filetype fortran
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=fortran %{
    require-module fortran
}

hook -group fortran-highlight global WinSetOption filetype=fortran %{
    add-highlighter window/fortran ref fortran
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/fortran }
}


provide-module fortran %{

    # Highlighters
    # ‾‾‾‾‾‾‾‾‾‾‾‾

    add-highlighter shared/fortran regions
    add-highlighter shared/fortran/code default-region group
    add-highlighter shared/fortran/string1  region "'" "'" fill string
    add-highlighter shared/fortran/string2  region '"' '"' fill string
    add-highlighter shared/fortran/comment  region '!' '$' fill comment

    add-highlighter shared/fortran/code/ regex \b([\-]?\d+[E]?[\+]?[\-]?[\.]?) 0:value
    add-highlighter shared/fortran/code/ regex \b(in|out|inout)\b 0:value
    add-highlighter shared/fortran/code/ regex \.\b(true|false)\b\. 0:value
    add-highlighter shared/fortran/code/ regex \.\b(and|or|not|eqv|neqv|eq|ne|gt|lt|ge|le)\b\. 0:operator
    add-highlighter shared/fortran/code/ regex \b(assign|backspace|block|data|call|close|common|continue|data|dimension|do|else|if|end|endfile|endif|entry|equivalence|external|format|function|goto|inquire|intrinsic|open|parameter|pause|print|program|read|return|rewind|rewrite|save|stop|subroutine|then|write|enddo)\b 0:keyword
    add-highlighter shared/fortran/code/ regex \b(allocatable|allocate|case|contains|cycle|deallocate|elsewhere|exit?|include|interface|intent|module|namelist|nullify|only|operator|optional|pointer|private|procedure|public|recursive|result|select|sequence|target|use|while|where)\b 0:keyword
    add-highlighter shared/fortran/code/ regex \b(elemental|forall|abs)\b 0:keyword
    add-highlighter shared/fortran/code/ regex \b(abstract|associate|asynchronous|bind|class|deferred|enum|enumerator|extends|final|flush|generic|import|non_overridable|nopass|pass|protected|value|volatile|wait)\b 0:keyword
    add-highlighter shared/fortran/code/ regex \b(block|codimension|concurrent|contiguous|critical|error|submodule|sync|all|images|memory|lock|unlock)\b 0:keyword
    add-highlighter shared/fortran/code/ regex \b(integer|double|precision|real|character|logical|complex|ipure|impure|type|implicit|none)\b 0:type
    add-highlighter shared/fortran/code/ regex \b(abs)\b 0:function

}

# face global value ${orange_dark}+b
# face global type ${orange_light}
# face global variable ${magenta_dark}
# face global module ${green_dark}
# face global function ${cyan_light}
# face global string ${green_dark}
# face global keyword ${purple_dark}+b
# face global operator ${cyan_light}
# face global attribute ${orange_dark}
# face global comment ${grey_dark}
# face global documentation comment
# face global meta ${orange_light}
# face global builtin default+b

