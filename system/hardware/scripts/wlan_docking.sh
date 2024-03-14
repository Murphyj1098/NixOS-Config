#!/usr/bin/env bash

wired_interfaces="en.*|eth.*"
exclude="enp0s13f0u1u4u3np|enp0s13f0u2u4u2u1"

# Lab dock (NixOS ifname):  enp0s13f0u1u4u3
# Home dock (NixOS ifname): enp0s13f0u2u4u2u1

if [[ "$1" =~ $wired_interfaces ]] && if ! [[ "$1" =~ $exclude ]]; then
    case "$2" in
        up)
            nmcli radio wifi off
            ;;
        down)
            nmcli radio wifi on
            ;;
    esac
fi
