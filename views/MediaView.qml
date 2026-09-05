import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "../components"
import "../services"
import "../styles"
import "../core"

FocusScope {
    id: root

    implicitWidth: 520
    implicitHeight: 145

    Component.onCompleted: {
        forceActiveFocus()
    }

    focus: true

    ColumnLayout {

        anchors.fill: parent
        anchors.margins: 22

        spacing: 0

        RowLayout {

            Layout.fillWidth: true

            spacing: 20

            MediaHeader {
                Layout.fillWidth: true
            }

            RowLayout {

                Layout.alignment: Qt.AlignVCenter

                Layout.topMargin: 10

                spacing: 14

                Rectangle {

                    width: 34
                    height: 34
                    radius: 17

                    color: Theme.surface

                    SvgIcon {

                        anchors.centerIn: parent

                        size: 18

                        source: "../assets/icons/player-skip-back.svg"

                        color: Theme.textPrimary
                    }

                    HoverHandler {
                        cursorShape: Qt.PointingHandCursor
                    }

                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: MediaService.previousTrack()
                    }
                }

                Rectangle {

                    width: 42
                    height: 42
                    radius: 21

                    color: Theme.accent

                    SvgIcon {

                        anchors.centerIn: parent

                        size: 20

                        source:
                            MediaService.isPlaying
                                ? "../assets/icons/player-pause.svg"
                                : "../assets/icons/player-play.svg"

                        color: Theme.background
                    }

                    HoverHandler {
                        cursorShape: Qt.PointingHandCursor
                    }

                    TapHandler {

                        acceptedButtons: Qt.LeftButton

                        onTapped: {
                            MediaService.togglePlayback()
                        }
                    }
                }

                Rectangle {

                    width: 34
                    height: 34
                    radius: 17

                    color:  Theme.surface

                    SvgIcon {

                        anchors.centerIn: parent

                        size: 18

                        source: "../assets/icons/player-skip-forward.svg"

                        color: Theme.textPrimary
                    }

                    HoverHandler {
                        cursorShape: Qt.PointingHandCursor
                    }

                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: MediaService.nextTrack()
                    }
                }    
            }
        }

        WaveformProgress {
            Layout.fillWidth: true
        }
    }

    Keys.onEscapePressed: IslandController.reset() // Close with Esc    

    Keys.onPressed: event => {
        if (event.key === Qt.Key_Down || event.key === Qt.Key_Space) {
            event.accepted = true;
            MediaService.togglePlayback();
        } else if (event.key === Qt.Key_Right) {
            event.accepted = true;
            MediaService.nextTrack();
        } else if (event.key === Qt.Key_Left) {
            event.accepted = true;
            MediaService.previousTrack();
        } 
    }
}