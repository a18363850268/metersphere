insert into project_application(project_id, type, type_value)
select id, 'CASE_CUSTOM_NUM', if(custom_num, 'true', 'false')
from project
where not exists(select * from project_application where project_id = id and type = 'CASE_CUSTOM_NUM');

insert into project_application(project_id, type, type_value)
select id, 'SCENARIO_CUSTOM_NUM', if(scenario_custom_num, 'true', 'false')
from project
where not exists(select * from project_application where project_id = id and type = 'SCENARIO_CUSTOM_NUM');

insert into project_application(project_id, type, type_value)
select id, 'API_QUICK_MENU', api_quick
from project
where api_quick is not null
  and not exists(select * from project_application where project_id = id and type = 'API_QUICK_MENU');


insert into project_application(project_id, type, type_value)
select id, 'CASE_PUBLIC', if(case_public, 'true', 'false')
from project
where not exists(select * from project_application where project_id = id and type = 'CASE_PUBLIC');


insert into project_application(project_id, type, type_value)
select id, 'MOCK_TCP_PORT', mock_tcp_port
from project
where not exists(select * from project_application where project_id = id and type = 'MOCK_TCP_PORT');


insert into project_application(project_id, type, type_value)
select id, 'MOCK_TCP_OPEN', if(is_mock_tcp_open, 'true', 'false')
from project
where not exists(select * from project_application where project_id = id and type = 'MOCK_TCP_OPEN');


insert into project_application(project_id, type, type_value)
select id, 'CLEAN_TRACK_REPORT', if(clean_api_report, 'true', 'false')
from project
where not exists(select * from project_application where project_id = id and type = 'CLEAN_TRACK_REPORT');


insert into project_application(project_id, type, type_value)
select id, 'CLEAN_TRACK_REPORT_EXPR', clean_track_report_expr
from project
where clean_track_report_expr is not null
  and not exists(select * from project_application where project_id = id and type = 'CLEAN_TRACK_REPORT_EXPR');

insert into project_application(project_id, type, type_value)
select id, 'CLEAN_API_REPORT', if(clean_api_report, 'true', 'false')
from project
where not exists(select * from project_application where project_id = id and type = 'CLEAN_API_REPORT');


insert into project_application(project_id, type, type_value)
select id, 'CLEAN_API_REPORT_EXPR', clean_api_report_expr
from project
where clean_api_report_expr is not null
  and not exists(select * from project_application where project_id = id and type = 'CLEAN_API_REPORT_EXPR');

insert into project_application(project_id, type, type_value)
select id, 'CLEAN_LOAD_REPORT', if(clean_load_report, 'true', 'false')
from project
where not exists(select * from project_application where project_id = id and type = 'CLEAN_LOAD_REPORT');

insert into project_application(project_id, type, type_value)
select id, 'CLEAN_LOAD_REPORT_EXPR', clean_load_report_expr
from project
where clean_load_report_expr is not null
  and not exists(select * from project_application where project_id = id and type = 'CLEAN_LOAD_REPORT_EXPR');

insert into project_application(project_id, type, type_value)
select id, 'URL_REPEATABLE', if(repeatable, 'true', 'false')
from project
where not exists(select * from project_application where project_id = id and type = 'URL_REPEATABLE');