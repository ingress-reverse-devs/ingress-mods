#!/bin/bash
cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
options=(1 "Rosa Resistance" off    # any option can be set to default to "on"
         2 "Landscape" off
         3 "Sättigung von Buttons runter(einbrennen von COMM/OPS verhindern" off
         4 "Option 4" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
url="http://ingress-apk-mod.o4kapuk.info/files/20130914/ingress-1.35.1-broot-1.0.2.11-mute.apk"
clear
echo $choices
if [ ! -e $(basename $url) ]
    then wget $url
fi
java -jar apktool.jar d -f $(basename "$url") out-dir
echo "going to patch"
for choice in $choices
do
    echo "patching"
    case $choice in
        1)
            echo "patch1"
            patch -p0 -i patch-rosa
            ;;
        3)
            echo "patch2"
            patch -p0 -i patch-dark
            for i in dark/*.png; do cp $i out-dir/assets/packed/$(basename $i .png)/common.png; done
            ;;
    esac
done
rm ingress-1.35.1-out-signed.apk; java -jar apktool.jar b out-dir ingress-1.35.1-out.apk &&  zipalign -v 4 ingress-1.35.1-out.apk ingress-1.35.1-out-signed.apk && jarsigner -verbose -keystore debug.keystore ingress-1.35.1-out-signed.apk ingress-reverse-devs && adb install -r ingress-1.35.1-out-signed.apk && rm ingress-1.35.1-out.apk

