import Colorized
open Colorized

def main : IO Unit := do
  -- Basic styles
  IO.println (Colorized.style Style.Bold "Bold text")
  IO.println (Colorized.style Style.Italic "Italic text")
  IO.println (Colorized.style Style.Underline "Underlined text")
  IO.println (Colorized.style Style.Strikethrough "Strikethrough text")
  IO.println (Colorized.style Style.Faint "Faint text")
  IO.println (Colorized.style Style.SlowBlink "Blinking text")
  IO.println (Colorized.style Style.Reverse "Reversed text")
  IO.println (Colorized.style Style.DoubleUnderline "Double underlined text")

  -- Standard colors (foreground)
  IO.println (Colorized.color Color.Red "Red text")
  IO.println (Colorized.color Color.Green "Green text")
  IO.println (Colorized.color Color.Blue "Blue text")
  IO.println (Colorized.color Color.Yellow "Yellow text")
  IO.println (Colorized.color Color.Magenta "Magenta text")
  IO.println (Colorized.color Color.Cyan "Cyan text")
  IO.println (Colorized.color Color.White "White text")
  IO.println (Colorized.color Color.Black "Black text")

  -- Bright colors
  IO.println (Colorized.color Color.BrightRed "Bright red text")
  IO.println (Colorized.color Color.BrightGreen "Bright green text")
  IO.println (Colorized.color Color.BrightBlue "Bright blue text")
  IO.println (Colorized.color Color.BrightYellow "Bright yellow text")
  IO.println (Colorized.color Color.BrightMagenta "Bright magenta text")
  IO.println (Colorized.color Color.BrightCyan "Bright cyan text")
  IO.println (Colorized.color Color.BrightWhite "Bright white text")
  IO.println (Colorized.color Color.BrightBlack "Bright black text")

  -- Background colors
  IO.println (Colorized.bgColor Color.Red "Red background")
  IO.println (Colorized.bgColor Color.Green "Green background")
  IO.println (Colorized.bgColor Color.Blue "Blue background")
  IO.println (Colorized.bgColor Color.BrightYellow "Bright yellow background")

  -- Combined style and color
  IO.println (Colorized.color Color.Red (Colorized.style Style.Bold "Bold red text"))
  IO.println (Colorized.color Color.Green (Colorized.style Style.Italic "Italic green text"))
  IO.println (Colorized.color Color.Blue (Colorized.style Style.Underline "Underlined blue text"))
  IO.println (Colorized.bgColor Color.Yellow (Colorized.color Color.Black "Black on yellow"))

  -- Nested combinations
  IO.println (Colorized.bgColor Color.BrightBlue
    (Colorized.color Color.BrightWhite
      (Colorized.style Style.Bold "Bold white on bright blue")))

  -- Cursor operations
  IO.print (CursorControl.cursor (α := String) (CursorOp.Up 2))
  IO.print "Moved up 2 lines"
  IO.print (CursorControl.cursor (α := String) (CursorOp.Down 2))
  IO.println ""

  IO.print (CursorControl.cursor (α := String) (CursorOp.Forward 10))
  IO.print "Moved forward"
  IO.print (CursorControl.cursor (α := String) (CursorOp.Back 10))
  IO.println ""

  IO.print (CursorControl.cursor (α := String) (CursorOp.Position 5 10))
  IO.print "At position (5,10)"
  IO.println ""

  -- Save/restore position
  IO.print (CursorControl.cursor (α := String) CursorOp.SavePosition)
  IO.print "Position saved"
  IO.print (CursorControl.cursor (α := String) (CursorOp.Forward 20))
  IO.print "Moved forward"
  IO.print (CursorControl.cursor (α := String) CursorOp.RestorePosition)
  IO.println "Back to saved position"

  -- Hide/show cursor
  IO.print (CursorControl.cursor (α := String) CursorOp.HideCursor)
  IO.print "Cursor hidden (wait 1 sec)"
  -- In real usage, you'd add a delay here
  IO.print (CursorControl.cursor (α := String) CursorOp.ShowCursor)
  IO.println "Cursor shown"

  -- Erase operations
  IO.print "This line will be partially erased"
  IO.print (CursorControl.eraseLine (α := String) EraseOp.ToEnd)
  IO.println ""

  IO.print "Clearing screen in 3 seconds..."
  -- In real usage, you'd add a delay here
  IO.print (CursorControl.eraseScreen (α := String) EraseOp.Entire)

  -- Test edge cases
  IO.println (Colorized.color Color.Default "Default color")
  IO.println (Colorized.bgColor Color.Default "Default background")
  IO.println (Colorized.style Style.Normal "Normal style (reset)")

  IO.println "All tests completed!"
