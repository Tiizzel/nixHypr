import QtQuick

QtObject {
    readonly property string fontFamily: "Fira Sans Semibold"
	<* for name, value in colors *>
		readonly property color {{name}}: "{{value.default.hex}}"
	<* endfor *>

    // Catppuccin mappings to Material You color roles
    readonly property color base: background
    readonly property color mantle: surface_container_low
    readonly property color crust: surface_container_lowest
    readonly property color text: on_background
    readonly property color subtext0: on_surface_variant
    readonly property color subtext1: on_surface
    readonly property color surface0: surface_container
    readonly property color surface1: surface_container_high
    readonly property color surface2: surface_container_highest
    readonly property color overlay0: outline
    readonly property color overlay1: outline_variant
    readonly property color overlay2: on_surface_variant
    
    readonly property color blue: primary
    readonly property color sapphire: tertiary
    readonly property color peach: error_container
    readonly property color green: primary_fixed
    readonly property color red: error
    readonly property color mauve: primary
    readonly property color pink: tertiary_container
    readonly property color yellow: primary_container
    readonly property color maroon: error
    readonly property color teal: secondary
}