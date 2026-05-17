import QtQuick

QtObject {
    readonly property string fontFamily: "Fira Sans Semibold"
	
		readonly property color background: "#0e1415"
	
		readonly property color error: "#ffb4ab"
	
		readonly property color error_container: "#93000a"
	
		readonly property color inverse_on_surface: "#2b3132"
	
		readonly property color inverse_primary: "#006972"
	
		readonly property color inverse_surface: "#dee4e4"
	
		readonly property color on_background: "#dee4e4"
	
		readonly property color on_error: "#690005"
	
		readonly property color on_error_container: "#ffdad6"
	
		readonly property color on_primary: "#00363c"
	
		readonly property color on_primary_container: "#9df0fb"
	
		readonly property color on_primary_fixed: "#001f23"
	
		readonly property color on_primary_fixed_variant: "#004f56"
	
		readonly property color on_secondary: "#1c3437"
	
		readonly property color on_secondary_container: "#cde7eb"
	
		readonly property color on_secondary_fixed: "#051f22"
	
		readonly property color on_secondary_fixed_variant: "#324b4e"
	
		readonly property color on_surface: "#dee4e4"
	
		readonly property color on_surface_variant: "#bec8ca"
	
		readonly property color on_tertiary: "#23304d"
	
		readonly property color on_tertiary_container: "#d9e2ff"
	
		readonly property color on_tertiary_fixed: "#0d1b36"
	
		readonly property color on_tertiary_fixed_variant: "#394664"
	
		readonly property color outline: "#899294"
	
		readonly property color outline_variant: "#3f484a"
	
		readonly property color primary: "#81d3df"
	
		readonly property color primary_container: "#004f56"
	
		readonly property color primary_fixed: "#9df0fb"
	
		readonly property color primary_fixed_dim: "#81d3df"
	
		readonly property color scrim: "#000000"
	
		readonly property color secondary: "#b1cbcf"
	
		readonly property color secondary_container: "#324b4e"
	
		readonly property color secondary_fixed: "#cde7eb"
	
		readonly property color secondary_fixed_dim: "#b1cbcf"
	
		readonly property color shadow: "#000000"
	
		readonly property color source_color: "#0c4248"
	
		readonly property color surface: "#0e1415"
	
		readonly property color surface_bright: "#343a3b"
	
		readonly property color surface_container: "#1b2122"
	
		readonly property color surface_container_high: "#252b2c"
	
		readonly property color surface_container_highest: "#303637"
	
		readonly property color surface_container_low: "#171d1e"
	
		readonly property color surface_container_lowest: "#090f10"
	
		readonly property color surface_dim: "#0e1415"
	
		readonly property color surface_tint: "#81d3df"
	
		readonly property color surface_variant: "#3f484a"
	
		readonly property color tertiary: "#b9c6ea"
	
		readonly property color tertiary_container: "#394664"
	
		readonly property color tertiary_fixed: "#d9e2ff"
	
		readonly property color tertiary_fixed_dim: "#b9c6ea"
	

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