eNM ontology viewer
===================
This service enables the visualization of [eNanoMapper ontologies](http://www.enanomapper.net/ontology). It provides also a sparql interface for querying [eNanoMapper ontologies](http://www.enanomapper.net/ontology).

Installation
------------
```
git clone https://github.com/enanomapper/enm-ontoviewer.git
cd enm-ontoviewer
bundle install
```

Starting the service
-----------------
`unicorn -c unicorn.rb -E production -D`

Accesing the service
--------------------

point your browser to [http://localhost:8080](http://localhost:8080)

&copy; [in-silico.ch](http://www.in-silico.ch/)
