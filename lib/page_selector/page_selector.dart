/**
 * Created by lejard_h on 11/12/15.
 */

@HtmlImport("page_selector.html")
library polymer_app_router.page_selector;

import "package:polymer/polymer.dart";
import "package:web_components/web_components.dart" show HtmlImport;

@PolymerRegister("page-selector")
class PageSelector extends PolymerElement {
  PageSelector.created() : super.created();

  dynamic _selected;

  String _attrForSelected;

  @property
  String get attrForSelected => _attrForSelected;

  set attrForSelected(String value) {
    _attrForSelected = value;
    notifyPath("attrForSelected", value);
  }

  @Property(reflectToAttribute: true)
  dynamic get selected => _selected;

  set selected(dynamic value) {
    _selected = value;
    _applySelection();
    notifyPath("selected", value);
  }

  @property
  List get items => this.children;

  dynamic _selectedItem;

  @property
  dynamic get selectedItem => _selectedItem;

  set selectedItem(dynamic value) {
    _selectedItem = value;
    notifyPath("selectedItem", value);
  }

  ready() {
    _applySelection();
  }

  _applySelection() {
    bool apply = false;
    for (var i = 0; i < this.children.length; i++) {
      if (attrForSelected == null && i == selected && !apply) {
        this.children[i].classes.add("iron-selected");
        selectedItem = this.children[i];
        apply = true;
      } else if (!apply &&
          this.children[i].attributes.containsKey(attrForSelected) &&
          this.children[i].attributes[attrForSelected] == selected) {
        this.children[i].classes.add("iron-selected");
        apply = true;
      } else {
        this.children[i].classes.remove("iron-selected");
      }
    }
    if (!apply && this.children.isNotEmpty) {
      this.children[0].classes.add("iron-selected");
    }
  }
}
