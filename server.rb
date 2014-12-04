require 'pg'
require 'sinatra'
require_relative 'lib/airline_query.rb'

set :bind, '0.0.0.0'

get '/' do 
  plane = AirData.new
  @total_airlines = plane.how_many_airlines
  @most_delayed_airline = plane.most_arrival_delays
  @least_delayed_airline = plane.least_arrival_delays
  @most_delayed_city = plane.most_delayed_city
  @least_delayed_city = plane.least_delayed_city
  @average_delay = plane.average_delay
  @avg_delay_per_airline = plane.average_delay_per_airline
  erb:home
end

post '/query-result' do 
  @data = AirData.new
  erb:result
end