CREATE TABLE healthdata.UserDimension (
    Id BIGINT PRIMARY KEY
);

       
INSERT INTO healthdata.UserDimension (Id)
select distinct  dmc.Id
from google_project.dailycalories_merged_cleaned dmc

/* I used two keys because and id could has many dates*/
/////////////////////// 
CREATE TABLE healthdata.TimeDimension (
   DateId DATE PRIMARY KEY,
   Day_of_Week_Activity VARCHAR(10),
   month_Activity int,
   year_Activity INT
);



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


//////////////////////////////////////////
CREATE VIEW healthdata.DailyActivityView AS
select
    ht.DateId,
    ud.id as User_id,
    dmc.Calories,
    dimc.FairlyActiveMinutes + dimc.VeryActiveMinutes + dimc.LightlyActiveMinutes as Total_active_minutes,
    dsmc.StepTotal
from google_project.dailycalories_merged_cleaned dmc
join healthdata.timedimension ht on ht.DateId = dmc.ActivityDay
join healthdata.userdimension ud on ud.Id = dmc.Id
join  google_project.dailyintensities_merged_cleaned  dimc on dimc.Id = ud.Id
join google_project.dailysteps_merged_cleaned dsmc on dsmc.Id  = ud.Id and dsmc.ActivityDay = ht.DateId
/////////////////////////////////////////
CREATE VIEW healthdata.SleepFact AS
select
    ht.DateId,
    ud.id as User_id,
    smc.TotalMinutesAsleep  as TotalMinutesAsleep,
    smc.TotalTimeInBed  as TotalTimeInBed
from google_project.dailycalories_merged_cleaned dmc
join healthdata.timedimension ht on ht.DateId = dmc.ActivityDay
join healthdata.userdimension ud on ud.Id = dmc.Id
join google_project.minutesleep_merged_cleaned mmc on mmc.Id = ud.Id
join google_project.sleepday_merged_cleaned smc on smc.Id = ud.Id and date(smc.SleepDay) = ht.DateId
//////////////////////////////////////////
CREATE VIEW healthdata.WeightFact     AS
select
    ht.DateId,
    ud.id as User_id,
    wmc.WeightKg,
    wmc.WeightPounds,
    wmc.Fat,
    wmc.BMI
from google_project.dailycalories_merged_cleaned dmc
join healthdata.timedimension ht on ht.DateId = dmc.ActivityDay
join healthdata.userdimension ud on ud.Id = dmc.Id
join google_project.weightloginfo_merged_cleaned  wmc on wmc.Id = dmc.Id and date(wmc.date_reg) = ht.DateId
////////////////////////////////////////////////
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
