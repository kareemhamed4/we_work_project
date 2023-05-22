import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:we_work/shared/constants/constants.dart';

class CVCubit extends Cubit<String> {
  CVCubit() : super('');

  static CVCubit get(context) => BlocProvider.of(context);

  final String apiUrl = 'http://mohamed2132-001-site1.ftempurl.com/api/Account/UplodeCv';

  Dio dio = Dio();

  Future<void> chooseCVFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Allow only PDF files
      );

      if (result != null && result.files.isNotEmpty) {
        final String filePath = result.files.first.path!;
        emit(filePath);
        uploadCVFile();
      }
    } catch (e) {
      // Handle file picking error
    }
  }

  Future<void> uploadCVFile() async {
    final String filePath = state;
    if (filePath.isEmpty) {
      // Handle empty file path error
      return;
    }

    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'multipart/form-data; boundary=${formData.boundary}',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data as Map<String, dynamic>;
        final cvUrl = jsonResponse['cv_Url'] as String;
        emit(cvUrl);
      } else {
        // Handle API error
      }
    } catch (e) {
      // Handle Dio error
    }
  }
}
