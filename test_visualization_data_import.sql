
use fx_db;

#create table pitch_table_fx
Load data local infile '~/myDesktop/CS_Courses/Sabermetrics/Project/Pitch_Predictions/pitch_table.csv' into table pitch_table_fx_test
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'

IGNORE 1 LINES;

#select * from pitch_table_fx_test;

select retro_game_id, inning, bat_home_id, pa_ball_ct, pa_strike_ct, outs_ct, start_bases_cd, ab_number, x, y, end_speed, 
	sz_top, sz_bot, pfx_x, pfx_z, px, pz, x0, y0, z0, vx0, vy0, vz0, ax, ay, az, break_y, 
    break_angle, break_length, spin_dir, spin_rate,
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

from pitch_table_fx_test 
where regseason_fl = "T" and playoffs_fl = "F" and pz != 0 and y0 = 50;

