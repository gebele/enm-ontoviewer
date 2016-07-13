####Viewer
The javascript plugin for visualisation process a json hash as response from the triple-store.
In order to write correct sparql queries please mind this example:

...  
{ "root_name":   {"type": "literal", "value": "root"},  
  "parent_name": {"type": "literal", "value": "root"},  
  "child_name":  {"type": "literal", "value": "child1"}},  
{ "root_name":   {"type": "literal", "value": "root"},  
  "parent_name": {"type": "literal", "value": "child1"},  
  "child_name":  {"type": "literal", "value": "grand child1"}},  
{ "root_name":   {"type": "literal", "value": "root"},  
  "parent_name": {"type": "literal", "value": "child1"},  
  "child_name":  {"type": "literal", "value": "grand child2"}},  
// additional parent-child node pairs  
...

####Sparql
A sparql interface to the triple-store backend. Available output formats are json, rdf and text. 

####Restrictions
The 4store triple-store we use has some restriction in using sparql syntax and functionality.

- Subqueries are not possible
- VALUES keyword is not available (you can use BIND instead)  
- PROPERTY PATHS like `*` or `+` are not allowed   
