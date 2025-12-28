drop table if exists sinh_vien;
drop table if exists mon_hoc;
drop table if exists enrollment;

create table sinh_vien(
	ma_sinh_vien varchar(20) primary key,
    ho_ten varchar(20) not null
)ENGINE = InnoDB;

create table mon_hoc(
	ma_mon_hoc varchar(20) primary key,
    ten_mon_hoc varchar(20) not null,
    so_tin_chi int not null check(so_tin_chi >0)
)ENGINE=InnoDB;

create table enrollment(
	ma_sinh_vien varchar(20) not null,
    ma_mon_hoc varchar(20) not null,
    ngay_dang_ky date not null,
	constraint pk_enrollment primary key(ma_sinh_vien, ma_mon_hoc),
    
    constraint fk_enroll_sv 
    foreign key (ma_sinh_vien) references sinh_vien(ma_sinh_vien)
    on update cascade
    on delete restrict
    ,
    
    constraint fk_enroll_mh
    foreign key (ma_mon_hoc) references mon_hoc(ma_mon_hoc)
    on update cascade
    on delete restrict
    
)ENGINE=InnoDB;