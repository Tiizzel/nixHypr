import QtQuick

QtObject {
    readonly property string fontFamily: "Fira Sans Semibold"
	
		readonly property color background: "#121318"
	
		readonly property color error: "#ffb4ab"
	
		readonly property color error_container: "#93000a"
	
		readonly property color inverse_on_surface: "#303036"
	
		readonly property color inverse_primary: "#515b92"
	
		readonly property color inverse_surface: "#e3e1e9"
	
		readonly property color on_background: "#e3e1e9"
	
		readonly property color on_error: "#690005"
	
		readonly property color on_error_container: "#ffdad6"
	
		readonly property color on_primary: "#222c61"
	
		readonly property color on_primary_container: "#dee0ff"
	
		readonly property color on_primary_fixed: "#0a154b"
	
		readonly property color on_primary_fixed_variant: "#394379"
	
		readonly property color on_secondary: "#2c2f42"
	
		readonly property color on_secondary_container: "#dfe1f9"
	
		readonly property color on_secondary_fixed: "#171a2c"
	
		readonly property color on_secondary_fixed_variant: "#434659"
	
		readonly property color on_surface: "#e3e1e9"
	
		readonly property color on_surface_variant: "#c6c5d0"
	
		readonly property color on_tertiary: "#44263e"
	
		readonly property color on_tertiary_container: "#ffd7f2"
	
		readonly property color on_tertiary_fixed: "#2d1228"
	
		readonly property color on_tertiary_fixed_variant: "#5d3c55"
	
		readonly property color outline: "#90909a"
	
		readonly property color outline_variant: "#46464f"
	
		readonly property color primary: "#bac3ff"
	
		readonly property color primary_container: "#394379"
	
		readonly property color primary_fixed: "#dee0ff"
	
		readonly property color primary_fixed_dim: "#bac3ff"
	
		readonly property color scrim: "#000000"
	
		readonly property color secondary: "#c3c5dd"
	
		readonly property color secondary_container: "#434659"
	
		readonly property color secondary_fixed: "#dfe1f9"
	
		readonly property color secondary_fixed_dim: "#c3c5dd"
	
		readonly property color shadow: "#000000"
	
		readonly property color source_color: "#646c9c"
	
		readonly property color surface: "#121318"
	
		readonly property color surface_bright: "#39393f"
	
		readonly property color surface_container: "#1f1f25"
	
		readonly property color surface_container_high: "#29292f"
	
		readonly property color surface_container_highest: "#34343a"
	
		readonly property color surface_container_low: "#1b1b21"
	
		readonly property color surface_container_lowest: "#0d0e13"
	
		readonly property color surface_dim: "#121318"
	
		readonly property color surface_tint: "#bac3ff"
	
		readonly property color surface_variant: "#46464f"
	
		readonly property color tertiary: "#e5bad8"
	
		readonly property color tertiary_container: "#5d3c55"
	
		readonly property color tertiary_fixed: "#ffd7f2"
	
		readonly property color tertiary_fixed_dim: "#e5bad8"
	

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