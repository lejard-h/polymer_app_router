/**
 * Created by lejard_h on 11/12/15.
 */

@HtmlImport("polymer_app_router.html")
library polymer_app_router.polymer_app_router;

import "package:polymer/polymer.dart";
import "package:web_components/web_components.dart" show HtmlImport;

import 'package:polymer_app_router/polymer_app_route_behavior/polymer_app_route_behavior.dart';
import 'package:polymer_elements/iron_pages.dart';

import 'package:route_hierarchical/client.dart';

@PolymerRegister("polymer-app-router")
class PolymerAppRouter extends PolymerElement {
  PolymerAppRouter.created() : super.created();

  static Router router = new Router(useFragment: true);
  static String defaultPathName;
  static String currentRouteName;
  static dynamic currentPage;

  @reflectable
  static goToDefault([Map params]) {
    if (params == null) {
      params = new Map();
    }
    if (defaultPathName != null) {
      router.go(defaultPathName, params);
    }
  }

  @reflectable
  static goToName(String name, [Map params]) {
    if (params == null) {
      params = new Map();
    }
    router.go(name, params);
  }

  static String get route_change_event => "polymer_app_router.route_change";

  IronPages get pages => $['pages'];

  String _selected;

  @reflectable
  String get selected => _selected;

  set selected(String value) {
    if (_selected != value) {
      _selected = value;
      notifyPath("selected", value);
    }
    if (currentRouteName != value) {
      currentRouteName = value;
    }
  }

  ready() {
    pages?.items.forEach((item) {
      if (item is PolymerAppRouteBehavior) {
        PolymerAppRouteBehavior _item = item;
        if (_item.isDefault) {
          defaultPathName = _item.name;
        }
        router.root.addRoute(name: item.name, path: item.path, defaultRoute: item.isDefault, enter: enterRoute);
      }
    });
    router.listen();
  }

  void enterRoute(RouteEnterEvent e) {
    if (e.route.name != currentRouteName) {
        selected = e.route.name;
      } else {
        goToDefault();
      }
  }

}