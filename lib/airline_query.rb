require 'pg'
require 'json'
require 'pry-byebug'

class AirData
  attr_reader :database, :res
  
  def initialize 
    @database = PG::Connection.open(dbname:'mks_data')
  end
  
#   this method returns the count for the 
#   number of airlines
  def how_many_airlines
    sql = %q[
      SELECT 
        count(distinct airline_id) 
      FROM  delays;
    ]
    result = database.exec(sql)
    result.entries
  end
  
#   this method returns the the 2 letter code 
#   for the airline with the most arrival delays
  def most_arrival_delays
    sql = %q[
      SELECT 
        carrier,
        count(*)
      FROM delays
      WHERE arr_delay_new > 0
      GROUP BY carrier
      ORDER BY count DESC
      LIMIT 1;
    ]
    result = database.exec(sql).entries
    result[0]['carrier']
  end
  
  #   this method returns the the 2 letter code 
#   for the airline with the least arrival delays
  def least_arrival_delays
        sql = %q[
      SELECT 
        carrier,
        count(*)
      FROM delays
      WHERE arr_delay_new > 0
      GROUP BY carrier
      ORDER BY count
      LIMIT 1;
    ]
    result = database.exec(sql).entries
    result[0]['carrier']
  end

  
end
