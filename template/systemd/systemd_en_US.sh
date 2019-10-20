#!/bin/bash
# CODER BY xiaoyao9184 1.0 beta
# TIME 2019-10-20
# FILE system_zh_CN
# DESC Systemctl Tool Command navigation
# --------------------
# CHANGE 2019-10-20
# --------------------


# var

tip="Systemctl Tool Command navigation"
ver="1.0"
# interactive
[[ -t 0 || -p /dev/stdin ]] && interactive=1 || interactive=0
# current info
current_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
current_script_name="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
current_script_name="${current_script_name%.*}"
# tip info
echo_select="Please enter your choice serial number:"
echo_exit_systemd="TIP: Use Ctrl+C for exit Systemctl"
echo_install="install"
echo_uninstall="uninstall"
echo_start="start"
echo_stop="stop"
echo_restart="restart"
echo_status="status"
echo_invalid="invalid option"


# title

echo -e '\033]2;'$tip $ver'\007'
echo "$tip"

# core

echo "${echo_select}"
echo "${echo_exit_systemd}"
options=("${echo_install}" "${echo_uninstall}" "${echo_start}" "${echo_stop}" "${echo_restart}" "${echo_status}")
select opt in "${options[@]}"
do
    case $opt in
        "${echo_install}")
            sudo systemctl link "${current_path}/${current_script_name}.service"
            break
            ;;
        "${echo_uninstall}")
            sudo systemctl disable "${current_path}/${current_script_name}.service"
            break
            ;;
        "${echo_start}")
            sudo systemctl reload "${current_path}/${current_script_name}.service"
            break
            ;;
        "${echo_stop}")
            sudo systemctl start "${current_script_name}.service"
            break
            ;;
        "${echo_restart}")
            sudo systemctl stop "${current_script_name}.service"
            break
            ;;
        "${echo_status}")
            sudo systemctl status "${current_script_name}.service"
            break
            ;;
        *) echo "${echo_invalid} $REPLY";;
    esac
done