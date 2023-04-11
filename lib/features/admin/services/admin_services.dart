import 'dart:io';
import 'package:flutter_commercial_nodjs/model/product.dart';
import 'package:minio/minio.dart';
import 'package:minio/io.dart';
import 'package:flutter/material.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      const String endPoint = 'storage.iran.liara.space';
      const String accessKey = 'oss98spdpt7e93l2';
      const String secretKey = '2b6b3387-f9b1-4e6c-a999-d0368987c411';
      const String bucket = 'amazone-clone';

      List<String> imageUrls = [];
      final minio = Minio(
        endPoint: endPoint,
        accessKey: accessKey,
        secretKey: secretKey,
      );
      for (int i = 0; i < images.length; i++) {
        String res = await minio.fPutObject(bucket, images[i].path, name);
        print(res);
        imageUrls.add(res);
        Product(
            name: name,
            description: description,
            quantity: quantity,
            images: imageUrls,
            category: category,
            price: price);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
