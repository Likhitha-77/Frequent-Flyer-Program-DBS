
--query1
SELECT p.prom_id, p.prom_action, p.prom_period
FROM Flights f
JOIN Flights_Promotions fp ON f.flight_id = fp.flight_id
JOIN Promotions p ON fp.prom_id = p.prom_id
WHERE f.flight_id = 'F003';

--query 2
SELECT Flights.flight_id, Flights.flight_miles, Flights.arrival_datetime
FROM Flights
INNER JOIN Passengers ON Flights.passid = Passengers.passid
WHERE Passengers.pname = 'Sai Teja';

--query 3
SELECT Flights.flight_id, COUNT(Flights_Promotions.prom_id) AS num_promotions
FROM Flights
LEFT JOIN Flights_Promotions ON Flights.flight_id = Flights_Promotions.flight_id
GROUP BY Flights.flight_id;

--query 4
SELECT Passengers.passid, Passengers.pname
FROM Passengers
JOIN Flights ON Passengers.passid = Flights.passid
WHERE Flights.destination = 'Berlin' AND Flights.arrival_datetime BETWEEN TO_DATE('03-01-2023', 'MM-DD-YYYY') AND TO_DATE('03-15-2023', 'MM-DD-YYYY');

--query 5
SELECT f.flight_id, f.source, f.destination, f.flight_miles, t.trip_id, t.arrival_datetime
FROM Flights f
INNER JOIN Flights_Trips ft ON f.flight_id = ft.flight_id
INNER JOIN Trips t ON ft.trip_id = t.trip_id
WHERE f.flight_id = 'F009';

--query 6
SELECT COUNT(*) as expired_card_count
FROM Cards
WHERE expiry_date < SYSDATE

--query 7
SELECT p.passid, p.pname, COUNT(*) AS num_expired_cards
FROM Passengers p
INNER JOIN Cards c ON p.passid = c.passid
WHERE c.is_valid = 'N'
GROUP BY p.passid, p.pname
HAVING COUNT(*) = (
    SELECT MAX(num_expired_cards)
    FROM (
        SELECT p.passid, COUNT(*) AS num_expired_cards
        FROM Passengers p
        INNER JOIN Cards c ON p.passid = c.passid
        WHERE c.is_valid = 'N'
        GROUP BY p.passid
    )
)
--query 8
SELECT a.award_id, a.a_description, p.pname, rh.center_id, rh.quantity
FROM Redemption_History rh
JOIN Passengers p ON p.passid = rh.passid
JOIN Awards a ON a.award_id = rh.award_id
WHERE p.pname = 'Sai Teja';

--query 9
SELECT Passengers.pname, Passengers.occupation
FROM Passengers
JOIN Addresses ON Passengers.passid = Addresses.passid
WHERE Addresses.city = 'Fairfax';

--query 10
SELECT SUM(total_points) AS points_sum
FROM Passengers p
JOIN Point_Accounts pa ON p.passid = pa.passid
JOIN Addresses a ON p.passid = a.passid
WHERE a.city = 'Fairfax';

--query 11
SELECT p.pname
FROM Passengers p
JOIN Point_Accounts pa ON p.passid = pa.passid
JOIN Flights f ON p.passid = f.passid AND pa.point_account_id = f.point_account_id
GROUP BY p.passid, p.pname
ORDER BY SUM(f.flight_miles) DESC
FETCH FIRST 1 ROW ONLY;

--query 12
SELECT SUM(quantity) as total_points_redeemed 
FROM Redemption_History 
WHERE redemption_date = TO_DATE('02-01-2023', 'MM-DD-YYYY');

--query 13
SELECT COUNT(*) AS num_awards_redeemed
FROM Redemption_History
WHERE passid = 100;

--query 14
SELECT COUNT(DISTINCT passid) as num_passengers_redeemed 
FROM Redemption_History 
WHERE center_id = 2;


--query 15
SELECT COUNT(*) AS total_awards
FROM Awards;

--query 16
SELECT pname
FROM Passengers p
JOIN Addresses a ON p.passid = a.passid
WHERE p.occupation = 'Engineer' AND a.city = 'Fairfax';

--query 17
SELECT t.trip_id, t.arrival_datetime, t.dept_datetime, t.source, t.destination, t.trip_miles
FROM Trips t
LEFT JOIN Flights_Trips ft ON t.trip_id = ft.trip_id
WHERE ft.flight_id IS NULL;

--query 18
SELECT t.trip_id, COUNT(ft.flight_id) AS num_bookings
FROM Trips t
JOIN Flights_Trips ft ON t.trip_id = ft.trip_id
GROUP BY t.trip_id
ORDER BY num_bookings DESC
FETCH FIRST 1 ROW ONLY;





