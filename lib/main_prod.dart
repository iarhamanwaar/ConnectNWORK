import 'package:connectnwork/environment.dart';
import 'package:connectnwork/main_common.dart';

Future<void> main() async {
  await mainCommon(Environment.prod);
}
