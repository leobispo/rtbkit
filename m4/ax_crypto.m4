AC_DEFUN_ONCE([AX_CRYPTO],
[
  link_crypto="no"
  AC_CANONICAL_HOST

  AC_CHECK_HEADERS(
    [cryptopp/sha.h cryptopp/md5.h cryptopp/adler32.h cryptopp/hex.h cryptopp/base64.h cryptopp/hmac.h cryptopp/cryptlib.h], ,
    [AC_MSG_ERROR("Required Crypto++ headers not found.")]
  )

  AC_CHECK_LIB([cryptopp], [main], 
    [CRYPTO_LIB="-lcryptopp"; AC_SUBST(CRYPTO_LIB) link_crypto="yes"; break],
    [link_crypto="no"]
  )

  if test "$link_crypto" = "no"
  then
    AC_MSG_ERROR(Crypto++ library not found)
  fi
])
