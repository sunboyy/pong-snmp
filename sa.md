# System Analysis

- Hardware
  - Start Screen ROM [PP]
  - Game Screen Logic + Memory Mapped IO
  - LED
- Software
  - Press button Start game
  - Move ball
  - Collision detection
  - Score++
  - Reset game

## Screen

- Start screen: Static
- Game screen:
  _ Static
  _ Score 1 -> MEM 0xff01
  _ Score 2 -> MEM 0xff02
  _ Padding 1 -> MEM 0xff03
  _ Padding 2 -> MEM 0xff04
  _ Ball -> MEM x: 0xff05, y: 0xff06
  _ A Pressing -> MEM 0x1f07
  _ S Pressing -> MEM 0x1f08
  _ J Pressing -> MEM 0x1f09
  _ K Pressing -> MEM 0x1f0a
  \_ Speed ball vector -> MEM x: 0x1ffe, y: 0x1fff
  Game state 0xff00 (In game, Start screen)

## Memory Mapped I/O
