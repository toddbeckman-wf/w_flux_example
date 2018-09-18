import 'package:over_react/over_react.dart';

import 'actions.dart';
import 'store.dart';

/// A component that counts characters but doesn't rerender when the fields given
/// by the [ExampleStoreSelector] prop match.
@Factory()
UiFactory<ExampleProps> Example;

@Props()
class ExampleProps extends FluxUiProps<ExampleActions, ExampleStore> {
  ExampleStoreSelector selector;
}

@Component()
class ExampleComponent extends FluxUiComponent<ExampleProps> {
  // Bonus: we can just pass this map into children instead of the whole store
  // which will also make their shouldComponentUpdate logic easier
  Map _substore;

  @override
  bool shouldComponentUpdate(ExampleProps nextProps, Map nextState) {
    // Failsafe
    if (_substore == null) {
      return true;
    }

    final nextPeople = props.selector(nextProps.store);

    // If every field matches, return false.
    //
    // If instead we tried returning true for any `!=`, we risk accidentally
    // missing a check when either the component or store is updated. We would
    // rather return true and update unnecessarily than fail to rerender when
    // it should.
    if (nextPeople[marioKey] == _substore[marioKey] &&
        nextPeople[luigiKey] == _substore[luigiKey]) {
      return false;
    }

    // Return true otherwise
    return true;
  }

  @override
  void componentWillUpdate(ExampleProps newProps, Map newState) {
    _substore = props.selector(newProps.store);
  }

  @override
  void componentDidMount() {
    _substore = props.selector(props.store);
  }

  @override
  ReactElement render() {
    print('Rerender!');
    return Dom.table()(
        Dom.tbody()(
          Dom.tr()(
            Dom.td()(),
            Dom.td()('Number of presses'),
          ),
          Dom.tr()(
            Dom.td()((Dom.button()
              ..onClick = (_) => props.actions.pickMario())('Tally Mario')),
            Dom.td()(
              props.store.marioCount,
            ),
          ),
          Dom.tr()(
            Dom.td()(
              (Dom.button()
                ..onClick = (_) => props.actions.pickLuigi())('Tally Luigi'),
            ),
            Dom.td()(
              props.store.luigiCount,
            ),
          ),
          Dom.tr()(
            Dom.td()(
              (Dom.button()
                ..onClick = (_) => props.actions.pickYoshi())('Tally Yoshi'),
            ),
            Dom.td()(
              props.store.yoshiCount,
            ),
          ),
        ),
      );
  }
}
