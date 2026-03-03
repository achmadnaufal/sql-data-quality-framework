# Sql Data Quality Framework

SQL-based data quality rule testing and monitoring framework

## Features
- Data ingestion from CSV/Excel input files
- Automated analysis and KPI calculation
- Summary statistics and trend reporting
- Sample data generator for testing and development

## Installation

```bash
pip install -r requirements.txt
```

## Quick Start

```python
from src.main import SQLDataQuality

analyzer = SQLDataQuality()
df = analyzer.load_data("data/sample.csv")
result = analyzer.analyze(df)
print(result)
```

## Data Format

Expected CSV columns: `table_name, column_name, rule_type, threshold, actual_value, status, run_date`

## Project Structure

```
sql-data-quality-framework/
├── src/
│   ├── main.py          # Core analysis logic
│   └── data_generator.py # Sample data generator
├── data/                # Data directory (gitignored for real data)
├── examples/            # Usage examples
├── requirements.txt
└── README.md
```

## License

MIT License — free to use, modify, and distribute.

## New: Referential Integrity Rules

Validate foreign key relationships in your database:

```sql
-- Check customer_id referential integrity
select * from rule_fk_customer_orders;

-- Results show violation count and percentage
-- Violations > 0 indicates orphaned records
```

Included Rules:
- Foreign key validation (customers, products)
- Temporal validity checks (future dates)
- Aggregated violation reporting

