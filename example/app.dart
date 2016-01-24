/**
 * Created by lejard_h on 11/12/15.
 */

@HtmlImport("app.html")
library polymer_app_router.example_app;

import "package:polymer/polymer.dart";
import "dart:html";
import "package:web_components/web_components.dart" show HtmlImport;
import 'package:polymer_app_router/polymer_app_router.dart';

@PolymerRegister("polymer-app")
class PolymerApp extends PolymerElement {
  PolymerApp.created() : super.created() {
    homeRouteElem = createElement("home");
    oneRouteElemA = createElement("one A");
    oneRouteElemAA = createElement("one AA");
    twoRouteElem = createElement("two");
    oneRouteElemB = createElement("one B");

    pages = [
      new Page("home", "", element: homeRouteElem),
      new Page("one", "one", isAbstract: true, redirectTo: "oneA"),
      new Page("oneA", "a", element: oneRouteElemA, parent: "one"),
      new Page("oneAA", "aa", element: oneRouteElemA, parent: "one"),
      new Page("oneB", "b", element: oneRouteElemA, parent: "one"),
      new Page("two", "two", element: twoRouteElem)
    ];
  }

  PolymerAppRoute homeRouteElem;
  PolymerAppRoute oneRouteElemA;
  PolymerAppRoute oneRouteElemAA;
  PolymerAppRoute oneRouteElemB;
  PolymerAppRoute twoRouteElem;

  PolymerAppRoute createElement(String text) {
    PolymerAppRoute route =
        (document.createElement("polymer-app-route") as PolymerAppRoute);
    route.innerHtml = text;
    return route;
  }

  List<Page> _pages;

  set pages(List<Page> values) {
    _pages = values;
    notifyPath("pages", values);
  }

  @property
  List<Page> get pages => _pages;

  String _selectedMenu;

  @Property()
  String get selectedMenu => _selectedMenu;

  set selectedMenu(String value) {
    _selectedMenu = value;
    notifyPath("selectedMenu", value);
  }

  String _selected;

  @Property()
  String get selected => _selected;

  set selected(String value) {
    _selected = value;
    selectedMenu = value;
    notifyPath("selected", value);
  }

  @reflectable
  void goTo(event, [_]) {
    HtmlElement elem = event.target;
    PolymerRouterBehavior.goToName(elem.text);
  }

  @reflectable
  void goToDefault(event, [_]) {
    PolymerRouterBehavior.goToDefault();
  }
}
