# polymer_app_router

Routing for polymer dart

## Installing

Add to your pubspec.yaml

    dependencies:
        polymer_app_router: "^0.0.2"

then `pub get`

then import

    import 'package:polymer_app_router/polymer_app_router.dart';

## Usage

    <polymer-app-router selected="{{selected}}">
        <polymer-app-route name="home" path="" is-default>home</polymer-app-route>
        <polymer-app-route name="one" path="one">one</polymer-app-route>
        <polymer-app-route name="two" path="two">two</polymer-app-route>
    </polymer-app-router>
    
## API

### Navigate to Route name

    PolymerRouter.goToName(String name,
          {Map parameters,
          Route startingFrom,
          bool replace: false,
          Map queryParameters,
          bool forceReload: false})
          
          
### Navigate to default Route

    PolymerRouter.goToDefault(
          {Map parameters,
          Route startingFrom,
          bool replace: false,
          Map queryParameters,
          bool forceReload: false})
          
### Current Route name
    
      String PolymerRouter.currentRouteName;
      
### Current Page

      PolymerAppRoute PolymerRouter.currentPage;
