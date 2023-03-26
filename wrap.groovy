// Copyright (c) 2011-2023  Egon Willighagen <egon.willighagen@gmail.com>
//
// GPL v3

// checks

maxLineLength = 80

System.in.eachLine { line ->
  while (line.length() > maxLineLength) {
    println line.substring(0,maxLineLength-2) + "..."
    line = "  " + line.substring(maxLineLength-2)
  }
  println line
}

