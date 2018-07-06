require 'typhoeus'
require_relative '../config/yml_load'
require 'time'
require 'uri'
require 'pry'
require 'openssl'

#85e7fe645f572574d623bf2187bd261aac862cac

class GistClient

  cnf = Loader::Yml_Load.new
  config_values = cnf.getConfigs


  $create_gists = config_values['create_gist']
  $get_gist = config_values['get_gist']
  $base_url = config_values['base_url_gist']

  puts $base_url


  def self.create_gist(request_json)

  puts request_json
    uri = URI.parse($base_url+$create_gists)
    #uri.query = options.to_query
    encoded_uri=uri.to_s

puts uri
    response = Typhoeus::Request.post(encoded_uri, headers: {"Authorization" => "token 85e7fe645f572574d623bf2187bd261aac862cac", "Content-Type" => "application/json"}, body: request_json, verbose: true)
    return data = JSON.parse(response.body),response.options[:response_code], response.headers_hash[:location]
    if response.success?
      return data = JSON.parse(response.body)

    else
      return nil
    end

  end

  def self.getGist(id)
    uri = URI.parse($base_url+$get_gist+"/"+id)
    encoded_uri=uri.to_s
    response = Typhoeus.get(encoded_uri, headers: {"Authorization" => "token 85e7fe645f572574d623bf2187bd261aac862cac", "accept" => "application/json"}, verbose: 'true')
    return data = JSON.parse(response.body),response.options[:response_code]
    if response.success?
      return data = JSON.parse(response.body)

    else
      return nil
    end
  end

  def self.deleteGist(id)
    uri = URI.parse($base_url+$get_gist+"/"+id)
    encoded_uri=uri.to_s
    response = Typhoeus.delete(encoded_uri, headers: {"Authorization" => "token 85e7fe645f572574d623bf2187bd261aac862cac", "accept" => "application/json"}, verbose: 'true')
    return data = response.options[:response_code]

  end

end