use covid_data;

select *
from deaths
where continent is not null
order by 3,4;

select count(*) from deaths;

select *
from vaccinations
order by 1,2;

select location, date, total_cases, new_cases, total_deaths, population
from deaths
where continent is not null
order by 1,2;

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country 
select location, date, total_cases, total_deaths, (total_deaths / total_cases) * 100 as DeathPercentage
from deaths
where location like '%spain%' and continent is not null
order by 1,2;

-- Looking at Total Cases vs Population
-- Show what percentage of population got covid
select Location, date, Population, total_cases, (total_cases / population) * 100 as PercentPopulationInfected
from deaths
where location like '%spain%' and continent is not null
order by 1,2;

-- Country with higher infections rates compared to population
select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases / population) * 100) as PercentPopulationInfected
from deaths
where continent is not null
group by Location, Population
order by PercentPopulationInfected DESC;

-- Let's break things down by continent
select Continent, MAX(CAST(total_deaths as unsigned)) as TotalDeathCount
from deaths
where continent is not null
group by Continent
order by TotalDeathCount DESC;

-- Showing countries with Highest Death Count per population
select Location, MAX(cast(total_deaths as unsigned)) as TotalDeathCount
from deaths
where continent is null
group by Location
order by TotalDeathCount DESC;

-- Showing continents with the highest death count per population
select Continent, Location, MAX(CAST(total_deaths as unsigned)) as TotalDeathCount
from deaths
where continent is not null
group by Continent, Location
order by TotalDeathCount DESC;

-- GLOBAL NUMBERS
select SUM(new_cases) as TotalCases, SUM(CAST(new_deaths as unsigned)) as DeathsPerDay, SUM(new_cases) * 100 as DeathPercentage
from deaths
where continent is not null
order by 1, 2;

-- Looking at Total Population vs Vaccinations
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(select dea.continent, dea.location, dea.date, dea.population, vac.daily_vaccinations
, SUM(CONVERT(unsigned, vac.daily_vaccinations)) OVER (PARTITION BY d.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
from deaths as dea
	join vaccinations as vac
		on dea.location = vac.location
        and dea.date = vac.date
where dea.continent is not null
-- order by 2, 3
);

select * from PopvsVac;

-- TEMP Table
DROP TABLE IF EXISTS PercentPopulationVaccinated;
CREATE TABLE PercentPopulationVaccinated
(
	Continent nvarchar(255),
    Location nvarchar(255),
    Date datetime,
    Population numeric,
    RollingPeopleVaccinated numeric
); 

INSERT INTO PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.daily_vaccinations
, SUM(CONVERT(unsigned, vac.daily_vaccinations)) OVER (PARTITION BY d.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
from deaths as dea
	join vaccinations as vac
		on dea.location = vac.location
        and dea.date = vac.date
where dea.continent is not null
-- order by 2, 3
;

select *, (RollingPeopleVaccinated/Population)*100
from PercentPopulationVaccinated;

-- Creating a view to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated AS
select dea.continent, dea.location, dea.date, dea.population, vac.daily_vaccinations
, SUM(CONVERT(unsigned, vac.daily_vaccinations)) OVER (PARTITION BY d.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
from deaths as dea
	join vaccinations as vac
		on dea.location = vac.location
        and dea.date = vac.date
where dea.continent is not null;



-- per country, people death percenage vs people vaccinated percentage 
-- My experiment (not working)
select d.location as Location, SUM(v.total_vaccinations) as TotalVaccinationsPerCountry, SUM(d.total_cases) as TotalCasesPerCountry
from vaccinations as v
	JOIN deaths as d
		ON v.location = d.location
group by d.location limit 10;	
