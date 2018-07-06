require 'json'
require 'rspec'
require_relative '../client/gist_client'
require 'pry'

class GistSpec
  describe 'create gist' do

    it('test create gist'){



      payload =
          {
              "description": "the description for this gist",
              "public": true,
              "files": {
                  "file1.txt": {
                      "content": "String file contents"
                  }
              }
          }

      query_response, response_code, location =  GistClient.create_gist(payload.to_json)
      puts query_response

      puts '***********'
      puts location
      uri = URI(location)
      $gist =  uri.path.partition('/').last.partition('/').last
      puts response_code
      expect(response_code).to eq 201
      puts '***********'

      query_response, response_code = GistClient.getGist($gist)
      expect(response_code).to eq 200

      response_code= GistClient.deleteGist($gist)
      puts '***********'
      puts response_code
      expect(response_code).to eq 204
      puts '***********'



    }

    it ('test get gist'){

      query_response, response_code = GistClient.getGist('7361b7a545aa7a0c1abf7dea223895c2')
      expect(response_code).to eq 200

    }



  it ('test delete gist'){

    response_code= GistClient.deleteGist('0d0a72e6014d7375623721256a145232')
    puts '***********'
    puts response_code
    expect(response_code).to eq 204
    puts '***********'


  }

end



end