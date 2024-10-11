import 'package:chat_app/gen/assets.gen.dart';

class OnloadingModel {
  String? imgPath;
  String? text;
}

final onloadings = [
  OnloadingModel()
    ..imgPath = Assets.img.intro1.path
    ..text = "Kết nối mọi lúc, chia sẻ mọi nơi",
  OnloadingModel()
    ..imgPath = Assets.img.intro3.path
    ..text = "Chat nhanh, kết nối mạnh",
  OnloadingModel()
    ..imgPath = Assets.img.intro4.path
    ..text = "Chia sẻ niềm vui, kết nối cảm xúc",
];
