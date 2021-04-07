require_relative './train.rb'
require_relative './station.rb'
require_relative './route.rb'

moscow = Station.new('Moscow')
piter = Station.new('St.-Petersburg')
voronezh = Station.new('Voronezh')
rostov = Station.new('Rostov')

first_route = Route.new(piter, rostov)
first_route.add_station(moscow)

second_route = Route.new(rostov, piter)
second_route.add_station(voronezh)
second_route.add_station(moscow)

first_train = Train.new(1, :freight)
first_train.define_route(first_route)

second_train = Train.new(2, :passenger)
second_train.define_route(second_route)

first_train.move(1)

second_train.move(1)
second_train.move(1)

moscow.show_trains_count_by_type
