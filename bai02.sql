drop table if exists sinh_vien;
drop table if exists mon_hoc;

create table sinh_vien(
	ma_sinh_vien varchar(20) primary key,
    ho_ten varchar(20) not null
)ENGINE = InnoDB;

create table mon_hoc(
	ma_mon_hoc varchar(20) primary key,
    ten_mon_hoc varchar(20) not null,
    so_tin_chi int not null check(so_tin_chi >0)
)ENGINE=InnoDB;
