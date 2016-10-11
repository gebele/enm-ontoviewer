require 'json'
require 'rest-client'
require 'rdiscount'
require_relative "./service.rb"

configure :development do
  $logger = Logger.new(STDOUT)
end

before do
  @version = File.read("VERSION").chomp
  @accepted = [
    "text/plain",
    "text/csv",
    "text/html",
    "text/n3",
    "text/turtle",
    "text/tab-separated-values",
    "application/json",
    "application/rdf+xml",
    "application/sparql-results+xml",
    "application/sparql-results+json",
    "application/vnd.ms-excel"
  ]
end

get '/?' do
  redirect to('/query') 
end

get '/query/?' do
  haml :query
end

# visualization route
# while xhr response gets 'null' for js function this needs an extra handling without response code
get '/search/:query?' do
  sparqlstring = params["query"]
  response = RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => "application/sparql-results+json"}).get do |response, request, result|
    if response.code == 400
      return "malformed query"
    elsif response.code > 400
      return "error processing query or fetching data"
    else
      return response.body
    end
  end
end

# sparql endpoint access
get '/sparql/:query?' do
  sparqlstring = params[:query]
  type = request.env["HTTP_ACCEPT"] == "application/sparql-results+json,*/*" ? request.env["HTTP_ACCEPT"].gsub(/,\*\/\*/,"") : request.env["HTTP_ACCEPT"]
  if @accepted.include?(type)
    RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => type } ).get do |response,request,result|
      if response.code == 400
        halt response.code, "malformed query\n"
      elsif response.code > 400
        halt response.code "error processing query or fetching data\n"
      else
        response
      end
    end
  else
    return "#{type} is not supported content type.\n"
  end
end

# sparql result as file download in various formats
get "/download" do
  type = params[:query_type]
  sparqlstring = params[:queryfield]
  file = Tempfile.new("enm")
  if @accepted.include?(type)
    RestClient::Resource.new(URI.encode("#{$service_uri}/sparql/?query=#{sparqlstring}"), :verify_ssl => 0, :headers => {:accept => type}).get do |response, request, result|
      if response.code == 400
        halt response.code, "malformed query\n"
      elsif response.code > 400
        halt response.code, "error processing query or fetching data\n"
      elsif response.code == 200
        file.write(response)
        file.rewind
        send_file(file, :disposition => 'attachment', :filename => File.basename(file), :type => type)
      end
      file.close
      file.unlink
    end
  else
    return "#{type} is not supported content type.\n"
  end
end
    
get '/help' do
  haml :help
end

get '/license' do
  haml :license
end
