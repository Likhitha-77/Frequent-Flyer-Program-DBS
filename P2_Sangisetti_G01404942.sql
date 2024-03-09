create table Promotions
(
prom_id varchar2(20),
prom_action varchar2(20),
prom_period varchar2(20),
p_description varchar2(100),
primary key(prom_id)
);

create table Trips
(
trip_id number(20) not null,
trip_miles number(20),
source varchar2(20),
destination varchar2(20),
dept_datetime varchar2(20),
arrival_datetime varchar2(20),
primary key(trip_id)
);


create table Passengers
(
passid varchar(20) not null,
pname varchar(20) not null ,
ssn varchar(10) not null,
is_member varchar(10) not null,
email varchar(30) not null,
gender varchar(10) not null,
home_num number(20),
occupation varchar(30) not null ,
dob date not null, 
PRIMARY KEY(passid)
);




create table Flights_Promotions
(
prom_id varchar2(20),
flight_id NUMBER(20),
primary key(prom_id,flight_id),
foreign key(prom_id) references Promotions(prom_id),
foreign key(flight_id) references Flights(flight_id)

);
create table Emp_Incentives
(
passid varchar2(20) not null,
incentive_id varchar2(20),
primary key(incentive_id),
foreign key(passid) references Passengers(passid)

);





create table Emp_Referrals
(
referral_id varchar2(20)not null,
passanger_id varchar2(20),
primary key(referral_id),
foreign key(passanger_id) references Passengers(passid)
);

create table Point_Accounts
(
point_account_id varchar2(20) not null,
total_points Number(20),
passid varchar(20) not null,
primary key(point_account_id),
foreign key(passid) references Passengers(passid)
);

create table Flights
(
flight_miles number(20),
source varchar2(20),
flight_id number(20),
destination varchar2(20),
arrival_datetime varchar2(20),
dept_datetime varchar(20),
percent_increase number(20),
point_account_id varchar2(20),
passid varchar(20),
referral_id varchar2(20)not null,
incentive_id varchar2(20),
primary key(flight_id),
foreign key(point_account_id) references Point_Accounts(point_account_id),
foreign key(passid) references Passengers(passid),
foreign key(referral_id) references Emp_Referrals(referral_id),
foreign key(incentive_id) references Emp_Incentives(incentive_id)
);



create table Flights_Trips
(
trip_id number(20),
flight_id number(20),
primary key(trip_id,flight_id),
foreign key(trip_id) references Trips(trip_id),
foreign key(flight_id) references Flights(flight_id)

);





create table passenger_address
(
passid varchar(20),
home_num varchar(10), 
street varchar(20),
city varchar(20),
state varchar(20),
zip varchar(10), 
Primary key(passid,home_num,street,city), 
foreign key(passid) references Passengers(passid)
);



create table Awards
(
award_id varchar(20) not null primary key,
a_description varchar(100) not null,
points_required int not null
);

create table Cards
(
card_id varchar(30), 
is_valid varchar(10) not null,
expiry_date date not null,
c_id varchar(20) not null,
passid varchar(30) not null, 
primary key(card_id), 
foreign key(passid) references Passengers(passid)

);

create table Passengers_awards
(
passid varchar(20) not null, 
award_id varchar2(20) not null,
redemption_date date not null, 
quantity int not null, 
primary key(passid, award_id),
foreign key(passid) references Passengers(passid), 
foreign key(award_id) references Awards(award_id)
);

create table Login
(
username varchar(30) not null,
password varchar(20) not null,
passid varchar(30) not null, 
primary key(username), 
foreign key(passid) references Passengers(passid)
);

create table Deduct_Exchange
(
passid varchar(20) not null, 
award_id varchar2(20) not null,
center_id varchar(30),
point_account_id varchar2(20),
primary key(passid,award_id,center_id,point_account_id),
foreign key(point_account_id) references Point_Accounts(point_account_id),
foreign key(center_id) references Exchgecenters(center_id),
foreign key(passid) references Passengers(passid), 
foreign key(award_id) references Awards(award_id)
);




create table Exchgecenters
(
center_id varchar(30),
centername varchar(20) not null,
c_location varchar(20) not null,
primary key(center_id) 
);


