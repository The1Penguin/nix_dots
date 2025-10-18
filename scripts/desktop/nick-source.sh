declare -A dic
dic["alsa_output.pci-0000_1c_00.1.hdmi-stereo"]="speaker"
dic["alsa_output.pci-0000_1e_00.3.analog-stereo"]="headphones"
dic["bluez_output.7C_96_D2_73_18_B7.1"]="bt headphones"
dic["bluez_output.80_4A_F2_02_45_16.1"]="bt headphones"
dic["bluez_output.98_52_3D_C4_E0_C8.1"]="bt speaker"

while [ true ]
do
    defaultsink=$(pactl info @DEFAULT_SINK@ | grep "Default Sink:" | awk '{ print substr ($0, 15 ) }')
    echo ${dic[$defaultsink]}
    sleep 0.2s
done
