import 'package:w_flux/w_flux.dart';

import 'actions.dart';

/// Uniquely identifies store.mario in the store selectors
const String marioKey = 'mario';

/// Uniquely identifies store.luigi in the store selectors
const String luigiKey = 'luigi';

/// Uniquely identifies store.yoshi in the store selectors
const String yoshiKey = 'yoshi';

typedef Map ExampleStoreSelector(ExampleStore selector);

/// A store that keeps a count of various characters
class ExampleStore extends Store {
  final ExampleActions _actions;
  ExampleStore(this._actions) {
    <ActionSubscription>[
      _actions.pickMario.listen(_pickMario),
      _actions.pickLuigi.listen(_pickLuigi),
      _actions.pickYoshi.listen(_pickYoshi),
    ].forEach(manageActionSubscription);
  }

  /// The number of times Mario was tallied
  int get marioCount => _marioCount;
  int _marioCount = 0;

  /// The number of times Luigi was tallied
  int get luigiCount => _luigiCount;
  int _luigiCount = 0;

  /// The number of times Yoshi was tallied
  int get yoshiCount => _yoshiCount;
  int _yoshiCount = 0;

  void _pickMario(Null _) {
    _marioCount++;
    trigger();
  }

  void _pickLuigi(Null _) {
    _luigiCount++;
    trigger();
  }

  void _pickYoshi(Null _) {
    _yoshiCount++;
    trigger();
  }
}
