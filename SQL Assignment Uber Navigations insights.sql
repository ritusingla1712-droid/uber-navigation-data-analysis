create database assign;
use assign ;
select * from ride1 r ;
select * from driver1 d ;
select* from passenger1 p;

#Basic Level:
#1What are & how many unique pickup locations are there in the dataset?
select distinct pickup_location from ride1 r;

#2What is the total number of rides in the dataset?
select count(*) from ride1;

#3Calculate the average ride duration.
select avg(ride_duration) from ride1 r ;

#4List the top 5 drivers based on their total earnings
select earnings from driver1 d 
having earnings = max(earnings)
limit 5;

#5Calculate the total number of rides for each payment method.
select payment_method, count(*) as total_rides from ride1 r 
group by payment_method 
order by total_rides desc;

#6.Retrieve rides with a fare amount greater than 20.
select ride_id,fare_amount from ride1 r 
where fare_amount > 20;

#7.Identify the most common pickup location.
select pickup_location, count(*) as rides from ride1 r 
group by pickup_location
order by rides desc
limit 1;

#8.Calculate the average fare amount.
select round(avg(fare_amount),2) as average_fare from ride1 r ;

#9.List the top 10 drivers with the highest average ratings.
select driver_id,avg(rating) as average_rating from driver1 d 
group by driver_id
order by average_rating desc 
limit 10;

#10.Calculate the total earnings for all drivers.
select round(sum(earnings),2) as total_earnings  from driver1 d ;

#11.How many rides were paid using the "Cash" payment method?
select payment_method, count(*) as rides_with_cash from ride1
where payment_method = "cash";

#12.Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.
select count(*) as originating_from_Dhanbad,round(avg(ride_distance),2) as average_ride_distance from ride1 r 
where pickup_location = "Dhanbad";

#13.Retrieve rides with a ride duration less than 10 minutes.
select ride_id, ride_duration from ride1 r 
where ride_duration < 10;

#14.List the passengers who have taken the most number of rides.
select p.passenger_id,p.passenger_name, count(r.ride_id) as total_rides from passenger1 p 
join ride1 r on p.passenger_id = r.ride_id
group by p.passenger_id,p.passenger_name
order by total_rides desc;

#15.Calculate the total number of rides for each driver in descending order.
select driver_id,driver_name,count(*)  as total_rides  from driver1
group by  driver_id,driver_name
order by total_rides desc;

#16.Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.
select distinct payment_method,pickup_location from ride1 r 
where pickup_location = "Gandhinagar" 
group by payment_method ;
select count(payment_method) from ride1 r 
where pickup_location = "Gandhinagar" ;

#17.Calculate the average fare amount for rides with a ride distance greater than 10.
select round(avg(fare_amount),2) as average_fare_amount from ride1 r 
where ride_distance>10;

#18.List the drivers in descending order accordinh to their total number of rides.
select driver_id,driver_name,total_rides  from driver1 d 
order by total_rides desc;

#19.Calculate the percentage distribution of rides for each pickup location.
select pickup_location,
    count(*) as total_rides,
    round(100.0 * count(*) / (select count(*) from ride1), 2) as percentage_distribution
from ride1
group by pickup_location
order by percentage_distribution desc;

#20.Retrieve rides where both pickup and dropoff locations are the same.
select * from ride1 r 
where pickup_location = dropoff_location;


#Intermediate Level:     
#1.List the passengers who have taken rides from at least 300 different pickup locations.
select passenger_id ,count(distinct pickup_location) as locations from ride1 r
group by passenger_id 
having locations >=300;

#2.Calculate the average fare amount for rides taken on weekdays.
select round(avg(ride_timestamp),2) as average_fare_on_weekdays from ride1 r 
where DAYOFWEEK(ride_timestamp) between 2 and 5 ;

#3.Identify the drivers who have taken rides with distances greater than 19.
select distinct driver_id ,ride_distance  from ride1 r 
where ride_distance > 19;

#4.Calculate the total earnings for drivers who have completed more than 100 rides.
select driver_id , sum(earnings) from driver1 d 
where driver_id in (select driver_id from ride1  
group by driver_id 
having count(*)>100)
group by driver_id ;

#5.Retrieve rides where the fare amount is less than the average fare amount.
select * from ride1 r 
where fare_amount <(select avg(fare_amount) from ride1);

select round(avg(fare_amount),2) from ride1 r ;

#6.Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.
select driver_id,avg(rating) as avg_ratings from driver1 d
where driver_id in(select driver_id from ride1 r where payment_method in ("Cash","Credit Card") 
group by driver_id having count(distinct payment_method )=2)
group by driver_id;

