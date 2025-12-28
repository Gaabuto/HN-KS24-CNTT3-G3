-- create table class (
-- class_id varchar(50) primary key,
-- class_name varchar(50) not null,
-- years int not null
-- );

-- create table student (
-- student_id varchar(50) primary key,
-- student_name varchar(50) not null,
-- date_birth date not null,
-- class_id varchar(50) not null,
-- foreign key (class_id) references class(class_id)
-- )



-- bai 2
-- create table subjects (
-- subject_id varchar(50) primary key,
-- subject_name varchar(50) not null,
-- credit int not null check (credit > 0)
-- );

-- -- create table student ( 
-- -- student_id varchar(50) primary key,
-- -- student_name varchar(50) not null
-- -- )






-- bai 3
-- create table class (
-- class_id varchar(50) primary key,
-- class_name varchar(50) not null,
-- credit int not null check (credit > 0)
-- );

-- create table student ( 
-- student_id varchar(50) primary key,
-- student_name varchar(50) not null
-- );

-- create table enrollment(
--  student_id varchar(50),
--  class_id varchar(50),
--  register_date date not null,
--  primary key( student_id, class_id),
--  foreign key( student_id) references student(student_id),
--  foreign key( class_id) references class(class_id)
-- )






-- bai 4
-- create table teacher(
-- teacher_id varchar(50) primary key,
-- teacher_name varchar(50) not null,
-- teacher_email varchar(50) not null
-- );

-- alter table subjects
-- add column teacher_id varchar(50),
-- add foreign key (teacher_id) references teacher(teacher_id);






-- bai 5
-- create table score(
-- student_id  varchar(50),
-- subject_id  varchar(50),
-- progress_point float not null check(progress_point < 10 and progress_point >0),
-- project_point float not null check(project_point < 10 and project_point >0),
-- primary key (student_id, subject_id),
-- foreign key (student_id) references student(student_id),
-- foreign key (subject_id) references sunbjects(subject_id)
-- )






-- bai 6

-- create table class (
--     class_id varchar(50) primary key,
--     class_name varchar(50)not null,
--     years int not null
-- );

-- create table student (
-- student_id varchar(50) primary key,
-- student_name varchar(50) not null,
-- date_birth date not null,
-- class_id varchar(50) not null,
-- foreign key (class_id) references class(class_id)
-- )


-- create table teacher (
--     teacher_id varchar(50) PRIMARY KEY,
--     teacher_name varchar(50) NOT NULL,
--     teacher_email varchar(100) NOT NULL UNIQUE
-- );

-- create table subjects (
--     subject_id varchar(50) primary key,
--     subject_name varchar(100) not null,
--     credit int not null check (credit > 0),
--     teacher_id varchar(50) not null,

--     forgein key (teacher_id) references teacher(teacher_id)
-- );

-- create table enrollment(
--  student_id varchar(50),
--  class_id varchar(50),
--  register_date date not null,
--  primary key( student_id, class_id),
--  foreign key( student_id) references student(student_id),
--  foreign key( class_id) references class(class_id)
-- )

-- create table score(
-- student_id  varchar(50),
-- subject_id  varchar(50),
-- progress_point float not null check(progress_point < 10 and progress_point >0),
-- project_point float not null check(project_point < 10 and project_point >0),
-- primary key (student_id, subject_id),
-- foreign key (student_id) references student(student_id),
-- foreign key (subject_id) references sunbjects(subject_id)
-- )


-- bai 7
create table customer (
    customer_id varchar(50) primary key,
    full_name varchar(100) not null,
    age int not null,
    cccd varchar(15) not null unique,
    phone varchar(15) not null unique,
    created_at timestamp default current_timestamp
);

create table account (
    account_id varchar(50) primary key,
    customer_id varchar(50) not null,
    balance decimal(15,2) not null check (balance >= 0),
    created_at timestamp default current_timestamp,
    foreign key (customer_id) references customer(customer_id)
);

create table partner (
    partner_id varchar(50) primary key,
    partner_name varchar(100) not null unique default 'rikkeisoft',
    created_at timestamp default current_timestamp
);

create table tuition_bill (
    bill_id varchar(50) primary key,
    partner_id varchar(50) not null,
    student_name varchar(100) not null,
    amount decimal(15,2) not null check (amount > 0),
    bill_status varchar(20) not null default 'unpaid',
    created_at timestamp default current_timestamp,

    foreign key (partner_id) references partner(partner_id)
);

create table transaction (
    transaction_id varchar(50) primary key,
    account_id varchar(50) not null,
    bill_id varchar(50) unique,
    amount decimal(15,2) not null check (amount > 0),
    transaction_status varchar(20) not null default 'pending',
    transaction_time timestamp default current_timestamp,

    foreign key (account_id)
        references account(account_id),

    foreign key (bill_id)
        references tuition_bill(bill_id)
);



