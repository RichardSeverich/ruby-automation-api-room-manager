require 'mongo'

# Author: Pablo Ramirez
class Mongodb
  def initialize(host_port, data_base)
    Mongo::Logger.logger.level = ::Logger::FATAL
    @connection = Mongo::Client.new([host_port],
                                    database: data_base)
  end

  def find_element(endpoint, key, value)
    @connection[:"#{endpoint}"].find(:"#{key}" => value).each do |data|
      return data
    end
  end

  def drop(data)
    @connection[:"#{data}"].delete_many
  end

  def close_connection
    @connection.close
  end

  def drop_database
    @connection.database.drop
  end
end
