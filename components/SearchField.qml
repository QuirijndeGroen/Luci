import QtQuick
import QtQuick.Layouts

import "../styles"

Rectangle {
    id: root

    property string searchInput: searchTextInput.text

    implicitWidth: parent.width
    implicitHeight: 60

    radius: 20

    color: Theme.surface

    border.width: 1
    border.color: active
                  ? Theme.accent
                  : Theme.border
    
    TextInput {
        id: searchTextInput

        width: parent.width - 24
        anchors.centerIn: parent

        color: Theme.textPrimary

        font.pixelSize: 16
        font.bold: true

        clip: true
        focus: true

        Accessible.role: Accessible.EditableText
        Accessible.name: "search applications"
    }
}