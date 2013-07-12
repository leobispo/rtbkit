AC_DEFUN([AX_TEST], [

cat << _ACEOF >runjstest.sh
#!/bin/sh

NODE_LIBS=\`echo \$NODE_LIBS | sed "s/;/ /g"\`

err=0

red='@<:@0;31m'
grn='@<:@0;32m'
lgn='@<:@1;32m'
blu='@<:@1;34m'
std='@<:@m'

DIR_NAME=\`dirname "\${0}"\`
DIR=\`cd \$DIR_NAME; pwd; cd -\`

for i in \`find \$DIR -name ".libs"\`
do
  NODE_PATH="\$NODE_PATH:\$i"
  LD_LIBRARY_PATH="\$LD_LIBRARY_PATH:\$i"
done

if [[ -d ./testing/ ]]
then
  cd testing
fi

export NODE_PATH=\$NODE_PATH:.
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:.
for i in \`find . -name "*_test.js" -o -name "*_test.coffee" | cut -d\/ -f2-\`
do
  \$NODE \$VOWS ./\$i > /dev/null 2>&1
  if [[ \$? -ne 0 ]]
  then
    echo "\${red}FAIL:\${std} \$i";
    err=1
  else
    echo "\${grn}PASS:\${std} \$i";
  fi
done

exit \$err
_ACEOF

chmod +x runjstest.sh

cat << _ACEOF >test_driver.sh
#!/bin/sh

if [[ \${#} -eq 1 ]]
then
  exec \${1}  > /dev/null 2>&1
else
  NL=\`echo \${3} | sed "s/ /;/g"\`

  export \${1}
  export \${2}
  export \$NL

  string="\${4}"
  substring="runjstest"
  if test "\${string#*\$substring}" != "\$string"
  then
    exec \${4}
  else
    exec \${4} > /dev/null 2>&1
  fi
fi

_ACEOF

chmod +x test_driver.sh
])
