require 'yaml'

module Loader

  class Yml_Load

    # def getConfigs
    # cnf = YAML::load_file(File.join(__dir__, 'env.yml'))
    # end

    def getConfigs
      cnf = YAML::load_file(File.join(__dir__, 'env.yml'))
      base_url = ENV['BASE_URL'] || cnf['base_url']
      cnf['base_url'] = base_url
      return cnf
    end

  end
end
