# world-layoffs-sql-data-cleaning
MySQL data cleaning project on global layoffs data: removing duplicates, standardizing values, fixing dates, and handling nulls
# World Layoffs: SQL Data Cleaning Project

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

## Skills Practiced
MySQL, CTEs, window functions, self-joins, `UPDATE`/`DELETE`, `ALTER TABLE`, string and date functions, data cleaning.

## Files
- `Portfolio_Project_-_Data_Cleaning_by_Aishat.sql`: full cleaning script

## How to Run
1. Download the dataset from Kaggle and import it into MySQL as `world_layoffs.layoffs`.
2. Run the script in MySQL Workbench from top to bottom.

## Next Steps
Exploratory data analysis (EDA) on the cleaned table.

## Author
Aishat Ibrahim | [LinkedIn](https://www.linkedin.com/in/aishat-ibrahim-5a9b5844b) | [GitHub](https://github.com/crystal918)
