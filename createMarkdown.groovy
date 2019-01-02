// Copyright (c) 2018  Egon Willighagen <egon.willighagen@gmail.com>
//
// GPL v3

input = args[0]

bibliography = new HashMap<String,String>();
def bibLines = new File("references.dat").readLines()
bibLines.each { String line ->
  fields = line.split("=1. ")
  bibliography.put(fields[0], fields[1])
}

references = new HashMap<String,String>();
bibList = "";
refCounter = 0;
topicCounter = 0;

def lines = new File(input).readLines()
lines.each { String line ->
  if (line.startsWith("<code>")) {
    def instruction = new XmlSlurper().parseText(line)
    def srcLines = new File("code/${instruction.text()}.verbatim.md").readLines()
    srcLines.each { String srcLine -> println srcLine }
  } else if (line.startsWith("<out>")) {
    def instruction = new XmlSlurper().parseText(line)
    println "```plain"
    def srcLines = new File("code/${instruction.text()}.out").readLines()
    srcLines.each { String srcLine -> println srcLine }
    println "```"
  } else if (line.contains("<references/>")) {
    println bibList
  } else if (line.startsWith("%%%")) {
    // ignore/remove this line
  } else {
    while (line.contains(".i.md")) {
      line = line.replace(".i.md", ".md")
    }
    while (line.contains("<cite>")) {
      citeStart = line.indexOf("<cite>")
      citeEnd = line.indexOf("</cite>")
      cites = line.substring(citeStart+6, citeEnd)
      if (cites.isEmpty()) cites = "?"
      replacement = ""
      if (!references.containsKey(cites)) {
        refCounter++
        references.put(cites, "" + refCounter)
        if (bibliography.get(cites) != null) {
          bibList += "${refCounter}. " + bibliography.get(cites) + "\n"
        } else {
          bibList += "${refCounter}. Missing\n"
        }
        replacement = refCounter
      } else {
        replacement = Integer.valueOf(references.get(cites))
      }
      line = line.substring(0, citeStart) + replacement + line.substring(citeEnd+7)
    }
    while (line.contains("<topic")) {
      topicCounter++
      topicStart = line.indexOf("<topic")
      topicEnd = line.indexOf("</topic>")
      topicsXML = line.substring(topicStart, topicEnd+8)
      def topicsInstruction = new XmlSlurper().parseText(topicsXML)
      replacement = ""
      if (topicsInstruction.@type == "class" ||
          topicsInstruction.@type == "key") {
        replacement = "`" + topicsInstruction.text() + "`"
      } else {
        replacement = topicsInstruction.text()
      }
      replacement = "<a name=\"tp${topicCounter}\">" + replacement + "</a>"
      line = line.substring(0, topicStart) + replacement + line.substring(topicEnd+8)
    }
    println line
  }
}
