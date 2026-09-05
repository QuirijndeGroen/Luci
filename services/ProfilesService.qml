import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property string profile: "…"

    function refresh() {
        getProfileProc.running = true
    }
    function cycle() {
        setNextProc.running = true
    }

    readonly property string icon: {
        if (root.profile === "Performance")
            return "󰓅";
        if (root.profile === "Balanced")
            return "󰾅";
        if (root.profile === "Quiet")
            return "󰾆";
        return String("?")
    }

    Process {
        id: getProfileProc
        command: ["asusctl", "profile", "get"]
        stdout: StdioCollector {
            onStreamFinished: {
                const m = this.text.match(/Active profile:\s*(\S+)/i)
                root.profile = m ? m[1] : "?"
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refresh()
    }
}