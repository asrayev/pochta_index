import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pochta_index/data/repository/pochta_repository.dart';
import 'package:pochta_index/ui/splash/splash_page.dart';
import 'package:pochta_index/view_model/pochta_view_model.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var fireStore = FirebaseFirestore.instance;

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // StorageService.getInstance();
  runApp(
      EasyLocalization(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('uz', 'UZ'),
          Locale('ru', 'RU'),
        ],
        path: 'assets/translations',
       child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => PochtaViewModel(productRepository: PochtaRepository(firebaseFirestore: fireStore))),
          ],
        child:  MyApp()),
  ));
}
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return ScreenUtilInit(
      designSize: const Size(423.5294,843.13727),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext contex, Widget? child) {
        return  MaterialApp(
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
        );
      },
    );
  }
}