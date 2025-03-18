# Ngọc trời

Ngọc Trời là dự án game visual novel/giải đố, với các yếu tố đến từ văn hóa dân gian Việt Nam.

## Cài đặt

Tải game tại đường link: https://drive.google.com/file/d/1uXrI6_ofArf3LCuNLCQB5_MZ3nuUeLWB/view?usp=sharing

Chọn bản mởi nhất: `Ngọc Trời.zip`. Các file còn lại là các bản cũ hơn. Bấm chuột phải -> Chọn Tải xuống

Sau khi tải xuống, giải nén file game.

Chọn `game.exe` để bắt đầu trò chơi.

![Màn hình chính](https://github.com/booleto/hat-ngoc-troi/blob/main/preview0.png?raw=true)
![Lựa chọn](https://github.com/booleto/hat-ngoc-troi/blob/main/preview1.png?raw=true)
![Minigame](https://github.com/booleto/hat-ngoc-troi/blob/main/preview2.png?raw=true)
![Minigame](https://github.com/booleto/hat-ngoc-troi/blob/main/preview3.png?raw=true)
![Màn chơi](https://github.com/booleto/hat-ngoc-troi/blob/main/preview4.png?raw=true)

## Tương thích

Game được làm cho hệ máy: Windows 10/11

## Hướng dẫn dự án

### Phiên bản

- Godot v4.3 stable
- Dialogic 2.0 - Alpha 16

### Bố trí folder

- addons: các plugin
- asset: file ảnh, âm thanh
- data: data game (các chỉ số)
- docs: tài liệu dự án
- level: màn chơi hoàn chỉnh trong game (VD main menu, chương 1, chương 2,...)
- scene: các scene để tạo thành level (VD custom textbox, style, dialogic timeline, character,...)
- script: file script (dùng gdscript để export bản web)
- Test: unit test

### Coding convention

```gd
# PascalCase cho tên class, tên file script, tên autoload, tên resource, tên scene
class_name PascalCase

# Dùng static type khi có thể
var snake_case: String = "snake_case cho tên biến"

func snake_case_method():
	print("snake_case cho tên hàm")
```
