# Android App Metrics Analysis (2010-2018 Data)

## 📊 Project Overview
This project analyzes metrics from over 10,000 Android apps, focusing on understanding the factors that drive app success in a highly competitive environment. By utilizing a Kaggle dataset of Google Play Store apps from 2010 to 2018, the analysis explores correlations between app downloads and key variables such as genre, audience, and reviews. Unlike traditional studies that focus on ratings or revenue, this analysis introduces a novel approach by emphasizing genre and developing a custom Deviation Metric to evaluate app performance.

The findings provide actionable insights for app developers, highlighting how genre, audience targeting, and seasonality can significantly impact download success.

## 🛠️ Tools Used
- **R (Jupyter Notebook):** Data cleaning, processing, and analysis.
- **Power BI:** Visualization and dashboard design.

## 🗂️ Project Structure
- **`scripts/` Folder:** Contains the Jupyter Notebook (`R`) used for data cleaning and processing.
- **`PowerBI/` Folder:** Includes the link to the Power BI dashboard visualizing app performance metrics across key dimensions.
- **`reports/` Folder:** Provides detailed project reports, including overall findings and data quality improvement analysis.
- **`datasets/` Folder:** Contains the raw dataset used for the analysis.

## 📂 Datasets
- **Google Play Store Apps Data (2010-2018):** This dataset contains information on various Google Play Store apps, including app name, category, rating, reviews, size, installs, and more.
  - Source: [Kaggle - Google Play Store Apps]([https://www.kaggle.com/datasets](https://www.kaggle.com/datasets/lava18/google-play-store-apps))

[Click here to download the dataset from this repository](datasets/).

[Click here to view the Power BI dashboard](https://app.powerbi.com/links/MOJIv481oU?ctid=75896fba-443c-4a4b-be5b-b780a63ffd94&pbi_source=linkShare)

## 📈 Key Insights
- **Data Cleaning and Quality Improvement:** Orchestrated data cleaning and processing of 10k+ apps in R, eliminating 483 duplicates through 'review' prioritization and imputing missing 'Rating' data with genre-specific means, achieving 100% data completeness and improving quality by 75%.
- **Deviation Metric Model:** Refined analysis by creating the 'Deviation Metric' model in Power BI with DAX, evaluating app download performance against variable averages across 5 critical dimensions (genre, audience, etc.), amplifying visualization insights and uncovering key success factors.
- **Targeted Insights and Trends:**
  - Identified a **250% rise** in arcade game downloads via genre analysis, supporting Dr. Warburton's stress-relief theory and illustrating user preference for value-centric apps.
  - Detected a **450% surge** in communication app downloads by analyzing trends, emphasizing the value users assign to human interaction.
  - Discovered a **310% spike** in app downloads during summer by analyzing seasonal patterns, recommending optimal release timing for maximum user acquisition.
  - Identified a **200% higher download rate** among pre-teens and teens by conducting app target audience analysis, guiding targeted marketing tactics and app designs tailored to their preferences.
- **Correlation Analysis:** Correlated user review counts with downloads (coefficient of 0.63) through statistical modeling in R, underlining the effectiveness of strategies to incentivize reviews.

## 📑 Project Reports
- [Overall Project Report](reports/Android%20App%20Metrics%20Analysis%20(2010-2018%20Data)_Report.pdf)
- [Data Quality Improvement Report (75%)](reports/Data%20Quality%20Improvement_Report.pdf)

## 📂 How to Use
1. **Explore the Jupyter Notebook**: Open the Jupyter notebook in the `scripts/` folder to review the R code for data cleaning and processing.
2. **Access the Power BI Dashboard**: Use the link provided above to explore interactive visualizations.

## 📬 Contact
For more information, feel free to reach out: [mouhamaad.ibrahim@gmail.com](mailto:mouhamaad.ibrahim@gmail.com)
