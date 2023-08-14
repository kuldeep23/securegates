import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../auth_exception_handler.dart';
import '../controller/user_controller.dart';

final directoryServiceProvider = Provider<DirectoryService>((ref) {
  return DirectoryService(ref);
});

abstract class BaseDirectoryService {
  Future<bool> addToLocalContacts(
    String subType,
    String name,
    String number,
    String local,
  );
}

class DirectoryService implements BaseDirectoryService {
  final Dio _dio = Dio();
  final Ref ref;

  DirectoryService(this.ref);

  @override
  Future<bool> addToLocalContacts(
      String subType, String name, String number, String local) async {
    try {
      final socCode = ref.read(userControllerProvider).currentUser!.socCode;
      final data = FormData.fromMap({
        'sub_type': subType,
        'name': name,
        'number': number,
        'local': local,
        'soc_code': socCode,
      });

      final response = await _dio.post(
          "https://gatesadmin.000webhostapp.com/local_directory.php",
          data: data);

      final status = response.data["status"];

      if (status == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw ErrorHandler.errorDialog(e);
    }
  }
}
