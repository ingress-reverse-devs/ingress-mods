$apkfile=$1
$outputfile=$2
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
#rm ingress-1.35.1-rosac.apk; java -jar apktool.jar b ingress-1.35.1-broot-1.0.2.11-mute ingress-1.35.1-rosa.apk &&  zipalign -v 4 ingress-1.35.1-rosa.apk ingress-1.35.1-rosac.apk && jarsigner -verbose -keystore debug.keystore  -keypass "#include <stdio.h>" ingress-1.35.1-rosac.apk tomle_singing && adb install -r ingress-1.35.1-rosac.apk

