/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsCfgGen {
  const $AssetsCfgGen();

  /// File path: assets/cfg/env_dev.json
  String get envDev => 'assets/cfg/env_dev.json';

  /// File path: assets/cfg/env_prod.json
  String get envProd => 'assets/cfg/env_prod.json';

  /// File path: assets/cfg/env_stg.json
  String get envStg => 'assets/cfg/env_stg.json';

  /// List of all assets
  List<String> get values => [envDev, envProd, envStg];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/fag_for_japan.svg
  String get fagForJapan => 'assets/images/fag_for_japan.svg';

  /// File path: assets/images/logo_bg_demo.png
  AssetGenImage get logoBgDemo =>
      const AssetGenImage('assets/images/logo_bg_demo.png');

  /// File path: assets/images/logo_text_demo.png
  AssetGenImage get logoTextDemo =>
      const AssetGenImage('assets/images/logo_text_demo.png');

  /// List of all assets
  List<dynamic> get values => [fagForJapan, logoBgDemo, logoTextDemo];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// File path: assets/translations/ja.json
  String get ja => 'assets/translations/ja.json';

  /// List of all assets
  List<String> get values => [en, ja];
}

class Assets {
  Assets._();

  static const $AssetsCfgGen cfg = $AssetsCfgGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
