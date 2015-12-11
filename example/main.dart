import 'package:polymer/polymer.dart';

import 'package:polymer_app_router/polymer_app_router.dart';

main() async {
  await initPolymer();
  PolymerAppRouter.goToName("one", parameters: {"foo": "bar"});
}