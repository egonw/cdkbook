// when it fails to run with a mention of entity-schema not being defined, add it to
// the params definition around line 80 in in node_modules/wikibase-sdk/lib/helpers/parse_claim.js
// of the wikibase-sdk module

const fs = require('fs');

const { Cite } = require('@citation-js/core')
// Load plugins
require('@citation-js/plugin-wikidata')
require('@citation-js/plugin-csl')

fs.readFile('references.qids', 'utf8', async function (err, file) {
  const data = Array.from(await Cite.async(file))
    .map(item => item.id + '=' + Cite(item).format('bibliography', {
      template: 'vancouver',
      append: function (entry) {
        return entry.DOI
          ? ' doi:[' + entry.DOI + '](https://doi.org/' + entry.DOI + ')' +
            ' ([Scholia](https://scholia.toolforge.org/doi/' + entry.DOI + "))"
          : '';
      }
    }))
  fs.writeFile('references.dat', data.join(''), function() {})
})
