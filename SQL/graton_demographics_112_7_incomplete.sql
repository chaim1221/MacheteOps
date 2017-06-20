
--test values
declare @beginDate datetime = '2017-01-01'
declare @endDate datetime = GETDATE()

--todo; this query is the basis of most of the Graton demographics report, and
--should be titled as such. we will need to pivot the columns from the original
--report so that the COLUMNS are the memberStatus_EN and the various data categories
--are the rows.
;with ages as 
(
SELECT
  workers.ID
  ,ROUND(DATEDIFF(day, Cast(Workers.dateOfBirth as Date), Cast(CURRENT_TIMESTAMP as Date)) / 365, 0) as age
  ,Lookups_Gender.gender_EN
  ,Lookups_MemberStatus.memberStatus_EN
FROM
  db_datareader.Lookups_MemberStatus AS Lookups_MemberStatus
  INNER JOIN Workers
    ON Lookups_MemberStatus.ID = Workers.memberStatus
  INNER JOIN WorkerSignins
    ON Workers.ID = WorkerSignins.WorkerID
  INNER JOIN Persons
    ON Persons.ID = Workers.ID
  INNER JOIN db_datareader.Lookups_Gender AS Lookups_Gender
    ON Lookups_Gender.ID = Persons.gender
WHERE
  WorkerSignins.dateforsignin >= @beginDate and
  WorkerSignins.dateforsignin <= @endDate
),
 combined as 
(
select 
  ID
  ,gender_EN
  ,memberStatus_EN
  ,case
	when age between 12 and 17 then '12 to 17'
	when age between 18 and 23 then '18 to 23'
    when age between 24 and 44 then '24 to 44'
    when age between 45 and 54 then '45 to 54'
	when age between 55 and 69 then '55 to 69'
    when age >= 70 then '70+'
	else 'unknown'
  end as age_group
from ages

)
select *
from combined