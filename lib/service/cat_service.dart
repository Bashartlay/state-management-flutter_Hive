import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:homework_statemangment_1/model/cat_model.dart';
import 'package:homework_statemangment_1/model/handle_model.dart';

abstract class Service {
  Dio req = Dio();
  late Response response;
  String baseurl = "https://freetestapi.com/api/v1/";
}

abstract class CatService extends Service {
  Future<ResultModel> getAllCat();
}

class CatServiceImp extends CatService {
  Box<CatModel> catsBox = Hive.box<CatModel>('catsBox');
  int currentIndex = 0;
  int fetchSize = 5;

  @override
  Future<ResultModel> getAllCat() async {
    try {
      if (catsBox.isNotEmpty) {
        print("From Cache");
        List<CatModel> cats = catsBox.values.skip(currentIndex).take(fetchSize).toList();
        currentIndex += fetchSize;
        return ListOf(modelList: cats);
      } else {
        print("From Server");
        response = await req.get(baseurl + "cats");
        if (response.statusCode == 200) {
          List<CatModel> fetchedCats = List.generate(
            response.data.length,
            (index) => CatModel.fromMap(response.data[index]),
          );
          for (var cat in fetchedCats) {
            catsBox.add(cat);
          }
          List<CatModel> cats = catsBox.values.take(fetchSize).toList();
          currentIndex = fetchSize;
          return ListOf(modelList: cats);
        } else {
          return ErrorModel(message: 'There Is a Problem');
        }
      }
    } catch (e) {
      return ExceptionModel(message: e.toString());
    }
  }
}

// abstract class BirdService extends Service {
//   Future<ResultModel> getAllBird();
// }

// class BirdServiceImp extends BirdService {
//   @override
//   Future<ResultModel> getAllBird() async {
//     try {
//       response = await req.get(baseurl + "birds");
//       if (response.statusCode == 200) {
//         return ListOf<BirdModel>(
//             modelList: List.generate(
//           response.data.length,
//           (index) => BirdModel.fromMap(response.data[index]),
//         ));
//       } else {
//         return ErrorModel(message: 'There Is a Problem');
//       }
//     } catch (e) {
//       return ExceptionModel(message: e.toString());
//     }
//   }
// }
