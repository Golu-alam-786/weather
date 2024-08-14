import 'package:flutter/material.dart';
import 'package:newtok_tech/components/provider/weather_provider.dart';
import 'package:newtok_tech/components/widgets/footer_widget.dart';
import 'package:newtok_tech/components/widgets/navbar_widget.dart';
import 'package:provider/provider.dart';

class UploadExcelScreen extends StatelessWidget {
  const UploadExcelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarWidget(title: "Upload Excel File"),
      body: Consumer<WeatherProvider>(builder: (BuildContext context, controller, Widget? child) {
        return Center(
          child: ElevatedButton(onPressed: ()async{
            controller.uploadFile(context);
          }, child: const Text("Upload Excel File")),
        );
      },),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
