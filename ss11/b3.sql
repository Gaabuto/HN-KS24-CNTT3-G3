-- bài 3
use social_network_pro;

delimiter //
create procedure CalculateBonusPoints(
	in p_user_id int,
	inout p_bonus_points int
)
begin  
    declare post_count int default 0;
    select count(*) into post_count from posts
    where user_id = p_user_id;

    if post_count >= 20 then set p_bonus_points = p_bonus_points + 100;
    elseif post_count >= 10 then set p_bonus_points = p_bonus_points + 50;
    end if;
end //
delimiter ;

set @bonus = 100;
call CalculateBonusPoints(1, @bonus);
select @bonus as bonus_point;
drop procedure if exists CalculateBonusPoints



