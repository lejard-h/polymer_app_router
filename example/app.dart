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
  PolymerApp.created() : super.created();

  PolymerAppRoute createElement(String text) {
    PolymerAppRoute route = (document.createElement("polymer-app-route") as PolymerAppRoute);
    route.innerHtml = text;
    return route;
  }

  @property
  List<Page> get pages =>  [
    new Page("home", "", createElement("home")),
    new Page("one", "/one", createElement("one")),
    new Page("two", "/two", createElement("two"))
  ];

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
    PolymerRouter.goToName(elem.text);
  }

  @reflectable
  void goToDefault(event, [_]) {
    PolymerRouter.goToDefault();
  }
}
