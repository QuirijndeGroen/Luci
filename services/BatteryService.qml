pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

Singleton {
    id: root

    property var battery: UPower.displayDevice
    property bool charging: battery && battery.ready && battery.state === UPowerDeviceState.PendingCharge || battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.FullyCharged
    readonly property int level: Math.round(battery.percentage * 100)

    readonly property string icon: {
        if (charging) {

            return "󰂄"

        } if (level >= 95) {

            return "󰁹"

        } else if (level >= 75) {

            return "󰂀"

        } else if (level >= 50) {

            return "󰁿"

        } else if (level >= 25) {

            return "󰁾"

        } else if (level >= 10) {

            return "󰁼"

        } else {

            return "󰁺"
        }
    }
}