DROP TABLE IF EXISTS score;
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS mon_hoc;
DROP TABLE IF EXISTS sinh_vien;
DROP TABLE IF EXISTS lop_hoc;
DROP TABLE IF EXISTS giang_vien;

CREATE TABLE giang_vien (
  ma_giang_vien VARCHAR(20) PRIMARY KEY,
  ho_ten        VARCHAR(50)  NOT NULL,
  email         VARCHAR(100) NOT NULL,
  CONSTRAINT uq_gv_email UNIQUE (email)
) ENGINE=InnoDB;

CREATE TABLE lop_hoc (
  ma_lop    VARCHAR(20) PRIMARY KEY,
  ten_lop   VARCHAR(50) NOT NULL,
  khoa      VARCHAR(50) NULL,
  nien_khoa VARCHAR(20) NULL,
  CONSTRAINT uq_lop_ten UNIQUE (ten_lop)
) ENGINE=InnoDB;

CREATE TABLE sinh_vien (
  ma_sinh_vien VARCHAR(20) PRIMARY KEY,
  ho_ten       VARCHAR(50)  NOT NULL,
  email        VARCHAR(100) NULL,
  ma_lop       VARCHAR(20)  NOT NULL,
  CONSTRAINT uq_sv_email UNIQUE (email),
  CONSTRAINT fk_sv_lop
    FOREIGN KEY (ma_lop) REFERENCES lop_hoc(ma_lop)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE mon_hoc (
  ma_mon_hoc     VARCHAR(20) PRIMARY KEY,
  ten_mon_hoc    VARCHAR(50) NOT NULL,
  so_tin_chi     INT NOT NULL,
  ma_giang_vien  VARCHAR(20) NOT NULL,
  CONSTRAINT uq_mh_ten UNIQUE (ten_mon_hoc),
  CONSTRAINT ck_mh_tin_chi CHECK (so_tin_chi > 0),
  CONSTRAINT fk_mh_gv
    FOREIGN KEY (ma_giang_vien) REFERENCES giang_vien(ma_giang_vien)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE enrollment (
  ma_sinh_vien VARCHAR(20) NOT NULL,
  ma_mon_hoc   VARCHAR(20) NOT NULL,
  ngay_dang_ky DATE NOT NULL,
  CONSTRAINT pk_enrollment PRIMARY KEY (ma_sinh_vien, ma_mon_hoc),
  CONSTRAINT fk_enroll_sv
    FOREIGN KEY (ma_sinh_vien) REFERENCES sinh_vien(ma_sinh_vien)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_enroll_mh
    FOREIGN KEY (ma_mon_hoc) REFERENCES mon_hoc(ma_mon_hoc)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE score (
  ma_sinh_vien   VARCHAR(20) NOT NULL,
  ma_mon_hoc     VARCHAR(20) NOT NULL,
  diem_qua_trinh DECIMAL(4,2) NOT NULL,
  diem_cuoi_ky   DECIMAL(4,2) NOT NULL,
  CONSTRAINT pk_score PRIMARY KEY (ma_sinh_vien, ma_mon_hoc),
  CONSTRAINT ck_diem_qua_trinh CHECK (diem_qua_trinh >= 0 AND diem_qua_trinh <= 10),
  CONSTRAINT ck_diem_cuoi_ky   CHECK (diem_cuoi_ky   >= 0 AND diem_cuoi_ky   <= 10),
  CONSTRAINT fk_score_enroll
    FOREIGN KEY (ma_sinh_vien, ma_mon_hoc)
    REFERENCES enrollment(ma_sinh_vien, ma_mon_hoc)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;