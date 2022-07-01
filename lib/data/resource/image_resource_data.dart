const _imageAssetPath = 'asset/image';

class ImageResourceData {
  final String appLogo;
  final String appSplash;

  const ImageResourceData.light()
      : appLogo = '$_imageAssetPath/app_logo.png',
        appSplash = '$_imageAssetPath/app_splash.png';

  const ImageResourceData.dark()
      : appLogo = '$_imageAssetPath/app_logo.png',
        appSplash = '$_imageAssetPath/app_splash.png';
}