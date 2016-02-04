require 'json'
require 'rest-client'
require "sinatra/reloader" if development?
require_relative "./service.rb"

configure :development do
  $logger = Logger.new(STDOUT)
end

def fileTime?
  ftime = File.mtime(File.join("./graphs.json"))
  ftime+3600 <= Time.now
end

get '/?' do
  redirect to('/query') 
end

get '/query/?' do
  @out_types = ["text/plain", "application/json","application/rdf+xml"]
  ["graphs", "subjects", "predicates"].each do |type|  
    sparqlstring = File.read( File.join "./templates/get/#{type}.sparql")
    response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "application/json"}).get
    File.open(File.join("./#{type}.json"), 'w') {|f| f.write(response.body) }
  end if fileTime?
  graphs = JSON.parse(File.read("./graphs.json"))
  subjects = JSON.parse(File.read("./subjects.json"))
  predicates = JSON.parse(File.read("./predicates.json"))
  @subjects = subjects["results"]["bindings"].collect{|hash| hash["s"]["value"]}.sort{|a,b| a <=> b}
  @predicates = predicates["results"]["bindings"].collect{|hash| hash["p"]["value"]}.sort{|a,b| a <=> b}
  @graphs = graphs["results"]["bindings"].collect{|hash| hash["g"]["value"]}.sort{|a,b| a <=> b}
  haml :query
end

post '/result:?' do
  case params[:graph]
  when ""
  else
    query = {:graph => params[:graph]}
    sparqlstring = File.read( File.join "./templates/post/graph.sparql") % {:graph => "#{params[:graph]}"}
    response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "#{params[:type]}"}).get
    @result = response.body
  end
  case params[:subject]
  when ""
  else
    query = {:subject => params[:subject]}
    sparqlstring = File.read( File.join "./templates/post/subject.sparql") % {:subject => "#{params[:subject]}"}
    response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "#{params[:type]}"}).get
    @result = response.body
  end
  case params[:predicate]
  when ""
  else
    query = {:predicate => params[:predicate]}
    sparqlstring = File.read( File.join "./templates/post/predicate.sparql") % {:predicate => "#{params[:predicate]}"}
    response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "#{params[:type]}"}).get
    @result = response.body
  end
  case params[:object]
  when ""
  else
    query = {:object => params[:object]}
    sparqlstring = File.read( File.join "./templates/post/object.sparql") % {:object => "\"#{params[:object].gsub(/\r\n|^M/, "")}\""}
    response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "#{params[:type]}"}).get
    @result = response.body
  end
  @query = query
  haml :result
end

