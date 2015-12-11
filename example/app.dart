/**
 * Created by lejard_h on 11/12/15.
 */

@HtmlImport("app.html")

library polymer_app_router.example_app;

import "package:polymer/polymer.dart";
import "package:web_components/web_components.dart" show HtmlImport;
import 'package:polymer_app_router/polymer_app_router.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_menu.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_elements/paper_drawer_panel.dart';
import 'package:polymer_elements/paper_header_panel.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/iron_media_query.dart';

@PolymerRegister("polymer-app")
class PolymerApp extends PolymerElement {
    PolymerApp.created() : super.created();

    String _selected;

    @Property(notify: true)
    String get selected => _selected;

    set selected(String value) {
        _selected = value;
        notifyPath("selected", value);
    }

    @reflectable
    void menuItemClicked(event, [_]) {
        PolymerAppRouter.goToName(selected);
        $['drawerPanel'].closeDrawer();
    }


}