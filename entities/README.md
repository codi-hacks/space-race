# Entity API

Entities are composed entirely from table properties (often called "aspects").
Rather than inheriting classes that contain functions and states, the functions are abstracted into modular systems and the entity will only hold its state. Below is a list of all possible aspects.

## Aspects

### body (table)

Given an empty table, all the default values will be assumed.
Given a `nil` value instead of a table, the entity won't be given a body.

- `fixed_rotation` (boolean = true) Whether or not an entity should have rotation movement [[1](https://love2d.org/wiki/Body:setFixedRotation)].
- `offset_x` (number = 0) Add a positive/negative horizontal pixel offset from all of the entity's designated spawn points.
- `offset_y` (number = 0) Add a positive/negative vertical pixel offset from all of the entity's designated spawn points.
- `mass` (number = 1) Set the entity's mass.
- `type` (string = 'dynamic') Set the Box2D body type. [[1](https://github.com/GuidebeeGameEngine/Box2D/wiki/Body-Types)]
  - `dynamic` - Body has a given mass and interactions with other bodies.
  - `kinematic` - Body interacts with dynamic bodies but cannot be moved by them.
  - `static` - Body interacts with dynamic bodies but cannot be moved by them and never has velocity.

### fixture (table)

- density (number) The fixture density in kilograms per square meter (the definition of a meter is found in the world's service). [[1](https://love2d.org/wiki/Fixture:setDensity)]
- friction (number) Set the contact sliding friction. [[1](https://love2d.org/wiki/Fixture:setFriction)]
- mask (number = 0) Set which fixture categories are filtered from collision. Add the categories together you want the fixture to ignore colliding with and subtract that number from `65535`. For instance, a player doesn't collide with players or player bullets so the formula for that would be `65535 - 1 - 2`.

### gravitational_mass (number = 0)

Mass for calculating gravity between two entities

### powerUps (table)

- Powerups active on the player.

- time (number) - Seconds the powerup has left until it is no longer active
- value (number) - Custom value to set the intensity of the powerup

```lua
powerUps = { time = 100, value = 100 }
```

### onCollision (function)

Register custom functionality to happen when contact with the player is made.

```lua
onCollision = function(self, player)
  print(player.body:getLinearVelocity())
end
```

### shape (table)

The shape is attached to the fixture and determines the entity's hitbox.

- points (table) an array of number x and y coordinates indicating all the corners of the polygon. This is only used when the shape `type` is `polygon` (see below).
- type (string) Set the shape type. This will determine what other parameters are required to define the shape. [[1](https://love2d.org/wiki/ShapeType)].
  - `chain` - Similar to an `edge`, except that it loops back to the first point.
  - `circle` - This will create a circular shape. Instead of defining a `points` table as you would with a `polygon` type shape, a `radius` is specified instead.
  - `edge` - A 2D shape defined by `points`. It does not have volume and can only collide with `circle` and `polygon` type shapes [[1](https://love2d.org/wiki/EdgeShape)].
  - `polygon` - Create a polygon based on defined `points` (as opposed to `radius` as with `circle` type shapes or `width` and `height` as with `rectangle` type shapes.)
  - `rectangle` - Instead of defining `points` or `radius` like you would with a polygon or circle, you would define the `height` and `width`. Box2D will create a shape with the resulting type of `polygon`, so this is just shorthand for not having to define 4 points everytime a rectangle is desired.

### spritesheet (table)

A `nil` value means no sprite will be registered.

See [spritesheed.md](./spritesheet.md) for more information.
