#!/bin/bash
#
# add your solution after each of the 10 comments below
#

# count the number of unique stations
cut -d, -f4,8 201402-citibike-tripdata.csv |tr , '\n'|sort | uniq | wc -l
#331

# count the number of unique bikes
cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq | wc -l
#5700

# count the number of trips per day
cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | sort | uniq -c | awk '{print $2, $1}'
#2014-02-01 12771
#...
#2014-02-28 9587
#starttime 1

# find the day with the most rides
cut -d, -f2 201402-citibike-tripdata.csv | cut -d' ' -f1 | sort | uniq -c | sort -nr | head -1 | awk '{print $2, $1}'
#2014-02-02 13816

# find the day with the fewest rides
tail -n +2 201402-citibike-tripdata.csv | cut -d, -f2 | cut -d' ' -f1 | sort | uniq -c | sort -n | head -1 | awk '{print $2, $1}'
#2014-02-13 876

#I want the second to last line because the last line is starttime 1
#different ways ... play around with sort -nr vs sort -n and head vs tail
#I'm not sure why if I put cut first it doesn't work, need tail first? I don't really understand the pipeline cascade ...

# find the id of the bike with the most rides
cut -d, -f12 201402-citibike-tripdata.csv | sort | uniq -c | sort -nr | head -1 | awk '{print $2}'
#20837

# count the number of rides by gender and birth year
cut -d, -f14,15 201402-citibike-tripdata.csv | cut -d' ' -f1 | sort | uniq -c | awk '{print $2, $1}'
#Make it more readable?

# count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)
cut -d, -f5 201402-citibike-tripdata.csv | grep '[0-9].*&.*[0-9]' | wc -l 
#90549

# compute the average trip duration
tail -n +2 201402-citibike-tripdata.csv | awk -F, '{sum+=$1; count++} END {print sum/count}'
#874.52