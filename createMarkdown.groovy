// Copyright (c) 2018  Egon Willighagen <egon.willighagen@gmail.com>
//
// GPL v3

input = args[0]

def lines = new File(input).readLines()

lines.each { String line ->
  if (line.contains("<code>")) {
    def instruction = new XmlSlurper().parseText(line)
    def srcLines = new File("code/${instruction.text()}.verbatim.md").readLines()
    srcLines.each { String srcLine -> println srcLine }
  } else if (line.contains("<out>")) {
    def instruction = new XmlSlurper().parseText(line)
    println "```plain"
    def srcLines = new File("code/${instruction.text()}.verbatim.md").readLines()
    srcLines.each { String srcLine -> println srcLine }
    println "```"
  } else if (line.contains(".i.md")) {
    line = line.replace(".i.md", ".md")
    println line
  } else {
    println line
  }
}
