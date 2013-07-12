AC_DEFUN_ONCE([AX_LZMA],
[
  link_lzma="no"
  AC_CHECK_LIB([lzma], [lzma_code], 
    [LZMA_LIB="-llzma"; AC_SUBST(LZMA_LIB) link_lzma="yes"; break],
    [link_lzma="no"]
  )

  if test "$link_lzma" = "no"
  then
    AC_MSG_ERROR(LZMA library not found)
  fi
])
