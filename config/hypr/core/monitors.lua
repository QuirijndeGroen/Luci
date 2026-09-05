------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@144",
    position = "0x0",
    scale    = "1",
})

hl.monitor({
    output   = "DVI-I-1",
    mode     = "1920x1080@60",
    position = "-990x-1080",
    scale    = "1",
})

hl.monitor({
    output   = "DVI-I-2",
    mode     = "1920x1080@60",
    position = "990x-1080",
    scale    = "1",
})