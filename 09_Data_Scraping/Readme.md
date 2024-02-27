![Alternatif Metin](https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/pics/asg.png)
# Hello!
In this notebook, I will give you information about Data Scraping and show you how to scrape data from a website in practice. 

## Contents:
- **What is Data Scraping?**
- **Which language and libraries can we use for Data Scrape?**
- **Understanding the structure of the website we will scrape and creating generic code.**
- **Gaining domain knowledge about the data to be scraped.**
- **Code we created and its explanations.**
- **To analyze the scraped data and create a rigid dataset with the necessary manipulations.**
- **Data visualization and machine learning application with final data set.**
- **Conclusion.**

### What is Data Scraping?
Data Scrape, also known as Web Scraping, is an automated method for collecting large amounts of data from websites and storing it in a structured format.<br>
- So what is this automated method? It is the code created using a certain programming language and libraries that behaves like a human and collects data from the source. In order to automate this, loops are created with the functions of the software language used, and they are made generic to ensure continuous operation.

### Which language and libraries can we use for Data Scrape?
![Alternatif Metin](https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/pics/pic1.jpg)

If you are currently working or researching in the field of data scraping, you will see that Python Programming Language is very successful in this field.

We will scrape data very successfully with these two Python libraries, Beautiful Soup and Selenium (by adding some Python skills). If you have any suggestions or different approaches, please do not hesitate to contact me or mention in the comments.

### Understanding the structure of the website we will scrape and creating generic code.
We will be using Otomoto website. This website is the largest online advertising and shopping site for buying and selling second-hand cars in Poland.

**The structure of links in Otomoto like:**
- **Website link:** https://www.otomoto.pl/
- **Defining types of car:** https://www.otomoto.pl/osobowe/ <br> *osobowe means type of car. It refers to regular passenger car.*
- **Choosing brand of car:** https://www.otomoto.pl/osobowe/"car-brand" <br> Example: https://www.otomoto.pl/osobowe/Audi

**Navigating between pages:**
- When we click on the second page of the list, the page information is included in the url. URL structure of the links to the following pages:
    - **Second Page:** https://www.otomoto.pl/osobowe/audi?page=2
    - **Third Page:** https://www.otomoto.pl/osobowe/audi?page=3
    - ...

**Navigating between individual ads.**<br>
- After logging in to the website, the advertisements you will see on the website pages are in the form of a list, and since the information in the list will not be enough for us, we will enter the individual advertisements one by one and get detailed information from there for each individual cars.
- In the code block shared, we will see how to extract information from these ads by clicking on each ad. I guess that's enough explanation for now.
![Alternatif Metin](https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/pics/Untitled.png)

### Gaining domain knowledge about the data to be scraped.
I have already well explained about general info for Domain Knowledge in one of my previous posts: [Here](https://www.linkedin.com/posts/emirhan-bozdogan_data-datascientist-dataanalysts-activity-6916958622887370752-zUpc?utm_source=share&utm_medium=member_desktop)

As a result of my research on how different countries evaluate cars, we will try to scrape as much of the data in the list below as possible from what is on our current website.

"mileage km", "fuel type", "price", "brand", "model", "version", "generation", "production year", "engine capacity detail", "fuel type detail", "power", "gearbox", "fuel consumption details", "damaged", "body type", "co2 emission", "color", "accident free", "condition" etc...

### Code we created and its explanations.

Please check out my python notebook on GitHub to better understand the codes and progress. For demonstration purposes, I set up my code to pull data from only the first 50 pages.
- First, our code is scraping data from page then storing following 7 fields as columns: "link", "full_name", "description", "year", "mileage_km", "fuel_type", "price".
- Then our code clicks on each ad in the list and scrapes all the details on the newly opened page and adds them as new columns, adhering to the links of the cars. Thus, 37 more columns will be added to our data and there will be 44 columns in total for each car ad.
- At the end it gives us a raw dataset in .csv format. ('cars.csv'). You can find it here: [Raw dataset (cars.csv)](https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/cars.csv)

Notebook Link: [Otomoto Data Scraping.ipynb](https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/Otomoto%20Data%20Scraping.ipynb)

### Exploratory Data Analysis
After manipulations and necessary changes, our raw data set becomes ready for visualization and machine learning algorithms.

Detailed information about how these manipulations and analyzes (Handling null data, dealing with outliers, extraction and feature selection etc.) are performed is available in the python notebook.

The final cleaned dataset is available here: [Cleaned dataset (clean_cars.csv)](https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/clean_cars.csv)

### Data visualization and machine learning application with final data set.
At this stage, you can make visualizations using the BI Tools you want. Even though I included basic visualizations in our notebook, I also tried this professionally in PowerBI and got good results. See below picture:
<p align="center">
  <img src="https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/pics/1.png" alt=""><br>
  <img src="https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/pics/2.png" alt=""><br>
  <img src="https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/pics/3.png" alt=""><br>
  <img src="https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/pics/4.png" alt=""><br>
  <img src="https://github.com/emir1031/03_PROJECTS/blob/main/09_Data_Scraping/pics/5.png" alt=""><br>
</p>

### Conclusion.
Apart from creating a machine learning algorithm and deploying our model, we learned what a data analysis project from scratch is like and its stages.

Unfortunately, the data we scraped is limited to only one car brand from one website. If we want to obtain sharper and more universal results, we must expand our data sources and extract all available data. At this point, you can take a look at the sites I recommend to you such as "Kaggle" and "Data World". Maybe someone has done this job before you and uploaded the data to such platforms.

In my next post, I will give you information about machine learning applications with a ready data set.

Stay well.

