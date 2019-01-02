// Copyright (c) 2019  Egon Willighagen <egon.willighagen@gmail.com>
//
// GPL v3

// use the output of findTopics.groovy to create a Markdown index

println "# Index\n\n";

def lines = new File("topics.tsv").readLines()
lines.each { String line ->
  data = line.split("\t")
  topic = data[0]
  where = data[1]
  ref = data[2]
  println "$topic [$where](${where}.i.md#$ref)<br />\n"
}

