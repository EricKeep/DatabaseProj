/* This sql file sets up the database using several insert statements
	First, it drops any existing tables
*/
DROP TABLE GROWS_IN;
DROP TABLE LIVES_IN;
DROP TABLE VISITOR_CENTER;
DROP TABLE LANDMARK;
DROP TABLE PLANT;
DROP TABLE ANIMAL;
DROP TABLE PARK;

/* Create each table 
	First is a list of parks:
*/
CREATE TABLE PARK (
Park_name VARCHAR(25) NOT NULL,
Biome VARCHAR(25),
PRIMARY KEY (Park_name)
);

/* Animals present in the parks */
CREATE TABLE ANIMAL (
Species VARCHAR(25) NOT NULL,
Class VARCHAR(25) NOT NULL,
Weight DECIMAL(7,2),
Height DECIMAL(5,2),
Diet VARCHAR(9),
Active VARCHAR(5),
PRIMARY KEY (Species)
);

/* Plants present in the parks */
CREATE TABLE PLANT (
Species VARCHAR(25) NOT NULL,
Class VARCHAR(25) NOT NULL,
PRIMARY KEY (Species)
);

/* Landmarks present in the different parks */
CREATE TABLE LANDMARK (
Name VARCHAR(25) NOT NULL,
Type VARCHAR(15),
Latitude VARCHAR(7),
Longitude VARCHAR(7),
Park_name VARCHAR(25) NOT NULL,
PRIMARY KEY (Name),
FOREIGN KEY (Park_name) REFERENCES PARK(Park_name)
);

/* Visitor centers in each park */
CREATE TABLE VISITOR_CENTER (
Name VARCHAR(30) NOT NULL,
Addr VARCHAR(25) NOT NULL UNIQUE,
Phone CHAR(10),
Open CHAR(4),
Close CHAR(4),
Park_name VARCHAR(25) NOT NULL,
PRIMARY KEY (Name),
FOREIGN KEY (Park_name) REFERENCES PARK(Park_name)
);

/* Keeps track of the parks each animal lives in */
CREATE TABLE LIVES_IN(
P_name VARCHAR(25) NOT NULL,
A_species VARCHAR(25) NOT NULL,
PRIMARY KEY (P_name, A_species),
FOREIGN KEY (P_name) REFERENCES PARK (Park_name),
FOREIGN KEY (A_species) REFERENCES ANIMAL (Species)
);

/* Keeps track of the parks each plant grows in */
CREATE TABLE GROWS_IN(
P_name VARCHAR(25) NOT NULL,
P_species VARCHAR(25) NOT NULL,
PRIMARY KEY (P_name, P_species),
FOREIGN KEY (P_name) REFERENCES PARK (Park_name),
FOREIGN KEY (P_species) REFERENCES PLANT (Species)
);

/* Inserts data into the tables to create database*/
INSERT INTO PARK
VALUES ('Grandview Meadows', 'Deciduous Forest');

INSERT INTO PARK
VALUES ('Sraserd Park', 'Desert');

INSERT INTO PARK
VALUES ('Blue Laguna Park', 'Rainforest');

INSERT INTO PARK
VALUES ('Raccoon Gardens', 'Deciduous Forest');

INSERT INTO PARK
VALUES ('Oan Park', 'Grasslands');

INSERT INTO PARK
VALUES ('Pleishl Gardens', 'Taiga');

INSERT INTO PARK
VALUES ('Mirror Lake Grounds', 'Taiga');

INSERT INTO ANIMAL
VALUES ('Bison', 'Mammal', 1400.0, 8.2, 'Herbivore', 'Day');

INSERT INTO ANIMAL
VALUES ('Lion', 'Mammal', 408.0, 3.7, 'Carnivore', 'Day');

INSERT INTO ANIMAL
VALUES ('Toucan', 'Bird', 1.27, 2.08, 'Herbivore', 'Day');

INSERT INTO ANIMAL
VALUES ('Golden Tamarin', 'Mammal', 1.4, 0.8, 'Omnivore', 'Day');

INSERT INTO ANIMAL
VALUES ('Grey Wolf', 'Mammal', 170, 2.7, 'Carnivore', 'Night');

INSERT INTO ANIMAL
VALUES ('Red Fox', 'Mammal', 28.5, 17.2, 'Omnivore', 'Night');

