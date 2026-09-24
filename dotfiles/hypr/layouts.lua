-- -----------------------------------------------------
-- Layout Configurations
-- -----------------------------------------------------

hl.config({
    -- ==========================================================
    -- DWINDLE LAYOUT
    -- The default recursive split layout (similar to bspwm)
    -- ==========================================================
    dwindle = {
        preserve_split = true, -- Keeps the split direction regardless of resizing
        smart_split = false,
        smart_resizing = true,
    },

    -- ==========================================================
    -- MASTER LAYOUT
    -- Stack-based tiling (similar to dwm or xmonad)
    -- ==========================================================
    master = {
        mfact = 0.5,
        orientation = "center",
        slave_count_for_center_master = 2,
        new_status = "master",
    },

    -- ==========================================================
    -- SCROLLING LAYOUT
    -- PaperWM-style infinite horizontal carousel
    -- ==========================================================
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.5,
        direction = "right",
        follow_focus = true,
        focus_fit_method = 0,
    }
})
