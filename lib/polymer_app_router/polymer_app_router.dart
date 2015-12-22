/**
 * Created by lejard_h on 11/12/15.
 */

@HtmlImport("polymer_app_router.html")
library polymer_app_router.polymer_app_router;

import "package:polymer/polymer.dart";
import "package:web_components/web_components.dart" show HtmlImport;

import 'package:polymer_app_router/behavior/polymer_app_route_behavior.dart';
import 'package:polymer_app_router/behavior/polymer_router_behavior.dart';
import 'package:polymer_app_router/polymer_app_route/polymer_app_route.dart';
import 'package:polymer_app_router/page_selector/page_selector.dart';

import 'package:route_hierarchical/client.dart';

@PolymerRegister("polymer-app-router")
class PolymerAppRouter extends PolymerElement with PolymerRouter {
  PolymerAppRouter.created() : super.created();
}
