library w_flux.example.todo_app;

import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart';

import 'package:w_flux_example/w_flux_example.dart';

main() async {
  // initialize action, stores, and components
  ExampleActions actions = new ExampleActions();
  ExampleStore store = new ExampleStore(actions);

  /// Returns a map of just the fields of [ExampleStore] that correspond to people
  peopleSelector(ExampleStore store) => {
      marioKey: store.marioCount,
      luigiKey: store.luigiCount,
    };

  // render the component
  setClientConfiguration();
  render((Example()
      ..actions = actions
      ..store = store
      ..selector = peopleSelector
    )(),
    querySelector('#content-container'));
}
