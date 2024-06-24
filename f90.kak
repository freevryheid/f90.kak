# https://fortran-lang.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*\.(f|f90|f95|f03|f08|F90|F95|F03|F08) %{
    set-option buffer filetype fortran
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=fortran %{
    require-module fortran
    hook window InsertChar \n -group fortran-indent fortran-indent-on-new-line
    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window fortran-.+ }
}

hook global BufSetOption filetype=fortran %{
    set-option buffer comment_line '!'
    map global normal '!' :comment-line<ret>
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
    add-highlighter shared/fortran/code/ regex (?i)\b[+-]?(\d*\.)?\d*([edq][+-]?\d+)?(_\w+)?\b 0:value

    add-highlighter shared/fortran/code/ regex (?i)\b(in|out|inout)\b 0:value
    add-highlighter shared/fortran/code/ regex (?i)\.\b(true|false)\b\. 0:value

    add-highlighter shared/fortran/code/ regex (?i)\.\b(and|or|not|eqv|neqv|eq|ne|gt|lt|ge|le)\b\. 0:operator
    add-highlighter shared/fortran/code/ regex \s*(\+|-|/|\*|=|/=|<|>)\s* 0:operator
    # add-highlighter shared/fortran/code/ regex (?i)\b(elemental|forall|abs)\b 0:keyword

    # add-highlighter shared/fortran/code/ regex (?i)\b(achar|acos|acosh|adjustl|adjustr|aimag|aint|anint|asin|asinh|atan|atan2|atanh|bessel_j0|bessel_j1|bessel_jn|bessel_y0|bessel_y1|bessel_yn|bge|bgt|ble|blt|btest|ceiling|char|cmplx|conjg|cos|cosh|dble|dim|dprod|dshiftl|dshiftr|erf|erfc|erfc_scaled|exp|exponent|floor|fraction|gamma|hypot|iachar|iand|ibclr|ibits|ibset|ichar|ieee_class|ieee_copy_sign|ieee_fma|ieee_get_flag|ieee_get_halting_mode|ieee_int|ieee_is_finite|ieee_is_nan|ieee_is_negative|ieee_is_normal|ieee_logb|ieee_max_num|ieee_max_num_mag|ieee_min_num|ieee_min_num_mag|ieee_next_after|ieee_next_down|ieee_next_up|ieee_quiet_eq|ieee_quiet_ge|ieee_quiet_gt|ieee_quiet_le|ieee_quiet_lt|ieee_quiet_nan|ieee_quiet_ne|ieee_real|ieee_rem|ieee_rint|ieee_scalb|ieee_signaling_eq|ieee_signaling_ge|ieee_signaling_gt|ieee_signaling_le|ieee_signaling_lt|ieee_signaling_ne|ieee_signbit|ieee_unordered|ieee_value|ieor|image_status|int|ior|ishft|ishftc|leadz|len_trim|lge|lgt|lle|llt|log|log_gamma|log10|logical|maskl|maskr|max|min|mod|modulo|mvbits|nearest|nint|not|out_of_range|popcnt|poppar|real|scale|scan|set_exponent|shape|shifta|shiftl|shiftr|sign|sin|sinh|spacing|sqrt|tan|tanh|trailz|verify|allocated|associated|bit_size|c_sizeof|coshape|digits|epsilon|extends_type_of|failed_images|huge|ieee_support_datatype|ieee_support_denormal|ieee_support_divide|ieee_support_inf|ieee_support_io|ieee_support_nan|ieee_support_sqrt|ieee_support_standard|ieee_support_subnormal|ieee_support_underflow_control|is_contiguous|is_iostat_end|is_iostat_eor|kind|lbound|lcobound|len|maxexponent|minexponent|new_line|precision|present|radix|range|rank|same_type_as|size|storage_size|tiny|ubound|ucobound|all|any|bessel_jn|bessel_yn|c_associated|c_funloc|c_loc|command_argument_count|compiler_options|compiler_version|count|cshift|dot_product|eoshift|findloc|get_team|iall|iany|ieee_selected_real_kind|ieee_support_flag|ieee_support_halting|ieee_support_rounding|image_index|index|iparity|matmul|maxloc|maxval|merge|merge_bits|minloc|minval|norm2|null|num_images|pack|parity|product|reduce|repeat|reshape|selected_char_kind|selected_int_kind|selected_real_kind|spread|stopped_images|sum|team_number|this_image|transpose|trim|unpack|cfi_address|cfi_allocate|cfi_deallocate|cfi_establish|cfi_is_contiguous|cfi_section|cfi_select_part|cfi_setpointer)\b 0:function

    add-highlighter shared/fortran/code/ regex (?i)\b(assign|backspace|block|data|call|close|common|continue|data|dimension|do|else|if|elseif|end|endfunction|endsubroutine)\b 0:keyword
    add-highlighter shared/fortran/code/ regex (?i)\b(endfile|endif|entry|equivalence|external|format|function|goto|inquire|intrinsic|open)\b 0:keyword
    add-highlighter shared/fortran/code/ regex (?i)\b(parameter|pause|print|program|read|return|rewind|rewrite|save|stop|subroutine|then|write|enddo|endprogram)\b 0:keyword
    add-highlighter shared/fortran/code/ regex (?i)\b(allocatable|allocate|case|contains|cycle|deallocate|elsewhere|exit?|include|interface|endinterface|intent|module|endmodule)\b 0:keyword
    add-highlighter shared/fortran/code/ regex (?i)\b(namelist|nullify|only|operator|optional|pointer|private|procedure|public|recursive|result|select|selectcase|endselect|sequence|target|use|while|where)\b 0:keyword
    add-highlighter shared/fortran/code/ regex (?i)\b(elemental|forall|abs)\b 0:keyword
    add-highlighter shared/fortran/code/ regex (?i)\b(abstract|associate|asynchronous|bind|class|deferred|enum|enumerator|extends|final|flush|generic|import|non_overridable|nopass)\b 0:keyword
    add-highlighter shared/fortran/code/ regex (?i)\b(pass|protected|value|volatile|wait)\b 0:keyword
    add-highlighter shared/fortran/code/ regex (?i)\b(block|codimension|concurrent|contiguous|critical|error|submodule|sync|all|images|memory|lock|unlock)\b 0:keyword

    add-highlighter shared/fortran/code/ regex (?i)\b(integer|double|precision|real|character|logical|complex|pure|impure|type|endtype|implicit|none|default)\b 0:type
    add-highlighter shared/fortran/code/ regex (:|%) 0:type

    add-highlighter shared/fortran/code/ regex (?i)\b(abort|abs|access|achar|acos|acosd|acosh|adjustl|adjustr|aimag|aint|alarm|all|allocated|and|anint|any)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(asin|asind|asinh|associated|atan|atand|atan2|atan2d|atanh|atomic_add|atomic_and|atomic_cas)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(atomic_define|atomic_fetch_add|atomic_fetch_and|atomic_fetch_or|atomic_fetch_xor|atomic_or)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(atomic_ref|atomic_xor|backtrace|bessel_j0|bessel_j1|bessel_jn|bessel_y0|bessel_y1|bessel_yn)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(bge|bgt|bit_size|ble|blt|btest|c_associated|c_f_pointer|c_f_procpointer|c_funloc|c_loc|c_sizeof|ceiling)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(char|chdir|chmod|cmplx|co_broadcast|co_max|co_min|co_reduce|co_sum|command_argument_count|compiler_options)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(compiler_version|conjg|cos|cosd|cosh|cotan|cotand|count|cpu_time|cshift|ctime|date_and_time|dble|dcmplx|digits|dim|dot_product|dprod|dreal)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(dshiftl|dshiftr|dtime|eoshift|epsilon|erf|erfc|erfc_scaled|etime|event_query|execute_command_line|exit|exp|exponent|extends_type_of|fdate)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(fget|fgetc|findloc|floor|flush|fnum|fput|fputc|fraction|free|fseek|fstat|ftell|gamma|gerror|getarg|get_command|get_command_argument|getcwd)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(getenv|get_environment_variable|getgid|getlog|getpid|getuid|gmtime|hostnm|huge|hypot|iachar|iall|iand|iany|iargc|ibclr|ibits|ibset|ichar)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(idate|ieor|ierrno|image_index|index|int|int2|int8|int16|int32|int64|sp|dp|xdp|ior|iparity|irand|is_contiguous|is_iostat_end|is_iostat_eor|isatty|ishft|ishftc|isnan)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(itime|kill|kind|lbound|lcobound|leadz|len|len_trim|lge|lgt|link|lle|llt|lnblnk|loc|log|log10|log_gamma|long|lshift|lstat|ltime|malloc)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(maskl|maskr|matmul|max|maxexponent|maxloc|maxval|mclock|mclock8|merge|merge_bits|min|minexponent|minloc|minval|mod|modulo|move_alloc)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(mvbits|nearest|new_line|nint|norm2|not|null|num_images|or|pack|parity|perror|popcnt|poppar|precision|present|product|radix|ran)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(rand|random_init|random_number|random_seed|range|rank|rename|repeat|reshape|rrspacing|rshift|same_type_as|scale|scan|secnds|second)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(selected_char_kind|selected_int_kind|selected_real_kind|set_exponent|shape|shifta|shiftl|shiftr|sign|signal|sin|sind|sinh|size|sizeof)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(sleep|spacing|spread|sqrt|srand|stat|storage_size|sum|symlnk|system|system_clock|tan|tand|tanh|this_image|time|time8|tiny|trailz|transfer)\b 0:function
    add-highlighter shared/fortran/code/ regex (?i)\b(transpose|trim|ttynam|ubound|ucobound|umask|unlink|unpack|verify|xor)\b 0:function

    add-highlighter shared/fortran/code/ regex (&|\;) 0:function

}

