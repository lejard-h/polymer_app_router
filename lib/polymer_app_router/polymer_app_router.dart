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
  static PolymerAppRouteBehavior currentPage;

  @reflectable
  static goToDefault(
      {Map parameters,
      Route startingFrom,
      bool replace: false,
      Map queryParameters,
      bool forceReload: false}) {
    if (defaultPathName != null) {
      goToName(defaultPathName,
          parameters: parameters,
          replace: replace,
          startingFrom: startingFrom,
          queryParameters: queryParameters,
          forceReload: forceReload);
    }
  }

  @reflectable
  static goToName(String name,
      {Map parameters,
      Route startingFrom,
      bool replace: false,
      Map queryParameters,
      bool forceReload: false}) {
    if (parameters == null) {
      parameters = new Map();
    }
    if (currentRouteName != name) {
      print("router go $name");
      router.go(name, parameters,
          replace: replace,
          startingFrom: startingFrom,
          queryParameters: queryParameters,
          forceReload: forceReload);
    }
  }

  static String get route_change_event => "polymer_app_router.route_change";

  IronPages get pages => $$('#pages');

  String _selected;

  @Property(reflectToAttribute: true, notify: true)
  String get selected => _selected;

  set selected(String value) {
    if (_selected != value && value != null) {
      _selected = value;
      notifyPath("selected", value);
    }
  }

  void attached() {
    async(() {
      pages?.items.forEach((item) {
        if (item is PolymerAppRouteBehavior) {
          PolymerAppRouteBehavior _item = item;
          if (_item.isDefault) {
            defaultPathName = _item.name;
          }
          router.root.addRoute(
              name: item.name,
              path: item.path,
              defaultRoute: item.isDefault,
              enter: enterRoute);
        }
      });
      router.listen();
    });
  }

  void enterRoute(RouteEnterEvent e) {
    if (e.route.name != currentRouteName) {
      selected = e.route.name;
      currentRouteName = selected;
      currentPage = pages.selectedItem;
      currentPage.enter(e, e.parameters);
    } else {
      goToDefault();
    }
  }
}
