/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

Select *
From PortofolioProject..CovidDeaths
Order by 1, 2


-- Select Data that we are going to be starting with

Select location, date, new_cases, total_cases, new_deaths, total_deaths 
From PortofolioProject..CovidDeaths
where location like '%Leb%'
and continent is not null
Order by 1, 2


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select location, date, new_cases, total_cases, new_deaths, total_deaths, (cast(total_deaths as int)/total_cases)*100 as DeathPercentage
From PortofolioProject..CovidDeaths
where location like '%Leb%'
and continent is not null
Order by DeathPercentage desc


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select location, date, population, total_cases, (total_cases/population)*100 as InfectedPercentage
From PortofolioProject..CovidDeaths
--where location like '%leb%'
Where continent is not null
Order by InfectedPercentage desc


-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortofolioProject..CovidDeaths
--Where location like '%leb%'
Group by Location, Population
order by PercentPopulationInfected desc


-- Countries with Highest Death Count per Population

Select Location, max(cast(total_deaths as int)) as TotalDeathCount 
From PortofolioProject..CovidDeaths
--Where location like '%leb%'
Where continent is not null
Group by Location
Order by TotalDeathCount desc


-- Countries with Highest death count compared to Population

Select Location, max(cast(total_deaths as int)) as TotalDeathCount, max((cast(total_deaths as int)/population))*100 as PercentPopulationDied 
From PortofolioProject..CovidDeaths
--Where location like '%leb%'
Where continent is not null
Group by Location
Order by PercentPopulationDied desc


-- Continents with Highest Death Count per Population

Select location, max(cast(total_deaths as int)) as TotalDeathCount
From PortofolioProject..CovidDeaths
--Where location like '%leb%'
Where continent is null
Group by location
Order by TotalDeathCount desc

Select continent, sum(cast(new_deaths as int)) as TotalDeathCount
From PortofolioProject..CovidDeaths
--Where location like '%leb%'
Where continent is not null
Group by continent
Order by TotalDeathCount desc


-- Global numbers

Select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum((cast(new_deaths as int)))/sum(new_cases)*100 as DeathPercentage
From PortofolioProject..CovidDeaths
--where location like '%Leb%'
Where continent is not null
Group by date
Order by 1,2


-- Total Population vs Vaccinations

Select dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Convert(int, vac.new_vaccinations)) Over (Partition by dea.location) as RollingPeopleVaccinated
from PortofolioProject..CovidDeaths dea
Join PortofolioProject..CovidVaccinations vac
On dea.location = vac.location
And dea.date = vac.date
Where dea.continent is not null
Order by 1, 2


-- Shows Percentage of Population that has recieved at least one Covid Vaccine
-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (location, date, population, new_vaccinations, RollingPeopleVaccinated) As
(
Select dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Convert(int, vac.new_vaccinations)) Over (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
from PortofolioProject..CovidDeaths dea
Join PortofolioProject..CovidVaccinations vac
On dea.location = vac.location
And dea.date = vac.date
Where dea.location like '%leb%'
--Order by 1, 2
)
Select*, (RollingPeopleVaccinated/population)*100 as PercentVaccinated
From PopvsVac


-- Using Temp Table to perform Calculation on Partition By in previous query

Drop table if exists #PercentPopulationVaccinated
Create table #PercentPopulationVaccinated
(
Location nvarchar(255),
date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Convert(int, vac.new_vaccinations)) Over (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
from PortofolioProject..CovidDeaths dea
Join PortofolioProject..CovidVaccinations vac
On dea.location = vac.location
And dea.date = vac.date
Where dea.location like '%leb%'
--Order by 1, 2

Select*, (RollingPeopleVaccinated/population)*100 as PercentVaccinated
From #PercentPopulationVaccinated


-- Creating View to store data for later visualizations

Create View PercentPopVaccinated as
Select dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Convert(int, vac.new_vaccinations)) Over (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
from PortofolioProject..CovidDeaths dea
Join PortofolioProject..CovidVaccinations vac
On dea.location = vac.location
And dea.date = vac.date
Where dea.location is not null
--Order by 1, 2

Select*
From PercentPopVaccinated