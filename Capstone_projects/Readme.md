[Introduction](#introduction)

# Case Study 2: How Can a Wellness Technology Company Play It Smart?

## Introduction 

Welcome to the Bellabeat data analysis case study! In this case study, you will perform many real-world tasks of a junior data
analyst. You will imagine you are working for Bellabeat, a high-tech manufacturer of health-focused products for women,
and meet different characters and team members. In order to answer the key business questions, you will follow the steps
of the data analysis process: ask, prepare, process, analyze, share, and act. Along the way, the Case Study Roadmap
tables — including guiding questions and key tasks — will help you stay on the right path.

You are a junior data analyst working on the marketing analyst team at Bellabeat, a high-tech manufacturer of
health-focused products for women. Bellabeat is a successful small company, but they have the potential to become a larger
player in the global smart device market. Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that
analyzing smart device fitness data could help unlock new growth opportunities for the company. You have been asked to
focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart
devices. The insights you discover will then help guide marketing strategy for the company. You will present your analysis to
the Bellabeat executive team along with your high-level recommendations for Bellabeat’s marketing strategy.

## Characters and products
### Characters
- **Urška Sršen**: Bellabeat’s cofounder and Chief Creative Officer
- **Sando Mur**: Mathematician and Bellabeat’s cofounder; key member of the Bellabeat executive team
- **Bellabeat marketing analytics team**: A team of data analysts responsible for collecting, analyzing, and
reporting data that helps guide Bellabeat’s marketing strategy. You joined this team six months ago and have been
busy learning about Bellabeat’’s mission and business goals — as well as how you, as a junior data analyst, can
help Bellabeat achieve them.
### Products
- **Bellabeat app**: The Bellabeat app provides users with health data related to their activity, sleep, stress,
menstrual cycle, and mindfulness habits. This data can help users better understand their current habits
and make healthy decisions. The Bellabeat app connects to their line of smart wellness products.
- **Leaf**: Bellabeat’s classic wellness tracker can be worn as a bracelet, necklace, or clip. The Leaf tracker connects
to the Bellabeat app to track activity, sleep, and stress.
- **Time**: This wellness watch combines the timeless look of a classic timepiece with smart technology to track user
activity, sleep, and stress. The Time watch connects to the Bellabeat app to provide you with insights into your

## Ask

- What are some trends in smart device usage?
- How could these trends apply to Bellabeat customers?
- How could these trends help influence Bellabeat marketing strategy?

## Prepare
- Where is your data stored?
- How is the data organized? Is it in long or wide format?
- Are there issues with bias or credibility in this data? Does your data ROCCC?
- How are you addressing licensing, privacy, security, and accessibility?
- How did you verify the data’s integrity?
- How does it help you answer your question?
- Are there any problems with the data?

## Process
- What tools are you choosing and why?
- Have you ensured your data’s integrity?
- What steps have you taken to ensure that your data is clean?
- How can you verify that your data is clean and ready to analyze?
- Have you documented your cleaning process so you can review and share those results?


## Analyze

- How should you organize your data to perform analysis on it?
- Has your data been properly formatted?
- What surprises did you discover in the data?
- What trends or relationships did you find in the data?
- How will these insights help answer your business questions?

## Share

- Were you able to answer the business questions?
- What story does your data tell?
- How do your findings relate to your original question?
- Who is your audience? What is the best way to communicate with them?
- Can data visualization help you share your findings?
- Is your presentation accessible to your audience?

## Share

- What is your final conclusion based on your analysis?
- How could your team and business apply your insights?
- What next steps would you or your stakeholders take based on your findings?
- Is there additional data you could use to expand on your findings?

## Act

- What is your final conclusion based on your analysis?
- How could your team and business apply your insights?
- What next steps would you or your stakeholders take based on your findings?
- Is there additional data you could use to expand on your findings?

## Report

## Ask
In this process I would like to resolve some question that are going to guide me for resolve the case. First, *what is the problem you are trying to solve?*, so answering this question my main idea is create insights base with the data shared and  present strategies for improve the **Bellabeat membership**, second *how can your insights drive business decisions?*, so the idea of found insights is found facts or trends that help to resolve or create a better understanding of the situation in the company related to the produced previous selected so based with facts would be easier to understand the environment of the service and create decisions better also So I've these question to resolve using the insights found it in the end of the proccess:

- What are some trends in smart device usage?
- How could these trends apply to Bellabeat customers?
- How could these trends help influence Bellabeat marketing strategy?

## Prepare

For the execution of this case study, I opted to utilize MySQL as the platform for storage, preparation, cleaning, and data relationships. To facilitate the loading of data into the MySQL database, I took an advanced approach by incorporating Python to handle the entire process of data creation and loading.

### Loading data
```
import os
import pandas as pd


def load_data():
    folder_path = os.path.join(os.getcwd(),'Google project/data')
    csv_files = {}
        
    try:
        file_list = list(os.listdir(folder_path))
        csv_files = {
            file : pd.read_csv(os.path.join(folder_path,file))
            for file in file_list
            for file in file_list
            if file.endswith('.csv')
        }
        
    
    except OSError as e:
        print(f'Error {e}')
        return None
    
    print("______________________Documents loaded________________________")
    return csv_files

```

### Creating connection

*The following information is only for educational purpose*

```
from sqlalchemy import create_engine, Column,Integer,String,Table,MetaData,Float,Boolean
import pandas as pd
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base


def mysql_connection():


    ####db credentials
    usr = 'admin'
    pwd = 'password'
    host = '127.0.0.1'
    port = 3306
    db_name = 'Projects'
    
    #create engine
    engine = create_engine(
        f"mysql+mysqldb://{usr}:{pwd}@{host}:{port}/{db_name}",
        echo= True,
        future = True
    )
    
    print('______________________Successful connection________________________')
    return engine

```

### Creating tables

```
from sqlalchemy import create_engine, Column,Integer,String,Table,MetaData,Float,Boolean,BigInteger
import pandas as pd
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.exc import OperationalError
import os 

def create_tables(engine,csv_files):

    try:

        Session = sessionmaker(bind = engine)
        session = Session()

        Base = declarative_base()


        for key,value in  csv_files.items():
            metadata = MetaData(bind=engine)
            df = value
            table_name = key.replace('.csv','')
            schema = 'Projects'
            columns = []
            for column_name, dtype in df.dtypes.items():
                if dtype == 'int64':
                    column_type = BigInteger()
                elif dtype == 'float64':
                    column_type = Float()
                elif dtype == 'object':
                    max_length = df[column_name].str.len().max()
                    if max_length is None or max_length == 0:
                        max_length = 50
                    column_type = String(length=max_length)
                elif dtype == 'bool':
                    column_type = Boolean()
                else:
                    column_type = String()

                column = Column(column_name, column_type)
                columns.append(column)
            table = Table(
                table_name,
                metadata,
                schema=schema,
                *columns
            )

            try:
                metadata.create_all(engine)
                session.commit()
                print(f'______________________Table {table_name} created______________________')
            except OperationalError as e:
                print(f"______________________Table {table_name} already exists or an error occurred: {str(e)}______________________")
                session.rollback()  
                continue  
            
            
            try:
                    df.to_sql(table_name, engine, if_exists='append', index=False, schema=schema)
                    print(f'______________________Data loaded into table {table_name}______________________')
            except Exception as e:
                print(f"______________________Error loading data into table {table_name}: {str(e)}______________________")


            
            




        session.close()
        print('______________________Tables created and loaded data________________________')

    except Exception as e:
        print(f'An error ocurred: {str(e)}')
```

```
After have created and loaded all the tables and data, I did the transformation process using SQL I goinf to share a few statments but you can check all the information used in the script initial_cleanup.sql file:

```
```
CREATE TABLE Projects.dailyCalories_merged_cleaned AS
select pdc.Id,
CONVERT(concat(right(pdc.ActivityDay,4),"-",left(pdc.ActivityDay,1),"-",REPLACE(SUBSTRING(pdc.ActivityDay,3,2),"-","")),DATE) as ActivityDay,
pdc.Calories
from Projects.dailyCalories_merged as pdc
```

```
CREATE TABLE Projects.dailyIntensities_merged_cleaned AS
SELECT pdm.Id,
CONVERT(concat(right(pdm.ActivityDay,4),"-",left(pdm.ActivityDay,1),"-",REPLACE(SUBSTRING(pdm.ActivityDay,3,2),"-","")),DATE) as ActivityDay,
pdm.SedentaryMinutes,
pdm.LightlyActiveMinutes,
pdm.FairlyActiveMinutes,
pdm.VeryActiveMinutes,
pdm.SedentaryActiveDistance,
pdm.LightActiveDistance,
pdm.ModeratelyActiveDistance,
pdm.VeryActiveDistance
FROM Projects.dailyIntensities_merged pdm;
```

Most of the data was stored in a long format, although a few cases were in a wide format due to the high number of closely related variables.

Regarding data credibility, it was not a concern since the data was collected by the company itself. This origin minimized the potential for bias in the dataset. However, with respect to the ROC curve (ROCCC), the limitation lies in the relatively short duration of data collection, spanning only two months over a period of two years. This temporal limitation could introduce accuracy bias into the analysis.

The data is securely stored within a database, accessible only through a password-protected system. In terms of data integrity, meticulous transformation was carried out to impose a structured format.

This transformation process played a pivotal role as it provided both a coherent structure to the data and facilitated the creation of a schema. This schema, in turn, allowed for efficient tracking of the key characteristics inherent in the dataset.

```
               +-----------------------+
               |   TimeDimension       |
               +-----------------------+
               | DateId (PK)           |
               | DayOfWeek             |
               | Month                 |
               | Year                  |
               +-----------------------+
                      |
                      |
                      v
               +-----------------------+
               |   UserDimension       |
               +-----------------------+
               | UserId (PK)           |
               +-----------------------+
                      |     |     |
                      |     |     |
                      v     v     v
+-----------------+  +-----------------+  +-----------------+
| DailyActivityFact |  |    SleepFact    |  |   WeightFact    |
+-----------------+  +-----------------+  +-----------------+
| DateId (FK)     |  | DateId (FK)     |  | DateId (FK)     |
| UserId (FK)     |  | UserId (FK)     |  | DateId (FK)     |
| CaloriesBurned  |  | TotalSleepMinutes|  | WeightKg        |
| ActivityMinutes|  | TimeInBed        |  | WeightPounds    |
| StepCount       |  +-----------------+  | FatPercentage   |
+-----------------+                      | BMI             |
                                         +-----------------+
```

With this process I could be more precise with the data

## Process

I decided to use different tools for this case. I used Python to create and load the data, SQL to clean and transform the data, and Tableau to analyze the information.

To maintain the integrity of my data, I chose to create a Schema. I started with a basic structure and a few sources for analysis.

First, I designed the structure of my schema. Then, I defined the dimensions and types of measures I intended to analyze. By doing this, I could prevent data duplication and maintain data cleanliness. This approach helped me determine if my data was ready for analysis. The entire process of cleaning and transforming the data is documented in the file "schema_tables.sql," where you can find the relevant information.

```
INSERT INTO healthdata.TimeDimension (DateId,Day_of_Week_Activity,month_Activity,year_Activity)
with date_act as (
select  dmc.ActivityDay
from google_project.dailycalories_merged_cleaned dmc
group by 1)
select da.ActivityDay,
case dayofweek(da.ActivityDay)
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
end as Day_of_Week_Activity,
month(ActivityDay) as month_Activity,
year(ActivityDay) as year_Activity
from date_act da
```

## Analyze

To analyze all the data for the study case, I focused my attention on several key performance indicators (KPIs): Calories per user, type of activity, and sleep minutes. These three measures were chosen to present the main insights regarding my primary question. I utilized Tableau to create both my analyses and visualizations.

Additionally, I incorporated a few additional metrics to gain a more comprehensive understanding of the data from various perspectives. This approach helped me uncover significant insights such as:

There exists a correlation between the number of calories burned and the steps taken by the user.
Tuesday emerged as the most active day for users in terms of activities. Consequently, it recorded the highest calorie expenditure.
Wednesday witnessed the longest sleep duration, likely attributed to the heightened activity levels on the preceding day.
Demographic data appeared to be a pivotal variable that could facilitate deeper analysis of the data.
These insights shed light on certain user routines, providing a better understanding of the days on which the service could implement an improved notification system. This system could offer timely alerts to users about their activities and suggest days for additional rest based on their activity patterns.

## Share

The primary goal of this analysis was to gain insights that could contribute to enhancing the Bellabeat membership experience. Building upon the previous steps where I uncovered valuable insights, I was able to address my main question effectively.

The data analysis revealed that users tend to have a preferred day for engaging in activities, as well as a preference for specific types of activities. This information underscores the importance of understanding which activities have higher demand. This knowledge can then be used to tailor future activity offerings to meet the specific requirements of users, thereby enhancing their experience.

In presenting these findings to the key stakeholders within the company, the audience comprises three principal characters. Through this presentation, I intend to communicate the key insights derived from the data analysis. These insights hold the potential to guide strategic decisions and improvements within the Bellabeat membership framework.

**https://public.tableau.com/app/profile/andres6452/viz/CaseStudyBellabeat_16922147124250/ActivitiesAnalysis**

## Act

In conclusion, I believe that the service has the potential to offer more personalized insights to improve activities, particularly on days with lower user engagement. One possible strategy could involve implementing a points-based system to incentivize user consistency. Moreover, an effective notification system could be developed that tailors activity suggestions based on their intensity and relevance.

To further enhance user engagement, the team might consider introducing a newsletter or campaign aimed at educating users on how to configure their activities based on their individual routines.

By focusing on the proposed features and strategies mentioned above, stakeholders can drive improvements within the service. Prioritizing these enhancements could lead to a more effective and user-centered approach.

To achieve better user segmentation, it's essential to gather and share additional user-related information. This data could be used to create detailed buyer personas, segment user groups effectively, and gain a deeper understanding of users' health-related needs. This comprehensive approach to segmentation could yield valuable insights for the development of a more tailored and impactful service.