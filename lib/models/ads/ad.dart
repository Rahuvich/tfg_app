import 'package:built_collection/built_collection.dart';
import 'package:jumpets_app/models/ads/animal_ad.dart';
import 'package:jumpets_app/models/ads/product_ad.dart';
import 'package:jumpets_app/models/ads/service_ad.dart';
import 'package:jumpets_app/models/users/user.dart';
import 'package:built_value/built_value.dart';

part 'ad.g.dart';

@BuiltValue(instantiable: false)
abstract class Ad {
  String get id;
  DateTime get createdAt;
  BuiltList<String> get tags;
  BuiltList<String> get photos;
  User get creator;

  Ad rebuild(void Function(AdBuilder) updates);
  AdBuilder toBuilder();

  static Ad fromJson(Map<String, dynamic> json) {
    switch (json['type'].toString().toUpperCase()) {
      case 'PRODUCTAD':
        return ProductAd.fromJson(json);
      case 'SERVICEAD':
        return ServiceAd.fromJson(json);
      default:
        return AnimalAd.fromJson(json);
    }
  }
}
