import 'dart:io';
import 'package:blueberry_flutter_template/feature/camera/ProfilePreviewScreen.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';

class CameraGalleryScreen extends StatefulWidget {
  static const String name = 'CameraGalleryScreen';
  const CameraGalleryScreen({super.key});

  @override
  State<CameraGalleryScreen> createState() => _CameraGalleryPage();
}

class _CameraGalleryPage extends State<CameraGalleryScreen> {
  final List<AssetEntity> _imageList = [];

  int _currentPage = 0;

  final int _pageSize = 50;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    // 권한 요청
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth || ps.hasAccess) {
      // 안드로이드 일때 ps.hasAccess가 없으면 이미지를 못가져옴

      // 모든 앨범 가져오기
      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
      );
      if (albums.isEmpty) return;

      final List<AssetEntity> images = await albums[0].getAssetListPaged(
        page: _currentPage,
        size: _pageSize, // 가져올 이미지 수
      );

      setState(() {
        _imageList.addAll(images);
        _currentPage++;
      });
    } else {
      SnackBar snackBar = SnackBar(
        content: const Text(AppStrings.errorMessage_permissionGallery),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            PhotoManager.openSetting();
          },
        ),
      );
    }
  }

  void _navigateToSharePostScreen(File imageFile) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfilePreviewScreen(imageFile),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemCount: _imageList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            final File? imageFile = await _imageList[index].file;
            if (imageFile != null) {
              _navigateToSharePostScreen(imageFile);
            }
          },
          child: FutureBuilder<Uint8List?>(
            future: _imageList[index].thumbnailData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                return Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                );
              }
              return Container(color: Colors.grey);
            },
          ),
        );
      },
    );
  }
}
