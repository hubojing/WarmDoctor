import 'package:WarmDoctor/api/home_model.dart';
export 'package:WarmDoctor/api/home_model.dart';
import 'package:WarmDoctor/http/viewmodel.dart';
import 'package:WarmDoctor/common/common.dart';

HomeListReqViewModel homeListReqViewModel = new HomeListReqViewModel();

class HomeListReqViewModel extends ViewModel {
  /*
  * 最新辟谣
  * */
  Future<dynamic> getHome() async {
    final data = await HomeListReqModel().data();

    List list = new List();

    if (listNoEmpty(data)){
      data.forEach((json) => list.add(HomeListModel.fromJson(json)));
    }

    return Future.value(list);
  }
}
