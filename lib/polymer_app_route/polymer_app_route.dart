/**
 * Created by lejard_h on 11/12/15.
 */

@HtmlImport("polymer_app_route.html")

library polymer_app_router.polymer_app_route;

import "package:polymer/polymer.dart";
import "package:web_components/web_components.dart" show HtmlImport;
import "package:route_hierarchical/client.dart";
import "package:polymer_app_router/behavior/polymer_app_route_behavior.dart";

@PolymerRegister("polymer-app-route")
class PolymerAppRoute extends PolymerElement with PolymerAppRouteBehavior {
    PolymerAppRoute.created() : super.created();

    enter(RouteEnterEvent event, [Map params]) {

    }
}