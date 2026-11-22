-- Exploratory Data Analysis: World Layoffs

-- 1. Preview the dataset
SELECT *
FROM world_layoffs.layoffs_staging2;


-- 2. Basic exploration

-- Maximum number of employees laid off in a single record
SELECT
    MAX(total_laid_off) AS max_laid_off
FROM world_layoffs.layoffs_staging2;

-- Maximum and minimum percentage of employees laid off
SELECT
    MAX(percentage_laid_off) AS max_percentage_laid_off,
    MIN(percentage_laid_off) AS min_percentage_laid_off
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off IS NOT NULL;

-- Companies that laid off their entire workforce
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1;

-- Companies that laid off their entire workforce, ordered by funding
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


-- 3. Aggregations and comparisons

-- Five largest single layoff records
SELECT
    company,
    total_laid_off
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NOT NULL
ORDER BY total_laid_off DESC
LIMIT 5;

-- Ten companies with the highest total number of layoffs
SELECT
    company,
    SUM(total_laid_off) AS total_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC
LIMIT 10;

-- Ten locations with the highest total number of layoffs
SELECT
    location,
    SUM(total_laid_off) AS total_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY total_laid_off DESC
LIMIT 10;

-- Total layoffs by country
SELECT
    country,
    SUM(total_laid_off) AS total_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC;

-- Total layoffs by year
SELECT
    YEAR(date) AS layoff_year,
    SUM(total_laid_off) AS total_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY YEAR(date)
ORDER BY layoff_year ASC;

-- Total layoffs by industry
SELECT
    industry,
    SUM(total_laid_off) AS total_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY total_laid_off DESC;

-- Total layoffs by company stage
SELECT
    stage,
    SUM(total_laid_off) AS total_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY total_laid_off DESC;


-- 4. Advanced analysis

-- Top three companies by total layoffs for each year
WITH company_year AS (
    SELECT
        company,
        YEAR(date) AS layoff_year,
        SUM(total_laid_off) AS total_laid_off
    FROM world_layoffs.layoffs_staging2
    GROUP BY company, YEAR(date)
),
company_year_rank AS (
    SELECT
        company,
        layoff_year,
        total_laid_off,
        DENSE_RANK() OVER (
            PARTITION BY layoff_year
            ORDER BY total_laid_off DESC
        ) AS ranking
    FROM company_year
)
SELECT
    company,
    layoff_year,
    total_laid_off,
    ranking
FROM company_year_rank
WHERE ranking <= 3
  AND layoff_year IS NOT NULL
ORDER BY layoff_year ASC, total_laid_off DESC;

-- Monthly total layoffs
SELECT
    DATE_FORMAT(date, '%Y-%m') AS layoff_month,
    SUM(total_laid_off) AS monthly_layoffs
FROM world_layoffs.layoffs_staging2
GROUP BY DATE_FORMAT(date, '%Y-%m')
ORDER BY layoff_month ASC;

-- Cumulative monthly layoffs
WITH monthly_layoffs AS (
    SELECT
        DATE_FORMAT(date, '%Y-%m') AS layoff_month,
        SUM(total_laid_off) AS monthly_layoffs
    FROM world_layoffs.layoffs_staging2
    GROUP BY DATE_FORMAT(date, '%Y-%m')
)
SELECT
    layoff_month,
    monthly_layoffs,
    SUM(monthly_layoffs) OVER (
        ORDER BY layoff_month ASC
    ) AS rolling_total_layoffs
FROM monthly_layoffs
ORDER BY layoff_month ASC;
