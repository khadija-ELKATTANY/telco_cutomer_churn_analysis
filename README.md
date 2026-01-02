# Telco Customer Churn Analysis - GitHub Project

## Overview
This project provides a comprehensive analysis of customer churn in a telecommunications dataset using R and Python. The analysis includes data cleaning, exploratory data analysis, statistical testing, and business insights.

## Dataset
- **File**: WA_Fn-UseC_-Telco-Customer-Churn.csv
- **Size**: 7,043 customers with 21 features
- **Target Variable**: Churn (Yes/No)
- **Overall Churn Rate**: 26.54%

## Files Included

### Analysis Files
1. **telco_churn_analysis.R** - Complete R analysis script
   - Data loading and cleaning
   - Descriptive statistics
   - Comprehensive visualizations
   - Statistical testing
   - Key insights and recommendations


3. **telco_churn_cleaned.csv** - Cleaned dataset
   - Missing values handled
   - Data types corrected
   - Ready for analysis

### Visualizations (plots/ directory)
1. **01_churn_distribution.png** - Overall churn distribution
2. **02_churn_by_gender.png** - Churn analysis by gender
3. **03_churn_by_senior.png** - Churn analysis by senior citizen status
4. **04_churn_by_contract.png** - Churn analysis by contract type
5. **05_churn_by_internet.png** - Churn analysis by internet service
6. **06_churn_by_payment.png** - Churn analysis by payment method
7. **07_numerical_distributions.png** - Box plots for numerical variables
8. **08_correlation_matrix.png** - Correlation matrix heatmap
9. **09_churn_by_tenure_group.png** - Churn analysis by tenure groups
10. **10_services_analysis.png** - Churn analysis by all services

## Key Findings

### High-Risk Segments
- **Month-to-month contracts**: 42.7% churn rate
- **Fiber optic internet**: 41.9% churn rate  
- **Electronic check payments**: 45.3% churn rate
- **New customers (0-12 months)**: 47.4% churn rate

### Statistical Significance
All key relationships are statistically significant (p < 0.001):
- Contract type vs Churn
- Internet service vs Churn
- Tenure differences
- Monthly charges differences

### Business Recommendations
1. Convert month-to-month customers to longer contracts
2. Investigate fiber optic service quality issues
3. Encourage automatic payment methods
4. Implement new customer retention programs
5. Review pricing strategy for high-churn segments
6. Focus retention efforts on customers with tenure < 12 months

## How to Run the Analysis

### R Analysis
```r
# Install required packages
install.packages(c("tidyverse", "ggplot2", "dplyr", "corrplot", "gridExtra", "scales", "cowplot"))

# Run the analysis
source("telco_churn_analysis.R")
```

### R Markdown Report
```r
# Render the HTML report
rmarkdown::render("Telco_Churn_Analysis_Report.Rmd")
```


# Run the analysis (use the code provided in the analysis)
```

## Methodology
1. **Data Quality Assessment** - Checked for missing values and data types
2. **Data Cleaning** - Handled missing values, converted data types
3. **Exploratory Data Analysis** - Comprehensive visualizations
4. **Statistical Testing** - Chi-square tests and t-tests
5. **Business Insights** - Actionable recommendations

## Technical Details
- **Tools**: R, Python, ggplot2, matplotlib, seaborn
- **Statistical Tests**: Chi-square tests, t-tests
- **Visualizations**: Bar charts, box plots, correlation heatmaps
- **Sample Size**: 7,043 customers

## Data Dictionary
- **customerID**: Unique customer identifier
- **gender**: Customer gender (Female/Male)
- **SeniorCitizen**: Whether customer is a senior citizen (0/1)
- **Partner**: Whether customer has a partner (Yes/No)
- **Dependents**: Whether customer has dependents (Yes/No)
- **tenure**: Number of months customer has stayed with the company
- **PhoneService**: Whether customer has phone service (Yes/No)
- **MultipleLines**: Whether customer has multiple lines (Yes/No/No phone service)
- **InternetService**: Customer's internet service provider (DSL/Fiber optic/No)
- **OnlineSecurity**: Whether customer has online security (Yes/No/No internet service)
- **OnlineBackup**: Whether customer has online backup (Yes/No/No internet service)
- **DeviceProtection**: Whether customer has device protection (Yes/No/No internet service)
- **TechSupport**: Whether customer has tech support (Yes/No/No internet service)
- **StreamingTV**: Whether customer has streaming TV (Yes/No/No internet service)
- **StreamingMovies**: Whether customer has streaming movies (Yes/No/No internet service)
- **Contract**: Customer's contract type (Month-to-month/One year/Two year)
- **PaperlessBilling**: Whether customer has paperless billing (Yes/No)
- **PaymentMethod**: Customer's payment method
- **MonthlyCharges**: Monthly charges
- **TotalCharges**: Total charges
- **Churn**: Whether customer churned (Yes/No)

## Contact
For questions or suggestions, please open an issue in the GitHub repository.

## License
This analysis is provided for educational and business purposes. Please cite appropriately.

---

**Analysis Date**: 2025-12-26
**Tools**: R, Statistical Analysis, Data Visualization
**Purpose**: Customer Churn Analysis and Business Intelligence
