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
    readonly property color subtext0: _theme.subtext0
    readonly property color subtext1: _theme.subtext1
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

    // Dynamic blending for the rotating ambient blobs
    property real baseBlend: 0.0
    SequentialAnimation on baseBlend {
        loops: Animation.Infinite; running: true
        NumberAnimation { to: 1.0; duration: 15000; easing.type: Easing.InOutSine }
        NumberAnimation { to: 0.0; duration: 15000; easing.type: Easing.InOutSine }
    }
    property color currentBasePurple: Qt.tint(root.mauve, Qt.rgba(root.pink.r, root.pink.g, root.pink.b, baseBlend))

    // Entrance animation
    property real introState: 0.0
    Component.onCompleted: {
        filterKeybinds("");
        entranceAnimation.start();
        root.forceActiveFocus();
        searchInput.forceActiveFocus();
    }

    onVisibleChanged: {
        if (visible) {
            searchInput.text = "";
            filterKeybinds("");
            searchInput.forceActiveFocus();
        }
    }

    ParallelAnimation {
        id: entranceAnimation
        NumberAnimation { target: root; property: "introState"; from: 0; to: 1.0; duration: 350; easing.type: Easing.OutCubic }
    }

    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Escape) {
            if (searchInput.text !== "") {
                searchInput.text = "";
                event.accepted = true;
            } else {
                masterWindow.switchWidget("hidden", "");
                event.accepted = true;
            }
        }
    }

    // Static Source Data (The Truth)
    readonly property var appsSource: [
        { icon: "󰞷", desc: "Terminal (Kitty)", key: "SUPER + T" },
        { icon: "󰈹", desc: "Web Browser (Zen)", key: "SUPER + B" },
        { icon: "󰉋", desc: "File Manager (Thunar)", key: "SUPER + F" },
        { icon: "󰅴", desc: "Code Editor (Antigravity)", key: "SUPER + Z" },
        { icon: "󰞷", desc: "Console Yazi File Manager", key: "SUPER + Y" },
        { icon: "󰍃", desc: "Discord Client (Vesktop)", key: "SUPER + SHIFT + D" },
        { icon: "󰞅", desc: "Emoji Picker (EmoPicker)", key: "SUPER + E" },
        { icon: "󰑋", desc: "OBS Studio (Recording)", key: "SUPER + O" },
        { icon: "󰓹", desc: "GIMP Image Editor", key: "SUPER + G" }
    ]

    readonly property var winSource: [
        { icon: "󰅙", desc: "Close Active Window", key: "SUPER + Q" },
        { icon: "󰉧", desc: "Toggle Float Selected", key: "SUPER + SHIFT + F" },
        { icon: "󰓠", desc: "Toggle Float All Windows", key: "SUPER + ALT + F" },
        { icon: "󰊓", desc: "Toggle Window Fullscreen", key: "SUPER + CTRL + F" },
        { icon: "󰶐", desc: "Focus Window Direction", key: "SUPER + H/J/K/L" },
        { icon: "󰪹", desc: "Move Window Direction", key: "SUPER + SHIFT + H/J/K/L" },
        { icon: "󰪺", desc: "Swap Window Direction", key: "SUPER + ALT + H/J/K/L" },
        { icon: "󰬎", desc: "Switch Workspace (1..10)", key: "SUPER + 1..10" },
        { icon: "󰬏", desc: "Move Window Workspace", key: "SUPER + SHIFT + 1..10" }
    ]

    readonly property var sysSource: [
        { icon: "󰀻", desc: "Application Launcher", key: "SUPER + SPACE" },
        { icon: "󰸉", desc: "Wallpaper Picker", key: "SUPER + SHIFT + W" },
        { icon: "󰍃", desc: "Session Menu (Logout)", key: "SUPER + X" },
        { icon: "󰖩", desc: "Network Popup Manager", key: "SUPER + C" },
        { icon: "󰅍", desc: "Clipboard History Manager", key: "SUPER + V" },
        { icon: "󰃭", desc: "Calendar & Notification Popup", key: "SUPER + M" },
        { icon: "󰒓", desc: "Shell/System Settings", key: "SUPER + ALT + P" },
        { icon: "󰄉", desc: "Focus Time Pomodoro Mode", key: "SUPER + CTRL + R" },
        { icon: "󰌌", desc: "Keybindings Quick Guide", key: "SUPER + K" }
    ]

    readonly property var utilsSource: [
        { icon: "󰹑", desc: "Take Interactive Screenshot", key: "SUPER + S" },
        { icon: "󰒕", desc: "Take Fullscreen Screenshot", key: "SUPER + CTRL + S" },
        { icon: "󰏤", desc: "Take Screenshot and Edit/Draw", key: "SUPER + SHIFT + S" },
        { icon: "󰉀", desc: "OCR Extract Text Screen", key: "SUPER + ALT + A" },
        { icon: "󰌾", desc: "Lock Session Screen (Hyprlock)", key: "SUPER + CTRL + L" },
        { icon: "󰖔", desc: "Toggle Night Light (Sunset)", key: "SUPER + SHIFT + H" },
        { icon: "󰊗", desc: "Toggle Gamemode Settings", key: "SUPER + ALT + G" },
        { icon: "󰓃", desc: "Volume / Brightness Keys", key: "XF86 Hardware" },
        { icon: "󰓇", desc: "Media Play/Pause/Next/Prev", key: "XF86 Media" }
    ]

    // Active Dynamic Filtered Models
    ListModel { id: filteredAppsModel }
    ListModel { id: filteredWinModel }
    ListModel { id: filteredSysModel }
    ListModel { id: filteredUtilsModel }

    readonly property int totalFilteredCount: filteredAppsModel.count + filteredWinModel.count + filteredSysModel.count + filteredUtilsModel.count

    // Instant Filtering Engine
    function filterKeybinds(query) {
        let q = query.trim().toLowerCase();
        
        function applyFilter(sourceData, targetModel) {
            targetModel.clear();
            for (let i = 0; i < sourceData.length; i++) {
                let item = sourceData[i];
                if (q === "" || 
                    item.desc.toLowerCase().includes(q) || 
                    item.key.toLowerCase().includes(q)) {
                    targetModel.append(item);
                }
            }
        }
        
        applyFilter(appsSource, filteredAppsModel);
        applyFilter(winSource, filteredWinModel);
        applyFilter(sysSource, filteredSysModel);
        applyFilter(utilsSource, filteredUtilsModel);
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

            // Header Layout (Title + Search Pill)
            RowLayout {
                Layout.fillWidth: true
                spacing: root.s(15)

                Text {
                    text: "SYSTEM KEYBINDINGS"
                    font.family: "JetBrains Mono"
                    font.weight: Font.Black
                    font.pixelSize: root.s(15)
                    font.letterSpacing: root.s(2)
                    color: root.text
                }

                Item { Layout.fillWidth: true } // Spacer

                // Sleek Search Input Pill
                Rectangle {
                    Layout.alignment: Qt.AlignVCenter
                    width: root.s(260)
                    height: root.s(32)
                    radius: root.s(8)
                    color: searchInput.activeFocus ? root.surface1 : root.surface0
                    border.color: searchInput.activeFocus ? root.mauve : root.surface2
                    border.width: 1
                    
                    Behavior on color { ColorAnimation { duration: 150 } }
                    Behavior on border.color { ColorAnimation { duration: 150 } }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: root.s(10)
                        anchors.rightMargin: root.s(10)
                        spacing: root.s(8)

                        Text {
                            text: "󰍉" // Magnifying glass
                            font.family: "Iosevka Nerd Font"
                            font.pixelSize: root.s(14)
                            color: searchInput.activeFocus ? root.mauve : root.overlay0
                            Layout.alignment: Qt.AlignVCenter
                            Behavior on color { ColorAnimation { duration: 150 } }
                        }

                        TextField {
                            id: searchInput
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            background: Item {} 
                            color: root.text
                            font.family: "JetBrains Mono"
                            font.pixelSize: root.s(11)
                            
                            placeholderText: "Search keybinds..."
                            placeholderTextColor: root.overlay0
                            
                            verticalAlignment: TextInput.AlignVCenter
                            
                            onTextChanged: {
                                root.filterKeybinds(text);
                            }

                            Keys.onPressed: (event) => {
                                if (event.key === Qt.Key_Escape) {
                                    if (text !== "") {
                                        text = "";
                                        event.accepted = true;
                                    } else {
                                        masterWindow.switchWidget("hidden", "");
                                        event.accepted = true;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Central Content: Grid of categories (Visible if we have matches)
            GridLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: 2
                columnSpacing: root.s(15)
                rowSpacing: root.s(15)
                visible: root.totalFilteredCount > 0

                // Category 1: Applications
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: root.s(16)
                    color: root.surface0
                    border.color: root.surface1
                    border.width: 1
                    clip: true
                    visible: filteredAppsModel.count > 0

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: root.s(14)
                        spacing: root.s(10)

                        Text {
                            text: "󰀻 APPLICATIONS"
                            font.family: "JetBrains Mono"
                            font.weight: Font.Bold
                            font.pixelSize: root.s(12)
                            color: root.teal
                            font.letterSpacing: root.s(1)
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 1
                            color: root.surface1
                        }

                        ListView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            model: filteredAppsModel
                            spacing: root.s(4)
                            boundsBehavior: Flickable.StopAtBounds
                            clip: true

                            ScrollBar.vertical: ScrollBar {
                                width: root.s(4)
                                policy: ScrollBar.AsNeeded
                                contentItem: Rectangle {
                                    implicitWidth: root.s(4)
                                    radius: root.s(2)
                                    color: root.surface2
                                    opacity: 0.5
                                }
                            }

                            delegate: keybindDelegateComponent
                        }
                    }
                }

                // Category 2: Window Management
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: root.s(16)
                    color: root.surface0
                    border.color: root.surface1
                    border.width: 1
                    clip: true
                    visible: filteredWinModel.count > 0

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: root.s(14)
                        spacing: root.s(10)

                        Text {
                            text: "󰖲 WINDOW MANAGEMENT"
                            font.family: "JetBrains Mono"
                            font.weight: Font.Bold
                            font.pixelSize: root.s(12)
                            color: root.blue
                            font.letterSpacing: root.s(1)
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 1
                            color: root.surface1
                        }

                        ListView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            model: filteredWinModel
                            spacing: root.s(4)
                            boundsBehavior: Flickable.StopAtBounds
                            clip: true

                            ScrollBar.vertical: ScrollBar {
                                width: root.s(4)
                                policy: ScrollBar.AsNeeded
                                contentItem: Rectangle {
                                    implicitWidth: root.s(4)
                                    radius: root.s(2)
                                    color: root.surface2
                                    opacity: 0.5
                                }
                            }

                            delegate: keybindDelegateComponent
                        }
                    }
                }

                // Category 3: Shell & System
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: root.s(16)
                    color: root.surface0
                    border.color: root.surface1
                    border.width: 1
                    clip: true
                    visible: filteredSysModel.count > 0

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: root.s(14)
                        spacing: root.s(10)

                        Text {
                            text: "󰒓 SYSTEM & SHELL"
                            font.family: "JetBrains Mono"
                            font.weight: Font.Bold
                            font.pixelSize: root.s(12)
                            color: root.mauve
                            font.letterSpacing: root.s(1)
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 1
                            color: root.surface1
                        }

                        ListView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            model: filteredSysModel
                            spacing: root.s(4)
                            boundsBehavior: Flickable.StopAtBounds
                            clip: true

                            ScrollBar.vertical: ScrollBar {
                                width: root.s(4)
                                policy: ScrollBar.AsNeeded
                                contentItem: Rectangle {
                                    implicitWidth: root.s(4)
                                    radius: root.s(2)
                                    color: root.surface2
                                    opacity: 0.5
                                }
                            }

                            delegate: keybindDelegateComponent
                        }
                    }
                }

                // Category 4: Utilities & Media
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: root.s(16)
                    color: root.surface0
                    border.color: root.surface1
                    border.width: 1
                    clip: true
                    visible: filteredUtilsModel.count > 0

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: root.s(14)
                        spacing: root.s(10)

                        Text {
                            text: "󰏤 UTILITIES & MEDIA"
                            font.family: "JetBrains Mono"
                            font.weight: Font.Bold
                            font.pixelSize: root.s(12)
                            color: root.red
                            font.letterSpacing: root.s(1)
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 1
                            color: root.surface1
                        }

                        ListView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            model: filteredUtilsModel
                            spacing: root.s(4)
                            boundsBehavior: Flickable.StopAtBounds
                            clip: true

                            ScrollBar.vertical: ScrollBar {
                                width: root.s(4)
                                policy: ScrollBar.AsNeeded
                                contentItem: Rectangle {
                                    implicitWidth: root.s(4)
                                    radius: root.s(2)
                                    color: root.surface2
                                    opacity: 0.5
                                }
                            }

                            delegate: keybindDelegateComponent
                        }
                    }
                }
            }

            // Centered "No results" Placeholder (Visible if count is 0)
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: root.totalFilteredCount === 0
                spacing: root.s(15)

                Item { Layout.fillHeight: true } // Spacer

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "Iosevka Nerd Font"
                    font.pixelSize: root.s(54)
                    color: root.mauve
                    text: "󰍉"
                    opacity: 0.6
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "Fira Sans Semibold"
                    font.pixelSize: root.s(14)
                    color: root.text
                    text: "No matching keybindings found"
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "JetBrains Mono"
                    font.pixelSize: root.s(10)
                    color: root.overlay0
                    text: "Try searching for another keyword or shortcut"
                    opacity: 0.7
                }

                Item { Layout.fillHeight: true } // Spacer
            }

            // Footer / Close Tip
            Text {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: "Press ESC or click outside to dismiss"
                font.family: "JetBrains Mono"
                font.pixelSize: root.s(9)
                font.weight: Font.Medium
                color: root.overlay0
                opacity: 0.7
            }
        }
    }

    // Reusable delegate component for keybinding rows
    Component {
        id: keybindDelegateComponent

        Rectangle {
            id: tile
            width: parent ? parent.width : 200
            height: root.s(32)
            radius: root.s(8)

            property bool isHovered: ma.containsMouse
            // Dynamically set highlight color based on the parent's color role
            property color highlightColor: parent.parent.parent.children[0].color

            color: isHovered ? Qt.alpha(highlightColor, 0.08) : "transparent"
            border.color: isHovered ? highlightColor : "transparent"
            border.width: 1

            Behavior on color { ColorAnimation { duration: 150 } }
            Behavior on border.color { ColorAnimation { duration: 150 } }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: root.s(8)
                anchors.rightMargin: root.s(8)
                spacing: root.s(8)

                Text {
                    font.family: "Iosevka Nerd Font"
                    font.pixelSize: root.s(15)
                    color: tile.isHovered ? tile.highlightColor : root.text
                    text: model.icon
                    Layout.alignment: Qt.AlignVCenter
                    Behavior on color { ColorAnimation { duration: 150 } }
                }

                Text {
                    font.family: "Fira Sans Semibold"
                    font.pixelSize: root.s(10.5)
                    color: tile.isHovered ? root.text : root.subtext0
                    text: model.desc
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    Behavior on color { ColorAnimation { duration: 150 } }
                }

                Rectangle {
                    height: root.s(20)
                    width: keyText.implicitWidth + root.s(10)
                    radius: root.s(5)
                    color: tile.isHovered ? Qt.alpha(tile.highlightColor, 0.12) : root.surface1
                    border.color: tile.isHovered ? tile.highlightColor : root.surface2
                    border.width: 1
                    Behavior on color { ColorAnimation { duration: 150 } }
                    Behavior on border.color { ColorAnimation { duration: 150 } }

                    Text {
                        id: keyText
                        anchors.centerIn: parent
                        font.family: "JetBrains Mono"
                        font.pixelSize: root.s(8.5)
                        font.weight: Font.Bold
                        color: tile.isHovered ? tile.highlightColor : root.text
                        text: model.key
                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                }
            }

            MouseArea {
                id: ma
                anchors.fill: parent
                hoverEnabled: true
            }
        }
    }
}
