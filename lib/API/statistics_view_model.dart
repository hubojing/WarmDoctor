import 'package:WarmDoctor/api/statistics_model.dart';
export 'package:WarmDoctor/api/statistics_model.dart';
import 'package:WarmDoctor/http/viewmodel.dart';

StatisticsViewModel statisticsViewModel = new StatisticsViewModel();

class StatisticsViewModel extends ViewModel {
  /*
  * 获取整体统计信息
  * */
  Future<dynamic> getData() async {
    final Map data = await StatisticsReqModel().data();

    if (data != null && data.isNotEmpty) {
      return StatisticsModel.fromJson(data);
    }

    return Future.value({});
  }
}
