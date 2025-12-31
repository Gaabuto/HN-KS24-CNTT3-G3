create database bai04;
use bai04;
ALTER TABLE Product ADD COLUMN sold_quantity INT;
-- Lấy 10 sản phẩm bán chạy nhất
SELECT * FROM Product ORDER BY sold_quantity DESC LIMIT 10;
-- Lấy 5 sản phẩm bán chạy tiếp theo (bỏ qua 10 sản phẩm đầu)
SELECT * FROM Product ORDER BY sold_quantity DESC LIMIT 5 OFFSET 10;
-- Hiển thị danh sách sản phẩm giá < 2.000.000, sắp xếp theo số lượng bán giảm dần
SELECT * FROM Product WHERE price < 2000000 ORDER BY sold_quantity DESC;