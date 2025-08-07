globals [global-tick]
patches-own [ticks-as-pink ticks-as-sky ticks-as-lime]
to setup
  clear-all
  reset-ticks
  set global-tick 0
  init-grid
  set-patch-size 60
  resize-world 0 9 0 9
  create-turtles num-turtles [
  let new-patch one-of patches with [not any? turtles-here]
  ifelse who = 0 [
    set color red
    set heading 180
  ] [
    ifelse who = 1 [
      set color blue
      set heading 90
    ] [
      set color green
      set heading 0
    ]
  ]
  move-to new-patch
]
end

to init-grid
  ask patches [
    set pcolor white
    set ticks-as-pink 0
    set ticks-as-sky 0
  ]
end

to Occupied
  ask turtles [
    if color = red [
      if ([pcolor] of patch-ahead 1 = white) or ([pcolor] of patch-ahead 1 = pink) [
        forward 1
        set pcolor pink
        set ticks-as-pink 0 ; Reset ticks-as-pink when patch turns pink
      ]
      if ([pcolor] of patch-ahead 1 = sky) or ([pcolor] of patch-ahead 1 = lime) [
        let choice random 3
        ifelse choice = 0 [left 90]
        [ifelse choice = 1 [right 90]
         [if choice = 2 [left 180]]
        ]
      ]
      let choice random 4
      if choice = 0 [left 90]
      if choice = 1 [right 90]
      if choice = 2 [right 180]
    ]


    if color = blue [
      if ([pcolor] of patch-ahead 1 = white) or ([pcolor] of patch-ahead 1 = sky) [
        forward 1
        set pcolor sky
        set ticks-as-sky 0
      ]
      if ([pcolor] of patch-ahead 1 = pink ) or ([pcolor] of patch-ahead 1 = sky) [
        let choice random 3
        ifelse choice = 0 [left 90]
        [ifelse choice = 1 [right 90]
         [if choice = 2 [left 180]]
        ]
      ]
      let choice random 4
      if choice = 0 [left 90]
      if choice = 1 [right 90]
      if choice = 2 [right 180]
    ]


    if color = green [
      if ([pcolor] of patch-ahead 1 = white) or ([pcolor] of patch-ahead 1 = lime) [
        forward 1
        set pcolor lime
        set ticks-as-lime 0
      ]
      if ([pcolor] of patch-ahead 1 = pink) or ([pcolor] of patch-ahead 1 = sky) [
        let choice random 3
        ifelse choice = 0 [left 90]
        [ifelse choice = 1 [right 90]
         [if choice = 2 [left 180]]
        ]
      ]
      let choice random 4
      if choice = 0 [left 90]
      if choice = 1 [right 90]
      if choice = 2 [right 180]
    ]
  ]

  ; Increase ticks-as-pink for all pink patches
  ask patches with [pcolor = pink] [set ticks-as-pink ticks-as-pink + 1]
  ask patches with [pcolor = sky] [set ticks-as-sky ticks-as-sky + 1]
  ask patches with [pcolor = lime] [set ticks-as-lime ticks-as-lime + 1]

  ; Check and change color of patches that have been pink for 50 ticks
  ask patches with [pcolor = pink and ticks-as-pink = 60] [set pcolor white]
  ask patches with [pcolor = sky and ticks-as-sky = 60] [set pcolor white]
  ask patches with [pcolor = lime and ticks-as-lime = 60] [set pcolor white]

  tick
  wait 0.3
end
