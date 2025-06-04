namespace Colorized

/-! Colorized library for adding color and style to text output. This library provides functionality
to change the foreground and background colors, as well as to apply various text styles. -/

/-- The `Section` type represents whether the color applies to the foreground or background. -/
inductive Section
  | Foreground
  | Background
  deriving BEq, Inhabited, Ord, DecidableEq, Repr

/-- The `Color` type represents different color options available for text. -/
inductive Color
  | Black
  | Red
  | Green
  | Yellow
  | Blue
  | Magenta
  | Cyan
  | White
  | BrightBlack
  | BrightRed
  | BrightGreen
  | BrightYellow
  | BrightBlue
  | BrightMagenta
  | BrightCyan
  | BrightWhite
  | Default
  deriving BEq, Inhabited, Ord, DecidableEq, Repr

@[inline] private def colorCode : Color -> Int
  | Color.Black => 30
  | Color.Red => 31
  | Color.Green => 32
  | Color.Yellow => 33
  | Color.Blue => 34
  | Color.Magenta => 35
  | Color.Cyan => 36
  | Color.White => 37
  | Color.BrightBlack => 90
  | Color.BrightRed => 91
  | Color.BrightGreen => 92
  | Color.BrightYellow => 93
  | Color.BrightBlue => 94
  | Color.BrightMagenta => 95
  | Color.BrightCyan => 96
  | Color.BrightWhite => 97
  | Color.Default => 39

/-- The `Style` type represents different text styles that can be applied. -/
inductive Style
  | Normal
  | Bold
  | Faint
  | Italic
  | Underline
  | SlowBlink
  | ColoredNormal
  | Reverse
  | Strikethrough
  | DoubleUnderline
  deriving BEq, Inhabited, Ord, DecidableEq, Repr

@[inline] private def styleCode : Style -> Nat
  | Style.Normal => 0
  | Style.Bold => 1
  | Style.Faint => 2
  | Style.Italic => 3
  | Style.Underline => 4
  | Style.SlowBlink => 5
  | Style.ColoredNormal => 6
  | Style.Reverse => 7
  | Style.Strikethrough => 9
  | Style.DoubleUnderline => 21

/-- Cursor movement and screen control operations -/
inductive CursorOp
  | Up (n : Nat)
  | Down (n : Nat)
  | Forward (n : Nat)
  | Back (n : Nat)
  | NextLine (n : Nat)
  | PreviousLine (n : Nat)
  | Position (row col : Nat)
  | HorizontalAbsolute (n : Nat)
  | SavePosition
  | RestorePosition
  | HideCursor
  | ShowCursor
  deriving BEq, Inhabited, Ord, DecidableEq, Repr

@[inline] private def cursorOpCode : CursorOp -> String
  | CursorOp.Up n => s!"{n}A"
  | CursorOp.Down n => s!"{n}B"
  | CursorOp.Forward n => s!"{n}C"
  | CursorOp.Back n => s!"{n}D"
  | CursorOp.NextLine n => s!"{n}E"
  | CursorOp.PreviousLine n => s!"{n}F"
  | CursorOp.HorizontalAbsolute n => s!"{n}G"
  | CursorOp.Position x y => s!"{x};{y}H"
  | CursorOp.SavePosition => "s"
  | CursorOp.RestorePosition => "u"
  | CursorOp.HideCursor => "?25l"
  | CursorOp.ShowCursor => "?25h"

/-- Screen erasing operations -/
inductive EraseOp
  | ToEnd
  | FromBeginning
  | Entire
  deriving BEq, Inhabited, Ord, DecidableEq, Repr

@[inline] private def eraseOpCode : EraseOp -> Nat
  | EraseOp.ToEnd => 0
  | EraseOp.FromBeginning => 1
  | EraseOp.Entire => 2

/-- The `Colorized` class defines an interface for colorizing and styling text. It provides methods
for applying color to the foreground or background, and for applying different text styles.
-/
class Colorized (α : Type) where
  colorize : Section → Color → α → α
  style : Style → α → α
  bgColor := colorize Section.Background
  color := colorize Section.Foreground

/-- Cursor control class -/
class CursorControl (α : Type) where
  cursor : CursorOp → α
  eraseScreen : EraseOp → α
  eraseLine : EraseOp → α

/-- Constant string representing the beginning of an ANSI escape sequence. -/
@[inline] private def const := "\x1b["

/-- Constant string for resetting text formatting. -/
@[inline] private def reset := "\x1b[0m"

@[inline] private def colorSectionCode : Section → Color → Int
  | Section.Foreground, c => colorCode c
  | Section.Background, c => colorCode c + 10

@[inline] instance : Colorized String where
  colorize sec col str := s!"{const}{colorSectionCode sec col}m{str}{reset}"
  style sty str := s!"{const}{styleCode sty}m{str}{reset}"

@[inline] instance : CursorControl String where
  cursor op := s!"{const}{cursorOpCode op}"
  eraseScreen param := s!"{const}{eraseOpCode param}J"
  eraseLine param := s!"{const}{eraseOpCode param}K"
