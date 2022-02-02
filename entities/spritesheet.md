# Spritesheet API

Each spritesheet table is a configuration for what will become the living sprite and spritesheet for an entity.
Whether there is a single non-animated sprite or multiple animated sprites (or a mix) they are all stored in the [actions](#actions) sub-table and transformed into [anim8](https://github.com/kikito/anim8) tables.
This is done to keep the data type and location consistent.
Spritesheets, similar to entities, are composed entirely of pure data properties.
Fo consistency we'll also refer to these as "aspects".
When registered to an entity, aspects are transformed as noted below.

## Aspects

### actions (table)

The table must contain at least one key, `default`, which represents the sprite to append to the entity on load.
If no table is given, a `default` action will be registered with 1 frame (`{ default = { frames = { 1, 1 } } }`).
The key given will also equal the actions name (`spritesheet[key].name == key`).
With the exception of the `image` property, sprite actions can contain any of the same aspects as the spritesheet itself, overriding those properties.
When a spritesheet is registered to an entity, each action table is transformed into an instance of [anim8.animation](https://github.com/kikito/anim8#animations).


Example:

```lua
{
  duration = 0.2,
  actions = {
    default = {
      frames = { 1, '1-2' },
      gap = 1
    },
    explode = {
      frames = { '2-3', '1-2' },
      gap = 1,
      -- Note this duration will override the sprite set's
      -- duration set above for this sprite action.
      duration = 0.2,
      on_loop = function(animation)
        animation:gotoFrame(3)
      end
    },
    -- Notice these sprite actions have no keys, so they are indexed
    -- sequentially starting from the number 1. This syntax
    -- works for LuaJIT 5.1, the dialect or Lua used by Love.
    {
      frames = { 4, '1-2' }
    },
    {
      frames = { 5, '1-2' }
    }
  }
}
```

### duration (number|table = 0)

The amount of time in seconds to display each frame.
When it's a number, it represents the duration of all the frames in the animation.
When it's a table, it can represent different durations for different frames.
You can specify durations for all frames individually, like `{0.1, 0.5, 0.1}` or you can specify durations for ranges of frames like `{ ['3-5'] = 0.2 }`.
A value of `0` means display it indefinitely.
Numbers must be positive or 0.
This value is passed direction to [anim8.newAnimation()](https://github.com/kikito/anim8#animations).

### frames (table = { 1, 1 })

Each pair of elements in the table represents the column and row of a frame.
Columns and rows in a sprite sheet grid are counted starting at `1`.
Any arbitrary number of columns and rows can be specified.
The rows and columns can be strings or numbers.
The strings can represent a range of columns or rows so that a range or sequential frames is easier to define.
Here are some examples:

```lua
-- 2 frames:
-- 1) column 3 row 8
-- 2) column 5 row 1
{ 3, 8, 5, 1 }
-- 13 frames:
-- 3 in column 2 row 3-5
-- 3 in column 3 row 3-5... etc.,
-- and ending on 1 frame on column 1 row 1
{ '2-5', '3-5', 1, 1 }
```

### gap (number = 0)

The padding between frames that will be skipped over.

### height (number)

The height of each sprite action.
The number must be positive.
If no number is specified the height of the entire spritesheet is used.

### image (string)

The name of an image used to compose the entire spritesheet.
This should match the name of an image in the texture service.
Example:
```lua
image = 'checkpoint-gate'
```

When the spritesheet is registered to an entity, the `image` aspect is transformed into an instance of [Love.graphics.image](https://love2d.org/wiki/Image).


### offset_x (number = 0)

The x-axis pixel offset of the sprite from the entity body. [[1](https://love2d.org/wiki/love.graphics.draw)]

### offset_y (number = offset_x)

The y-axis pixel offset. This will match the offset_x unless specified.

### on_loop (function)

This function will be called after the last frame has finished its draw duration.
It can be used to manipulate the sprite itself or invoke a system.
It has one argument, the sprite itself, which is an [anim8.animation](https://github.com/kikito/anim8#animations).

### width (number)

The width of each sprite action.
The number must be positive.
If no number is specified, the width of the entire spritesheet is used.

## x (number = 0)

The x position of the top-left corner where the sprite begins.

## y (number = 0)

The y position of the top-left corner where the sprite begins.
