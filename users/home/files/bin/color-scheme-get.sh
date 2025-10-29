sleep 0.1
RES=`gsettings get org.gnome.desktop.interface color-scheme`
echo "{\"alt\": \"$RES\"}"
