library polymer_app_router.page;

import "dart:html";
import "package:polymer/polymer.dart";
import "package:polymer_app_router/behavior/polymer_app_route_behavior.dart";

class Page extends JsProxy {

  /// path of the page
  @reflectable
  final String path;

  /// name of the page
  @reflectable
  final String name;

  /// element of the page
  /// Can be an [HtmlElement] or the element name as a [String]
  @reflectable
  PolymerAppRouteBehavior element;

  /// definne if page is default, home
  @reflectable
  final bool isDefault;

  String toString() =>
      "{ name: $name, path: $path, element: $element, isDefault: $isDefault}";


  Page(this.name, this.path, this.element, {this.isDefault: false}) {
    if (element == null) {
      throw "element must not be Null";
    }
    element.path = this.path;
    element.name = this.name;
    element.isDefault = this.isDefault;
  }
}