# Commands
# ‾‾‾‾‾‾‾‾

define-command -hidden fortran-indent-on-new-line %{
    evaluate-commands -no-hooks -draft -itersel %{
       # preserve previous line indent
       try %{ execute-keys -draft <semicolon> K <a-&> }
       # cleanup trailing whitespaces from previous line
       # try %{ execute-keys -draft k <a-x> s \h+$ <ret> d }
       try %{ execute-keys -draft k x s \h+$ <ret> d }
       # indent after certain keywords
       # try %{ execute-keys -draft k <a-x> <a-k> (?i)(if|then|contains|else)\h*$<ret> j <a-gt> }
       try %{ execute-keys -draft k x <a-k> (?i)(if|then|contains|else)\h*$<ret> j <a-gt> }
       # indent lines that start with certian keywords
       # try %{ execute-keys -draft k <a-x> <a-k> (?i)(do|interface|case)\s.*$<ret> j <a-gt> }
       try %{ execute-keys -draft k x <a-k> (?i)(do|interface|case)\s.*$<ret> j <a-gt> }
       # indent lines that start with certian keywords
       # try %{ execute-keys -draft k <a-x> y <a-k> (?i)^\h*(program|subroutine|function|module)\s+\w+[^(]*$<ret> p p j j I end , <esc> k <a-b> <semicolon> 2W d <a-gt>}
       # try %{ execute-keys -draft k x y <a-k> (?i)^\h*(program|subroutine|function|module)\s+\w+[^(]*$<ret> p I end , <esc> k <a-b> <semicolon> 2W d <a-gt>}
    }
}
