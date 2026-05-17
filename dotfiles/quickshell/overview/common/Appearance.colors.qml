import QtQuick

QtObject {
    readonly property string fontFamily: "Fira Sans Semibold"
	
		readonly property color background: "#161217"
	
		readonly property color error: "#ffb4ab"
	
		readonly property color error_container: "#93000a"
	
		readonly property color inverse_on_surface: "#342f34"
	
		readonly property color inverse_primary: "#765084"
	
		readonly property color inverse_surface: "#e9e0e7"
	
		readonly property color on_background: "#e9e0e7"
	
		readonly property color on_error: "#690005"
	
		readonly property color on_error_container: "#ffdad6"
	
		readonly property color on_primary: "#442253"
	
		readonly property color on_primary_container: "#f8d8ff"
	
		readonly property color on_primary_fixed: "#2d0a3d"
	
		readonly property color on_primary_fixed_variant: "#5d386b"
	
		readonly property color on_secondary: "#392c3d"
	
		readonly property color on_secondary_container: "#f1dcf4"
	
		readonly property color on_secondary_fixed: "#231728"
	
		readonly property color on_secondary_fixed_variant: "#504255"
	
		readonly property color on_surface: "#e9e0e7"
	
		readonly property color on_surface_variant: "#cec3cd"
	
		readonly property color on_tertiary: "#4c2524"
	
		readonly property color on_tertiary_container: "#ffdad8"
	
		readonly property color on_tertiary_fixed: "#331111"
	
		readonly property color on_tertiary_fixed_variant: "#663b39"
	
		readonly property color outline: "#978e97"
	
		readonly property color outline_variant: "#4c444d"
	
		readonly property color primary: "#e4b7f3"
	
		readonly property color primary_container: "#5d386b"
	
		readonly property color primary_fixed: "#f8d8ff"
	
		readonly property color primary_fixed_dim: "#e4b7f3"
	
		readonly property color scrim: "#000000"
	
		readonly property color secondary: "#d4c0d7"
	
		readonly property color secondary_container: "#504255"
	
		readonly property color secondary_fixed: "#f1dcf4"
	
		readonly property color secondary_fixed_dim: "#d4c0d7"
	
		readonly property color shadow: "#000000"
	
		readonly property color source_color: "#a272b4"
	
		readonly property color surface: "#161217"
	
		readonly property color surface_bright: "#3d373d"
	
		readonly property color surface_container: "#231e23"
	
		readonly property color surface_container_high: "#2d282e"
	
		readonly property color surface_container_highest: "#383339"
	
		readonly property color surface_container_low: "#1f1a1f"
	
		readonly property color surface_container_lowest: "#110d12"
	
		readonly property color surface_dim: "#161217"
	
		readonly property color surface_tint: "#e4b7f3"
	
		readonly property color surface_variant: "#4c444d"
	
		readonly property color tertiary: "#f5b7b5"
	
		readonly property color tertiary_container: "#663b39"
	
		readonly property color tertiary_fixed: "#ffdad8"
	
		readonly property color tertiary_fixed_dim: "#f5b7b5"
	

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