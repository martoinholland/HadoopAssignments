-- Load the CSV file
orders = LOAD '/user/maria_dev/diplomacy/orders.csv' USING PigStorage(',')
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
-- Filter the location to not show empty locations and the target to only show "Holland"
filteredLocation = Filter orders BY location != '';
filteredTarget = FILTER filteredLocation BY target == '"Holland"';
-- Group the orders by the sending location and target, and then count how many times the target is present per location
grouped_orders = GROUP filteredTarget by (location, target);
grouped_counted_locations = FOREACH grouped_orders GENERATE group, COUNT($1);
-- Sort the results by the location alphabetically and dump the result
sorted_result = Order grouped_counted_locations BY $0 ASC; 
DUMP sorted_result;
