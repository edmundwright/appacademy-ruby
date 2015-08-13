# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp > (
        SELECT
          MAX(gdp)
        FROM
          countries
        WHERE
          continent = 'Europe'
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      countries.continent, name, area
    FROM
      countries
    INNER JOIN (
      SELECT
        continent, MAX(area) AS max_area
      FROM
        countries
      GROUP BY
        continent
      ) AS max_areas ON countries.continent = max_areas.continent
    WHERE
      area = max_areas.max_area
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      big_countries.name, big_countries.continent
    FROM
      countries AS big_countries
    INNER JOIN
      countries AS smaller_countries
    ON
      big_countries.continent = smaller_countries.continent
    WHERE
      big_countries.name != smaller_countries.name
    GROUP BY
      big_countries.name
    HAVING
      SUM(CASE
          WHEN big_countries.population > smaller_countries.population * 3
          THEN 0
          ELSE 1
          END) = 0
  SQL
end
