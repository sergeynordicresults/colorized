import Lake
open Lake DSL

package Colorized where
  -- add package configuration options here

@[default_target]
lean_lib Colorized where
  -- add library configuration options here

lean_exe «example» where
  root := `Example
  supportInterpreter := true
