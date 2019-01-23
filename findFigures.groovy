// Copyright (c) 2018  Egon Willighagen <egon.willighagen@gmail.com>
//
// GPL v3

chapterCounters = new HashMap<String,String>();
chapterCounter = 0
def chapterLines = new File("order.txt").readLines()
chapterLines.each { String line ->
  chapterCounter++
  chapterCounters.put(line, "" + chapterCounter)
}

figureCounter = 0;

chapters = "order.txt"
new File(chapters).eachLine { chapter ->
  chapterCounter++
  currentChapterCounter = chapterCounters.get(chapter)
  file = "${chapter}.i.md"
  figureCounter = 0
  lines = new File(file).readLines()
  figureInstructionText = ""
  inFigure = false
  lines.each { String line ->
    if (inFigure && !line.contains("</figure>")) {
      figureInstructionText += line
      return
    } else if (line.contains("</figure>")) {
      figureEnd = line.indexOf("</figure>")
      figureInstructionText += line.substring(0, figureEnd+9)
      // now process the XML
      def figuresInstruction = new XmlSlurper().parseText(figureInstructionText)
      figNumber = "${currentChapterCounter}.${figureCounter}"
      if (figuresInstruction.@label != null && !(figuresInstruction.@label.isEmpty())) {
        println "${figuresInstruction.@label}\t${chapter}\t${figNumber}"
      }
      inFigure = false
    } else if (line.startsWith("<figure")) {
      inFigure = true
      figureCounter++
      figureStart = line.indexOf("<figure")
      figureInstructionText = line.substring(figureStart)
    }
  }
}