INSERT INTO ANIMAL
VALUES ('Robin', 'Bird', 0.17, 0.83, 'Herbivore', 'Day');

INSERT INTO ANIMAL
VALUES ('Cheetah', 'Mammal', 120.34, 2.78, 'Carnivore', 'Day');

INSERT INTO ANIMAL
VALUES ('Armadillo', 'Mammal', 65.3, 8.6, 'Omnivore', 'Day');

INSERT INTO ANIMAL
VALUES ('Elk', 'Mammal', 600.5, 4.5, 'Herbivore', 'Day');

INSERT INTO ANIMAL
VALUES ('Fruit Bat', 'Mammal', 0.02, 0.96, 'Herbivore', 'Night');

INSERT INTO ANIMAL
VALUES ('Barn Owl', 'Bird', 1.12, 1.3, 'Carnivore', 'Night');

INSERT INTO ANIMAL
VALUES ('Brown Bear', 'Mammal', 1300.1, 4.8, 'Omnivore', 'Day');

INSERT INTO ANIMAL
VALUES ('Carp', 'Fish', 29.8, 27.3, 'Omnivore', 'Night');

INSERT INTO ANIMAL
VALUES ('Rainbow Trout', 'Fish', 27.1, 1.3, 'Omnivore', 'Night');

INSERT INTO ANIMAL
VALUES ('Pink Salmon', 'Fish', 8.2, 2.8, 'Omnivore', 'Day');

INSERT INTO PLANT
VALUES ('Hemlock', 'Pinopsida');

INSERT INTO PLANT
VALUES ('Black Spruce', 'Pinopsida');

INSERT INTO PLANT
VALUES ('Balsam Fir', 'Pinopsida');

INSERT INTO PLANT
VALUES ('Poinsettia', 'Rosids');

INSERT INTO PLANT
VALUES ('Heliconia', 'Commelinids');

INSERT INTO PLANT
VALUES ('Orchid', 'Monocots');

INSERT INTO PLANT
VALUES ('Button Snakeroot', 'Asterids');

INSERT INTO PLANT
VALUES ('Tall Bluestem', 'Commelinids');

INSERT INTO PLANT
VALUES ('Prickly Pear', 'Cactaceae');

INSERT INTO PLANT
VALUES ('Saguaro', 'Cactaceae');

INSERT INTO PLANT
VALUES ('Juniper', 'Pinopsida');

INSERT INTO PLANT
VALUES ('Shagbark Hickory', 'Rosids');

INSERT INTO PLANT
VALUES ('Guelder Rose', 'Asterids');

INSERT INTO PLANT
VALUES ('White Birch', 'Rosids');

INSERT INTO LANDMARK
VALUES ('Mirror Lake', 'Lake', '41.2 N', '76.3 W', 'Mirror Lake Grounds');

INSERT INTO LANDMARK
VALUES ('Young Mans Cave', 'Cave', '34.8 N', '111.2 W', 'Sraserd Park');

INSERT INTO LANDMARK
VALUES ('McKenzie Mansion', 'Mansion', '40.3 N', '76.1 W', 'Mirror Lake Grounds');

INSERT INTO LANDMARK
VALUES ('Red Valley Canyon', 'Canyon', '33.9 N', '109.7 W', 'Sraserd Park');

INSERT INTO LANDMARK
VALUES ('Marshall Falls', 'Waterfall', '9.5 N', '83.2 W', 'Blue Laguna Park');

INSERT INTO LANDMARK
VALUES ('Laguna River', 'River', '8.7 N', '85.4 W', 'Blue Laguna Park');

INSERT INTO LANDMARK
VALUES ('Orange Lake', 'Lake', '42.8 N', '87.8 W', 'Raccoon Gardens');

INSERT INTO LANDMARK
VALUES ('Grandview Meadow', 'Meadow', '46.2 N', '85.3 W', 'Grandview Meadows');

INSERT INTO LANDMARK
VALUES ('Opal Garden', 'Garden', '43.4 N', '89.1 W', 'Raccoon Gardens');

INSERT INTO LANDMARK
VALUES ('Maverick Amphitheatre', 'Public Venue', '47.1 N', '84.9 W', 'Grandview Meadows');

