import 'package:WarmDoctor/api/book_model.dart';
export 'package:WarmDoctor/api/book_model.dart';
import 'package:WarmDoctor/Common/Check.dart';
import 'package:WarmDoctor/http/ViewModel.dart';

BookViewModel bookViewModel = new BookViewModel();

class BookViewModel extends ViewModel {
  /*
  * 最新知识百科
  * */
  Future<dynamic> getBook() async {
    List map = await BookReqModel().data();

    List data = map;

    List list = new List();

    if (listNoEmpty(data)) {
      data.forEach((json) => list.add(BookModel.fromJson(json)));
    }

    return Future.value(list);
  }
}
