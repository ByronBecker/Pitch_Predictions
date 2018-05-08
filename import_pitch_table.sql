
use fx_db;

#create table pitch_table_fx
Load data local infile '~/myDesktop/CS_Courses/Sabermetrics/Project/Pitch_Predictions/first_2months_pitch_2017.csv' into table pitch_table_fx
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'

IGNORE 1 LINES;


select * from pitch_table_fx limit 100;
select * from single_encoder limit 100;
select * from single_encoder where pitch_event = 10;

#SELECT * FROM pitch_table_fx order by id limit 50;

select * from pitch_table_fx
where pitch_des /*= '"In play' or pitch_des = "Swinging Strike" or pitch_des*/ = "Swinging Strike (Blocked)";

# creates dummy encodings for 4 outcomes - Ball, Called Strike, Swinging Strike, and Ball Hit
# the dummy encodings are then put into

/*
drop table if exists pitch_table_encodings;
create table pitch_table_encodings

select *,
	case
		when pitch_des = "Ball" or pitch_des = "Ball In Dirt" or pitch_des = "Hit By Pitch" or pitch_des = "Intent Ball" or pitch_des = "Pitchout" or pitch_des = "Automatic Ball"
			or pitch_des = '"Ball"' or pitch_des = '"Ball In Dirt"' or pitch_des = '"Hit By Pitch"' or pitch_des = '"Intent Ball"' or pitch_des = '"Pitchout"' or pitch_des = '"Automatic Ball"'
			or pitch_des = "Called Strike" or pitch_des = "Unknown Strike" or pitch_des = '"Called Strike"' or pitch_des = '"Unknown Strike"'
            then 0
        when pitch_des = "Swinging Strike" or pitch_des = "Swinging Strike (Blocked)" or pitch_des = "Foul Tip" or pitch_des = "Foul Bunt" or pitch_des = "Missed Bunt"
			or pitch_des = '"Swinging Strike"' or pitch_des = '"Swinging Strike (Blocked)"' or pitch_des = '"Swinging Strike (Blocked' or pitch_des = '"Foul Tip"' or pitch_des = '"Foul Bunt"' or pitch_des = '"Missed Bunt"'
			or pitch_des = "Foul" or pitch_des = "Foul (Runner Going)" or pitch_des = '"Foul"' or pitch_des = '"Foul (Runner Going)"' or pitch_des = '"In Play' 
            then 1
        else 2
	end as encoding1,
    case
		when pitch_des = "Ball" or pitch_des = "Ball In Dirt" or pitch_des = "Hit By Pitch" or pitch_des = "Intent Ball" or pitch_des = "Pitchout" or pitch_des = "Automatic Ball"
			or pitch_des = '"Ball"' or pitch_des = '"Ball In Dirt"' or pitch_des = '"Hit By Pitch"' or pitch_des = '"Intent Ball"' or pitch_des = '"Pitchout"' or pitch_des = '"Automatic Ball"'
			or pitch_des = "Swinging Strike" or pitch_des = "Swinging Strike (Blocked)" or pitch_des = "Foul Tip" or pitch_des = "Foul Bunt" or pitch_des = "Missed Bunt" 
            or pitch_des = '"Swinging Strike"' or pitch_des = '"Swinging Strike (Blocked)"' or pitch_des = '"Swinging Strike (Blocked' or pitch_des = '"Foul Tip"' or pitch_des = '"Foul Bunt"' or pitch_des = '"Missed Bunt"'
			then 0
        when pitch_des = "Called Strike" or pitch_des = "Unknown Strike" or pitch_des = '"Called Strike"' or pitch_des = '"Unknown Strike"'
			or pitch_des = "Foul" or pitch_des = "Foul (Runner Going)" or pitch_des = '"Foul"' or pitch_des = '"Foul (Runner Going)"' or pitch_des = '"In Play' 
            then 1
        else 2
	end as encoding2,
    case 
		when pit_hand_cd = "R" then 0
        else 1
	end as pit_hand_fl,
    case
		when bat_hand_cd = "R" then 0
        else 1
	end as bat_hand_fl

from pitch_table_fx

where regseason_fl = "T" and playoffs_fl = "F";
*/

drop table if exists single_encoder;
create table single_encoder

select *,
	case
		when pitch_des = "Ball" or pitch_des = "Ball In Dirt" or pitch_des = "Hit By Pitch" or pitch_des = "Intent Ball" or pitch_des = "Pitchout" or pitch_des = "Automatic Ball"
			or pitch_des = '"Ball"' or pitch_des = '"Ball In Dirt"' or pitch_des = '"Hit By Pitch"' or pitch_des = '"Intent Ball"' or pitch_des = '"Pitchout"' or pitch_des = '"Automatic Ball"'
            then 0
		when pitch_des = "Swinging Strike" or pitch_des = "Swinging Strike (Blocked)" or pitch_des = "Foul Tip" or pitch_des = "Foul Bunt" or pitch_des = "Missed Bunt"
			or pitch_des = '"Swinging Strike"' or pitch_des = '"Swinging Strike (Blocked)"' or pitch_des = '"Swinging Strike (Blocked' or pitch_des = '"Foul Tip"' or pitch_des = '"Foul Bunt"' or pitch_des = '"Missed Bunt"'
            then 1
		when pitch_des = "Called Strike" or pitch_des = "Unknown Strike" or pitch_des = '"Called Strike"' or pitch_des = '"Unknown Strike"'
			then 2
		when pitch_des = "Foul" or pitch_des = "Foul (Runner Going)" or pitch_des = '"Foul"' or pitch_des = '"Foul (Runner Going)"' or pitch_des = '"In Play' 
            then 3
		else 10
	end as pitch_event,
    case 
		when pit_hand_cd = "R" then 0
        else 1
	end as pit_hand_fl,
    case
		when bat_hand_cd = "R" then 0
        else 1
	end as bat_hand_fl
    
