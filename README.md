# Hạt ngọc trời

## Hướng dẫn dự án

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
