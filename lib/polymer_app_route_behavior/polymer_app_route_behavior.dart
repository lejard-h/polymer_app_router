/**
 * Created by lejard_h on 11/12/15.
 */

library polymer_app_router.polymer_app_route_behavior;

import "package:polymer/polymer.dart";
import "package:web_components/web_components.dart" show HtmlImport;

@PolymerRegister("polymer-app-route")
class PolymerAppRoute extends PolymerElement {
    PolymerAppRoute.created() : super.created();

    bool _isDefault;
    String _name;
    String _path;
    dynamic _content;

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
    dynamic get content => _content;

    set content(dynamic value) {
        _content = value;
        notifyPath("content", value);
    }

    @property
    String get path => _path;

    set path(String value) => _path = value;


}