from pitch_table_fx 
where regseason_fl = "T" and playoffs_fl = "F" and pz != 0;

select pitch_event, count(*) from single_encoder group by pitch_event;

#select * from pitch_table_fx where regseason_fl = "T" and playoffs_fl = "F" and (pitch_des = "Foul" or pitch_des = "Foul (Runner Going)" or pitch_des = '"Foul"' or pitch_des = '"Foul (Runner Going)"' or pitch_des = '"In Play') and pz != 0 limit 100 ;
#select * from single_encoder where pitch_des = "Foul" or pitch_des = "Foul (Runner Going)" or pitch_des = '"Foul"' or pitch_des = '"Foul (Runner Going)"' or pitch_des = '"In Play' limit 100;


select inning, bat_home_id, bat_hand_fl, pit_hand_fl, pa_ball_ct, pa_strike_ct, outs_ct, start_bases_cd, ab_number, x, y, end_speed, 
	pitch_event, sz_top, sz_bot, pfx_x, pfx_z, px, pz, x0, y0, z0, vx0, vy0, vz0, ax, ay, az, break_y, 
    break_angle, break_length, spin_dir, spin_rate
    from single_encoder
    where y0 = 50;

/*
select inning, bat_home_id, bat_hand_fl, pit_hand_fl, pa_ball_ct, pa_strike_ct, outs_ct, start_bases_cd, ab_number, x, y, end_speed, 
	pitch_event, sz_top, sz_bot, pfx_x, pfx_z, px, pz, x0, y0, z0, vx0, vy0, vz0, ax, ay, az, break_y, 
    break_angle, break_length, spin_dir, spin_rate
    from single_encoder
    limit 200000;
select pitch_event, count(*) from single_encoder group by pitch_event;
*/
/*
drop table if exists pitch_table_encodings;
create table pitch_table_encodings

select *,
	case
		when pitch_des = "Ball" or pitch_des = "Ball In Dirt" or pitch_des = "Hit By Pitch" or pitch_des = "Intent Ball" or pitch_des = "Pitchout" or pitch_des = "Automatic Ball"
			or pitch_des = '"Ball"' or pitch_des = '"Ball In Dirt"' or pitch_des = '"Hit By Pitch"' or pitch_des = '"Intent Ball"' or pitch_des = '"Pitchout"' or pitch_des = '"Automatic Ball"'
            then 1
        else 0
	end as ball,
    case
		when pitch_des = "Called Strike" or pitch_des = "Unknown Strike" or pitch_des = '"Called Strike"' or pitch_des = '"Unknown Strike"' then 1
        else 0
	end as called_strike,
    case
		when pitch_des = "Swinging Strike" or pitch_des = "Swinging Strike (Blocked)" or pitch_des = "Foul Tip" or pitch_des = "Foul Bunt" or pitch_des = "Missed Bunt" 
            or pitch_des = '"Swinging Strike"' or pitch_des = '"Swinging Strike (Blocked)"' or pitch_des = '"Swinging Strike (Blocked' or pitch_des = '"Foul Tip"' or pitch_des = '"Foul Bunt"' or pitch_des = '"Missed Bunt"'
			then 1
		else 0
	end as swinging_strike,
    case
		when pitch_des = "Foul" or pitch_des = "Foul (Runner Going)" or pitch_des = '"Foul"' or pitch_des = '"Foul (Runner Going)"' or pitch_des = '"In Play' then 1
        else 0
	end as ball_hit,
    case 
		when pit_hand_cd = "R" then 0
        else 1
	end as pit_hand_fl,
    case
		when bat_hand_cd = "R" then 0
        else 1
	end as bat_hand_fl
    
from pitch_table_fx where regseason_fl = "T" and playoffs_fl = "F";

select * from pitch_table_encodings limit 10;

drop table if exists pandas_pitch_export;
create table pandas_pitch_export
select inning, bat_home_id, bat_hand_fl, pit_hand_fl, pa_ball_ct, pa_strike_ct, outs_ct, start_bases_cd, ab_number, x, y, end_speed, 
	ball, called_strike, swinging_strike, ball_hit, sz_top, sz_bot, pfx_x, pfx_z, px, pz, x0, y0, z0, vx0, vy0, vz0, ax, ay, az, break_y, break_angle, break_length, spin_dir, spin_rate
from pitch_table_encodings;
*/

select * from pandas_pitch_export;




