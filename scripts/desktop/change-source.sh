defaultsink=$(pactl info @DEFAULT_SINK@ | grep "Default Sink:" | awk '{ print substr ($0, 15 ) }')
found=false
x=$(pactl list short sinks)
IFS=$'\n' read -rd '' -a y <<<"$x"
for i in "${y[@]}"
do
    if [ $found = true ]
    then
        pactl set-default-sink $(echo $i | awk '{print $1}')
        found=false
    fi
    if [ $defaultsink == $(echo $i | awk '{print $2}') ]
    then
        found=true
    fi
done

if [ $found = true ]
then
    pactl set-default-sink $(echo ${y[0]} | awk '{print $1}')
    found=false
fi
