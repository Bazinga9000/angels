#!/usr/bin/env bash

INTERVAL=3
INTERFACES="lo wlp0s20f3 enp0s31f6"

declare -A bytes

for interface in $INTERFACES; do
    bytes[past_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
    bytes[past_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"
done

while true; do
    down=0
    up=0

    for interface in $INTERFACES; do
        bytes[now_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
        bytes[now_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"

        bytes_down=$(((${bytes[now_rx_$interface]} - ${bytes[past_rx_$interface]}) / INTERVAL))
        bytes_up=$(((${bytes[now_tx_$interface]} - ${bytes[past_tx_$interface]}) / INTERVAL))

        down=$(( "$down" + "$bytes_down" ))
        up=$(( "$up" + "$bytes_up" ))

        bytes[past_rx_$interface]=${bytes[now_rx_$interface]}
        bytes[past_tx_$interface]=${bytes[now_tx_$interface]}
    done

    echo "$down $up"

    sleep $INTERVAL
done
