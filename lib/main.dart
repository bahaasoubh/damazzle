import 'package:damazzle/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:damazzle/features/home/domain/home_cubit.dart';
import 'package:damazzle/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'core/StartUp/StartUp.dart';
import 'features/user/domain/cubit/user_cubit.dart';
import 'features/user/presentation/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StartUp.setup();
  runApp(_blocProvider());
}
_blocProvider()
{
  return MultiBlocProvider(
    providers: [

      BlocProvider<UserCubit>(
        create: (BuildContext context) => UserCubit(),
      ),
      BlocProvider<HomeCubit>(
        create: (BuildContext context) => HomeCubit(),
      ),
    ],
    child: Sizer(),
  );

}


class Sizer extends StatelessWidget {
  final Widget child;

  const Sizer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
            return MyApp();
          },
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home:AppSharedPreferences.accessToken!=null?HomePage(): LogIn(),
    );
  }
}
