import QtQuick

QtObject {
    readonly property string fontFamily: "Fira Sans Semibold"
	
		readonly property color background: "#11140f"
	
		readonly property color error: "#ffb4ab"
	
		readonly property color error_container: "#93000a"
	
		readonly property color inverse_on_surface: "#2e322b"
	
		readonly property color inverse_primary: "#406835"
	
		readonly property color inverse_surface: "#e1e4da"
	
		readonly property color on_background: "#e1e4da"
	
		readonly property color on_error: "#690005"
	
		readonly property color on_error_container: "#ffdad6"
	
		readonly property color on_primary: "#12380b"
	
		readonly property color on_primary_container: "#c1efaf"
	
		readonly property color on_primary_fixed: "#012200"
	
		readonly property color on_primary_fixed_variant: "#295020"
	
		readonly property color on_secondary: "#263422"
	
		readonly property color on_secondary_container: "#d7e8cc"
	
		readonly property color on_secondary_fixed: "#121f0e"
	
		readonly property color on_secondary_fixed_variant: "#3d4b37"
	
		readonly property color on_surface: "#e1e4da"
	
		readonly property color on_surface_variant: "#c3c8bc"
	
		readonly property color on_tertiary: "#003739"
	
		readonly property color on_tertiary_container: "#bcebee"
	
		readonly property color on_tertiary_fixed: "#002021"
	
		readonly property color on_tertiary_fixed_variant: "#1e4d50"
	
		readonly property color outline: "#8d9387"
	
		readonly property color outline_variant: "#43483f"
	
		readonly property color primary: "#a5d395"
	
		readonly property color primary_container: "#295020"
	
		readonly property color primary_fixed: "#c1efaf"
	
		readonly property color primary_fixed_dim: "#a5d395"
	
		readonly property color scrim: "#000000"
	
		readonly property color secondary: "#bbcbb1"
	
		readonly property color secondary_container: "#3d4b37"
	
		readonly property color secondary_fixed: "#d7e8cc"
	
		readonly property color secondary_fixed_dim: "#bbcbb1"
	
		readonly property color shadow: "#000000"
	
		readonly property color source_color: "#283b22"
	
		readonly property color surface: "#11140f"
	
		readonly property color surface_bright: "#363a34"
	
		readonly property color surface_container: "#1d211b"
	
		readonly property color surface_container_high: "#272b25"
	
		readonly property color surface_container_highest: "#32362f"
	
		readonly property color surface_container_low: "#191d17"
	
		readonly property color surface_container_lowest: "#0c0f0a"
	
		readonly property color surface_dim: "#11140f"
	
		readonly property color surface_tint: "#a5d395"
	
		readonly property color surface_variant: "#43483f"
	
		readonly property color tertiary: "#a0cfd2"
	
		readonly property color tertiary_container: "#1e4d50"
	
		readonly property color tertiary_fixed: "#bcebee"
	
		readonly property color tertiary_fixed_dim: "#a0cfd2"
	

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