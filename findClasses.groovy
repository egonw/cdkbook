// Copyright (c) 2019-2022  Egon Willighagen <egon.willighagen@gmail.com>
//
// GPL v3
//
// find all classes and makes a data file to be complemented with additional data
//
// it takes one optional argument, which is appended to the output

import groovy.xml.XmlSlurper

if (args.length == 0) {
  println "groovy findClasses.groovy <directory>"
  System.exit(0)
}

def folder = args[0]

def basedir = new File(folder)
files = basedir.listFiles().grep(~/.*i.md$/)
files.each { file ->
  file.eachLine { line ->
    while (line.contains("<class")) {
      classStart = line.indexOf("<class")
      classEnd = line.indexOf("</class>")
      classXML = line.substring(classStart, classEnd+8)
      def classInstruction = new XmlSlurper().parseText(classXML)
      classname = classInstruction.text()
      if (!classname.isEmpty()) {
        println "${classname}"
      }
      line = line.substring(0, classStart) + line.substring(classEnd+8)
    }
  }
}

