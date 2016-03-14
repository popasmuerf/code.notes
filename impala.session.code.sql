create table tmp_sessionizing as
select dyad_id, starttime,
if((
unix_timestamp(starttime)-lag(unix_timestamp(starttime),1) over (partition by dyad_id order by starttime)
) >30*70, 1, 0) as delta
from sr_internal_flowsample;

create table tmp_sessionizing_final as
select dyad_id, starttime,
delta,
sum(delta) over (partition by dyad_id order by starttime rows between unbounded preceding and current rows) as
sessionid
from tmp_sessionizing;




create table topgun.web_session_test0 as
select dyad_id, start_time,
if((
unix_timestamp(start_time)-lag(unix_timestamp(start_time),1) over (partition by dyad_id order by start_time)
) >30*70, 1, 0) as delta
from web;

create table topgun.attack_session_test0 as
select dyad_id,  pday ,
delta,
sum(delta) over (partition by dyad_id order by pday rows between unbounded preceding and current rows) as
pmonth
from topgun.attack ;