input = args[0]

def lines = new File(input).readLines()

lines.each { String line ->
  if (line.contains("<code")) {
    def instruction = new XmlSlurper().parseText(line)
      if (instruction.@src) {
        def srcLines = new File("code/${instruction.@src}.verbatim.md").readLines()
        srcLines.each { String srcLine -> println srcLine }
      } else if (instruction.@out) {
        println "```plain"
        println "" + instruction.@out
	println "```"
      }    
  } else {
    println line
  }
}
