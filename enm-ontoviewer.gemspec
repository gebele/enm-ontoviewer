# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "enm-ontoviewer"
  s.version     = File.read("./VERSION")
  s.authors     = ["Christoph Helma","Micha Rautenberg","Denis Gebele"]
  s.email       = ["helma@in-silico.ch","rautenberg@in-silico.ch","gebele@in-silico.ch"]
  s.homepage    = "http://github.com/gebele/enm-ontoviewer"
  s.summary     = %q{enm-ontoviewer}
  s.description = %q{Graphical User Interface for eNanoMapper ontology}
  s.license     = 'GPL-3'

  s.rubyforge_project = "enm-ontoviewer"

  s.files       = `git ls-files`.split("\n")
  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency "sinatra"
  s.add_runtime_dependency "haml"
  s.add_runtime_dependency "unicorn"
end
