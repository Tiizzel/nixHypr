import QtQuick

QtObject {
    readonly property string fontFamily: "Fira Sans Semibold"
	
		readonly property color background: "#101418"
	
		readonly property color error: "#ffb4ab"
	
		readonly property color error_container: "#93000a"
	
		readonly property color inverse_on_surface: "#2d3135"
	
		readonly property color inverse_primary: "#2b638b"
	
		readonly property color inverse_surface: "#e0e2e8"
	
		readonly property color on_background: "#e0e2e8"
	
		readonly property color on_error: "#690005"
	
		readonly property color on_error_container: "#ffdad6"
	
		readonly property color on_primary: "#003351"
	
		readonly property color on_primary_container: "#cce5ff"
	
		readonly property color on_primary_fixed: "#001e31"
	
		readonly property color on_primary_fixed_variant: "#054b71"
	
		readonly property color on_secondary: "#23323f"
	
		readonly property color on_secondary_container: "#d4e4f6"
	
		readonly property color on_secondary_fixed: "#0d1d2a"
	
		readonly property color on_secondary_fixed_variant: "#394857"
	
		readonly property color on_surface: "#e0e2e8"
	
		readonly property color on_surface_variant: "#c2c7ce"
	
		readonly property color on_tertiary: "#372a4a"
	
		readonly property color on_tertiary_container: "#ecdcff"
	
		readonly property color on_tertiary_fixed: "#211534"
	
		readonly property color on_tertiary_fixed_variant: "#4e4162"
	
		readonly property color outline: "#8c9198"
	
		readonly property color outline_variant: "#42474e"
	
		readonly property color primary: "#98ccf9"
	
		readonly property color primary_container: "#054b71"
	
		readonly property color primary_fixed: "#cce5ff"
	
		readonly property color primary_fixed_dim: "#98ccf9"
	
		readonly property color scrim: "#000000"
	
		readonly property color secondary: "#b8c8da"
	
		readonly property color secondary_container: "#394857"
	
		readonly property color secondary_fixed: "#d4e4f6"
	
		readonly property color secondary_fixed_dim: "#b8c8da"
	
		readonly property color shadow: "#000000"
	
		readonly property color source_color: "#448ec4"
	
		readonly property color surface: "#101418"
	
		readonly property color surface_bright: "#363a3e"
	
		readonly property color surface_container: "#1c2024"
	
		readonly property color surface_container_high: "#272a2e"
	
		readonly property color surface_container_highest: "#313539"
	
		readonly property color surface_container_low: "#181c20"
	
		readonly property color surface_container_lowest: "#0b0f12"
	
		readonly property color surface_dim: "#101418"
	
		readonly property color surface_tint: "#98ccf9"
	
		readonly property color surface_variant: "#42474e"
	
		readonly property color tertiary: "#d1bfe7"
	
		readonly property color tertiary_container: "#4e4162"
	
		readonly property color tertiary_fixed: "#ecdcff"
	
		readonly property color tertiary_fixed_dim: "#d1bfe7"
	

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