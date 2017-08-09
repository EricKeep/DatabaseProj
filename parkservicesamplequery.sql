SELECT DISTINCT Species, Height, Weight
FROM LIVES_IN, ANIMAL, PARK
WHERE PARK.Biome='Taiga' AND PARK.Park_name = LIVES_IN.P_name AND LIVES_IN.A_species = ANIMAL.Species;
/*Displays the Height and Weight of all animals living in a park in a Taiga Biome*/

SELECT DISTINCT VISITOR_CENTER.Name, Addr, Phone
FROM VISITOR_CENTER, ANIMAL, LIVES_IN
WHERE ANIMAL.Class = 'Fish' AND ANIMAL.Species = LIVES_IN.A_species AND LIVES_IN.P_name = VISITOR_CENTER.Park_name;
/* Gives the phone number, address, and name of a visitor center to call where there are fish */

SELECT P.Park_name
FROM PARK P, LANDMARK L
WHERE L.Type='Waterfall' AND P.Park_name = L.Park_name;
/* Lists park names with waterfalls */
