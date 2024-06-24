import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:homework_statemangment_1/model/handle_model.dart';

part 'cat_model.g.dart';

@HiveType(typeId: 0)
class CatModel extends ResultModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String origin;
  @HiveField(2)
  String temperament;
  @HiveField(3)
  List<String> colors;
  @HiveField(4)
  String description;
  @HiveField(5)
  String image;

  CatModel({
    required this.name,
    required this.origin,
    required this.temperament,
    required this.colors,
    required this.description,
    required this.image,
  });

  CatModel copyWith({
    String? name,
    String? origin,
    String? temperament,
    List<String>? colors,
    String? description,
    String? image,
  }) {
    return CatModel(
      name: name ?? this.name,
      origin: origin ?? this.origin,
      temperament: temperament ?? this.temperament,
      colors: colors ?? this.colors,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'origin': origin,
      'temperament': temperament,
      'colors': colors,
      'description': description,
      'image': image,
    };
  }

  factory CatModel.fromMap(Map<String, dynamic> map) {
    return CatModel(
      name: map['name'] as String,
      origin: map['origin'] as String,
      temperament: map['temperament'] as String,
      colors: List<String>.from(map['colors'] as List),
      description: map['description'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatModel.fromJson(String source) => CatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CatModel(name: $name, origin: $origin, temperament: $temperament, colors: $colors, description: $description, image: $image)';
  }

  @override
  bool operator ==(covariant CatModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.origin == origin &&
        other.temperament == temperament &&
        other.colors == colors &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        origin.hashCode ^
        temperament.hashCode ^
        colors.hashCode ^
        description.hashCode ^
        image.hashCode;
  }
}
