ADDR='org.gnome.desktop.interface'
DARK="'prefer-dark'"
LIGHT="'prefer-light'"
SCHEME=`gsettings get ${ADDR} color-scheme`
if [ "$SCHEME" = "$DARK" ]; then
  gsettings set ${ADDR} color-scheme ${LIGHT}
else
  gsettings set ${ADDR} color-scheme ${DARK}
fi
