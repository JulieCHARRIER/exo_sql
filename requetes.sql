-- SQLite
-- 1. How many countries are included in our data set?

SELECT COUNT(DISTINCT location) FROM data_covid;

-- 2. When was the most recent entry?

SELECT * FROM data_covid
ORDER BY date DESC
LIMIT 1;

-- 3. What country had the highest single day deaths per million?

SELECT SUM(total_deaths_per_million) AS death_per_day, date, location FROM data_covid
GROUP BY date, location
ORDER BY death_per_day DESC
LIMIT 1;

SELECT SUM(new_deaths_per_million) AS death_per_day, date, location FROM data_covid
GROUP BY date, location
ORDER BY death_per_day DESC
LIMIT 1;

-- 4. Select any country. How many times have the deaths per million exceeded 1,000 in one day?

SELECT COUNT(death_per_day) AS day_over_1000, location FROM (
  SELECT SUM(total_deaths_per_million) AS death_per_day, date, location FROM data_covid
  GROUP BY date, location)
WHERE death_per_day > 1000
GROUP BY location
ORDER BY day_over_1000 DESC;

SELECT COUNT(death_per_day) AS day_over_1000, location FROM (
  SELECT SUM(total_deaths_per_million) AS death_per_day, date, location FROM data_covid
  GROUP BY date, location)
WHERE death_per_day > 1000 AND location = 'Peru';

-- 5. Extract the deaths per million for US, France, and India. Plot the time series data and compare results to what the media is currently saying

SELECT total_deaths_per_million, date ,location FROM data_covid
WHERE location = 'United States' OR location = 'France' OR location = 'India';

SELECT new_deaths_per_million, date ,location FROM data_covid
WHERE location = 'United States' OR location = 'France' OR location = 'India';

-- 6. Plot the deaths per million and cases per million by continent for your birthday in 2020. What does the data say?

SELECT SUM(total_deaths_per_million), SUM(total_cases_per_million), continent FROM data_covid
WHERE date = '2020-08-29'
GROUP BY continent;

SELECT SUM(new_deaths_per_million), SUM(new_cases_per_million), continent FROM data_covid
WHERE date = '2020-08-29'
GROUP BY continent;

-- 7. Plot the lockdown stringency for each country and color the scatter points by continent. Any insights?

SELECT AVG(stringency_index), location, continent, date FROM data_covid
GROUP BY location;

--BONUS

-- Plot deaths per million for one country. Find Google's mobility for that country. Determine if lockdowns for that country have influenced
-- deaths per million (changed the shape of the curve). Remember, you have have to create a lagged variable to account for time from
-- infection to death (median time ~ 15 days). Therefore, any change in policy ("lockdown") would take ~15 days to see an effect

-- Plot cases per million for a given country. Look up when masks became mandatory in that country. Did this implementation of this anti-social
-- and anti-science intervention change the shape of the curve. (Meaning was their a sharp change in case numbers?)

