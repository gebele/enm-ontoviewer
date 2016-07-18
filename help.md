####Viewer
The javascript plugin for visualisation process a json hash as response from the triple-store.
In order to write correct SPARQL queries please mind this example:

```
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

    SELECT ?root_name ?parent_name ?child_name WHERE {
      VALUES ?root_name { "endpoint" }
      ?root rdfs:label ?root_name .
      ?child rdfs:subClassOf{,3} ?root .
      ?child rdfs:subClassOf ?parent .
      ?child rdfs:label ?child_name .
      ?parent rdfs:label ?parent_name .
    }
```
####Sparql
SPARQL interface to the triple-store. Available output formats are json, rdf and text. 