INSERT INTO LANDMARK
VALUES ('Raccoon Garden', 'Garden', '42.2 N', '90.0 W', 'Raccoon Gardens');

INSERT INTO LANDMARK
VALUES ('Pleishl Garden', 'Garden', '39.8 N', '103.2 W', 'Pleishl Gardens');

INSERT INTO LANDMARK
VALUES ('Engellman Forest', 'Forest', '40.0 N', '102.9 W', 'Pleishl Gardens');

INSERT INTO LANDMARK
VALUES ('Greenbell Prairie', 'Prairie', '47.1 N', '113.1 W', 'Oan Park');

INSERT INTO LANDMARK
VALUES ('Mt. Greyrock', 'Mountain', '48.2 N', '111.8 W', 'Oan Park');

INSERT INTO LANDMARK
VALUES ('Blue Valley', 'Valley', '48.7 N', '111.2 W', 'Oan Park');

INSERT INTO VISITOR_CENTER
VALUES ('McKinley Visitor Center', '45 East Lake Drive', '8984556678', '0730', '1830', 'Mirror Lake Grounds');

INSERT INTO VISITOR_CENTER
VALUES ('Blue Laguna Visitor Center', '37 Mellow Avenue', '5546736544', '0800', '1900', 'Blue Laguna Park');

INSERT INTO VISITOR_CENTER
VALUES ('Red Valley Visitor Center', '24 Red Valley Lane', '3446690056', '0815', '1845', 'Sraserd Park');

INSERT INTO VISITOR_CENTER
VALUES ('Oan Park Visitor Center', '85 Maple Avenue', '2685548986', '0800', '1830', 'Oan Park');

INSERT INTO VISITOR_CENTER
VALUES ('Grandview Center', '56 First Street', '2123448865', '0900', '1815', 'Grandview Meadows');

INSERT INTO VISITOR_CENTER
VALUES ('Engellman Visitor Center', '43 Forest Lane', '4428776543', '0845', '1830', 'Pleishl Gardens');

INSERT INTO LIVES_IN
VALUES ('Mirror Lake Grounds', 'Bison');

INSERT INTO LIVES_IN
VALUES ('Pleishl Gardens', 'Bison');

INSERT INTO LIVES_IN
VALUES ('Oan Park', 'Bison');

INSERT INTO LIVES_IN
VALUES ('Oan Park', 'Lion');

INSERT INTO LIVES_IN
VALUES ('Blue Laguna Park', 'Toucan');

INSERT INTO LIVES_IN
VALUES ('Blue Laguna Park', 'Golden Tamarin');

INSERT INTO LIVES_IN
VALUES ('Mirror Lake Grounds', 'Grey Wolf');

INSERT INTO LIVES_IN
VALUES ('Pleishl Gardens', 'Grey Wolf');

INSERT INTO LIVES_IN
VALUES ('Grandview Meadows', 'Grey Wolf');

INSERT INTO LIVES_IN
VALUES ('Grandview Meadows', 'Red Fox');

INSERT INTO LIVES_IN
VALUES ('Raccoon Gardens', 'Red Fox');

INSERT INTO LIVES_IN
VALUES ('Raccoon Gardens', 'Robin');

INSERT INTO LIVES_IN
VALUES ('Grandview Meadows', 'Robin');

INSERT INTO LIVES_IN
VALUES ('Mirror Lake Grounds', 'Robin');

INSERT INTO LIVES_IN
VALUES ('Oan Park', 'Cheetah');

INSERT INTO LIVES_IN
VALUES ('Sraserd Park', 'Armadillo');

INSERT INTO LIVES_IN
VALUES ('Pleishl Gardens', 'Elk');

INSERT INTO LIVES_IN
VALUES ('Mirror Lake Grounds', 'Elk');

INSERT INTO LIVES_IN
VALUES ('Raccoon Gardens', 'Elk');

INSERT INTO LIVES_IN
VALUES ('Sraserd Park', 'Fruit Bat');

INSERT INTO LIVES_IN
VALUES ('Blue Laguna Park', 'Fruit Bat');

INSERT INTO LIVES_IN
VALUES ('Grandview Meadows', 'Fruit Bat');

INSERT INTO LIVES_IN
VALUES ('Mirror Lake Grounds', 'Fruit Bat');

INSERT INTO LIVES_IN
VALUES ('Raccoon Gardens', 'Barn Owl');

