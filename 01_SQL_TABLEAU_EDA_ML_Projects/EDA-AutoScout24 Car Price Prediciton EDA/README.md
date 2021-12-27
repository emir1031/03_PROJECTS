<h1><p style="text-align: center;">Exploratory Data Analysis (EDA) Project</p></h1> 

<blockquote style="background: #f9f9f9;padding: 0.5em 10px;" class="">
<img src="https://docs.google.com/uc?id=1FOcuE9AkAqc0JU6dUly-cuoUg3bOp92H" class="img-fluid" width="200" height="85"> <h1>EDA for Car Price Prediction Model</h1>
</blockquote>

***
# Descriptions :
- A ``.json`` file containing a dataset consisting of 15919 rows and 54 columns is provided.
- This dataset, scraped from the on-line car trading company in 2019, contains many features of 9 different car models.
- The features (variables) of this dataset are too messy and distored.

# What is expected of you?
- Read the ``.json`` file and assign the dataset into a ``DataFrame`` using ``pandas``.
- Implement all aspects of the **EDA process** to the dataset.
   - Fix corrupted data formats,
   - Handle with outliers and missing values,
      - Domain (automobiles) knowledge is important.
      - Always use the internet to do the research that you need.
      - Think carefully to decide whether a data is outliers or not. Examples :
         - There is no conventional car model with an average fuel consumption of 1 - 1.5 liters per 100 km. 
         - Or you need to know that it cannot be a 300 euro car. 
         - Or if there is only one car with 3 doors out of the 15919 cars, this is what you should pay attention to and examine.
   - Drop the columns / rows you determined unnecessary as a result of your analysis,
   - Use visualization tools while doing all these processes.
- As a result, get the dataset ready to provide an appropriate input to the ML models.
- Save cleaned dataset into a ``.csv`` file.

# Need to Study :
- ``.str.method``,
- ``.contains()``,
- ``.extract()``,
- ``.to_datetime()``,
- ``.get_dummies()``,
- ``.add_prefix()``,
- ``.sample()``,
- `regex`,
- ``.to_numeric()``,
- ``.isin()``,
- ``.corr()``.