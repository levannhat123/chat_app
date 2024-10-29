/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/avatar.jpg
  AssetGenImage get avatar => const AssetGenImage('assets/img/avatar.jpg');

  /// File path: assets/img/default_avatar.png
  AssetGenImage get defaultAvatar =>
      const AssetGenImage('assets/img/default_avatar.png');

  /// File path: assets/img/intro1.jpg
  AssetGenImage get intro1 => const AssetGenImage('assets/img/intro1.jpg');

  /// File path: assets/img/intro3.jpg
  AssetGenImage get intro3 => const AssetGenImage('assets/img/intro3.jpg');

  /// File path: assets/img/intro4.jpg
  AssetGenImage get intro4 => const AssetGenImage('assets/img/intro4.jpg');

  /// File path: assets/img/login.png
  AssetGenImage get login => const AssetGenImage('assets/img/login.png');

  /// File path: assets/img/logo.jpg
  AssetGenImage get logo => const AssetGenImage('assets/img/logo.jpg');

  /// File path: assets/img/register.png
  AssetGenImage get register => const AssetGenImage('assets/img/register.png');

  /// File path: assets/img/splahs.png
  AssetGenImage get splahs => const AssetGenImage('assets/img/splahs.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        avatar,
        defaultAvatar,
        intro1,
        intro3,
        intro4,
        login,
        logo,
        register,
        splahs
      ];
}

class Assets {
  Assets._();

  static const $AssetsImgGen img = $AssetsImgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