#7.List the top 3 passengers with the highest total spending.
select p.passenger_id, p.passenger_name, sum(r.fare_amount) as total_spending
from passenger1 p
join ride1 r on p.passenger_id = r.passenger_id
group by p.passenger_id, p.passenger_name
order by total_spending desc
limit 3;

#8.Calculate the average fare amount for rides taken during different months of the year.
select monthname(ride_timestamp) as ride_month,avg(fare_amount) as average_fare from ride1
group by month(ride_timestamp), ride_month
order by month(ride_timestamp);

#9.Identify the most common pair of pickup and dropoff locations.
select pickup_location,dropoff_location,count(*) as ride_count from ride1 r 
group by pickup_location,dropoff_location
order by ride_count desc
limit 1;

#10.Calculate the total earnings for each driver and order them by earnings in descending order.
select driver_id,sum(earnings)as total_earnings from driver1 d 
group by driver_id 
order by total_earnings desc;

#11.List the passengers who have taken rides on their signup date.
select p.passenger_id,p.passenger_name,p.signup_date,r.ride_timestamp from passenger1 p 
join ride1 r on p.passenger_id = r.passenger_id
where date(p.signup_date) = date(r.ride_timestamp);

#12.Calculate the average earnings for each driver and order them by earnings in descending order.
select driver_id,avg(earnings)as avg_earnings from driver1 d 
group by driver_id 
order by avg_earnings desc;

#13.Retrieve rides with distances less than the average ride distance.
select ride_id,avg(ride_distance) from ride1 r 
where ride_distance <(select avg(ride_distance) from ride1) 
group by ride_id ;

#14.List the drivers who have completed the least number of rides.
select driver_name,count(total_rides)as rides from driver1 d 
group by driver_name 
order by rides asc;

#15.Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.
SELECT AVG(fare_amount)
FROM ride1 r  
WHERE passenger_id IN (SELECT passenger_id FROM ride1 r GROUP BY passenger_id HAVING COUNT(*) >= 20);

#16.Identify the pickup location with the highest average fare amount.
select pickup_location,avg(fare_amount)as fare_amt from ride1 r 
group by pickup_location 
order by fare_amt desc 
limit 1;

#17.Calculate the average rating of drivers who completed at least 100 rides.
select avg(rating) as avg_rating from driver1 d 
where driver_id in (select driver_id from ride1 r  group by driver_id having count(*)>=100);

#18.List the passengers who have taken rides from at least 5 different pickup locations.
select passenger_id ,count(distinct pickup_location) as distinct_locations from ride1 r
group by passenger_id
having distinct_locations >=300;  

#19.Calculate the average fare amount for rides taken by passengers with ratings above 4.
select avg(fare_amount) from ride1 r 
where passenger_id in (select passenger_id from passenger1 p where rating >4);

#20.Retrieve rides with the shortest ride duration in each pickup location.
select pickup_location,min(ride_duration) from ride1 r 
group  by pickup_location;

#Advanced Level:

#1.List the drivers who have driven rides in all pickup locations.
select driver_id from driver1 d 
where driver_id not in (select distinct driver_id from ride1 
where pickup_location  not in (select distinct pickup_location from ride1));

#2.Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.
select avg(fare_amount) as avg_fare from ride1 r 
where passenger_id in (select passenger_id from passenger1 where total_spent > 300);

#3.List the bottom 5 drivers based on their average earnings.
select driver_id,avg(earnings) from driver1 d 
group by driver_id
order by avg(earnings) asc
limit 5 ;

#4.Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.
select sum(fare_amount ) from ride1 r where passenger_id in 
(select passenger_id from ride1 group by passenger_id having count(distinct payment_method)>1);

#5.Retrieve rides where the fare amount is significantly above the average fare amount.
select * from ride1 r 
where fare_amount > (select avg(fare_amount)  from ride1);

#6.List the drivers who have completed rides on the same day they joined.
select d.driver_id,d.driver_name from driver1 d join ride1 r 
on d.driver_id = r.driver_id
where date(d.join_date) =  date(r.ride_timestamp);

#7.Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.
select avg(fare_amount ) from ride1 r where passenger_id in 
(select passenger_id from ride1 group by passenger_id having count(distinct payment_method)>1);

#8.Identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare.
select pickup_location, avg(fare_amount) as location_avg,
    ((avg(fare_amount) - (select avg(fare_amount) from ride1)) / 
     (select avg(fare_amount) from ride1)) * 100 as percent_increase
from 
    ride1
group by pickup_location
order by percent_increase desc
limit 1;

#9.Retrieve rides where the dropoff location is the same as the pickup location.
select * from ride1 r 
where pickup_location = dropoff_location;

#10.Calculate the average rating of drivers who have driven rides with varying pickup locations.
select avg(rating) from driver1 d 
where driver_id in (select distinct driver_id from ride1 r group by driver_id having count(distinct pickup_location)>1);