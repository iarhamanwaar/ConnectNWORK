import 'package:connectnwork/environment.dart';
import 'package:connectnwork/app.dart';

Future<void> main() async {
  await app(flavor: Environment.stag);
}
