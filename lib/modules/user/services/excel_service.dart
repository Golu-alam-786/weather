// // import 'package:file_picker/file_picker.dart';
// // import 'package:excel/excel.dart';
// //
// // class ExcelService {
// //
// //   Future<PlatformFile?> pickFile() async {
// //     var result = await FilePicker.platform.pickFiles(
// //       type: FileType.custom,
// //       allowedExtensions: ['xlsx'],
// //     );
// //     return result?.files.first;
// //   }
// //
// //   Future<List<List<dynamic>>> parseFile(PlatformFile file) async {
// //     var bytes = file.bytes;
// //     var excel = Excel.decodeBytes(bytes!);
// //     List<List<dynamic>> locations = [];
// //
// //     for (var table in excel.tables.keys) {
// //       var sheet = excel.tables[table];
// //       for (var row in sheet!.rows) {
// //         locations.add(row.map((elements) => elements?.value).toList());
// //       }
// //     }
// //
// //     return locations;
// //   }
// // }
// import 'package:excel/excel.dart';
// import 'package:file_picker/file_picker.dart';
//
// class ExcelService {
//   Future<PlatformFile?> pickFile() async {
//     var result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['xlsx'],
//     );
//     return result?.files.first;
//   }
//
//   Future<List<List<dynamic>>> parseFile(PlatformFile file) async {
//     var bytes = file.bytes;
//     var excel = Excel.decodeBytes(bytes!);
//     List<List<dynamic>> locations = [];
//
//     for (var table in excel.tables.keys) {
//       var sheet = excel.tables[table];
//       for (var row in sheet!.rows) {
//         locations.add(row.map((elements) => elements?.value).toList());
//       }
//     }
//
//     return locations;
//   }
// }
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

class ExcelService {
  Future<PlatformFile?> pickFile() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    return result?.files.first;
  }

  Future<List<List<dynamic>>> parseFile(PlatformFile file) async {
    var bytes = file.bytes;

    if (bytes == null && file.path != null) {
      bytes = await File(file.path!).readAsBytes();
    }

    if (bytes == null) {
      throw Exception("The selected file is empty or could not be read.");
    }

    try {
      var excel = Excel.decodeBytes(bytes);
      List<List<dynamic>> locations = [];

      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        if (sheet == null) {
          continue;
        }
        for (var row in sheet.rows) {
          if (row.isEmpty) {
            continue;
          }
          locations.add(row.map((cell) => cell?.value).toList());
        }
      }

      if (locations.isEmpty) {
        throw Exception("No data found in the Excel file.");
      }

      return locations;
    } catch (e) {
      throw Exception("Failed to parse the Excel file: ${e.toString()}");
    }
  }
}
