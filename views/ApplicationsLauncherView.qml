import Quickshell
import QtQuick
import QtQuick.Layouts

import "../styles"
import "../components"
import "../core"
import "../views"
import "../services"

FocusScope {
    id: root

    clip: true
    
    implicitWidth: 520
    implicitHeight: 530

    property int selectedIndex: 0

    Component.onCompleted: {
        forceActiveFocus()
    }

    focus: true

    // Search filter
    ScriptModel {
        id: filteredApps
        objectProp: "id"
        values: {
            const all = [...DesktopEntries.applications.values];
            const q = searchField.searchInput.trim().toLowerCase();
            if (q === "") return all.sort((a, b) => a.name.localeCompare(b.name));
            return all.filter(d =>
                (d.name && d.name.toLowerCase().includes(q)) ||
                (d.genericName && d.genericName.toLowerCase().includes(q)) ||
                (d.keywords && d.keywords.some(k => k.toLowerCase().includes(q))) ||
                (d.categories && d.categories.some(c => c.toLowerCase().includes(q)))
            ).sort((a, b) => {
                const an = a.name.toLowerCase();
                const bn = b.name.toLowerCase();
                const aStarts = an.startsWith(q);
                const bStarts = bn.startsWith(q);
                if (aStarts && !bStarts) return -1;
                if (!aStarts && bStarts) return 1;
                return an.localeCompare(bn);
            });
        }
    }

    // Lanch command
    function launchApp(entry) {
        entry.execute();
        IslandController.reset();
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 22

        spacing: 18

        Text {
            text: "Application Launcher"

            color: Theme.textPrimary

            font.pixelSize: 20
            font.bold: true

            Layout.alignment: Qt.AlignLeft
        }

        SearchField {
            id: searchField
        }

        // App list
        ListView {
            id: resultsList

            Layout.fillWidth: true
            Layout.fillHeight: true

            model: filteredApps
            clip: true

            spacing: 12

            boundsBehavior: Flickable.StopAtBounds

            currentIndex: root.selectedIndex

            delegate: ApplicationEntry {
                id: applicationEntry

                required property var modelData
                required property int index

                title: modelData.name ?? "Application"
                subtitle: modelData.genericName ?? modelData.comment
                iconSource : Quickshell.iconPath(modelData.icon)
                active: root.selectedIndex == index
            }

            // Empty state
            Text {
                anchors.centerIn: parent
                text: "No applications found"
                color: Theme.textPrimary
                font.pixelSize: 13
                font.bold: true
                visible: resultsList.count === 0 && searchField.searchInput !== ""
            }
        }
    }
    Keys.onEscapePressed: IslandController.reset() // Close with Esc

    Keys.onPressed: event => {
        if (event.key === Qt.Key_Down) {
            event.accepted = true;
            root.selectedIndex = Math.min(root.selectedIndex + 1, resultsList.count - 1);
            resultsList.positionViewAtIndex(root.selectedIndex, ListView.Contain);
        } else if (event.key === Qt.Key_Up) {
            event.accepted = true;
            root.selectedIndex = Math.max(root.selectedIndex - 1, 0);
            resultsList.positionViewAtIndex(root.selectedIndex, ListView.Contain);
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            event.accepted = true;
            if (root.selectedIndex >= 0) {
                const entry = filteredApps.values[root.selectedIndex];
                if (entry) root.launchApp(entry);
            }
        } else if (event.key === Qt.Key_Tab) {
            event.accepted = true;
            root.selectedIndex = Math.min(root.selectedIndex + 1, searchTextInput.count - 1);
            resultsList.positionViewAtIndex(root.selectedIndex, ListView.Contain);
        }
    }
}