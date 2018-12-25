// find all references to scripts
//
// it takes one optional argument, which is appended to the output

if (args.length == 0) {
  println "groovy findScripts.groovy <directory> [suffix]"
  System.exit(0)
}

def folder = args[0]

def suffix = ""
if (args.length == 2) suffix = args[1]

def basedir = new File(folder)
files = basedir.listFiles().grep(~/.*mdi$/)
files.each { file ->
  file.eachLine { line ->
    if (line.contains("<code")) {
      def instruction = new XmlSlurper().parseText(line)
      if (instruction.@src) {
        println "" + instruction.@src + suffix
      } else if (instruction.@out) {
        println "" + instruction.@out + suffix
      }
    }
  }
}

