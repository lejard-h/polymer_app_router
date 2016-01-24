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

  String _internalSelected;

  @Property(reflectToAttribute: true, notify: true)
  String get internalSelected => _internalSelected;

  set internalSelected(String value) {
    if (_internalSelected != value && value != null) {
      _internalSelected = value;
      notifyPath("internalSelected", value);
    }
  }

  createPages() {
    if (_pages == null) {
      _pages = new List<Page>();
    }
    pagesSelector.children.forEach((elem) {
      if (elem is PolymerAppRouteBehavior && !_pages.contains(elem)) {
        _pages.add(new Page(elem.name, elem.path,
            element: elem,
            isAbstract: elem.isAbstract,
            redirectTo: elem.redirectTo,
            isDefault: elem.isDefault));
      }
    });
  }

  static attached(PolymerRouterBehavior instance) {
    instance.createPages();
    if (instance.pages?.isNotEmpty) {
      instance.launchRouter();
    }
  }

  String findParentPath(String name) {
    try {
      Page page = pages.firstWhere((Page p) => p.name == name);
      String path = page.path;
      if (page.parent != null) {
        return "${findParentPath(page.parent)}/$path";
      }
      return path;
    } catch (e) {
      return "";
    }
  }

  _addRoutes(List<Page> p) {
    p.forEach((Page item) {
      if (item.isDefault) {
        _defaultPathName = item.name;
      }

      String path = item.path;
      if (item.parent != null) {
        path = "${findParentPath(item.parent)}/$path";
      }

      _router.root.addRoute(
          name: item.name,
          path: path,
          defaultRoute: item.isDefault,
          enter: enterRoute);
    });
  }

  launchRouter() async {
    _addRoutes(pages);
    _router.listen();
  }

  PolymerAppRouteBehavior findElement(String name) {
    PolymerAppRouteBehavior elem;
    try {
      Page page = pages.firstWhere((Page p) => p.name == name);
      elem = page.element;
    } catch (e) {
      return null;
    }
    return elem;
  }

  void enterRoute(RouteEnterEvent e) {
    if (e.route.name != currentRouteName) {
      currentPage = findElement(e.route.name);
      if (currentPage.isAbstract && currentPage.redirectTo != null) {
        goToName(currentPage.redirectTo);
      } else {
        if (!pagesSelector.children.contains(currentPage)) {
          pagesSelector.append(currentPage as HtmlElement);
        }
        selected = e.route.name;
        currentRouteName = selected;
        internalSelected = currentPage.name;
        currentPage?.enter(e, e.parameters);
      }
    } else {
      goToDefault();
    }
  }
}
