{ config, lib, pkgs, desktop, laptop, ... }:

{
  home.packages = with pkgs; [
    (writeScriptBin "notify" ''
        declare -A DIC
        DIC["alsa_output.pci-0000_1c_00.1.hdmi-stereo-extra1"]="speaker"
        DIC["alsa_output.pci-0000_1c_00.1.hdmi-stereo"]="speaker"
        DIC["alsa_output.pci-0000_1e_00.3.analog-stereo"]="headphones"
        DIC["bluez_output.88_C9_E8_90_8B_58.1"]="bt headphones"
        DIC["bluez_output.80_4A_F2_02_45_16.1"]="bt headphones"
        DIC["bluez_output.98_52_3D_C4_E0_C8.1"]="bt portable speaker"
        DIC["bluez_output.F4_6A_DD_B3_53_67.1"]="bt speaker"
        TIME=$(date "+%H:%M")
        battery_stat="$(${pkgs.acpi}/bin/acpi --battery | head -n 1)"
        battery_greped_status="$(echo $battery_stat| cut -d',' -f1 | cut -d':' -f2 | xargs | awk '{print tolower($0)}')"
        battery_percentage_v="$(echo $battery_stat| grep -Po '(\d+%)' | grep -Po '\d+')"
        network="$(${pkgs.networkmanager}/bin/nmcli -t -f name connection show --active | ${pkgs.gnused}/bin/sed 's/^lo$/not connected/' | head -n 1)"
        audio_mute="$(${pkgs.pulseaudio}/bin/pactl get-sink-mute @DEFAULT_SINK@)"
        audio_volume="$(${pkgs.pulseaudio}/bin/pactl get-sink-volume @DEFAULT_SINK@ | cut -d'/' -f2 | head -n1 | xargs)"
        DEFAULTSINK=$(${pkgs.pulseaudio}/bin/pactl info @DEFAULT_SINK@ | grep "Default Sink:" | awk '{ print substr ($0, 15 ) }')

        audio=""
        if [ "$audio_mute" = "Mute: yes" ]; then
            audio="muted"
        else
            audio="$audio_volume"
        fi;

        DND=$(swaync-client -D)
        DNDMessage=""
        if [ "$DND" = true ]; then
            DNDMessage="\nDo Not Disturb: enabled"
        fi


        ${pkgs.libnotify}/bin/notify-send \
            --transient \
            --hint boolean:SWAYNC_BYPASS_DND:true \
            -a "notify" \
            'Status' \
            "$(echo -e "${
            if laptop then
              "Time: $TIME \\n Network: $network \\n Audio: $audio \\n Battery: $battery_percentage_v%, and $battery_greped_status$DNDMessage"
            else if desktop then
              "Time: $TIME \\nAudio source: \${DIC[$DEFAULTSINK]}$DNDMessage"
            else "Time: $TIME$DNDMessage" }")"
    '')
  ];
}
