create database SocialLab;
use SocialLab;

create table post(
	post_id int primary key auto_increment,
    content text,
    author varchar(50),
    likes_count int default(0)
);

/*
Task 1 (CREATE): Viết thủ tục sp_CreatePost để thêm bài viết mới.
	- Sử dụng tham số IN cho content và author.
	- Sử dụng tham số OUT để trả về post_id của bài viết vừa tạo.
*/
DELIMITER $$
create procedure sp_CreatePost (
	IN content_in text,
    IN author_in varchar(50)
)
BEGIN
	insert into posts(content, author)
    values
		(content_in, author_in);
END $$
DELIMITER ;
call sp_CreatePost('Đây là nội dung về back end', 'Bàng Trọng Tú');
DELIMITER $$
create procedure get_last_post(OUT )
DELIMITER ;

/*
Task 2 (READ & SEARCH): Viết thủ tục sp_SearchPost để tìm kiếm.
	- Sử dụng tham số IN là từ khóa tìm kiếm.
	- Kết quả trả về danh sách các bài viết có nội dung chứa từ khóa đó.
*/

/*
Task 3 (UPDATE): Viết thủ tục sp_IncreaseLike để tăng tương tác.
	- Sử dụng tham số IN cho post_id.
	- Sử dụng tham số INOUT để truyền vào số Like hiện tại và nhận lại số Like mới sau khi đã cộng thêm 1.
*/

/*
Task 4 (DELETE): Viết thủ tục sp_DeletePost.
	- Sử dụng tham số IN là post_id để xóa bài viết tương ứng.
*/