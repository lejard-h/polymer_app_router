library polymer_app_router.page;

import "dart:html";
import "package:polymer/polymer.dart";
import "package:polymer_app_router/behavior/polymer_app_route_behavior.dart";

num _pageId = 0;
num get generatePageId {
  _pageId++;
  return _pageId;
}

class Page extends JsProxy {

  @reflectable
  String redirectTo;

  @reflectable
  bool isAbstract;

  @reflectable
  num pageId = generatePageId;

  /// path of the page
  @reflectable
  String path;

  /// name of the page
  @reflectable
  String name;

  /// element of the page
  /// Can be an [HtmlElement] or the element name as a [String]
  @reflectable
  PolymerAppRouteBehavior element;

  /// define if page is default home
  @reflectable
  bool isDefault;

  @reflectable
  String parent;

  String toString() =>
      "{ name: $name, path: $path, element: $element, isDefault: $isDefault}";


  Page(this.name, this.path, {this.element, this.isDefault: false, this.isAbstract: false, this.parent, this.redirectTo}) {
    if (isAbstract && redirectTo == null) {
      throw "if isAbstract == true, redirectTo must not be Null.";
    }
    if (element == null) {
      element = new Element.tag("polymer-app-route") as PolymerAppRouteBehavior;
    }
    element?.path = this.path;
    element?.name = this.name;
    element?.isDefault = this.isDefault;
    element?.redirectTo = redirectTo;
    element?.isAbstract = isAbstract;
  }
}
