part of 'cat_model.dart';

class CatModelAdapter extends TypeAdapter<CatModel> {
  @override
  final int typeId = 0;

  @override
  CatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatModel(
      name: fields[0] as String,
      origin: fields[1] as String,
      temperament: fields[2] as String,
      colors: (fields[3] as List).cast<String>(),
      description: fields[4] as String,
      image: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CatModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.origin)
      ..writeByte(2)
      ..write(obj.temperament)
      ..writeByte(3)
      ..write(obj.colors)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
