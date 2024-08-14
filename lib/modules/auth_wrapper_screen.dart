import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:newtok_tech/components/services/auth_service.dart';
import 'package:newtok_tech/modules/user/screens/upload_excel_screen.dart';
import 'package:newtok_tech/modules/user/screens/user_dashboard_screen.dart';
import 'package:provider/provider.dart';
import 'admin/screens/admin_dashboard_screen.dart';
import 'login_screen.dart';

class AuthWrapperScreen extends StatelessWidget {
  const AuthWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (BuildContext context, authService, Widget? child) {
      return StreamBuilder<User?>(
        stream: authService.userChanges,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            final user = snapshot.data;
            if(user == null){
              return const LoginScreen();
            }else{
              if(authService.isAdmin(user)){
                return const AdminDashboardScreen();
              }else{
                return const UploadExcelScreen();
                // return const UserDashboardScreen();
              }
            }

          }else{
            return const Center(child: CupertinoActivityIndicator(),);
          }
        },
      );

    },);
  }
}
