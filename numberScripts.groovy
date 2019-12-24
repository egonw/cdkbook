// Copyright (c) 2018-2020  Egon Willighagen <egon.willighagen@gmail.com>
//
// GPL v3

chapters = "order.txt"
chapterCounters = new HashMap<String,String>();
chapterCounter = 0
def chapterLines = new File(chapters).readLines()
chapterLines.each { String line ->
  chapterCounter++
  chapterCounters.put(line, "" + chapterCounter)
}

scriptCounter = 0;

tags = [ "code" ]
new File(chapters).eachLine { chapter ->
  chapterCounter++
  scriptsNames = new HashSet<String>();
  currentChapterCounter = chapterCounters.get(chapter)
  file = "${chapter}.i.md"
  scriptCounter = 0
  lines = new File(file).readLines()
  scriptInstructionText = ""
  inScript = false
  lines.each { String line ->
    for (tag in tags) {
      while (line.contains("<${tag}")) {
        xmlStart = line.indexOf("<${tag}")
        xmlEnd = line.indexOf("</${tag}>")
        fullXML = line.substring(xmlStart, xmlEnd+tag.length()+3)
        def scriptInstruction = new XmlSlurper().parseText(fullXML)
        scriptname = scriptInstruction.text()
        if (!scriptname.isEmpty() && !scriptsNames.contains(scriptname)) {
          scriptsNames.add(scriptname)
          scriptCounter++
          scriptNumber = "${currentChapterCounter}.${scriptCounter}"
          println "${scriptname}\t${chapter}\t${scriptNumber}"
        }
        line = line.substring(0, xmlStart) + line.substring(xmlEnd+tag.length()+3)
      }
    }
  }
}
