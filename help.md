####Viewer
This page allows you to visualize your query results. `Dendogram` is a tree based vector graphic representing the relations of nodes from the triple-store, where `Sunburst` used an interactive pie chart vector graphic for this  approach. In order to get a proper result it is necessary to think about the relationships of the output variables in your [SPARQL](https://www.w3.org/TR/rdf-sparql-query/) query.  
A `child` must have a relation to `root` and a `parent`, where the same `parent` needs to have a relation to the same `root`.  
Please mind this example:


PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>  
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>  
  
SELECT DISTINCT ?root_name ?parent_name ?child_name WHERE {  
  VALUES ?root_name { "endpoint" }  
  ?root rdfs:label ?root_name .  
  ?child rdfs:subClassOf{,5} ?root .  
  ?child rdfs:subClassOf ?parent .   
  ?child rdfs:label ?child_name .  
  ?parent rdfs:label ?parent_name .  
} 
 
---
####Sparql
This page gives you a [SPARQL](https://www.w3.org/TR/rdf-sparql-query/) interface to the triple-store. Available output formats are json, rdf, turtle, ntriples, csv, tsv, html and vnd.ms-excel. The full [SPARQL](https://www.w3.org/TR/rdf-sparql-query/) syntax is available including subqueries.

