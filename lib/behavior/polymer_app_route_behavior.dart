/**
 * Created by lejard_h on 11/12/15.
 */

library polymer_app_router.polymer_app_route_behavior;

import "package:polymer/polymer.dart";
import "package:route_hierarchical/client.dart";

@behavior
abstract class PolymerAppRouteBehavior {
  bool _isDefault;
  String _name = "";
  String _path = "";

  @property
  bool get isDefault => _isDefault;

  set isDefault(bool value) {
    _isDefault = value;
    notifyPath("isDefault", value);
  }

  @property
  String get name => _name;

  set name(String value) {
    _name = value;
    notifyPath("name", value);
  }

  @property
  String get path => _path;

  set path(String value) {
    _path = value;
    notifyPath("path", value);
  }

  enter(RouteEnterEvent event, [Map params]) {}
}
