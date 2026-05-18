import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import Quickshell
import "../"

Item {
    id: root
    focus: true

    Scaler {
        id: scaler
        currentWidth: Screen.width
        currentHeight: Screen.height
    }

    function s(val) { 
        return scaler.s(val); 
    }

    MatugenColors { id: _theme }
    readonly property color base: _theme.base
    readonly property color mantle: _theme.mantle
    readonly property color crust: _theme.crust
    readonly property color text: _theme.text
    readonly property color surface0: _theme.surface0
    readonly property color surface1: _theme.surface1
    readonly property color surface2: _theme.surface2
    readonly property color overlay0: _theme.overlay0

    readonly property color mauve: _theme.mauve
    readonly property color pink: _theme.pink
    readonly property color red: _theme.red
    readonly property color yellow: _theme.yellow
    readonly property color green: _theme.green
    readonly property color teal: _theme.teal
    readonly property color sapphire: _theme.sapphire
    readonly property color blue: _theme.blue

    property real globalOrbitAngle: 0
    NumberAnimation on globalOrbitAngle {
        from: 0; to: Math.PI * 2; duration: 60000; loops: Animation.Infinite; running: true
    }

    // Dynamic purples/lavenders for the rotating ambient blobs
    property real baseBlend: 0.0
    SequentialAnimation on baseBlend {
        loops: Animation.Infinite; running: true
        NumberAnimation { to: 1.0; duration: 15000; easing.type: Easing.InOutSine }
        NumberAnimation { to: 0.0; duration: 15000; easing.type: Easing.InOutSine }
    }
    property color currentBasePurple: Qt.tint(root.mauve, Qt.rgba(root.pink.r, root.pink.g, root.pink.b, baseBlend))

    // Animation States for Entrance
    property real introState: 0.0
    Component.onCompleted: {
        entranceAnimation.start();
        root.forceActiveFocus();
    }

    ParallelAnimation {
        id: entranceAnimation
        NumberAnimation { target: root; property: "introState"; from: 0; to: 1.0; duration: 350; easing.type: Easing.OutCubic }
    }

    function triggerPowerAction(action) {
        masterWindow.switchWidget("hidden", "");
        Quickshell.execDetached([Config.hyprDir + "/scripts/power.sh", action]);
    }

    Keys.onPressed: (event) => {
        let key = event.key;
        if (key === Qt.Key_L) {
            triggerPowerAction("lock");
            event.accepted = true;
        } else if (key === Qt.Key_U) {
            triggerPowerAction("suspend");
            event.accepted = true;
        } else if (key === Qt.Key_E) {
            triggerPowerAction("exit");
            event.accepted = true;
        } else if (key === Qt.Key_R) {
            triggerPowerAction("reboot");
            event.accepted = true;
        } else if (key === Qt.Key_S) {
            triggerPowerAction("shutdown");
            event.accepted = true;
        } else if (key === Qt.Key_Escape) {
            masterWindow.switchWidget("hidden", "");
            event.accepted = true;
        }
    }

    // Outer Container
    Rectangle {
        id: container
        anchors.fill: parent
        radius: root.s(20)
        color: root.base
        border.color: root.surface0
        border.width: 1
        clip: true

        opacity: root.introState
        scale: 0.95 + (0.05 * root.introState)
        transform: Translate { y: root.s(10) * (1 - root.introState) }

        // Rotating Ambient Blobs
        Rectangle {
            width: parent.width * 0.7; height: width; radius: width / 2
            x: (parent.width / 2 - width / 2) + Math.cos(root.globalOrbitAngle) * root.s(120)
            y: (parent.height / 2 - height / 2) + Math.sin(root.globalOrbitAngle) * root.s(60)
            opacity: 0.05
            color: root.currentBasePurple
        }

        Rectangle {
            width: parent.width * 0.7; height: width; radius: width / 2
            x: (parent.width / 2 - width / 2) + Math.sin(root.globalOrbitAngle) * root.s(-120)
            y: (parent.height / 2 - height / 2) + Math.cos(root.globalOrbitAngle) * root.s(-60)
            opacity: 0.04
            color: root.blue
        }

        // Close on Clicking Background
        MouseArea {
            anchors.fill: parent
            onClicked: masterWindow.switchWidget("hidden", "")
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: root.s(20)
            spacing: root.s(15)

            // Title Header
            Text {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: "SESSION MENU"
                font.family: "JetBrains Mono"
                font.weight: Font.Black
                font.pixelSize: root.s(14)
                font.letterSpacing: root.s(2)
                color: root.overlay0
            }

            // Buttons Layout
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: root.s(12)

                // Repeater for the 5 actions
                Repeater {
                    model: [
                        { label: "Lock",      icon: "󰌾", key: "L", color: root.blue,     action: "lock" },
                        { label: "Suspend",   icon: "󰤄", key: "U", color: root.teal,     action: "suspend" },
                        { label: "Log Out",   icon: "󰍃", key: "E", color: root.mauve,    action: "exit" },
                        { label: "Restart",   icon: "󰜉", key: "R", color: root.yellow,   action: "reboot" },
                        { label: "Power Off", icon: "󰐥", key: "S", color: root.red,      action: "shutdown" }
                    ]

                    delegate: Rectangle {
                        id: btn
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: root.s(14)

                        // Hover & Press states
                        property bool isHovered: ma.containsMouse

                        color: isHovered ? Qt.alpha(modelData.color, 0.12) : root.surface0
                        border.color: isHovered ? modelData.color : root.surface1
                        border.width: 1
                        scale: isHovered ? 1.03 : 1.0

                        Behavior on color { ColorAnimation { duration: 150 } }
                        Behavior on border.color { ColorAnimation { duration: 150 } }
                        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: root.s(8)

                            // Icon
                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                font.family: "Iosevka Nerd Font"
                                font.pixelSize: root.s(32)
                                color: btn.isHovered ? modelData.color : root.text
                                text: modelData.icon
                                Behavior on color { ColorAnimation { duration: 150 } }
                            }

                            // Label
                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                font.family: "JetBrains Mono"
                                font.weight: Font.Bold
                                font.pixelSize: root.s(12)
                                color: btn.isHovered ? modelData.color : root.text
                                text: modelData.label
                                Behavior on color { ColorAnimation { duration: 150 } }
                            }

                            // Shortcut text e.g. [L]
                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                font.family: "JetBrains Mono"
                                font.pixelSize: root.s(9)
                                font.weight: Font.Medium
                                color: btn.isHovered ? modelData.color : root.overlay0
                                text: "[" + modelData.key + "]"
                                opacity: 0.8
                                Behavior on color { ColorAnimation { duration: 150 } }
                            }
                        }

                        MouseArea {
                            id: ma
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: triggerPowerAction(modelData.action)
                        }
                    }
                }
            }
        }
    }
}
