import 'package:flutter/material.dart';
import 'package:newtok_tech/components/services/auth_service.dart';
import 'package:newtok_tech/components/widgets/footer_widget.dart';
import 'package:newtok_tech/components/widgets/navbar_widget.dart';
import 'package:provider/provider.dart';

import 'add_location_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarWidget(title: "Admin Dashboard",actions: [
        Consumer<AuthService>(builder: (BuildContext context, authService, Widget? child) {
          return IconButton(onPressed: (){
            authService.signOut(context);
          }, icon: const Icon(Icons.logout));
        },)
      ],
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddLocationScreen(),));
        }, child: const Text("Add Location")),
      ),
      bottomNavigationBar: const FooterWidget(),

    );
  }
}
