orders = LOAD '/user/maria_dev/orders.csv' USING PigStorage(',')
AS
(game_id:chararray,
 unit_id:chararray,
 unit_order:chararray,
 location:chararray,
 target:chararray,
 target_dest:chararray,
 success:chararray,
 reason:chararray,
 turn_num:chararray); 
filteredLocation = Filter orders BY location != '';
filteredTarget = FILTER filteredLocation BY target == '"Holland"';
grouped_orders = GROUP filteredTarget by (location, target);
grouped_counted_locations = FOREACH grouped_orders GENERATE group, COUNT($1);
sorted_result = Order grouped_counted_locations BY $0 ASC; 
DUMP sorted_result;
