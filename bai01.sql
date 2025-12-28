DROP TABLE IF EXISTS sinh_vien;
DROP TABLE IF EXISTS lop_hoc;

CREATE TABLE lop_hoc (
  ma_lop   VARCHAR(20) PRIMARY KEY,
  ten_lop  VARCHAR(50) NOT NULL,
  nam_hoc  INT NOT NULL,
  CONSTRAINT ck_nam_hoc CHECK (nam_hoc >= 2000)
) ENGINE=InnoDB;

CREATE TABLE sinh_vien (
  ma_sinh_vien VARCHAR(20) PRIMARY KEY,
  ho_ten       VARCHAR(100) NOT NULL,
  ngay_sinh    DATE NOT NULL,
  ma_lop       VARCHAR(20) NOT NULL,

  CONSTRAINT fk_sv_lop
    FOREIGN KEY (ma_lop) REFERENCES lop_hoc(ma_lop)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;