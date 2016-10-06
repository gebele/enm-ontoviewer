require 'json'
require 'rest-client'
require 'rdiscount'
require_relative "./service.rb"

configure :development do
  $logger = Logger.new(STDOUT)
end

before do
  @version = File.read("VERSION").chomp
end

get '/?' do
  redirect to('/query') 
end

get '/query/?' do
  haml :query
end

get '/search/:query?' do
  sparqlstring = params["query"]
  response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "application/sparql-results+json"}).get
  response
end

# sparql endpoint access
get '/sparql/:query?' do
  accepted = [
    "text/plain",
    "text/csv",
    "text/html",
    "text/n3",
    "text/turtle",
    "text/tab-separated-values",
    "application/rdf+xml",
    "application/sparql-results+json",
    "application/vnd.ms-excel"
  ]
  sparqlstring = params[:query]
  content_type = request.env["HTTP_ACCEPT"]
  if accepted.include?(content_type)
    RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => content_type } ).get do |response,request,result|
      if response.code == 400
        return "malformed query\n"
      elsif response.code >= 400
        return "error processing query or fetching data\n"
      else
        response
      end
    end
  else
    return "#{content_type} is not supported content type.\n"
  end
end

post "/download" do
  type = params[:query_type]
  sparqlstring = params[:queryfield]
  file = Tempfile.new("enm")
  response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => type}).get do |response, request, result|
    if response.code == 400
      return "malformed query\n"
    elsif response.code >= 400
      return "error processing query or fetching data\n"
    else
      file.write(response)
      send_file(file, :disposition => 'attachment', :filename => File.basename(file))
      file.close
    end
  end
end
    
get '/help' do
  haml :help
end

get '/license' do
  haml :license
end
