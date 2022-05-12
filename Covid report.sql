Select *
From PortfolioProject..CovidDeaths$ 
Where continent is not null
Order by 3,4



Select *
From PortfolioProject..CovidDeaths$
Order by 3,4

-- Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths$
Where continent is not null
Order by 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where location like '%states%'
Order by 1,2

Select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where location like '%nigeria%'
Order by 1,2

Select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where location like '%africa%'
Order by 1,2


-- Looking at the Total Cases vs Population
--Shows what percentage of population contracted covid

Select Location, date, total_cases, population, (total_cases/population)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where location like '%states%'
Order by 1,2

Select Location, date, total_cases, population, (total_cases/population)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where location like '%nigeria%'
Order by 1,2

Select Location, date, total_cases, population, (total_cases/population)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where location like '%africa%'
Order by 1,2

Select Location, date, total_cases, population, (total_cases/population)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where location like '%europe%'
Order by 1,2

Select Location, date, total_cases, population, (total_cases/population)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where location like '%asia%'
Order by 1,2

Select Location, date, total_cases, population, (total_cases/population)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where location like '%america%'
Order by 1,2

Select Location, date, total_cases, population, (total_cases/population)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where location like '%oceania%'
Order by 1,2


-- Looking at Country with HIGHEST INFECTION rate compare to POPULATION

Select Location, population, MAX(total_cases) as HighestInfectionCount, 
MAX(total_cases/population)*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths$
--Where location like '%america%'
Group by location, population
Order by PercentagePopulationInfected desc


-- Showing countries with Highest Death Count per Population

Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
--Where location like '%america%'
Where continent is not null
Group by location
Order by TotalDeathCount desc

-- Showing countries with Highest Death Count per Population
-- Broken down by Continent

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is not null
Group by continent
Order by TotalDeathCount desc


-- Global Numbers

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage 
From PortfolioProject..CovidDeaths$
Where continent is not null
Group by date
Order by 1,2

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage 
From PortfolioProject..CovidDeaths$
Where continent is not null
Order by 1,2


Select *
From PortfolioProject..CovidVaccination$

Select *
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date 


-- Looking at Total population vs vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date 
Where dea.continent is not null
Order by 1,2,3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location)
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date 
Where dea.continent is not null
Order by 2,3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(int, vac.new_vaccinations)) OVER (Partition by dea.location)
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date 
Where dea.continent is not null
Order by 2,3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date)
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date 
Where dea.continent is not null
Order by 2,3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, 
dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date 
Where dea.continent is not null
Order by 2,3

--USE CTE

With PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, 
dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date 
Where dea.continent is not null
)
select*, (RollingPeopleVaccinated/Population)*100
From Popvsvac





--temp table

DROP Table if exists #PercentagePopulationVaccinated
create Table #PercentagePopulationVaccinated
(
continent nvarchar(255),
Location nvarchar(225),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentagePopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, 
  dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date 
--Where dea.continent is not null

select*, (RollingPeopleVaccinated/Population)*100
From #PercentagePopulationVaccinated




--Creating view to store data for later visualization

Create view PercentagePopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Convert(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, 
dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date 
Where dea.continent is not null

select*
from PercentagePopulationvaccinated

