/**
 * Created by lejard_h on 11/12/15.
 */

library polymer_app_router.polymer_router_behavior;

import "dart:html";
import "dart:async";
import "package:polymer/polymer.dart";
import "package:route_hierarchical/client.dart";

import "package:polymer_app_router/page_selector/page_selector.dart";
import "polymer_app_route_behavior.dart";
import "package:polymer_app_router/page.dart";

@behavior
abstract class PolymerRouterBehavior {
  List<Page> _pages;

  @Property(notify: true)
  List<Page> get pages => _pages;

  set pages(List<Page> values) {
    if (_pages != values && values != null && values.isNotEmpty) {
      _pages = values;
      _router = new Router(useFragment: true);
      launchRouter();
    }
    notifyPath("pages", values);
  }

  static Router _router = new Router(useFragment: true);
  static String _defaultPathName;
  static String currentRouteName;
  static PolymerAppRouteBehavior currentPage;

  @reflectable
  static goToDefault(
      {Map parameters,
      Route startingFrom,
      bool replace: false,
      Map queryParameters,
      bool forceReload: false}) {
    if (_defaultPathName != null) {
      goToName(_defaultPathName,
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
      _router.go(name, parameters,
          replace: replace,
          startingFrom: startingFrom,
          queryParameters: queryParameters,
          forceReload: forceReload);
    }
  }

  static String get route_change_event => "polymer_app_router.route_change";

  PageSelector get pagesSelector => $$('#pages');

  String _selected;

  @Property(reflectToAttribute: true, notify: true)
  String get selected => _selected;

  set selected(String value) {
    if (_selected != value && value != null) {
      _selected = value;
      notifyPath("selected", value);
    }
  }

  static attached(PolymerRouterBehavior instance) {
    if (instance.pages?.isNotEmpty) {
      instance.launchRouter();
    }
  }

  launchRouter() async {
    _createRoutes();

    pagesSelector?.items.forEach((item) {
      if (item is PolymerAppRouteBehavior) {
        PolymerAppRouteBehavior _item = item;
        if (_item.isDefault) {
          _defaultPathName = _item.name;
        }
        _router.root.addRoute(
            name: item.name,
            path: item.path,
            defaultRoute: item.isDefault,
            enter: enterRoute);
      }
    });

    _router.listen();
  }

  void enterRoute(RouteEnterEvent e) {
    if (e.route.name != currentRouteName) {
      selected = e.route.name;
      currentRouteName = selected;
      currentPage = pagesSelector.selectedItem;
      currentPage?.enter(e, e.parameters);
    } else {
      goToDefault();
    }
  }

  _createRoutes() {
    pagesSelector.children.clear();
    pages?.forEach((Page page) {
      pagesSelector.append(page.element as HtmlElement);
    });
  }
}
