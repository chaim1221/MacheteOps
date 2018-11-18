--select * from dbo.ReportDefinitions
--select * from lookups

update workorders 
set workorders.status = 44
from workorders wo
join workassignments wa on wa.workorderid = wo.id
where status = 42
and wa.workerassignedid is not null
