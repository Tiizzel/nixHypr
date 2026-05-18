import QtQuick

QtObject {
    readonly property string fontFamily: "Fira Sans Semibold"
	
		readonly property color background: "#0f1416"
	
		readonly property color error: "#ffb4ab"
	
		readonly property color error_container: "#93000a"
	
		readonly property color inverse_on_surface: "#2c3133"
	
		readonly property color inverse_primary: "#00687b"
	
		readonly property color inverse_surface: "#dee3e6"
	
		readonly property color on_background: "#dee3e6"
	
		readonly property color on_error: "#690005"
	
		readonly property color on_error_container: "#ffdad6"
	
		readonly property color on_primary: "#003641"
	
		readonly property color on_primary_container: "#afecff"
	
		readonly property color on_primary_fixed: "#001f27"
	
		readonly property color on_primary_fixed_variant: "#004e5d"
	
		readonly property color on_secondary: "#1d343a"
	
		readonly property color on_secondary_container: "#cee7ef"
	
		readonly property color on_secondary_fixed: "#061f25"
	
		readonly property color on_secondary_fixed_variant: "#344a51"
	
		readonly property color on_surface: "#dee3e6"
	
		readonly property color on_surface_variant: "#bfc8cb"
	
		readonly property color on_tertiary: "#292e4d"
	
		readonly property color on_tertiary_container: "#dee0ff"
	
		readonly property color on_tertiary_fixed: "#141937"
	
		readonly property color on_tertiary_fixed_variant: "#404565"
	
		readonly property color outline: "#899295"
	
		readonly property color outline_variant: "#40484b"
	
		readonly property color primary: "#85d2e8"
	
		readonly property color primary_container: "#004e5d"
	
		readonly property color primary_fixed: "#afecff"
	
		readonly property color primary_fixed_dim: "#85d2e8"
	
		readonly property color scrim: "#000000"
	
		readonly property color secondary: "#b2cbd3"
	
		readonly property color secondary_container: "#344a51"
	
		readonly property color secondary_fixed: "#cee7ef"
	
		readonly property color secondary_fixed_dim: "#b2cbd3"
	
		readonly property color shadow: "#000000"
	
		readonly property color source_color: "#548796"
	
		readonly property color surface: "#0f1416"
	
		readonly property color surface_bright: "#343a3c"
	
		readonly property color surface_container: "#1b2022"
	
		readonly property color surface_container_high: "#252b2d"
	
		readonly property color surface_container_highest: "#303638"
	
		readonly property color surface_container_low: "#171c1e"
	
		readonly property color surface_container_lowest: "#090f11"
	
		readonly property color surface_dim: "#0f1416"
	
		readonly property color surface_tint: "#85d2e8"
	
		readonly property color surface_variant: "#40484b"
	
		readonly property color tertiary: "#c0c4eb"
	
		readonly property color tertiary_container: "#404565"
	
		readonly property color tertiary_fixed: "#dee0ff"
	
		readonly property color tertiary_fixed_dim: "#c0c4eb"
	

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