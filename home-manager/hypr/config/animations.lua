hl.config({
    animations = {
        enabled = true,
    },
})

-- curves
hl.curve("wind",
    {   type = "bezier",
        points = {
            { 0.2, 0.6 },
            { 0.1, 1.05 },
        }
    }
)
hl.curve("wind2",
    {   type = "bezier",
        points = {
            { 0.05, 1.1 },
            { 0.1,  1.5 },
        }
    }
)
hl.curve("winIn",
    {   type = "bezier",
        points = {
            { 0.1, 1.1    },
            { 0.1, 1.0175 },
        }
    }
)
hl.curve("liner",
    {   type = "bezier",
        points = {
            { 1, 1 },
            { 1, 1 },
        }
    }
)
hl.curve("md3_decel",
    {   type = "bezier",
        points = {
            { 0.05, 0.7 },
            { 0.1,  1   },
        }
    }
)
hl.curve("menu_decel",
    {   type = "bezier",
        points = {
            { 0.1, 1 },
            { 0,   1 },
        }
    }
)
hl.curve("menu_accel",
    {   type = "bezier",
        points = {
            { 0.38, 0.04 },
            { 1,    0.07 },
        }
    }
)
hl.curve("workspace",
    {   type = "bezier",
        points = {
            { 0.22, 1      },
            { 0.36, 1.0125 },
        }
    }
)
hl.curve("winClose",
    {   type = "bezier",
        points = {
            { 0.8, 1    },
            { 0.9, 1.05 },
        }
    }
)
hl.curve("spring_anim",
    {   type = "bezier",
        points = {
            { 0.45, 1.25 },
            { 0.45, 1.15 },
        }
    }
)
hl.curve("overshot",
    {   type = "bezier",
        points = {
            { 0.18, 0.95 },
            { 0.22, 1.03 },
        }
    }
)

-- spring curves
hl.curve("spring_menu",
    {   type = "spring",
        mass = 1,
        stiffness = 80,
        dampening = 14,
    }
)
hl.curve("spring_window",
    {   type = "spring",
        mass = 1,
        stiffness = 30,
        dampening = 8,
    }
)
hl.curve("spring_open",
    {   type = "spring",
        mass = 1,
        stiffness = 30,
        dampening = 8,
    }
)
hl.curve("spring_workspace",
    {   type = "spring",
        mass = 1.2,
        stiffness = 30,
        dampening = 10,
    }
)
hl.curve("spring_special",
    {   type = "spring",
        mass = 1,
        stiffness = 30,
        dampening = 8,
    }
)

-- animations
hl.animation({
    leaf    = "border",
    enabled = true,
    speed   = 4,
    bezier  = "liner",
})
hl.animation({
    leaf    = "borderangle",
    enabled = true,
    speed   = 30,
    bezier  = "liner",
    style   = "loop",
})
hl.animation({
    leaf    = "windows",
    enabled = true,
    speed   = 2,
    bezier  = "wind",
    style   = "slide",
})
hl.animation({
    leaf    = "windowsIn",
    enabled = true,
    speed   = 10,
    bezier  = "winIn",
    style   = "slide",
})
hl.animation({
    leaf    = "windowsOut",
    enabled = true,
    speed   = 8,
    bezier  = "overshot",
    style   = "slide",
})
hl.animation({
    leaf    = "windowsMove",
    enabled = true,
    speed   = 17,
    bezier  = "wind",
    style   = "popins",
})
hl.animation({
    leaf    = "fade",
    enabled = true,
    speed   = 3,
    bezier  = "md3_decel",
})
hl.animation({
    leaf    = "layersIn",
    enabled = true,
    speed   = 9,
    bezier  = "menu_decel",
    style   = "slide",
})
hl.animation({
    leaf    = "layersOut",
    enabled = true,
    speed   = 9,
    bezier  = "menu_decel",
    style   = "slide",
})
hl.animation({
    leaf    = "fadeLayersIn",
    enabled = true,
    speed   = 2,
    bezier  = "menu_decel",
})
hl.animation({
    leaf    = "fadeLayersOut",
    enabled = true,
    speed   = 4.5,
    bezier  = "menu_accel",
})
hl.animation({
    leaf    = "workspaces",
    enabled = true,
    speed   = 9,
    bezier  = "workspace",
    style   = "slidefadevert 25%",
})
hl.animation({
    leaf    = "zoomFactor",
    enabled = true,
    speed   = 12,
    bezier  = "workspace",
})
