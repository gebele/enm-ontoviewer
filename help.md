####Viewer
This page allows you to visualize your query results. `Dendogram` is a tree based vector graphic representing the relations of nodes from the triple-store, where `Sunburst` is an interactive pie chart vector graphic for this  approach. In order to get a proper result it is necessary to think about the relationships of the output variables in your [SPARQL](https://www.w3.org/TR/rdf-sparql-query/) query.  
A `child` must have a relation to `root` and a `parent`, where the same `parent` needs to have a relation to the same `root`.  
Please mind the template given in the editor and note the `{,5}` [property paths](https://www.w3.org/TR/sparql11-property-paths/) which is used for numbers of results. Some browser can not handle large numbers.  
  
---
####Sparql
This page gives you a [SPARQL](https://www.w3.org/TR/rdf-sparql-query/) interface to the triple-store. Available output formats are json, rdf, turtle, ntriples, csv, tsv, html and vnd.ms-excel. The full [SPARQL](https://www.w3.org/TR/rdf-sparql-query/) syntax is available including subqueries.

