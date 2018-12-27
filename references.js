const fs = require('fs');

const Cite = require('citation-js');

fs.readFile('references.qids', 'utf8', async function (err, file) {
  const data = Array.from(await Cite.async(file))
    .map(item => item.id + '=' + Cite(item).format('bibliography', {template: 'vancouver'}))
  fs.writeFile('references.new.dat', data.join('\n'), function() {})
})
