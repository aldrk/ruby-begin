require_relative './train.rb'
require_relative './station.rb'
require_relative './route.rb'

moscow = Station.new('Moscow')
piter = Station.new('St.-Petersburg')
voronezh = Station.new('Voronezh')
rostov = Station.new('Rostov')


route = Route.new(rostov, piter)
route.add_station(voronezh)
route.add_station(moscow)

train = Train.new(2, :passenger, 15)
train.define_route(route)

train.move_to_next_station
train.move_to_next_station

puts train.current_station.name
