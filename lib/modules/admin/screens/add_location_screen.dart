import 'package:flutter/material.dart';
import 'package:newtok_tech/components/widgets/footer_widget.dart';
import 'package:newtok_tech/components/widgets/navbar_widget.dart';
import 'package:newtok_tech/modules/admin/services/location_service.dart';

class AddLocationScreen extends StatelessWidget {
  const AddLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _countryController = TextEditingController();
    TextEditingController _stateController = TextEditingController();
    TextEditingController _districtController = TextEditingController();
    TextEditingController _cityController = TextEditingController();
    final LocationService locationService = LocationService();
    return Scaffold(
      appBar: NavbarWidget(title: "Add Location"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(controller: _countryController,decoration: const InputDecoration(labelText: 'Country'),),
            TextFormField(controller: _stateController,decoration: const InputDecoration(labelText: 'State'),),
            TextFormField(controller: _districtController,decoration: const InputDecoration(labelText: 'District'),),
            TextFormField(controller: _cityController,decoration: const InputDecoration(labelText: 'City'),),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              locationService.addLocation(
                  country: _countryController.text,
                  state: _stateController.text,
                  district: _districtController.text,
                  city: _cityController.text

              );
            }, child: const Text("Add"))

          ],
        ),
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
