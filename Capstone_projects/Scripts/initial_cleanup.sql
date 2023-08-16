
CREATE TABLE Projects.dailyCalories_merged_cleaned AS
select pdc.Id,
CONVERT(concat(right(pdc.ActivityDay,4),"-",left(pdc.ActivityDay,1),"-",REPLACE(SUBSTRING(pdc.ActivityDay,3,2),"-","")),DATE) as ActivityDay,
pdc.Calories
from Projects.dailyCalories_merged as pdc

//////////////////////////////////
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

/////////////////////////////////
CREATE TABLE Projects.hourlyCalories_merged_cleaned AS
SELECT
    hcm.Id,
    CONVERT(
        CONCAT(
            RIGHT(SUBSTRING_INDEX(ActivityHour, ' ', 1), 4),
            "-",
            LEFT(SUBSTRING_INDEX(ActivityHour, ' ', 1), 1),
            "-",
            REPLACE(SUBSTRING(SUBSTRING_INDEX(ActivityHour, ' ', 1), 3, 2), "-", "")
        ),
        DATE
    ) AS ActivityDay,
    hcm.Calories
FROM Projects.hourlyCalories_merged hcm;
////////////////////////////////////////////
CREATE TABLE Projects.hourlyIntensities_merged_cleaned AS
select him.Id,
DATE_FORMAT(STR_TO_DATE(ActivityHour, '%m/%d/%Y %h:%i:%s %p'), '%Y-%m-%d %H:%i:%s') AS ActivityHour,
him.TotalIntensity,
him.AverageIntensity
from Projects.hourlyIntensities_merged as him
//////////////////////////////////////////////
CREATE TABLE Projects.hourlySteps_merged_cleaned AS
select hsm.Id,
DATE_FORMAT(STR_TO_DATE(ActivityHour, '%m/%d/%Y %h:%i:%s %p'), '%Y-%m-%d %H:%i:%s') AS ActivityHour,
hsm.StepTotal
from Projects.hourlySteps_merged hsm
///////////////////////////////////////////
CREATE TABLE Projects.minuteCaloriesNarrow_merged_cleaned AS
select 
mcn.Id,
DATE_FORMAT(STR_TO_DATE(mcn.ActivityMinute, '%m/%d/%Y %h:%i:%s %p'), '%Y-%m-%d %H:%i:%s') AS ActivityMinute,
mcn.Calories
from Projects.minuteCaloriesNarrow_merged mcn
/////////////////////////////////////////
CREATE TABLE Projects.minuteCaloriesWide_merged_cleaned AS
select mcw.Id,
DATE_FORMAT(STR_TO_DATE(mcw.ActivityHour, '%m/%d/%Y %h:%i:%s %p'), '%Y-%m-%d %H:%i:%s') AS ActivityHour,
mcw.Calories01,
mcw.Calories02,
mcw.Calories03,
mcw.Calories04,
mcw.Calories05,
mcw.Calories06,
mcw.Calories07,
mcw.Calories08,
mcw.Calories09,
mcw.Calories10,
mcw.Calories11,
mcw.Calories12,
mcw.Calories13,
mcw.Calories14,
mcw.Calories15,
mcw.Calories16,
mcw.Calories17,
mcw.Calories18,
mcw.Calories19,
mcw.Calories20,
mcw.Calories21,
mcw.Calories22,
mcw.Calories23,
mcw.Calories24,
mcw.Calories25,
mcw.Calories26,
mcw.Calories27,
mcw.Calories28,
mcw.Calories29,
mcw.Calories30,
mcw.Calories31,
mcw.Calories32,
mcw.Calories33,
mcw.Calories34,
mcw.Calories35,
mcw.Calories36,
mcw.Calories37,
mcw.Calories38,
mcw.Calories39,
mcw.Calories40,
mcw.Calories41,
mcw.Calories42,
mcw.Calories43,
mcw.Calories44,
mcw.Calories45,
mcw.Calories46,
mcw.Calories47,
mcw.Calories48,
mcw.Calories49,
mcw.Calories50,
mcw.Calories51,
mcw.Calories52,
mcw.Calories53,
mcw.Calories54,
mcw.Calories55,
mcw.Calories56,
mcw.Calories57,
mcw.Calories58,
mcw.Calories59
from Projects.minuteCaloriesWide_merged mcw
////////////////////////////////////////////////////
CREATE TABLE Projects.minuteIntensitiesWide_merged_cleaned AS
select
mcw.Id,
DATE_FORMAT(STR_TO_DATE(mcw.ActivityHour, '%m/%d/%Y %h:%i:%s %p'), '%Y-%m-%d %H:%i:%s') AS ActivityHour,
mcw.Intensity01,
mcw.Intensity02,
mcw.Intensity03,
mcw.Intensity04,
mcw.Intensity05,
mcw.Intensity06,
mcw.Intensity07,
mcw.Intensity08,
mcw.Intensity09,
mcw.Intensity10,
mcw.Intensity11,
mcw.Intensity12,
mcw.Intensity13,
mcw.Intensity14,
mcw.Intensity15,
mcw.Intensity16,
mcw.Intensity17,
mcw.Intensity18,
mcw.Intensity19,
mcw.Intensity20,
mcw.Intensity21,
mcw.Intensity22,
mcw.Intensity23,
mcw.Intensity24,
mcw.Intensity25,
mcw.Intensity26,
mcw.Intensity27,
mcw.Intensity28,
mcw.Intensity29,
mcw.Intensity30,
mcw.Intensity31,
mcw.Intensity32,
mcw.Intensity33,
mcw.Intensity34,
mcw.Intensity35,
mcw.Intensity36,
mcw.Intensity37,
mcw.Intensity38,
mcw.Intensity39,
mcw.Intensity40,
mcw.Intensity41,
mcw.Intensity42,
mcw.Intensity43,
mcw.Intensity44,
mcw.Intensity45,
mcw.Intensity46,
mcw.Intensity47,
mcw.Intensity48,
mcw.Intensity49,
mcw.Intensity50,
mcw.Intensity51,
mcw.Intensity52,
mcw.Intensity53,
mcw.Intensity54,
mcw.Intensity55,
mcw.Intensity56,
mcw.Intensity57,
mcw.Intensity58,
mcw.Intensity59
from Projects.minuteIntensitiesWide_merged mcw
///////////////////////////////////////////////////////////
CREATE TABLE Projects.minuteSleep_merged_cleaned AS
select msm.Id,
DATE_FORMAT(STR_TO_DATE(msm.date, '%m/%d/%Y %h:%i:%s %p'), '%Y-%m-%d %H:%i:%s') AS log_date,
msm.value as log_value, 
msm.logId
from
Projects.minuteSleep_merged as msm
//////////////////////////////////////////////////////////
CREATE TABLE Projects.minuteStepsWide_merged_cleaned AS
select
mcw.Id,
DATE_FORMAT(STR_TO_DATE(mcw.ActivityHour, '%m/%d/%Y %h:%i:%s %p'), '%Y-%m-%d %H:%i:%s') AS ActivityHour,
mcw.Steps00,
mcw.Steps02,
mcw.Steps03,
mcw.Steps04,
mcw.Steps05,
mcw.Steps06,
mcw.Steps07,
mcw.Steps08,
mcw.Steps09,
mcw.Steps10,
mcw.Steps11,
mcw.Steps12,
mcw.Steps13,
mcw.Steps14,
mcw.Steps15,
mcw.Steps16,
mcw.Steps17,
mcw.Steps18,
mcw.Steps19,
mcw.Steps20,
mcw.Steps21,
mcw.Steps22,
mcw.Steps23,
mcw.Steps24,
mcw.Steps25,
mcw.Steps26,
mcw.Steps27,
mcw.Steps28,
mcw.Steps29,
mcw.Steps30,
mcw.Steps31,
mcw.Steps32,
mcw.Steps33,
mcw.Steps34,
mcw.Steps35,
mcw.Steps36,
mcw.Steps37,
mcw.Steps38,
mcw.Steps39,
mcw.Steps40,
mcw.Steps41,
mcw.Steps42,
mcw.Steps43,
mcw.Steps44,
mcw.Steps45,
mcw.Steps46,
mcw.Steps47,
mcw.Steps48,
mcw.Steps49,
mcw.Steps50,
mcw.Steps51,
mcw.Steps52,
mcw.Steps53,
mcw.Steps54,
mcw.Steps55,
mcw.Steps56,
mcw.Steps57,
mcw.Steps58,
mcw.Steps59
from Projects.minuteStepsWide_merged mcw
//////////////////////////////////////////////
CREATE TABLE Projects.sleepDay_merged_cleaned AS
select sm.Id,
DATE_FORMAT(STR_TO_DATE(sm.SleepDay, '%m/%d/%Y %h:%i:%s %p'), '%Y-%m-%d %H:%i:%s') AS SleepDay, 
sm.TotalSleepRecords,
sm.TotalMinutesAsleep,
sm.TotalTimeInBed
from
Projects.sleepDay_merged as sm
/////////////////////////////////////////////
CREATE TABLE Projects.weightLogInfo_merged_cleaned AS
select wm.Id,
DATE_FORMAT(STR_TO_DATE(wm.date, '%m/%d/%Y %h:%i:%s %p'), '%Y-%m-%d %H:%i:%s') AS date_reg,
wm.WeightKg,
wm.WeightPounds,
case
when wm.Fat != 0 then wm.Fat
else 0
end as Fat,
wm.BMI,
case
when wm.IsManualReport = 1 then True
else False
end as IsManualReport,
wm.LogId    
from Projects.weightLogInfo_merged as wm
