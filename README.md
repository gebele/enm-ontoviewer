eNM ontology viewer
===================
This service enables visualization of [eNanoMapper ontologies](http://www.enanomapper.net/ontology). It also provides a sparql interface.
install
-------
```
git clone https://github.com/enanomapper/enm-ontoviewer.git
cd enm-ontoviewer
bundle install
```
start
-----
unicorn -c unicorn.rb -E production -D
requirements
------------
`touch service.rb`

*inside service.rb point to the sparql endpoint:*

`$service_uri = "SERVICE URI"`

&copy; [in-silico.ch](http://www.in-silico.ch/)
