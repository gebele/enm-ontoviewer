This application is designed to enable easy access to enm ontology and nanomaterials data stored in a triple-store database. 

---
#### Viewer
This page enables to obtain complex data relatioships from a triple-store as easy understandable graphics. `Dendogram` is a tree based vector graphic showing relations as bonds from node to node ordered from left to right. `Sunburst` is an interactive pie chart vector graphic aiming this approach with the level of circles around the center, where each color reflects a bond. In order to get a proper result it is necessary to write [SPARQL](https://www.w3.org/TR/rdf-sparql-query/) queries in a special sequence. Please mind the given template in the editor. A `child` must have a relation to `root` and a `parent`, where the same `parent` needs to have a relation to the same `root`.  
Please also note the `{,5}` [property path](https://www.w3.org/TR/sparql11-property-paths/) which is used for numbers of results. Some browser can not handle large numbers. For most regular expressions search terms you also need to pass '@en' at the end like `"algorithm type"@en` . 
 
---
#### Sparql
This page allowes you to write [SPARQL](https://www.w3.org/TR/rdf-sparql-query/) queries without any restrictions and with full [SPARQL](https://www.w3.org/TR/rdf-sparql-query/) syntax support including subqueries. The result returns as file download. Please note the different output formats in the drop-down list.
