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
  
#   this method returns the airport with the highest 
#   number of delayed flights
  def most_delayed_city
    sql = %q[
      SELECT
        origin_city_name,
        count(*) as delay_total
      FROM
        delays
      WHERE dep_delay_new > 0
      OR arr_delay_new > 0
      GROUP BY origin_city_name
      ORDER BY delay_total DESC
      LIMIT 1;
    ]
    result = database.exec(sql).entries
    result[0]['origin_city_name']
  end

#   this method returns the airport with the fewest
#   number of delayed flights
  def least_delayed_city
    sql = %q[
      SELECT
        origin_city_name,
        count(*) as delay_total
      FROM
        delays
      WHERE dep_delay_new > 0
      OR arr_delay_new > 0
      GROUP BY origin_city_name
      ORDER BY delay_total
      LIMIT 1;
    ]
    result = database.exec(sql).entries
    result[0]['origin_city_name']
  end

 #    this method returns the average number of minutes
#     late across all airlines
    
#     this returns the average number of minutes late across
#     all airlines

  
end
