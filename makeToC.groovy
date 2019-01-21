// Copyright (c) 2019  Egon Willighagen <egon.willighagen@gmail.com>
//
// GPL v3

// find all topics and makes a data file to be converted into an Index
//
// it takes one optional argument, which is appended to the output

def chapterCounter = 0

chapters = "order.txt"
new File(chapters).eachLine { chapter ->
  chapterCounter++
  file = "${chapter}.i.md"
  sectionCounter = 0
  subsectionCounter = 0
  new File(file).eachLine { line ->
    if (line.startsWith("# ")) {
      chapterTitle = line.substring(2).trim()
      println "${chapterCounter}. [${chapterTitle}](${chapter}.i.md) <br />"
    } else if (line.startsWith("## ") && !line.contains("References")) {
      subsectionCounter = 0
      sectionTitle = line.substring(3).trim()
      sectionCounter++
      sectionHref = sectionTitle.toLowerCase().replaceAll(" ", "-").replaceAll("\\.", "")
      println "${chapterCounter}.${sectionCounter}. [${sectionTitle}](${chapter}.i.md#${sectionHref}) <br />"
    } else if (line.startsWith("### ")) {
      subsectionCounter++
      sectionTitle = line.substring(4).trim()
      sectionHref = sectionTitle.toLowerCase().replaceAll(" ", "-").replaceAll("\\.", "")
      println "${chapterCounter}.${sectionCounter}.${subsectionCounter}. [${sectionTitle}](${chapter}.i.md#${sectionHref}) <br />"
    }
  }  
}

