m = load '$M' using PigStorage(',');
n = load '$N' using PigStorage(',');
mn = join m by $1, n by $0;
mn_v = foreach mn generate ($0,$4,$2*$5);
mn_v = foreach mn_v generate flatten($0);
res = group mn_v by ($0,$1);
final = foreach res generate (group.$0, group.$1, SUM(mn_v.$2));
final = foreach final generate flatten($0);
store final into '$O';

