DROP TABLE bookings;
DROP TABLE members;
DROP TABLE gymclasses;

CREATE TABLE members (
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  premium_member BOOLEAN
);

CREATE TABLE gymclasses (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  start_time VARCHAR(255),
  capacity INT4
);

CREATE TABLE bookings (
  id SERIAL4 PRIMARY KEY,
  member_id INT4,
  gymclass_id INT4
);
