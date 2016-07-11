require 'json'
require 'rest-client'
require "sinatra/reloader" if development?
require_relative "./service.rb"

configure :development do
  $logger = Logger.new(STDOUT)
end

get '/?' do
  redirect to('/query') 
end

get '/query/?' do
  haml :query
end

get '/search/:query?' do
  sparqlstring = params["query"] 
  response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "application/json"}).get
  response
end

["json", "rdf", "txt"].each do |path|
  get "/download/#{path}/:query?" do
    sparqlstring = params["query"]
    file = Tempfile.new("enm")
    case path
    when "json"
      response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "application/json"}).get
    when "rdf"
      response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "application/rdf+xml"}).get
    when "txt"
      response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "text/plain"}).get
    end
    file.write(response)
    file.close
    file.path.gsub(/\/tmp\//,"")
  end
end

get '/download/:file?' do
  file = File.join("/tmp", params[:file])
  send_file(file, :disposition => 'attachment', :filename => File.basename(file))
end
