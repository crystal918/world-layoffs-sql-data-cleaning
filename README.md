# World Layoffs: SQL Data Cleaning & EDA Project

A MySQL data cleaning and exploratory data analysis (EDA) project on global tech layoffs data, built while following [Alex The Analyst's](https://www.youtube.com/@AlexTheAnalyst) SQL portfolio project series.

## Dataset
[Layoffs 2022 (Kaggle)](https://www.kaggle.com/datasets/swaptr/layoffs-2022)

## Goal
Turn the raw layoffs table into a clean, analysis-ready table, without touching the original data.

## Steps
1. **Staging tables:** Copied the raw table into `layoffs_staging` and `layoffs_staging2` so the original stays untouched.
2. **Remove duplicates:** Used `ROW_NUMBER() OVER (PARTITION BY ...)` and a CTE to find duplicate rows, then deleted rows where `row_num > 1`.
3. **Standardize data:**
   - Converted blank industries to `NULL`, then filled them using a self-join on company
   - Merged variants like "Crypto Currency" into "Crypto"
   - Removed trailing periods from country names ("United States.")
   - Converted `date` from text to `DATE` using `STR_TO_DATE`
4. **Handle nulls:** Reviewed null values and kept those that were not safe to change.
5. **Remove unusable data:** Deleted rows where both `total_laid_off` and `percentage_laid_off` were null, and dropped the helper `row_num` column.

## Exploratory Data Analysis
Using the cleaned table, `Portfolio_Project_EDA_Cleaned.sql` explores:
- Maximum and minimum layoffs, and companies that laid off 100% of their workforce
- Top companies, locations, countries, industries, and company stages by total layoffs
- Layoffs by year and by month
- Top 3 companies per year using `DENSE_RANK()`
- Rolling (cumulative) monthly layoffs using a window function

## Key Findings
- Google had the largest single layoff in the dataset, at 12,000 employees.
- Many companies laid off 100% of their workforce, which suggests they shut down.
- The data covers about three years, from 2020 to 2023.

## Skills Practiced
MySQL, CTEs, window functions (`ROW_NUMBER`, `DENSE_RANK`, rolling totals), aggregations, self-joins, `UPDATE`/`DELETE`, `ALTER TABLE`, string and date functions, data cleaning.

## Files
- `Portfolio_Project_-_Data_Cleaning_by_Aishat.sql`: data cleaning script
- `Portfolio_Project_EDA_Cleaned.sql`: exploratory data analysis script

## How to Run
1. Download the dataset from Kaggle and import it into MySQL as `world_layoffs.layoffs`.
2. Run the cleaning script first, then the EDA script, in MySQL Workbench.

## Next Steps
Visualize the findings in a dashboard (Power BI or Tableau).

## Author
Aishat Ibrahim | [LinkedIn](https://www.linkedin.com/in/aishat-ibrahim-5a9b5844b) | [GitHub](https://github.com/crystal918)
