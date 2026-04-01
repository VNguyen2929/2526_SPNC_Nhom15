-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 01, 2026 at 07:18 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz_game_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` int(11) NOT NULL,
  `class_name` varchar(50) NOT NULL,
  `teacher_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`id`, `class_name`, `teacher_id`) VALUES
(1, '10A1', 1),
(2, '10A2', 1),
(3, '10A9', 2);

-- --------------------------------------------------------

--
-- Table structure for table `gameresults`
--

CREATE TABLE `gameresults` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `lesson_id` int(11) DEFAULT NULL,
  `play_mode` varchar(50) DEFAULT NULL,
  `correct_answers` int(11) DEFAULT NULL,
  `score` decimal(4,1) DEFAULT NULL,
  `play_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gameresults`
--

INSERT INTO `gameresults` (`id`, `student_id`, `lesson_id`, `play_mode`, `correct_answers`, `score`, `play_time`) VALUES
(52, 3, 2, 'Ở Nhà', 0, 0.0, '2026-03-23 15:04:14'),
(53, 3, 2, 'Ở Nhà', 1, 1.0, '2026-03-23 15:04:21'),
(54, NULL, 1, 'Trên Lớp', 0, 0.0, '2026-03-23 15:27:09'),
(55, NULL, 1, 'Trên Lớp', 0, 0.0, '2026-03-24 08:31:45');

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_summary` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `topic_id`, `name`, `is_summary`) VALUES
(1, 1, 'Bài 1: Thông tin và xử lý thông tin', 0),
(2, 1, 'Bài 2: Vai trò của thiết bị thông minh và tin học đối với xã hội', 0),
(3, 1, 'Bài 3: Một số kiểu dữ liệu và dữ liệu văn bản', 0),
(4, 1, 'Bài 4: Hệ nhị phân và dữ liệu số nguyên', 0),
(5, 1, 'Bài 5: Dữ liệu lôgic', 0),
(6, 1, 'Bài 6: Dữ liệu âm thanh và hình ảnh', 0),
(7, 1, 'Bài 7: Thực hành sử dụng thiết bị số thông dụng', 0),
(8, 2, 'Bài 8: Mạng máy tính trong cuộc sống hiện đại', 0),
(9, 2, 'Bài 9: An toàn trên không gian mạng', 0),
(10, 2, 'Bài 10: Thực hành khai thác tài nguyên trên Internet', 0),
(11, 3, 'Bài 11: Ứng xử trên môi trường số. Nghĩa vụ tôn trọng bản quyền', 0),
(12, 4, 'Bài 12: Phần mềm thiết kế đồ họa', 0),
(13, 4, 'Bài 13: Bổ sung các đối tượng đồ họa', 0),
(14, 4, 'Bài 14: Làm việc với đối tượng đường và văn bản', 0),
(15, 4, 'Bài 15: Hoàn thiện hình ảnh đồ họa', 0),
(16, 5, 'Bài 16: Ngôn ngữ lập trình bậc cao và Python', 0),
(17, 5, 'Bài 17: Biến và lệnh gán', 0),
(18, 5, 'Bài 18: Các lệnh vào ra đơn giản', 0),
(19, 5, 'Bài 19: Câu lệnh rẽ nhánh if', 0),
(20, 5, 'Bài 20: Câu lệnh lặp for', 0),
(21, 5, 'Bài 21: Câu lệnh lặp while', 0),
(22, 5, 'Bài 22: Kiểu dữ liệu danh sách', 0),
(23, 5, 'Bài 23: Một số lệnh làm việc với dữ liệu danh sách', 0),
(24, 5, 'Bài 24: Xâu kí tự', 0),
(25, 5, 'Bài 25: Một số lệnh làm việc với xâu kí tự', 0),
(26, 5, 'Bài 26: Hàm trong Python', 0),
(27, 5, 'Bài 27: Tham số của hàm', 0),
(28, 5, 'Bài 28: Phạm vi của biến', 0),
(29, 5, 'Bài 29: Nhận biết lỗi chương trình', 0),
(30, 5, 'Bài 30: Kiểm thử và gỡ lỗi chương trình', 0),
(31, 5, 'Bài 31: Thực hành viết chương trình đơn giản', 0),
(32, 5, 'Bài 32: Ôn tập lập trình Python', 0),
(33, 6, 'Bài 33: Nghề thiết kế đồ họa máy tính', 0),
(34, 6, 'Bài 34: Nghề phát triển phần mềm', 0);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `options_json` text NOT NULL,
  `correct_answer` varchar(1) NOT NULL,
  `difficulty` enum('easy','medium','hard') DEFAULT 'medium'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `lesson_id`, `question_text`, `options_json`, `correct_answer`, `difficulty`) VALUES
(1, 1, 'Dữ liệu trong máy tính được biểu diễn dưới dạng nào?', '[\"Dãy bit\", \"Văn bản\", \"Âm thanh\", \"Hình ảnh\"]', '0', 'easy'),
(2, 1, 'Đơn vị nhỏ nhất để đo dung lượng thông tin là gì?', '[\"Byte\", \"Bit\", \"KB\", \"MB\"]', '1', 'easy'),
(3, 1, '1 Byte bằng bao nhiêu bit?', '[\"8\", \"10\", \"1024\", \"16\"]', '0', 'easy'),
(4, 1, 'Thiết bị nào sau đây là thiết bị vào?', '[\"Chuột\", \"Màn hình\", \"Loa\", \"Máy in\"]', '0', 'easy'),
(5, 1, 'Thiết bị nào sau đây là thiết bị ra?', '[\"Máy in\", \"Bàn phím\", \"Micro\", \"Máy quét\"]', '0', 'medium'),
(6, 1, 'Quá trình xử lý thông tin gồm mấy bước chính?', '[\"3\", \"4\", \"5\", \"2\"]', '1', 'medium'),
(7, 1, 'Bộ nhớ trong của máy tính bao gồm?', '[\"RAM và ROM\", \"Ổ cứng\", \"Thẻ nhớ\", \"USB\"]', '0', 'medium'),
(8, 1, 'Tại sao máy tính dùng hệ nhị phân để xử lý dữ liệu?', '[\"Phù hợp linh kiện điện tử có 2 trạng thái đóng/ngắt\", \"Dễ học hơn hệ thập phân\", \"Ít tốn bộ nhớ hơn\", \"Vì hệ nhị phân đẹp\"]', '0', 'hard'),
(9, 1, 'Đơn vị đo dung lượng nào sau đây là lớn nhất?', '[\"Terabyte\", \"Gigabyte\", \"Megabyte\", \"Kilobyte\"]', '0', 'hard'),
(10, 1, 'Mã hóa thông tin là quá trình gì?', '[\"Chuyển thông tin thành dữ liệu máy tính hiểu được\", \"Xóa dữ liệu\", \"Lưu trữ dữ liệu\", \"In dữ liệu\"]', '0', 'hard'),
(11, 1, 'Thông tin có đặc điểm nào sau đây?', '[\"Tính hữu ích\", \"Tính xác thực\", \"Tính thời điểm\", \"Tất cả các phương án trên\"]', '3', 'hard'),
(12, 2, 'Thiết bị thông minh là thiết bị có khả năng?', '[\"Kết nối mạng và xử lý dữ liệu tự động\", \"Chạy bằng pin\", \"Có màn hình màu\", \"Luôn đắt tiền\"]', '0', 'easy'),
(13, 2, 'Thiết bị nào sau đây KHÔNG phải là thiết bị thông minh?', '[\"Điện thoại di động\", \"Máy tính bảng\", \"Nồi cơm điện cơ (nút gạt)\", \"Đồng hồ thông minh\"]', '2', 'easy'),
(14, 2, 'Tin học đóng vai trò gì trong sự phát triển của xã hội?', '[\"Làm con người lười hơn\", \"Thúc đẩy tự động hóa và xử lý thông tin nhanh chóng\", \"Chỉ dùng để giải trí\", \"Thay thế hoàn toàn lao động chân tay\"]', '1', 'easy'),
(15, 2, 'Thiết bị nào giúp điều khiển ngôi nhà thông minh từ xa?', '[\"Smartphone\", \"Tivi thường\", \"Bàn ghế\", \"Cửa gỗ\"]', '0', 'easy'),
(16, 2, 'Cách mạng công nghiệp 4.0 đặc trưng bởi yếu tố nào?', '[\"Động cơ hơi nước\", \"Sản xuất dây chuyền\", \"Công nghệ số, AI và IoT\", \"Năng lượng nguyên tử\"]', '2', 'medium'),
(17, 2, 'Nghề nghiệp nào hiện nay cần ứng dụng mạnh mẽ của Tin học?', '[\"Y tế\", \"Giáo dục\", \"Ngân hàng\", \"Tất cả các ngành trên\"]', '3', 'medium'),
(18, 2, 'Hạn chế lớn nhất của máy tính hiện nay so với con người là?', '[\"Tính toán chậm\", \"Chưa có khả năng tư duy sáng tạo và cảm xúc như người\", \"Lưu được ít thông tin\", \"Dễ bị hỏng hơn người\"]', '1', 'medium'),
(19, 2, 'Thành tựu nào sau đây là của ngành Tin học?', '[\"Mạng xã hội\", \"Hệ thống định vị GPS\", \"Thanh toán điện tử\", \"Tất cả các phương án trên\"]', '3', 'hard'),
(20, 2, 'Internet vạn vật (IoT) có nghĩa là gì?', '[\"Mọi thiết bị đều được kết nối mạng để trao đổi dữ liệu\", \"Chỉ máy tính mới kết nối mạng\", \"Mạng dành cho người giàu\", \"Mạng dây cáp đồng xuyên lục địa\"]', '0', 'hard'),
(21, 2, 'Tin học giúp gì trong lĩnh vực quốc phòng?', '[\"Dự báo thời tiết\", \"Phát triển vũ khí thông minh và quản lý an ninh\", \"Nấu ăn cho quân đội\", \"Thay thế hoàn toàn binh lính\"]', '1', 'hard'),
(22, 2, 'Sự khác biệt lớn nhất giữa thiết bị số và thiết bị thông minh là?', '[\"Kích thước\", \"Khả năng tương tác và xử lý linh hoạt theo ngữ cảnh\", \"Độ nặng\", \"Giá thành\"]', '1', 'hard'),
(23, 3, 'Bảng mã dùng để biểu diễn các ký tự Tiếng Việt chuẩn hiện nay là?', '[\"ASCII\", \"Unicode\", \"TCVN3\", \"VNI\"]', '1', 'easy'),
(24, 3, 'Đuôi tệp văn bản thuần túy thường là?', '[\".txt\", \".mp3\", \".jpg\", \".exe\"]', '0', 'easy'),
(25, 3, 'Phần mềm nào dùng để soạn thảo văn bản phổ biến nhất?', '[\"Excel\", \"PowerPoint\", \"Microsoft Word\", \"Photoshop\"]', '2', 'easy'),
(26, 3, 'Trong bảng mã ASCII chuẩn, mỗi ký tự chiếm bao nhiêu bit?', '[\"7 bit\", \"8 bit\", \"16 bit\", \"32 bit\"]', '0', 'easy'),
(27, 3, 'Bảng mã Unicode ra đời nhằm mục đích gì?', '[\"Tiết kiệm bộ nhớ\", \"Hỗ trợ biểu diễn tất cả các ngôn ngữ trên thế giới\", \"Làm chữ đẹp hơn\", \"Tăng tốc độ máy tính\"]', '1', 'medium'),
(28, 3, 'Đơn vị đo lượng tin nhỏ nhất trong dữ liệu văn bản là?', '[\"Ký tự\", \"Từ\", \"Câu\", \"Đoạn văn\"]', '0', 'medium'),
(29, 3, 'Tệp tin .docx là định dạng của phần mềm nào?', '[\"Notepad\", \"Wordpad\", \"MS Word 2007 trở về sau\", \"Google Sheet\"]', '2', 'medium'),
(30, 3, 'Sự khác biệt giữa mã ASCII và Unicode là gì?', '[\"ASCII mã hóa được nhiều ký tự hơn\", \"Unicode dùng nhiều bit hơn để mã hóa được nhiều ký tự hơn\", \"ASCII chỉ dùng cho hình ảnh\", \"Unicode không dùng cho tiếng Anh\"]', '1', 'hard'),
(31, 3, 'Tại sao khi mở tệp văn bản đôi khi bị lỗi font (chữ lạ)?', '[\"Vì máy bị virus\", \"Do sai lệch bảng mã giữa tệp gốc và phần mềm đọc\", \"Vì màn hình hỏng\", \"Do gõ sai chính tả\"]', '1', 'hard'),
(32, 3, 'UTF-8 là một định dạng thuộc bảng mã nào?', '[\"ASCII\", \"TCVN3\", \"Unicode\", \"VNI\"]', '2', 'hard'),
(33, 3, 'Số bit tối thiểu để mã hóa 1 ký tự trong bảng mã Unicode (UTF-16) là?', '[\"8 bit\", \"16 bit\", \"32 bit\", \"64 bit\"]', '1', 'hard'),
(34, 4, 'Hệ nhị phân sử dụng các ký hiệu nào để biểu diễn dữ liệu?', '[\"0 và 1\", \"1 và 2\", \"0 đến 9\", \"A đến Z\"]', '0', 'easy'),
(35, 4, 'Số thập phân 2 được biểu diễn trong hệ nhị phân là bao nhiêu?', '[\"01\", \"10\", \"11\", \"100\"]', '1', 'easy'),
(36, 4, 'Máy tính sử dụng hệ đếm nào là chính để xử lý dữ liệu?', '[\"Hệ thập phân\", \"Hệ nhị phân\", \"Hệ bát phân\", \"Hệ thập lục phân\"]', '1', 'easy'),
(37, 4, 'Dãy 8 bit nhị phân được gọi là gì?', '[\"Kilobyte\", \"Word\", \"Byte\", \"Pixel\"]', '2', 'easy'),
(38, 4, 'Số nhị phân 101 tương ứng với giá trị nào trong hệ thập phân?', '[\"3\", \"4\", \"5\", \"6\"]', '2', 'medium'),
(39, 4, 'Phép cộng nhị phân 1 + 1 cho kết quả là?', '[\"2\", \"11\", \"10\", \"0\"]', '2', 'medium'),
(40, 4, 'Tại sao hệ nhị phân lại phù hợp với máy tính điện tử?', '[\"Vì nó có ít số\", \"Vì các linh kiện điện tử có hai trạng thái đóng/ngắt\", \"Vì nó dễ viết\", \"Vì nó tiết kiệm điện\"]', '1', 'medium'),
(41, 4, 'Để biểu diễn số nguyên âm trong máy tính, người ta thường dùng cách nào?', '[\"Dấu trừ (-)\", \"Số bù 2\", \"Màu đỏ\", \"Số thập phân\"]', '1', 'hard'),
(42, 4, 'Số nhị phân 1111 tương ứng với giá trị thập phân nào?', '[\"7\", \"15\", \"16\", \"31\"]', '1', 'hard'),
(43, 4, 'Số bit cần thiết để biểu diễn số nguyên trong phạm vi từ 0 đến 255 là?', '[\"4 bit\", \"8 bit\", \"16 bit\", \"32 bit\"]', '1', 'hard'),
(44, 4, 'Phép toán logic AND giữa hai bit 1 và 0 cho kết quả là?', '[\"1\", \"0\", \"True\", \"Lỗi\"]', '1', 'hard'),
(45, 5, 'Các giá trị lôgic trong máy tính thường được đại diện bằng hai con số nào?', '[\"1 và 2\", \"0 và 1\", \"-1 và 1\", \"1 và 10\"]', '1', 'easy'),
(46, 5, 'Phép toán lôgic NOT của giá trị \"Đúng\" (True) là gì?', '[\"Đúng\", \"Sai (False)\", \"Không xác định\", \"1\"]', '1', 'easy'),
(47, 5, 'Phép toán lôgic AND trả về kết quả \"Đúng\" khi nào?', '[\"Cả hai mệnh đề đều đúng\", \"Chỉ cần một mệnh đề đúng\", \"Cả hai mệnh đề đều sai\", \"Hai mệnh đề khác nhau\"]', '0', 'easy'),
(48, 5, 'Trong lập trình, giá trị logic thường được gọi là kiểu dữ liệu gì?', '[\"Integer\", \"Float\", \"Boolean\", \"String\"]', '2', 'easy'),
(49, 5, 'Phép toán lôgic OR trả về kết quả \"Sai\" (False) khi nào?', '[\"Cả hai đều đúng\", \"Cả hai đều sai\", \"Một đúng một sai\", \"Luôn luôn đúng\"]', '1', 'medium'),
(50, 5, 'Biểu thức (5 > 3) AND (2 < 1) cho kết quả là?', '[\"True\", \"False\", \"None\", \"Error\"]', '1', 'medium'),
(51, 5, 'Để biểu diễn một giá trị lôgic trong bộ nhớ, tối thiểu cần bao nhiêu bit?', '[\"1 bit\", \"8 bit\", \"16 bit\", \"32 bit\"]', '0', 'medium'),
(52, 5, 'Kết quả của phép toán lôgic (True OR False) AND False là?', '[\"True\", \"False\", \"1\", \"Lỗi\"]', '1', 'hard'),
(53, 5, 'Mệnh đề lôgic \"Nếu P thì Q\" chỉ sai khi nào?', '[\"P đúng và Q đúng\", \"P đúng và Q sai\", \"P sai và Q đúng\", \"P sai và Q sai\"]', '1', 'hard'),
(54, 5, 'Trong Python, biểu thức logic nào dùng để kiểm tra x thuộc khoảng (0, 10)?', '[\"x > 0 or x < 10\", \"x > 0 and x < 10\", \"0 < x < 10\", \"Cả B và C đều đúng\"]', '3', 'hard'),
(55, 5, 'Phép toán XOR (Tuyển loại) trả về True khi?', '[\"Hai giá trị giống nhau\", \"Hai giá trị khác nhau\", \"Cả hai đều True\", \"Cả hai đều False\"]', '1', 'hard'),
(56, 6, 'Đơn vị nhỏ nhất tạo nên một bức ảnh số là gì?', '[\"Bit\", \"Byte\", \"Pixel (Điểm ảnh)\", \"Inch\"]', '2', 'easy'),
(57, 6, 'Định dạng tệp tin nào sau đây là định dạng hình ảnh?', '[\".mp3\", \".txt\", \".jpg\", \".exe\"]', '2', 'easy'),
(58, 6, 'Hệ màu phổ biến nhất để hiển thị hình ảnh trên màn hình là?', '[\"CMYK\", \"RGB\", \"RYB\", \"Đen trắng\"]', '1', 'easy'),
(59, 6, 'Để số hóa âm thanh, thiết bị cần thực hiện quá trình nào?', '[\"In ấn\", \"Lấy mẫu (Sampling)\", \"Quét (Scanning)\", \"Vẽ đồ thị\"]', '1', 'easy'),
(60, 6, 'Độ sâu màu (Color Depth) 24-bit cho phép hiển thị tối đa bao nhiêu màu?', '[\"256 màu\", \"65.536 màu\", \"Khoảng 16,7 triệu màu\", \"Vô số màu\"]', '2', 'medium'),
(61, 6, 'Độ phân giải của ảnh (Resolution) thường được đo bằng đơn vị nào?', '[\"DPI\", \"PPI\", \"Pixel\", \"Tất cả các phương án\"]', '3', 'medium'),
(62, 6, 'Định dạng âm thanh .mp3 có đặc điểm gì nổi bật?', '[\"Dung lượng rất lớn\", \"Là định dạng âm thanh nén có mất dữ liệu\", \"Không thể nghe trên điện thoại\", \"Chỉ chứa văn bản\"]', '1', 'medium'),
(63, 6, 'Ảnh Vector khác ảnh Bitmap ở điểm nào?', '[\"Không bị vỡ hình khi phóng to\", \"Nhiều màu sắc hơn\", \"Dung lượng luôn lớn hơn\", \"Chỉ dùng cho ảnh chụp\"]', '0', 'hard'),
(64, 6, 'Tần số lấy mẫu (Sampling rate) càng cao thì âm thanh số sẽ?', '[\"Càng kém chất lượng\", \"Càng trung thực nhưng tệp càng nặng\", \"Càng nhỏ gọn\", \"Không thay đổi\"]', '1', 'hard'),
(65, 6, 'Một pixel trong hệ màu RGB được cấu tạo từ các màu nào?', '[\"Đỏ, Vàng, Xanh\", \"Đỏ, Lục, Lam\", \"Hồng, Xanh, Trắng\", \"Đen, Trắng, Xám\"]', '1', 'hard'),
(66, 6, 'Video số thực chất là gì?', '[\"Một tệp âm thanh dài\", \"Chuỗi các hình ảnh tĩnh được phát liên tục với tốc độ cao\", \"Một bức tranh động\", \"Sóng điện từ\"]', '1', 'hard'),
(67, 7, 'Hệ điều hành phổ biến nhất trên các dòng điện thoại thông minh hiện nay là?', '[\"Windows\", \"Android và iOS\", \"Linux\", \"MS-DOS\"]', '1', 'easy'),
(68, 7, 'Thao tác nào để mở một ứng dụng trên màn hình cảm ứng?', '[\"Vuốt\", \"Chạm (Tap)\", \"Lắc máy\", \"Nói\"]', '1', 'easy'),
(69, 7, 'Để kết nối mạng Internet không dây cự ly gần, thiết bị số dùng công nghệ?', '[\"Bluetooth\", \"Wifi\", \"4G\", \"Cáp quang\"]', '1', 'easy'),
(70, 7, 'Cửa hàng ứng dụng của hệ điều hành Android có tên là gì?', '[\"App Store\", \"Google Play (CH Play)\", \"Microsoft Store\", \"Amazon Store\"]', '1', 'easy'),
(71, 7, 'Khi muốn truyền file dung lượng nhỏ giữa hai điện thoại ở cạnh nhau, nên dùng?', '[\"Email\", \"Bluetooth/AirDrop\", \"Bưu điện\", \"Đăng lên Facebook\"]', '1', 'medium'),
(72, 7, 'Mã QR (QR Code) dùng để làm gì?', '[\"Chụp ảnh đẹp hơn\", \"Truy cập nhanh thông tin hoặc liên kết\", \"Trang trí máy\", \"Tăng tốc độ sạc pin\"]', '1', 'medium'),
(73, 7, 'Để mở rộng dung lượng lưu trữ cho điện thoại, người ta thường dùng?', '[\"Thẻ nhớ SD/MicroSD\", \"Thêm RAM\", \"Dán thêm vỏ\", \"Sạc dự phòng\"]', '0', 'medium'),
(74, 7, 'Tại sao cần đặt mật khẩu hoặc khóa vân tay cho thiết bị số?', '[\"Để máy đẹp hơn\", \"Để bảo mật thông tin cá nhân\", \"Để máy chạy nhanh hơn\", \"Để không bị mất máy\"]', '1', 'hard'),
(75, 7, 'Chế độ \"Đồ đêm\" (Night mode/Blue light filter) giúp ích gì?', '[\"Tiết kiệm pin\", \"Giảm mỏi mắt khi dùng máy trong bóng tối\", \"Làm màn hình sáng hơn\", \"Tự động tắt máy\"]', '1', 'hard'),
(76, 7, 'Việc \"Đồng bộ hóa\" (Sync) dữ liệu lên đám mây giúp?', '[\"Làm mất dữ liệu cũ\", \"Giúp truy cập dữ liệu từ nhiều thiết bị khác nhau\", \"Làm hỏng máy\", \"Tốn tiền điện\"]', '1', 'hard'),
(77, 7, 'Khi sạc pin thiết bị số, điều nào sau đây là KHÔNG nên làm?', '[\"Dùng bộ sạc chính hãng\", \"Vừa sạc vừa chơi game nặng hoặc dùng liên tục\", \"Sạc nơi thoáng mát\", \"Rút sạc khi đầy\"]', '1', 'hard'),
(78, 8, 'Mạng LAN là viết tắt của cụm từ nào?', '[\"Local Area Network\", \"Large Area Network\", \"Link Area Network\", \"Long Area Network\"]', '0', 'easy'),
(79, 8, 'Thiết bị nào dùng để kết nối các máy tính trong mạng cục bộ?', '[\"Loa\", \"Switch/Hub\", \"Chuột\", \"Bàn phím\"]', '1', 'easy'),
(80, 8, 'Internet là mạng kết nối máy tính ở quy mô nào?', '[\"Trong một phòng\", \"Trong một quốc gia\", \"Toàn cầu\", \"Chỉ một châu lục\"]', '2', 'easy'),
(81, 8, 'Phương thức kết nối Internet phổ biến cho smartphone là?', '[\"Wifi hoặc 4G/5G\", \"Sóng Radio\", \"Điện lưới\", \"Cáp điện thoại bàn\"]', '0', 'easy'),
(82, 8, 'Thiết bị Router có chức năng chính là gì?', '[\"Gõ văn bản\", \"Định tuyến và kết nối các mạng khác nhau\", \"In ấn\", \"Lưu trữ phim\"]', '1', 'medium'),
(83, 8, 'Điện toán đám mây (Cloud Computing) cung cấp dịch vụ gì?', '[\"Lưu trữ và xử lý dữ liệu qua Internet\", \"Dự báo thời tiết\", \"Làm sạch máy tính\", \"Kết nối vệ tinh\"]', '0', 'medium'),
(84, 8, 'Mạng WAN khác mạng LAN chủ yếu ở điểm nào?', '[\"Phạm vi địa lý\", \"Tốc độ chuột\", \"Màu sắc dây cáp\", \"Giá máy tính\"]', '0', 'medium'),
(85, 8, 'Mạng máy tính mang lại lợi ích gì lớn nhất?', '[\"Chia sẻ tài nguyên và thông tin\", \"Làm máy tính đẹp hơn\", \"Tăng tiền điện\", \"Hạn chế người dùng\"]', '0', 'hard'),
(86, 8, 'Dịch vụ Google Drive, OneDrive là ví dụ của?', '[\"Mạng LAN\", \"Lưu trữ đám mây\", \"Hệ điều hành\", \"Trình duyệt web\"]', '1', 'hard'),
(87, 8, 'Internet vạn vật (IoT) ứng dụng trong ngôi nhà thông minh giúp?', '[\"Điều khiển thiết bị điện từ xa\", \"Tự động tưới cây\", \"Giám sát an ninh\", \"Tất cả các phương án\"]', '3', 'hard'),
(88, 8, 'Giao thức truyền tải siêu văn bản trên mạng là?', '[\"FTP\", \"SMTP\", \"HTTP/HTTPS\", \"IP\"]', '2', 'hard'),
(89, 9, 'Virus máy tính thực chất là gì?', '[\"Một loại vi khuẩn\", \"Một đoạn mã độc phá hoại\", \"Bụi bẩn trong máy\", \"Lỗi phần cứng\"]', '1', 'easy'),
(90, 9, 'Cách đặt mật khẩu nào sau đây là an toàn nhất?', '[\"12345678\", \"Ngày sinh của bạn\", \"Mật khẩu gồm chữ hoa, chữ thường, số và ký tự đặc biệt\", \"Tên của bạn\"]', '2', 'easy'),
(91, 9, 'Phần mềm diệt virus dùng để làm gì?', '[\"Tăng tốc độ mạng\", \"Phòng ngừa và loại bỏ mã độc\", \"Làm sạch màn hình\", \"Chơi game\"]', '1', 'easy'),
(92, 9, 'Nên làm gì khi nhận được link lạ từ một người không quen biết?', '[\"Nhấp vào xem ngay\", \"Không nhấp vào và xóa tin nhắn\", \"Gửi cho bạn bè\", \"Lưu lại để sau này xem\"]', '1', 'easy'),
(93, 9, 'Hành vi lừa đảo Phishing trên mạng thường nhằm mục đích?', '[\"Tăng lượt theo dõi\", \"Chiếm đoạt tài khoản và thông tin cá nhân\", \"Tặng quà miễn phí\", \"Giúp đỡ người nghèo\"]', '1', 'medium'),
(94, 9, 'Tại sao không nên công khai thông tin cá nhân như địa chỉ, căn cước lên mạng?', '[\"Vì tốn bộ nhớ\", \"Tránh bị kẻ xấu lợi dụng lừa đảo hoặc tống tiền\", \"Để người khác không biết mình ở đâu\", \"Vì nó không đẹp\"]', '1', 'medium'),
(95, 9, 'Bắt nạt qua mạng (Cyberbullying) nên được xử lý thế nào?', '[\"Chửi lại mạnh hơn\", \"Im lặng chịu đựng\", \"Chặn người đó và báo cáo cho người lớn hoặc cơ quan chức năng\", \"Hẹn gặp ngoài đời để đánh nhau\"]', '2', 'medium'),
(96, 9, 'Tính năng \"Tường lửa\" (Firewall) có tác dụng gì?', '[\"Chống cháy máy tính\", \"Kiểm soát và ngăn chặn truy cập mạng trái phép\", \"Làm máy tính chạy nhanh hơn\", \"Diệt virus hoàn toàn\"]', '1', 'hard'),
(97, 9, 'Khi sử dụng Wifi công cộng để giao dịch ngân hàng, nguy cơ lớn nhất là gì?', '[\"Mạng bị chậm\", \"Bị nghe lén và đánh cắp thông tin tài khoản\", \"Tốn pin điện thoại\", \"Bị quảng cáo làm phiền\"]', '1', 'hard'),
(98, 9, 'Dấu hiệu nào cho thấy máy tính có thể bị nhiễm mã độc?', '[\"Máy chạy nhanh hơn\", \"Hay hiện quảng cáo lạ, máy chậm bất thường, file bị mất\", \"Màn hình sáng hơn\", \"Âm thanh to hơn\"]', '1', 'hard'),
(99, 9, 'Phần mềm gián điệp (Spyware) có đặc điểm gì?', '[\"Luôn hiện thông báo cho người dùng\", \"Âm thầm thu thập thông tin người dùng gửi về cho kẻ xấu\", \"Giúp bảo mật máy tính\", \"Là một loại trò chơi\"]', '1', 'hard'),
(100, 10, 'Máy tìm kiếm phổ biến nhất hiện nay là gì?', '[\"Facebook\", \"Google\", \"Zalo\", \"Shopee\"]', '1', 'easy'),
(101, 10, 'Từ khóa tìm kiếm (Keyword) nên được chọn như thế nào?', '[\"Dài và đầy đủ các từ nối\", \"Ngắn gọn và đúng nội dung cần tìm\", \"Chỉ dùng tiếng Anh\", \"Không quan trọng\"]', '1', 'easy'),
(102, 10, 'Để tìm kiếm thông tin về một bài học trên mạng, em nên gõ gì?', '[\"Gõ tên bài học vào ô tìm kiếm\", \"Gõ địa chỉ nhà mình\", \"Gõ mật khẩu Facebook\", \"Gõ số điện thoại\"]', '0', 'easy'),
(103, 10, 'Khi lấy thông tin từ một trang web để làm bài thuyết trình, em cần?', '[\"Sao chép y hệt không cần sửa\", \"Ghi rõ nguồn trích dẫn từ trang web đó\", \"Tự nhận là mình viết\", \"Xóa hết tên tác giả\"]', '1', 'easy'),
(104, 10, 'Google Translate là công cụ dùng để làm gì?', '[\"Tìm đường\", \"Dịch ngôn ngữ\", \"Xem phim\", \"Nghe nhạc\"]', '1', 'medium'),
(105, 10, 'Kết quả tìm kiếm trên Google thường được hiển thị dưới dạng?', '[\"Một bức ảnh\", \"Danh sách các đường liên kết (link)\", \"Một đoạn video\", \"Một bản nhạc\"]', '1', 'medium'),
(106, 10, 'Kỹ năng nào quan trọng nhất khi đánh giá thông tin trên Internet?', '[\"Gõ phím nhanh\", \"Kiểm chứng nguồn tin và tính xác thực\", \"Tải dữ liệu nhanh\", \"Chia sẻ tin tức thật nhiều\"]', '1', 'medium'),
(107, 10, 'Sử dụng công cụ \"Tìm kiếm hình ảnh\" giúp em tìm được gì?', '[\"Các tệp âm thanh\", \"Các hình ảnh liên quan đến từ khóa\", \"Các tệp văn bản\", \"Các phần mềm\"]', '1', 'hard'),
(108, 10, 'Tại sao không phải thông tin nào trên Internet cũng là đúng?', '[\"Vì máy tính bị lỗi\", \"Vì bất kỳ ai cũng có thể đăng tin lên mạng\", \"Vì mạng bị chậm\", \"Vì Internet là miễn phí\"]', '1', 'hard'),
(109, 10, 'Dịch vụ bản đồ số như Google Maps giúp ích gì?', '[\"Tìm đường và xem vị trí địa lý\", \"Mua sắm quần áo\", \"Nấu ăn\", \"Dịch văn bản\"]', '0', 'hard'),
(110, 10, 'Để lưu trữ một trang web về máy xem lại sau, em có thể dùng tính năng?', '[\"Dấu trang (Bookmark)\", \"Xóa lịch sử\", \"Tắt trình duyệt\", \"Quét virus\"]', '0', 'hard'),
(111, 13, 'Trong Inkscape, công cụ nào dùng để vẽ hình chữ nhật, hình vuông?', '[\"Công cụ Pen\", \"Công cụ Rectangle\", \"Công cụ Circle\", \"Công cụ Star\"]', '1', 'easy'),
(112, 13, 'Để vẽ một hình tròn hoàn hảo thay vì hình bầu dục, em nhấn giữ phím nào?', '[\"Shift\", \"Alt\", \"Ctrl\", \"Space\"]', '2', 'easy'),
(113, 13, 'Lệnh nào dùng để nhân đôi một đối tượng trong Inkscape?', '[\"Ctrl + C\", \"Ctrl + D\", \"Ctrl + V\", \"Ctrl + X\"]', '1', 'easy'),
(114, 13, 'Để tô màu cho đối tượng, em sử dụng bảng màu ở đâu?', '[\"Phía trên màn hình\", \"Phía dưới màn hình\", \"Bên phải màn hình\", \"Bên trái màn hình\"]', '1', 'easy'),
(115, 13, 'Phép toán Union trong Inkscape dùng để làm gì?', '[\"Gộp hai hay nhiều đối tượng thành một\", \"Lấy phần giao\", \"Cắt đối tượng\", \"Xóa đối tượng\"]', '0', 'medium'),
(116, 13, 'Để thay đổi độ dày của đường viền đối tượng, em chỉnh trong bảng nào?', '[\"Fill\", \"Stroke style\", \"Stroke paint\", \"Object\"]', '1', 'medium'),
(117, 13, 'Công cụ \"Create and edit stars and polygons\" dùng để vẽ gì?', '[\"Hình tròn\", \"Hình sao và hình đa giác\", \"Đường thẳng\", \"Văn bản\"]', '1', 'medium'),
(118, 13, 'Sự khác biệt giữa Group (Nhóm) và Union (Hợp) là gì?', '[\"Không có gì khác\", \"Group có thể rã nhóm, Union thì các đối tượng đã hòa làm một\", \"Group làm tệp nặng hơn\", \"Union chỉ dùng cho hình vuông\"]', '1', 'hard'),
(119, 13, 'Lệnh Intersection (Ctrl + *) thực hiện phép toán gì?', '[\"Lấy phần chung của các đối tượng\", \"Xóa phần chung\", \"Lấy tất cả các phần\", \"Chia nhỏ đối tượng\"]', '0', 'hard'),
(120, 13, 'Lệnh Difference (Ctrl + -) thực hiện phép toán gì?', '[\"Hợp hai hình\", \"Lấy phần hình dưới trừ đi hình trên\", \"Lấy phần giao\", \"Đảo ngược màu\"]', '1', 'hard'),
(121, 13, 'Khi muốn di chuyển một đối tượng ra phía sau cùng, ta dùng lệnh?', '[\"End\", \"Home\", \"Page Up\", \"Page Down\"]', '0', 'hard'),
(122, 14, 'Để vẽ đường cong tự do hoặc đường thẳng trong Inkscape, ta dùng công cụ?', '[\"Pen (Bezier)\", \"Rectangle\", \"Text\", \"Eraser\"]', '0', 'easy'),
(123, 14, 'Công cụ nào dùng để chèn văn bản vào bản thiết kế?', '[\"Công cụ Pen\", \"Công cụ Text (A)\", \"Công cụ Zoom\", \"Công cụ Selector\"]', '1', 'easy'),
(124, 14, 'Trong đồ họa Vector, đường được tạo thành từ các yếu tố nào?', '[\"Các điểm ảnh\", \"Các điểm neo (Node) và đường nối\", \"Màu sắc\", \"Ký tự\"]', '1', 'easy'),
(125, 14, 'Để chỉnh sửa các điểm neo trên một đường, ta dùng công cụ?', '[\"Selector\", \"Node Tool (N)\", \"Pen\", \"Eraser\"]', '1', 'easy'),
(126, 14, 'Lệnh \"Path > Object to Path\" dùng để làm gì?', '[\"Xóa đối tượng\", \"Chuyển một hình cơ bản thành đường để sửa từng điểm neo\", \"Đổi màu\", \"Lưu tệp\"]', '1', 'medium'),
(127, 14, 'Làm thế nào để viết chữ chạy theo một đường cong có sẵn?', '[\"Gõ chữ rồi xoay\", \"Chọn cả chữ và đường rồi dùng lệnh Put on Path\", \"Dùng công cụ Pen vẽ chữ\", \"Không làm được\"]', '1', 'medium'),
(128, 14, 'Để thay đổi font chữ và kích thước chữ, em dùng bảng điều khiển ở đâu?', '[\"Bên dưới màn hình\", \"Thanh điều khiển thuộc tính phía trên\", \"Bảng màu\", \"Cửa sổ Layer\"]', '1', 'medium'),
(129, 14, 'Đường Bezier là gì?', '[\"Đường thẳng tắp\", \"Đường cong mượt mà được định nghĩa bằng các thuật toán\", \"Đường nét đứt\", \"Đường kẻ bằng tay\"]', '1', 'hard'),
(130, 14, 'Điểm neo dạng \"Smooth node\" có đặc điểm gì?', '[\"Tạo ra góc nhọn\", \"Tạo ra đường cong mềm mại tại điểm đó\", \"Làm mất đường nối\", \"Chỉ dùng cho hình vuông\"]', '1', 'hard'),
(131, 14, 'Lệnh \"Text > Flow into frame\" giúp ích gì?', '[\"Làm chữ biến mất\", \"Đổ văn bản vào trong một hình khép kín\", \"Đổi màu chữ\", \"Kiểm tra chính tả\"]', '1', 'hard'),
(132, 14, 'Khi vẽ bằng công cụ Pen, nhấn giữ phím nào để vẽ đường thẳng nằm ngang hoặc dọc?', '[\"Shift\", \"Ctrl\", \"Alt\", \"Tab\"]', '1', 'hard'),
(133, 15, 'Để xuất bản vẽ Inkscape ra định dạng ảnh thông thường để xem, ta dùng lệnh?', '[\"Save\", \"Export PNG Image\", \"Print\", \"Cut\"]', '1', 'easy'),
(134, 15, 'Lớp (Layer) trong thiết kế đồ họa giúp ích gì?', '[\"Làm tệp nhẹ hơn\", \"Quản lý các đối tượng riêng biệt dễ dàng hơn\", \"Xóa đối tượng nhanh\", \"Tăng độ sáng cho ảnh\"]', '1', 'easy'),
(135, 15, 'Khi một đối tượng bị che khuất, em cần làm gì để nó hiện lên trên?', '[\"Xóa hình che\", \"Thay đổi thứ tự lớp hoặc dùng lệnh Raise to Top\", \"Đổi màu hình che\", \"Tắt máy\"]', '1', 'easy'),
(136, 15, 'Định dạng .png thường được dùng để xuất ảnh vì ưu điểm?', '[\"Dung lượng cực lớn\", \"Hỗ trợ nền trong suốt\", \"Không có màu\", \"Chỉ xem được trên tivi\"]', '1', 'easy'),
(137, 15, 'Tính năng Opacity của đối tượng dùng để chỉnh?', '[\"Kích thước\", \"Độ trong suốt\", \"Màu sắc\", \"Vị trí\"]', '1', 'medium'),
(138, 15, 'Để căn lề các đối tượng thẳng hàng nhau, em dùng bảng nào?', '[\"Fill and Stroke\", \"Align and Distribute\", \"Layers\", \"Text and Font\"]', '1', 'medium'),
(139, 15, 'Lệnh \"Duplicate\" khác lệnh \"Copy\" ở điểm nào?', '[\"Duplicate không dùng được\", \"Duplicate nhân bản tại chỗ, Copy cần lệnh Paste\", \"Copy nhanh hơn\", \"Không có gì khác\"]', '1', 'medium'),
(140, 15, 'Trước khi xuất ảnh, việc \"Group\" các đối tượng lại giúp?', '[\"Làm ảnh đẹp hơn\", \"Tránh việc di chuyển nhầm các chi tiết nhỏ\", \"Giảm số lượng màu\", \"Tăng độ phân giải\"]', '1', 'hard'),
(141, 15, 'Khi xuất ảnh PNG, thông số DPI ảnh hưởng đến?', '[\"Màu sắc\", \"Độ sắc nét và kích thước tệp\", \"Tên tệp\", \"Ngày tháng năm\"]', '1', 'hard'),
(142, 15, 'Bộ lọc (Filters) trong Inkscape dùng để?', '[\"Vẽ hình mới\", \"Tạo các hiệu ứng đặc biệt cho đối tượng\", \"Sửa lỗi chính tả\", \"Kết nối mạng\"]', '1', 'hard'),
(143, 15, 'Để đảm bảo bản thiết kế không bị mất khi máy hỏng, em nên?', '[\"Không cần làm gì\", \"Thường xuyên dùng lệnh Save (Ctrl + S)\", \"Tắt máy liên tục\", \"In ra giấy\"]', '1', 'hard'),
(144, 11, 'Hành vi nào sau đây là thiếu văn hóa khi giao tiếp trên mạng?', '[\"Tôn trọng ý kiến khác biệt\", \"Sử dụng ngôn ngữ lịch sự\", \"Công kích, nói xấu người khác\", \"Trích dẫn nguồn thông tin\"]', '2', 'easy'),
(145, 11, 'Bản quyền phần mềm thuộc loại quyền sở hữu nào?', '[\"Sở hữu trí tuệ\", \"Sở hữu vật chất\", \"Sở hữu công cộng\", \"Sở hữu tạm thời\"]', '0', 'easy'),
(146, 11, 'Khi sử dụng nội dung từ Internet vào bài làm, ta cần thực hiện điều gì?', '[\"Xóa tên tác giả gốc\", \"Ghi rõ nguồn và tên tác giả\", \"Tự nhận là của mình\", \"Thay đổi nội dung rồi dùng\"]', '1', 'easy'),
(147, 11, 'Phần mềm bẻ khóa (crack) vi phạm điều gì?', '[\"Quy định nhà trường\", \"Luật Sở hữu trí tuệ\", \"Chính sách nhà mạng\", \"Không vi phạm gì\"]', '1', 'easy'),
(148, 11, 'Hành động nào giúp bảo vệ thông tin cá nhân trên mạng xã hội?', '[\"Công khai số điện thoại\", \"Chia sẻ mật khẩu với bạn thân\", \"Sử dụng chế độ riêng tư\", \"Đăng ảnh căn cước công dân\"]', '2', 'medium'),
(149, 11, 'Nghĩa vụ tôn trọng bản quyền có ý nghĩa gì đối với xã hội?', '[\"Gây khó khăn cho người nghèo\", \"Khuyến khích sự sáng tạo và phát triển công nghệ\", \"Làm tốn kém chi phí\", \"Hạn chế việc chia sẻ thông tin\"]', '1', 'medium'),
(150, 11, 'Hành vi \"Bắt nạt qua mạng\" (Cyberbullying) có thể gây ra hậu quả gì?', '[\"Tăng sự nổi tiếng\", \"Gây tổn thương tâm lý nghiêm trọng cho nạn nhân\", \"Giúp nạn nhân mạnh mẽ hơn\", \"Không có hậu quả gì\"]', '1', 'medium'),
(151, 11, 'Khái niệm \"Dấu chân số\" (Digital Footprint) được hiểu là?', '[\"Kích thước chân của bạn\", \"Mọi dấu vết hoạt động của bạn trên không gian mạng\", \"Địa chỉ nhà của bạn\", \"Tốc độ di chuyển chuột\"]', '1', 'hard'),
(152, 11, 'Tại sao việc phát tán tin giả trên mạng lại nguy hiểm?', '[\"Làm nghẽn mạng\", \"Gây hoang mang dư luận và ảnh hưởng đến an ninh trật tự\", \"Làm hỏng máy tính\", \"Tốn dung lượng lưu trữ\"]', '1', 'hard'),
(153, 11, 'Quyền tác giả đối với tác phẩm văn học, nghệ thuật phát sinh từ khi nào?', '[\"Khi tác phẩm được công bố\", \"Khi tác phẩm được sáng tạo và thể hiện dưới một hình thức vật chất nhất định\", \"Khi được cấp bằng sáng chế\", \"Khi tác phẩm bán được tiền\"]', '1', 'hard'),
(154, 11, 'Sử dụng phần mềm tự do (Free Software) có nghĩa là gì?', '[\"Được quyền chạy, sao chép, nghiên cứu và sửa đổi\", \"Không được phép thay đổi mã nguồn\", \"Phải trả tiền bản quyền\", \"Chỉ được dùng thử 30 ngày\"]', '0', 'hard'),
(155, 12, 'Thiết kế đồ họa máy tính được chia làm mấy loại chính?', '[\"2 loại (Bitmap và Vector)\", \"3 loại\", \"4 loại\", \"5 loại\"]', '0', 'easy'),
(156, 12, 'Inkscape là phần mềm dùng để xử lý loại đồ họa nào?', '[\"Đồ họa Bitmap\", \"Đồ họa Vector\", \"Đồ họa 3D\", \"Xử lý video\"]', '1', 'easy'),
(157, 12, 'Đặc điểm nổi bật của đồ họa Vector là gì?', '[\"Hình ảnh bị vỡ khi phóng to\", \"Hình ảnh không bị vỡ khi phóng to\", \"Dung lượng tệp rất lớn\", \"Phù hợp cho ảnh chụp kỹ thuật số\"]', '1', 'easy'),
(158, 12, 'Tệp tin thiết kế của Inkscape mặc định có đuôi mở rộng là gì?', '[\".jpg\", \".png\", \".svg\", \".bmp\"]', '2', 'easy'),
(159, 12, 'Để chọn một đối tượng trong Inkscape, ta dùng công cụ nào?', '[\"Công cụ Pen\", \"Công cụ Selector (mũi tên)\", \"Công cụ Zoom\", \"Công cụ Text\"]', '1', 'medium'),
(160, 12, 'Khi phóng to một bức ảnh Bitmap quá mức, hiện tượng gì sẽ xảy ra?', '[\"Hình ảnh biến mất\", \"Hình ảnh vẫn sắc nét\", \"Hình ảnh bị răng cưa (vỡ ảnh)\", \"Màu sắc bị thay đổi\"]', '2', 'medium'),
(161, 12, 'Đối tượng đồ họa Vector được cấu tạo từ yếu tố nào?', '[\"Các điểm ảnh (pixel)\", \"Các đối tượng hình học (điểm, đường, đường cong)\", \"Các khối đa diện\", \"Các sóng âm\"]', '1', 'medium'),
(162, 12, 'Phần mềm nào sau đây là phần mềm đồ họa Bitmap chuyên nghiệp?', '[\"Inkscape\", \"Adobe Photoshop\", \"CorelDraw\", \"Adobe Illustrator\"]', '1', 'hard'),
(163, 12, 'Trong Inkscape, phím tắt nào dùng để nhóm các đối tượng lại với nhau?', '[\"Ctrl + G\", \"Ctrl + U\", \"Ctrl + C\", \"Ctrl + Z\"]', '0', 'hard'),
(164, 12, 'Thuộc tính Fill của một đối tượng trong thiết kế đồ họa dùng để?', '[\"Tô màu đường viền\", \"Tô màu nền bên trong đối tượng\", \"Thay đổi kích thước\", \"Xóa đối tượng\"]', '1', 'hard'),
(165, 12, 'Tại sao biểu trưng (Logo) thường được thiết kế dưới dạng đồ họa Vector?', '[\"Vì nó nhiều màu hơn\", \"Vì dễ dàng in ấn ở mọi kích thước mà không mất chất lượng\", \"Vì tệp nhỏ hơn\", \"Vì dễ vẽ hơn\"]', '1', 'hard'),
(166, 17, 'Lệnh gán giá trị cho biến trong Python sử dụng dấu nào?', '[\"==\", \":=\", \"=\", \"->\"]', '2', 'easy'),
(167, 17, 'Tên biến nào sau đây là HỢP LỆ trong Python?', '[\"1_bien\", \"bien_1\", \"bien 1\", \"if\"]', '1', 'easy'),
(168, 17, 'Phép toán lũy thừa (số mũ) trong Python ký hiệu là?', '[\"^\", \"**\", \"*\", \"//\"]', '1', 'easy'),
(169, 17, 'Để tính phần nguyên của phép chia, ta dùng ký hiệu nào?', '[\"/\", \"//\", \"%\", \"div\"]', '1', 'easy'),
(170, 17, 'Kết quả của phép toán 10 % 3 là bao nhiêu?', '[\"3\", \"3.33\", \"1\", \"0\"]', '2', 'medium'),
(171, 17, 'Biến trong Python có cần khai báo kiểu dữ liệu trước không?', '[\"Có\", \"Không\", \"Tùy môi trường\", \"Chỉ với số thực\"]', '1', 'medium'),
(172, 17, 'Sau lệnh x = 5; x = x + 2, giá trị của x là?', '[\"5\", \"2\", \"7\", \"Lỗi\"]', '2', 'medium'),
(173, 17, 'Lệnh gán đa biến x, y = 1, 2 có nghĩa là gì?', '[\"x=1, y=1\", \"x=2, y=1\", \"x=1, y=2\", \"Lỗi\"]', '2', 'hard'),
(174, 17, 'Kiểu dữ liệu của x sau lệnh x = \"10\" là gì?', '[\"int\", \"float\", \"str\", \"bool\"]', '2', 'hard'),
(175, 17, 'Biểu thức 2 ** 3 ** 2 trong Python trả về bao nhiêu?', '[\"64\", \"512\", \"18\", \"Lỗi\"]', '1', 'hard'),
(176, 17, 'Lệnh x = y = z = 0 thực hiện điều gì?', '[\"Gán 0 cho cả 3 biến\", \"Báo lỗi\", \"Chỉ gán cho z\", \"Gán cho x\"]', '0', 'hard'),
(177, 18, 'Hàm nào dùng để nhập dữ liệu từ bàn phím?', '[\"print()\", \"input()\", \"read()\", \"scan()\"]', '1', 'easy'),
(178, 18, 'Hàm input() luôn trả về dữ liệu kiểu gì?', '[\"Số nguyên\", \"Số thực\", \"Xâu ký tự\", \"Logic\"]', '2', 'easy'),
(179, 18, 'Để chuyển đổi xâu sang số nguyên, ta dùng hàm?', '[\"float()\", \"int()\", \"str()\", \"bool()\"]', '1', 'easy'),
(180, 18, 'Hàm dùng để xem kiểu dữ liệu của biến là?', '[\"check()\", \"type()\", \"kind()\", \"class()\"]', '1', 'easy'),
(181, 18, 'Lệnh n = int(input(\"Nhập n: \")) dùng để làm gì?', '[\"Nhập xâu\", \"Nhập và chuyển đổi sang số nguyên\", \"In số nguyên\", \"Lỗi\"]', '1', 'medium'),
(182, 18, 'Tham số \"end\" trong lệnh print() dùng để?', '[\"Ngắt dòng\", \"Xác định ký tự kết thúc (mặc định xuống dòng)\", \"Xóa dữ liệu\", \"Dừng\"]', '1', 'medium'),
(183, 18, 'Kết quả của int(7.9) là bao nhiêu?', '[\"7\", \"8\", \"7.9\", \"Lỗi\"]', '0', 'medium'),
(184, 18, 'Biểu thức float(\"3.14\") * 2 cho kết quả?', '[\"6.28\", \"3.143.14\", \"Lỗi\", \"6\"]', '0', 'hard'),
(185, 18, 'Để in nhiều giá trị cách nhau bởi dấu sao, dùng tham số nào?', '[\"end\", \"sep\", \"split\", \"join\"]', '1', 'hard'),
(186, 18, 'Lệnh print(int(True)) in ra giá trị nào?', '[\"True\", \"0\", \"1\", \"Lỗi\"]', '2', 'hard'),
(187, 18, 'Lệnh nào sau đây sẽ bị báo lỗi ValueError?', '[\"int(10.5)\", \"int(\"10\")\", \"int(\"abc\")\", \"float(5)\"]', '2', 'hard'),
(188, 19, 'Cấu trúc rẽ nhánh dạng thiếu là?', '[\"if điều kiện\", \"if điều kiện :\", \"if điều kiện then\", \"if điều kiện do\"]', '1', 'easy'),
(189, 19, 'Ký hiệu so sánh bằng trong Python là?', '[\"=\", \"==\", \"===\", \":=\"]', '1', 'easy'),
(190, 19, 'Khối lệnh sau if phải được trình bày như thế nào?', '[\"Viết sát lề trái\", \"Thụt lề vào trong\", \"Viết trong ngoặc nhọn\", \"Viết hoa\"]', '1', 'easy'),
(191, 19, 'Từ khóa rẽ nhánh nhiều trường hợp là?', '[\"else if\", \"elif\", \"case\", \"switch\"]', '1', 'easy'),
(192, 19, 'Phép toán so sánh \"khác\" ký hiệu là?', '[\"<>\", \"!=\", \"not\", \"^=\"]', '1', 'medium'),
(193, 19, 'Kết quả của (5 > 3) and (2 > 4) là?', '[\"True\", \"False\", \"None\", \"Error\"]', '1', 'medium'),
(194, 19, 'Lệnh \"else\" thực hiện khi nào?', '[\"If đúng\", \"If sai\", \"Luôn thực hiện\", \"Khi có lỗi\"]', '1', 'medium'),
(195, 19, 'Điều kiện n % 2 == 0 dùng để kiểm tra gì?', '[\"Số lẻ\", \"Số chẵn\", \"Số dương\", \"Số nguyên tố\"]', '1', 'hard'),
(196, 19, 'Biểu thức 0 < x < 10 trong Python có hợp lệ không?', '[\"Hợp lệ\", \"Không hợp lệ\", \"Báo lỗi\", \"Chỉ đúng trong C++\"]', '0', 'hard'),
(197, 19, 'Kết quả: a=10; b=5; if a > b: print(a-b) else: print(a+b)', '[\"15\", \"5\", \"10\", \"50\"]', '1', 'hard'),
(198, 19, 'Phép toán logic nào ưu tiên cao nhất?', '[\"and\", \"or\", \"not\", \"Bằng nhau\"]', '2', 'hard'),
(199, 20, 'Vòng lặp for thường dùng khi nào?', '[\"Số lần chưa biết\", \"Số lần biết trước\", \"Vô hạn\", \"Không lặp\"]', '1', 'easy'),
(200, 20, 'Hàm range(5) tạo dãy số nào?', '[\"1-5\", \"0-4\", \"0-5\", \"5-1\"]', '1', 'easy'),
(201, 20, 'Cú pháp chuẩn vòng lặp for?', '[\"for i to n:\", \"for i in range(n):\", \"for i range(n)\", \"loop:\"]', '1', 'easy'),
(202, 20, 'Lệnh dừng vòng lặp ngay lập tức?', '[\"exit\", \"stop\", \"break\", \"continue\"]', '2', 'easy'),
(203, 20, 'Hàm range(1, 10, 2) tạo dãy nào?', '[\"1-10\", \"1, 3, 5, 7, 9\", \"2-10\", \"1, 10, 2\"]', '1', 'medium'),
(204, 20, 'Lệnh \"for i in range(3): print(i)\" in ra?', '[\"1 2 3\", \"0 1 2\", \"0 1 2 3\", \"3 2 1\"]', '1', 'medium'),
(205, 20, 'Lệnh bỏ qua lần lặp hiện tại?', '[\"break\", \"skip\", \"continue\", \"pass\"]', '2', 'medium'),
(206, 20, 'Kết quả: s=0; for i in range(1, 4): s += i; print(s)', '[\"3\", \"6\", \"10\", \"0\"]', '1', 'hard'),
(207, 20, 'Lệnh range(5, 0, -1) cho kết quả?', '[\"5 4 3 2 1\", \"0-5\", \"Rỗng\", \"Lỗi\"]', '0', 'hard'),
(208, 20, 'Vòng lặp for i in \"ABC\": thực hiện mấy lần?', '[\"1\", \"2\", \"3\", \"0\"]', '2', 'hard'),
(209, 20, 'Cấu trúc for có thể đi kèm khối lệnh nào?', '[\"then\", \"do\", \"else\", \"until\"]', '2', 'hard'),
(210, 21, 'Vòng lặp while kết thúc khi nào?', '[\"Điều kiện Đúng\", \"Điều kiện Sai\", \"Đủ 10 lần\", \"Luôn chạy\"]', '1', 'easy'),
(211, 21, 'Lặp với số lần chưa biết trước là?', '[\"Đánh răng 2 lần\", \"Học đến khi thuộc\", \"Đi 100 bước\", \"Ăn 3 bát\"]', '1', 'easy'),
(212, 21, 'Nếu điều kiện luôn Đúng, while sẽ?', '[\"Dừng\", \"Vô hạn\", \"Báo lỗi\", \"Tự tắt\"]', '1', 'easy'),
(213, 21, 'Để thoát while True, dùng lệnh?', '[\"exit\", \"break\", \"continue\", \"stop\"]', '1', 'easy'),
(214, 21, 'Cấu trúc while thiếu dấu gì sẽ lỗi?', '[\"Dấu phẩy\", \"Chấm phẩy\", \"Hai chấm\", \"Ngoặc đơn\"]', '2', 'medium'),
(215, 21, 'Kết quả: i=1; while i < 4: print(i); i+=1', '[\"1 2 3\", \"1 2 3 4\", \"0 1 2 3\", \"Vô hạn\"]', '0', 'medium'),
(216, 21, 'While kiểm tra điều kiện khi nào?', '[\"Sau khi lặp\", \"Trước khi lặp\", \"Trong khi lặp\", \"Không kiểm tra\"]', '1', 'medium'),
(217, 21, 'Lệnh while False: thực hiện mấy lần?', '[\"0\", \"1\", \"Vô hạn\", \"Lỗi\"]', '0', 'hard'),
(218, 21, 'Sự khác biệt chính giữa for và while?', '[\"Tốc độ\", \"Cách xác định số lần lặp\", \"Thụt lề\", \"Biến chạy\"]', '1', 'hard'),
(219, 21, 'Kết quả: n=5; while n>0: n-=2; print(n)', '[\"3 1 -1\", \"-1\", \"1\", \"Vô hạn\"]', '1', 'hard'),
(220, 21, 'While có thể có khối else không?', '[\"Có\", \"Không\", \"Tùy bản Python\", \"Chỉ với số\"]', '0', 'hard'),
(221, 22, 'Danh sách trong Python bao quanh bởi?', '[\"()\", \"{}\", \"[]\", \"<>\"]', '2', 'easy'),
(222, 22, 'Chỉ số phần tử đầu tiên là?', '[\"1\", \"0\", \"-1\", \"Tùy ý\"]', '1', 'easy'),
(223, 22, 'Lệnh xem số phần tử danh sách a?', '[\"size(a)\", \"len(a)\", \"count(a)\", \"length(a)\"]', '1', 'easy'),
(224, 22, 'Khai báo danh sách rỗng?', '[\"a = []\", \"a = list()\", \"Cả hai đúng\", \"Cả hai sai\"]', '2', 'easy'),
(225, 22, 'Kết quả [1, 2] + [3, 4]?', '[\"[4, 6]\", \"[1, 2, 3, 4]\", \"[[1, 2], [3, 4]]\", \"Lỗi\"]', '1', 'medium'),
(226, 22, 'Truy cập phần tử cuối của a?', '[\"len(a)\", \"0\", \"-1\", \"last\"]', '2', 'medium'),
(227, 22, 'Lệnh 2 in [1, 2, 3] trả về?', '[\"True\", \"False\", \"2\", \"Lỗi\"]', '0', 'medium'),
(228, 22, 'Phép toán [1, 2] * 2 kết quả?', '[\"[2, 4]\", \"[1, 2, 1, 2]\", \"[1, 1, 2, 2]\", \"Lỗi\"]', '1', 'hard'),
(229, 22, 'Chỉ số của phần tử cuối danh sách a là?', '[\"len(a)\", \"len(a)-1\", \"len(a)+1\", \"0\"]', '1', 'hard'),
(230, 22, 'Danh sách có thể chứa nhiều kiểu dữ liệu khác nhau không?', '[\"Có\", \"Không\", \"Chỉ số và xâu\", \"Chỉ số thực\"]', '0', 'hard'),
(231, 22, 'Lệnh list(\"abc\") trả về?', '[\"abc\", \"[\"a\", \"b\", \"c\"]\", \"[\"abc\"]\", \"Lỗi\"]', '1', 'hard'),
(232, 23, 'Thêm phần tử vào cuối danh sách dùng?', '[\"add()\", \"append()\", \"insert()\", \"push()\"]', '1', 'easy'),
(233, 23, 'Xóa phần tử theo giá trị x đầu tiên?', '[\"del\", \"remove(x)\", \"pop()\", \"clear()\"]', '1', 'easy'),
(234, 23, 'Xóa phần tử theo chỉ số i?', '[\"del a[i]\", \"pop(i)\", \"Cả hai đúng\", \"Cả hai sai\"]', '2', 'easy'),
(235, 23, 'Phương thức làm trống danh sách?', '[\"del\", \"clear()\", \"remove()\", \"pop()\"]', '1', 'easy'),
(236, 23, 'Lệnh a.insert(1, 5) có nghĩa là?', '[\"Chèn 5 vào vị trí 1\", \"Thêm 5 vào cuối\", \"Xóa 1\", \"Thay 1 bằng 5\"]', '0', 'medium'),
(237, 23, 'Lệnh a.pop() không tham số sẽ xóa?', '[\"Phần tử đầu\", \"Phần tử cuối\", \"Cả danh sách\", \"Lỗi\"]', '1', 'medium'),
(238, 23, 'Sắp xếp danh sách a tăng dần dùng?', '[\"sort()\", \"arrange()\", \"order()\", \"sorted\"]', '0', 'medium'),
(239, 23, 'Lệnh a.count(x) dùng để?', '[\"Xóa x\", \"Đếm số lần x xuất hiện\", \"Tìm vị trí x\", \"Thêm x\"]', '1', 'hard'),
(240, 23, 'Lệnh a.index(x) trả về gì?', '[\"Số lượng x\", \"Vị trí đầu tiên của x\", \"Xóa x\", \"True/False\"]', '1', 'hard'),
(241, 23, 'Lệnh a.reverse() dùng để?', '[\"Sắp xếp\", \"Đảo ngược danh sách\", \"Xóa danh sách\", \"Sao chép\"]', '1', 'hard'),
(242, 23, 'Kết quả: a=[1]; b=a; b.append(2); print(a)', '[\"[1]\", \"[1, 2]\", \"[2]\", \"Lỗi\"]', '1', 'hard'),
(243, 24, 'Xâu kí tự trong Python được đặt trong cặp dấu nào?', '[\"Ngoặc đơn\", \"Nháy đơn hoặc nháy kép\", \"Ngoặc vuông\", \"Dấu gạch chéo\"]', '1', 'easy'),
(244, 24, 'Lệnh nào dùng để biết chiều dài (số kí tự) của xâu s?', '[\"len(s)\", \"size(s)\", \"count(s)\", \"length(s)\"]', '0', 'easy'),
(245, 24, 'Phép toán nối hai xâu \"Tin\" + \"Học\" cho kết quả là?', '[\"Tin Học\", \"TinHọc\", \"Tìnhọc\", \"Lỗi\"]', '1', 'easy'),
(246, 24, 'Chỉ số (index) của kí tự đầu tiên trong một xâu là?', '[\"1\", \"0\", \"-1\", \"Tùy ý\"]', '1', 'easy'),
(247, 24, 'Kết quả của lệnh \"Python\"[1] là gì?', '[\"P\", \"y\", \"t\", \"n\"]', '1', 'medium'),
(248, 24, 'Để truy cập kí tự cuối cùng của xâu s, ta có thể dùng chỉ số nào?', '[\"0\", \"1\", \"-1\", \"len(s)\"]', '2', 'medium'),
(249, 24, 'Xâu kí tự trong Python có đặc điểm nào sau đây?', '[\"Có thể thay đổi từng kí tự\", \"Là kiểu dữ liệu không thể thay đổi (immutable)\", \"Chỉ chứa được chữ cái\", \"Luôn có độ dài cố định\"]', '1', 'medium'),
(250, 24, 'Kết quả của biểu thức \"abc\" * 2 là?', '[\"abc2\", \"abc abc\", \"abcabc\", \"Lỗi\"]', '2', 'hard'),
(251, 24, 'Lệnh \"a\" in \"apple\" trả về giá trị gì?', '[\"True\", \"False\", \"1\", \"0\"]', '0', 'hard'),
(252, 24, 'Kết quả của lệnh \"Hanoi\"[1:4] là gì?', '[\"Han\", \"ano\", \"anoi\", \"Hano\"]', '1', 'hard'),
(253, 24, 'Trong Python, xâu \"123\" và số 123 có thể cộng trực tiếp với nhau không?', '[\"Có\", \"Không\", \"Chỉ khi dùng dấu phẩy\", \"Chỉ trong vòng lặp\"]', '1', 'hard'),
(254, 25, 'Phương thức s.upper() dùng để làm gì?', '[\"Viết hoa toàn bộ xâu\", \"Viết thường toàn bộ xâu\", \"Xóa xâu\", \"In xâu\"]', '0', 'easy'),
(255, 25, 'Phương thức s.find(\"x\") trả về giá trị nào nếu không tìm thấy \"x\"?', '[\"0\", \"None\", \"-1\", \"False\"]', '2', 'easy'),
(256, 25, 'Lệnh s.replace(\"a\", \"b\") thực hiện điều gì?', '[\"Xóa a\", \"Thay thế các kí tự a thành b\", \"Thêm b vào sau a\", \"Đổi tên xâu\"]', '1', 'easy'),
(257, 25, 'Phương thức nào dùng để chuyển xâu sang chữ thường?', '[\"upper()\", \"lower()\", \"clean()\", \"small()\"]', '1', 'easy'),
(258, 25, 'Lệnh \"a-b-c\".split(\"-\") trả về kết quả nào?', '[\"abc\", \"[\"a\", \"b\", \"c\"]\", \"a b c\", \"[\"a-b-c\"]\"]', '1', 'medium'),
(259, 25, 'Để nối danh sách [\"a\", \"b\"] thành xâu \"a,b\", ta dùng?', '[\"join(\",\", [\"a\", \"b\"])\", \"\",\".join([\"a\", \"b\"])\", \"connect([\"a\", \"b\"])\", \"[\"a\", \"b\"].join()\"]', '1', 'medium'),
(260, 25, 'Phương thức s.isdigit() dùng để kiểm tra điều gì?', '[\"Xâu có toàn chữ cái không\", \"Xâu có toàn chữ số không\", \"Xâu có rỗng không\", \"Xâu có dấu cách không\"]', '1', 'medium'),
(261, 25, 'Kết quả của \"  python  \".strip() là gì?', '[\"\"python\"\", \"  python\", \"python  \", \"py thon\"]', '0', 'hard'),
(262, 25, 'Phương thức s.count(\"h\") dùng để làm gì?', '[\"Tìm vị trí h\", \"Đếm số lần xuất hiện của kí tự h\", \"Xóa h\", \"Thay thế h\"]', '1', 'hard'),
(263, 25, 'Phương thức s.startswith(\"P\") trả về True khi nào?', '[\"Xâu kết thúc bằng P\", \"Xâu bắt đầu bằng P\", \"Xâu có chứa P\", \"Xâu có 1 kí tự P\"]', '1', 'hard'),
(264, 25, 'Lệnh \"  \".isspace() trả về giá trị gì?', '[\"True\", \"False\", \"None\", \"Lỗi\"]', '0', 'hard'),
(265, 26, 'Từ khóa dùng để định nghĩa một hàm là gì?', '[\"function\", \"def\", \"task\", \"sub\"]', '1', 'easy'),
(266, 26, 'Lệnh nào dùng để trả về giá trị từ hàm?', '[\"print\", \"get\", \"return\", \"out\"]', '2', 'easy'),
(267, 26, 'Tên hàm trong Python phải tuân theo quy tắc nào?', '[\"Giống quy tắc đặt tên biến\", \"Phải viết hoa toàn bộ\", \"Phải bắt đầu bằng số\", \"Không được có dấu gạch dưới\"]', '0', 'easy'),
(268, 26, 'Hàm không có lệnh return thì mặc định trả về giá trị nào?', '[\"0\", \"False\", \"None\", \"Rỗng\"]', '2', 'easy'),
(269, 26, 'Lợi ích chính của việc sử dụng hàm là gì?', '[\"Tái sử dụng mã nguồn\", \"Làm chương trình chạy chậm hơn\", \"Tăng dung lượng file\", \"Bắt buộc phải có\"]', '0', 'medium'),
(270, 26, 'Lời gọi hàm `xin_chao()` thực hiện điều gì?', '[\"Xóa hàm\", \"Thực thi các lệnh bên trong hàm\", \"Định nghĩa hàm\", \"Lưu hàm vào ổ cứng\"]', '1', 'medium'),
(271, 26, 'Cấu trúc của hàm bắt đầu bằng def và kết thúc bằng dấu gì ở dòng đầu tiên?', '[\"Dấu chấm phẩy\", \"Dấu hai chấm\", \"Dấu phẩy\", \"Dấu ngoặc nhọn\"]', '1', 'medium'),
(272, 26, 'Hàm có thể được định nghĩa bên trong một hàm khác không?', '[\"Có\", \"Không\", \"Chỉ trong Java\", \"Chỉ trong C++\"]', '0', 'hard'),
(273, 26, 'Để sử dụng các hàm toán học như sqrt, sin, cos, ta cần import thư viện nào?', '[\"random\", \"math\", \"time\", \"os\"]', '1', 'hard'),
(274, 26, 'Một hàm có thể có bao nhiêu lệnh return?', '[\"Duy nhất 1\", \"Nhiều lệnh nhưng chỉ 1 lệnh được thực thi khi chạy\", \"Không giới hạn và tất cả đều chạy\", \"Bắt buộc phải có 2\"]', '1', 'hard'),
(275, 26, 'Hàm `len()`, `print()`, `input()` được gọi là loại hàm gì?', '[\"Hàm tự định nghĩa\", \"Hàm có sẵn (built-in function)\", \"Hàm ẩn\", \"Hàm hệ thống\"]', '1', 'hard'),
(276, 27, 'Tham số của hàm được đặt ở vị trí nào?', '[\"Sau từ khóa return\", \"Trong cặp ngoặc đơn () sau tên hàm\", \"Ở dòng cuối cùng của hàm\", \"Bên ngoài hàm\"]', '1', 'easy'),
(277, 27, 'Khi gọi hàm, giá trị thực tế truyền vào cho tham số được gọi là?', '[\"Biến hằng\", \"Đối số (Arguments)\", \"Lệnh\", \"Kiểu dữ liệu\"]', '1', 'easy'),
(278, 27, 'Một hàm có thể có tối đa bao nhiêu tham số?', '[\"1\", \"10\", \"Không giới hạn (tùy bộ nhớ)\", \"Bắt buộc có 2\"]', '2', 'easy'),
(279, 27, 'Nếu hàm định nghĩa có tham số nhưng khi gọi không truyền đối số thì sao?', '[\"Tự động nhận giá trị 0\", \"Báo lỗi TypeError\", \"Bỏ qua hàm\", \"Chạy bình thường\"]', '1', 'easy'),
(280, 27, 'Tham số mặc định (default parameter) được khai báo như thế nào?', '[\"def f(x=1):\", \"def f(x): x=1\", \"f(1):\", \"def f(=1):\"]', '0', 'medium'),
(281, 27, 'Khi truyền đối số theo tên (keyword argument), thứ tự đối số có quan trọng không?', '[\"Có\", \"Không\", \"Chỉ quan trọng với số\", \"Chỉ quan trọng với xâu\"]', '1', 'medium'),
(282, 27, 'Tham số hình thức là gì?', '[\"Giá trị thực tế khi gọi hàm\", \"Biến được khai báo trong định nghĩa hàm\", \"Một loại lỗi\", \"Kết quả của hàm\"]', '1', 'medium'),
(283, 27, 'Trong Python, đối số truyền vào hàm theo cơ chế nào?', '[\"Truyền tham chiếu\", \"Truyền đối tượng (pass-by-object-reference)\", \"Truyền giá trị\", \"Truyền địa chỉ\"]', '1', 'hard'),
(284, 27, 'Tham số mặc định phải được đặt ở đâu trong danh sách tham số?', '[\"Ở đầu\", \"Ở cuối\", \"Ở giữa\", \"Bất cứ đâu\"]', '1', 'hard'),
(285, 27, 'Lệnh `def func(*args):` dùng để làm gì?', '[\"Định nghĩa hàm không tham số\", \"Định nghĩa hàm với số lượng đối số biến đổi\", \"Xóa đối số\", \"Chỉ nhận đối số là số thực\"]', '1', 'hard'),
(286, 27, 'Hàm có thể nhận một hàm khác làm đối số không?', '[\"Có\", \"Không\", \"Chỉ trong lớp 12\", \"Chỉ trong AI\"]', '0', 'hard'),
(287, 28, 'Biến được khai báo bên ngoài tất cả các hàm gọi là gì?', '[\"Biến cục bộ\", \"Biến toàn cục (global)\", \"Biến tĩnh\", \"Biến ẩn\"]', '1', 'easy'),
(288, 28, 'Biến được khai báo bên trong một hàm gọi là gì?', '[\"Biến toàn cục\", \"Biến cục bộ (local)\", \"Biến hệ thống\", \"Biến hằng\"]', '1', 'easy'),
(289, 28, 'Biến cục bộ có thể được truy cập từ bên ngoài hàm không?', '[\"Có\", \"Không\", \"Chỉ khi dùng lệnh print\", \"Chỉ khi hàm đang chạy\"]', '1', 'easy'),
(290, 28, 'Khi hàm kết thúc, các biến cục bộ trong hàm đó sẽ như thế nào?', '[\"Vẫn tồn tại\", \"Bị xóa khỏi bộ nhớ\", \"Trở thành biến toàn cục\", \"Lưu vào ổ cứng\"]', '1', 'easy'),
(291, 28, 'Từ khóa nào dùng để báo cho hàm biết một biến là biến toàn cục?', '[\"local\", \"global\", \"def\", \"static\"]', '1', 'medium'),
(292, 28, 'Nếu biến cục bộ và biến toàn cục trùng tên, trong hàm sẽ ưu tiên dùng biến nào?', '[\"Biến toàn cục\", \"Biến cục bộ\", \"Lỗi trùng tên\", \"Cả hai\"]', '1', 'medium'),
(293, 28, 'Biến toàn cục có thể được đọc giá trị bên trong hàm không?', '[\"Có\", \"Không\", \"Phải khai báo global mới đọc được\", \"Chỉ đọc được số\"]', '0', 'medium'),
(294, 28, 'Phạm vi của biến (Scope) có nghĩa là gì?', '[\"Độ lớn của biến\", \"Vùng chương trình mà biến có hiệu lực\", \"Thời gian tồn tại của biến\", \"Kiểu dữ liệu của biến\"]', '1', 'hard'),
(295, 28, 'Điều gì xảy ra nếu cố thay đổi biến toàn cục trong hàm mà không dùng từ khóa global?', '[\"Giá trị biến toàn cục thay đổi\", \"Python tạo một biến cục bộ mới cùng tên\", \"Báo lỗi ngay lập tức\", \"Chương trình dừng\"]', '1', 'hard'),
(296, 28, 'Tại sao nên hạn chế dùng quá nhiều biến toàn cục?', '[\"Làm máy chạy chậm\", \"Dễ gây nhầm lẫn và khó kiểm soát lỗi trong chương trình lớn\", \"Tốn bộ nhớ\", \"Vì Python không cho phép\"]', '1', 'hard'),
(297, 28, 'Biến toàn cục tồn tại khi nào?', '[\"Chỉ khi gọi hàm\", \"Suốt quá trình thực thi chương trình\", \"Chỉ khi máy tính bật\", \"Trong 10 phút\"]', '1', 'hard'),
(298, 29, 'Lỗi cú pháp (Syntax Error) thường do nguyên nhân nào?', '[\"Viết sai quy tắc ngôn ngữ\", \"Chia cho số 0\", \"Thuật toán sai\", \"Máy hết pin\"]', '0', 'easy'),
(299, 29, 'Lỗi chương trình vẫn chạy nhưng kết quả không như mong muốn gọi là gì?', '[\"Lỗi cú pháp\", \"Lỗi lôgic (Logic Error)\", \"Lỗi Runtime\", \"Lỗi hệ thống\"]', '1', 'easy'),
(300, 30, 'Quá trình tìm và sửa lỗi trong chương trình gọi là gì?', '[\"Coding\", \"Debugging (Gỡ lỗi)\", \"Testing\", \"Running\"]', '1', 'easy'),
(301, 30, 'Lệnh nào đơn giản nhất thường dùng để theo dõi giá trị biến khi gỡ lỗi?', '[\"input()\", \"print()\", \"break\", \"clear()\"]', '1', 'easy'),
(302, 29, 'Lỗi \"ZeroDivisionError\" thuộc loại lỗi nào?', '[\"Lỗi cú pháp\", \"Lỗi ngoại lệ (Runtime Error)\", \"Lỗi lôgic\", \"Lỗi phần cứng\"]', '1', 'medium'),
(303, 29, 'Lỗi \"IndentationError\" liên quan đến điều gì?', '[\"Sai tên biến\", \"Sai thụt lề khối lệnh\", \"Thiếu ngoặc\", \"Sai kiểu dữ liệu\"]', '1', 'medium'),
(304, 31, 'Việc chạy chương trình với nhiều bộ dữ liệu đầu vào khác nhau để kiểm tra gọi là gì?', '[\"Gỡ lỗi\", \"Kiểm thử (Testing)\", \"Lập trình\", \"Soạn thảo\"]', '1', 'medium'),
(305, 30, 'Để xử lý các lỗi có thể xảy ra khi chạy (Runtime), Python dùng cấu trúc nào?', '[\"if...else\", \"try...except\", \"for...in\", \"while\"]', '1', 'hard'),
(306, 32, 'Bộ dữ liệu kiểm thử (Test case) bao gồm những gì?', '[\"Chỉ dữ liệu vào\", \"Dữ liệu vào và kết quả kỳ vọng tương ứng\", \"Chỉ mã lỗi\", \"Danh sách các biến\"]', '1', 'hard'),
(307, 31, 'Lỗi lôgic thường được phát hiện khi nào?', '[\"Khi đang gõ code\", \"Khi thực hiện kiểm thử\", \"Khi máy tính báo lỗi đỏ\", \"Khi lưu file\"]', '1', 'hard'),
(308, 32, 'Tại sao nên gỡ lỗi từng đoạn mã nhỏ thay vì viết cả chương trình lớn mới sửa?', '[\"Để tiết kiệm điện\", \"Để dễ dàng xác định vị trí gây ra lỗi\", \"Vì Python bắt buộc thế\", \"Làm code đẹp hơn\"]', '1', 'hard'),
(309, 31, 'Bước đầu tiên khi giải quyết một bài toán lập trình là?', '[\"Gõ code ngay\", \"Xác định bài toán (Input, Output)\", \"Viết hướng dẫn sử dụng\", \"Mua máy mới\"]', '1', 'easy'),
(310, 32, 'Khi ôn tập lập trình, điều quan trọng nhất là gì?', '[\"Học thuộc lòng code\", \"Tư duy giải quyết vấn đề và thực hành gõ code\", \"Biết nhiều ngôn ngữ\", \"Gõ phím nhanh\"]', '1', 'easy'),
(311, 31, 'Việc vẽ sơ đồ khối giúp ích gì trong lập trình?', '[\"Làm đẹp bài làm\", \"Hình dung rõ ràng các bước của thuật toán\", \"Máy chạy nhanh hơn\", \"Giảm dung lượng tệp\"]', '1', 'easy'),
(312, 32, 'Dữ liệu kiểu danh sách (list) có thể chứa những gì?', '[\"Chỉ số\", \"Chỉ xâu\", \"Nhiều kiểu dữ liệu khác nhau\", \"Chỉ số thực\"]', '2', 'easy'),
(313, 31, 'Để giải bài toán tìm số lớn nhất trong 3 số, ta dùng cấu trúc nào?', '[\"Vòng lặp for\", \"Câu lệnh rẽ nhánh if\", \"Cấu trúc while\", \"Hàm math.sqrt\"]', '1', 'medium'),
(314, 32, 'Cách kiểm tra một số n có phải là số chẵn không?', '[\"n / 2 == 0\", \"n % 2 == 0\", \"n // 2 == 0\", \"n % 2 != 0\"]', '1', 'medium'),
(315, 31, 'Để tính tổng các số từ 1 đến 100, cấu trúc nào là tối ưu nhất?', '[\"Câu lệnh if\", \"Vòng lặp for hoặc while\", \"Dùng 100 biến cộng lại\", \"Dùng hàm input\"]', '1', 'medium'),
(316, 32, 'Sự khác biệt chính giữa vòng lặp for và while là?', '[\"For chạy nhanh hơn\", \"For dùng khi biết trước số lần lặp, while dùng khi lặp theo điều kiện\", \"While không cần thụt lề\", \"For chỉ dùng cho số\"]', '1', 'hard'),
(317, 31, 'Tại sao phải lập kế hoạch (thuật toán) trước khi viết mã?', '[\"Để tiết kiệm thời gian và tránh sai sót logic\", \"Để người khác không hiểu mình viết gì\", \"Để tăng độ khó\", \"Vì giáo viên yêu cầu\"]', '0', 'hard');
INSERT INTO `questions` (`id`, `lesson_id`, `question_text`, `options_json`, `correct_answer`, `difficulty`) VALUES
(318, 32, 'Kết quả của biểu thức \"10\" + \"20\" trong Python là?', '[\"30\", \"1020\", \"Lỗi\", \"None\"]', '1', 'hard'),
(319, 31, 'Kỹ năng nào là quan trọng nhất của một lập trình viên?', '[\"Gõ phím 10 ngón\", \"Tư duy logic và khả năng tự học\", \"Biết sửa phần cứng\", \"Học giỏi toán hình\"]', '1', 'hard'),
(320, 33, 'Sản phẩm nào sau đây là kết quả của nghề thiết kế đồ họa?', '[\"Phần mềm kế toán\", \"Logo, poster quảng cáo\", \"Bộ vi xử lý CPU\", \"Dây cáp mạng\"]', '1', 'easy'),
(321, 33, 'Công việc chính của người thiết kế đồ họa là gì?', '[\"Sửa chữa máy tính\", \"Sử dụng công cụ phần mềm để tạo ra hình ảnh, thông điệp bằng hình ảnh\", \"Lập trình web\", \"Quét virus\"]', '1', 'easy'),
(322, 33, 'Phần mềm nào thường được dùng trong thiết kế đồ họa Vector?', '[\"Excel\", \"Inkscape\", \"Word\", \"Calculator\"]', '1', 'easy'),
(323, 33, 'Yếu tố nào quan trọng nhất đối với một người làm nghề thiết kế đồ họa?', '[\"Gõ phím nhanh\", \"Sự sáng tạo và tư duy thẩm mỹ\", \"Biết sửa điện\", \"Giỏi toán đại số\"]', '1', 'easy'),
(324, 33, 'Nghề thiết kế đồ họa máy tính có thể làm việc trong lĩnh vực nào?', '[\"Quảng cáo và truyền thông\", \"Xuất bản sách báo\", \"Thiết kế giao diện (UI/UX)\", \"Tất cả các phương án trên\"]', '3', 'medium'),
(325, 33, 'Đồ họa Bitmap và đồ họa Vector khác nhau cơ bản ở điểm nào?', '[\"Giá phần mềm\", \"Cách cấu tạo hình ảnh (điểm ảnh và công thức toán học)\", \"Màu sắc\", \"Độ nặng máy tính\"]', '1', 'medium'),
(326, 33, 'Để trở thành một nhà thiết kế đồ họa chuyên nghiệp, cần trang bị kỹ năng gì?', '[\"Sử dụng thành thạo các phần mềm đồ họa\", \"Kiến thức về bố cục và màu sắc\", \"Khả năng làm việc với khách hàng\", \"Tất cả các phương án trên\"]', '3', 'medium'),
(327, 33, 'Sự phát triển của công nghệ AI ảnh hưởng thế nào đến nghề thiết kế đồ họa?', '[\"Làm nghề này biến mất\", \"Hỗ trợ tạo ý tưởng và thực hiện công việc nhanh hơn\", \"Làm máy tính hỏng\", \"Không có ảnh hưởng\"]', '1', 'hard'),
(328, 33, 'Tại sao người thiết kế đồ họa cần nắm vững bản quyền hình ảnh?', '[\"Để tiết kiệm tiền\", \"Tránh các rắc rối pháp lý và tôn trọng chất xám của đồng nghiệp\", \"Để ảnh đẹp hơn\", \"Vì luật bắt buộc phải mua máy mới\"]', '1', 'hard'),
(329, 33, 'Định dạng file nào sau đây thường được dùng để in ấn chất lượng cao?', '[\"TIFF hoặc PDF chất lượng cao\", \"GIF\", \"JPG nén cực thấp\", \"BMP\"]', '0', 'hard'),
(330, 33, 'Xu hướng thiết kế đồ họa hiện đại thường hướng tới điều gì?', '[\"Càng nhiều chi tiết càng tốt\", \"Sự tối giản và tập trung vào trải nghiệm người dùng\", \"Chỉ dùng hai màu đen trắng\", \"Chỉ dùng chữ không dùng hình\"]', '1', 'hard'),
(331, 34, 'Nghề phát triển phần mềm là làm công việc gì?', '[\"Bán máy tính\", \"Thiết kế, xây dựng và bảo trì các chương trình máy tính\", \"Sửa chữa phần cứng\", \"Lắp đặt mạng\"]', '1', 'easy'),
(332, 34, 'Ngôn ngữ lập trình nào sau đây phổ biến trong phát triển phần mềm hiện nay?', '[\"Tiếng Anh\", \"Python\", \"Mã Morse\", \"Tiếng Việt\"]', '1', 'easy'),
(333, 34, 'Người viết mã lệnh cho chương trình máy tính được gọi là gì?', '[\"Designer\", \"Programmer (Lập trình viên)\", \"Tester\", \"Manager\"]', '1', 'easy'),
(334, 34, 'Sản phẩm của nghề phát triển phần mềm bao gồm?', '[\"Ứng dụng di động\", \"Hệ điều hành\", \"Trình duyệt web\", \"Tất cả các phương án trên\"]', '3', 'easy'),
(335, 34, 'Trong một dự án phần mềm, vai trò của người kiểm thử (Tester) là?', '[\"Viết mã\", \"Tìm lỗi và đảm bảo chất lượng phần mềm\", \"Bán phần mềm\", \"Thiết kế logo\"]', '1', 'medium'),
(336, 34, 'Quy trình phát triển phần mềm thường bắt đầu bằng bước nào?', '[\"Gõ code\", \"Khảo sát và phân tích yêu cầu\", \"Kiểm thử\", \"Đóng gói sản phẩm\"]', '1', 'medium'),
(337, 34, 'Đặc điểm của nghề phát triển phần mềm là?', '[\"Làm việc độc lập hoàn toàn\", \"Đòi hỏi tư duy logic và khả năng tự học liên tục\", \"Chỉ làm việc ban ngày\", \"Không cần dùng tiếng Anh\"]', '1', 'medium'),
(338, 34, 'Phát triển phần mềm theo phương pháp Agile có ưu điểm gì?', '[\"Làm một lần là xong\", \"Linh hoạt và thích ứng nhanh với sự thay đổi của yêu cầu\", \"Rẻ hơn các phương pháp khác\", \"Không cần lập trình viên giỏi\"]', '1', 'hard'),
(339, 34, 'Tại sao lập trình viên cần tham gia các cộng đồng mã nguồn mở?', '[\"Để chơi game\", \"Để học hỏi, chia sẻ kinh nghiệm và đóng góp cho cộng đồng\", \"Để lấy tiền\", \"Để quảng cáo máy tính\"]', '1', 'hard'),
(340, 34, 'Thách thức lớn nhất của nghề phát triển phần mềm là gì?', '[\"Gõ phím mỏi tay\", \"Công nghệ thay đổi quá nhanh và áp lực về thời gian dự án\", \"Ngồi một chỗ quá lâu\", \"Không có máy tính mạnh\"]', '1', 'hard'),
(341, 34, 'Vai trò của \"Full-stack Developer\" là gì?', '[\"Chỉ làm giao diện\", \"Chỉ làm cơ sở dữ liệu\", \"Làm được cả phần giao diện (Frontend) và phần xử lý (Backend)\", \"Người quản lý dự án\"]', '2', 'hard');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `student_number` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `class_id`, `student_number`, `full_name`, `password`) VALUES
(3, 1, 1, 'Nguyễn Ngọc K', '20102015'),
(4, 1, 2, 'Nguyễn Thanh D', '20001000'),
(5, 1, 3, 'Lê Kim E', '123456'),
(6, 1, 4, 'Tô Ngọc F', '123456'),
(7, 1, 5, 'Đoàn Minh G', '123456'),
(8, 2, 1, 'Nguyễn Ngọc C', '123456'),
(9, 2, 2, 'Nguyễn Thanh D', '123456'),
(10, 2, 3, 'Lê Kim E', '123456'),
(11, 2, 4, 'Tô Ngọc F', '123456'),
(12, 2, 5, 'Đoàn Minh G', '123456'),
(13, 3, 1, 'Nguyễn Nhân C', '20001000');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `username`, `password`, `full_name`) VALUES
(1, 'admin', '20102015', 'ADMIN'),
(2, 'VanTIN', '29012003', 'Nguyễn Nhân V');

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `topics`
--

INSERT INTO `topics` (`id`, `name`, `created_at`) VALUES
(1, 'Chủ đề 1: Máy tính và xã hội tri thức', '2026-03-16 08:59:59'),
(2, 'Chủ đề 2: Mạng máy tính và Internet', '2026-03-16 08:59:59'),
(3, 'Chủ đề 3: Đạo đức, pháp luật và văn hóa trong môi trường số', '2026-03-16 08:59:59'),
(4, 'Chủ đề 4: Ứng dụng tin học', '2026-03-16 08:59:59'),
(5, 'Chủ đề 5: Giải quyết vấn đề với sự trợ giúp của máy tính', '2026-03-16 08:59:59'),
(6, 'Chủ đề 6: Hướng nghiệp với tin học', '2026-03-16 08:59:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `class_name` (`class_name`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `gameresults`
--
ALTER TABLE `gameresults`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_result_student` (`student_id`),
  ADD KEY `fk_result_lesson` (`lesson_id`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topic_id` (`topic_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lesson_id` (`lesson_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `gameresults`
--
ALTER TABLE `gameresults`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=342;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `gameresults`
--
ALTER TABLE `gameresults`
  ADD CONSTRAINT `fk_result_lesson` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_result_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