INSERT INTO LIVES_IN
VALUES ('Grandview Meadows', 'Barn Owl');

INSERT INTO LIVES_IN
VALUES ('Pleishl Gardens', 'Barn Owl');

INSERT INTO LIVES_IN
VALUES ('Mirror Lake Grounds', 'Brown Bear');

INSERT INTO LIVES_IN
VALUES ('Raccoon Gardens', 'Brown Bear');

INSERT INTO LIVES_IN
VALUES ('Oan Park', 'Brown Bear');

INSERT INTO LIVES_IN
VALUES ('Raccoon Gardens', 'Carp');

INSERT INTO LIVES_IN
VALUES ('Blue Laguna Park', 'Carp');

INSERT INTO LIVES_IN
VALUES ('Mirror Lake Grounds', 'Carp');

INSERT INTO LIVES_IN
VALUES ('Blue Laguna Park', 'Rainbow Trout');

INSERT INTO LIVES_IN
VALUES ('Raccoon Gardens', 'Rainbow Trout');

INSERT INTO LIVES_IN
VALUES ('Raccoon Gardens', 'Pink Salmon');

INSERT INTO LIVES_IN
VALUES ('Mirror Lake Grounds', 'Pink Salmon');

INSERT INTO GROWS_IN
VALUES ('Pleishl Gardens', 'Hemlock');

INSERT INTO GROWS_IN
VALUES ('Raccoon Gardens', 'Hemlock');

INSERT INTO GROWS_IN
VALUES ('Mirror Lake Grounds', 'Hemlock');

INSERT INTO GROWS_IN
VALUES ('Mirror Lake Grounds', 'Black Spruce');

INSERT INTO GROWS_IN
VALUES ('Pleishl Gardens', 'Black Spruce');

INSERT INTO GROWS_IN
VALUES ('Pleishl Gardens', 'Balsam Fir');

INSERT INTO GROWS_IN
VALUES ('Mirror Lake Grounds', 'Balsam Fir');

INSERT INTO GROWS_IN
VALUES ('Blue Laguna Park', 'Poinsettia');

INSERT INTO GROWS_IN
VALUES ('Blue Laguna Park', 'Heliconia');

INSERT INTO GROWS_IN
VALUES ('Blue Laguna Park', 'Orchid');

INSERT INTO GROWS_IN
VALUES ('Raccoon Gardens', 'Orchid');

INSERT INTO GROWS_IN
VALUES ('Grandview Meadows', 'Button Snakeroot');

INSERT INTO GROWS_IN
VALUES ('Raccoon Gardens', 'Button Snakeroot');

INSERT INTO GROWS_IN
VALUES ('Pleishl Gardens', 'Button Snakeroot');

INSERT INTO GROWS_IN
VALUES ('Pleishl Gardens', 'Tall Bluestem');

INSERT INTO GROWS_IN
VALUES ('Mirror Lake Grounds', 'Tall Bluestem');

INSERT INTO GROWS_IN
VALUES ('Sraserd Park', 'Prickly Pear');

INSERT INTO GROWS_IN
VALUES ('Sraserd Park', 'Saguaro');

INSERT INTO GROWS_IN
VALUES ('Sraserd Park', 'Juniper');

INSERT INTO GROWS_IN
VALUES ('Oan Park', 'Juniper');

INSERT INTO GROWS_IN
VALUES ('Grandview Meadows', 'Shagbark Hickory');

INSERT INTO GROWS_IN
VALUES ('Raccoon Gardens', 'Shagbark Hickory');

INSERT INTO GROWS_IN
VALUES ('Pleishl Gardens', 'Shagbark Hickory');

INSERT INTO GROWS_IN
VALUES ('Pleishl Gardens', 'Guelder Rose');

INSERT INTO GROWS_IN
VALUES ('Raccoon Gardens', 'Guelder Rose');

INSERT INTO GROWS_IN
VALUES ('Grandview Meadows', 'Guelder Rose');

INSERT INTO GROWS_IN
VALUES ('Grandview Meadows', 'White Birch');

INSERT INTO GROWS_IN
VALUES ('Raccoon Gardens', 'White Birch');

INSERT INTO GROWS_IN
VALUES ('Mirror Lake Grounds', 'White Birch');
