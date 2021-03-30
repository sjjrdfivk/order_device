// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import 'shop_scroll_coordinator.dart';
import 'shop_scroll_position.dart';

// import 'scroll_context.dart';
// import 'scroll_physics.dart';
// import 'scroll_position.dart';
// import 'scroll_position_with_single_context.dart';
class ShopScrollController extends ScrollController {
  /// Creates a controller for a scrollable widget.
  ///
  /// The values of `initialScrollOffset` and `keepScrollOffset` must not be null.
  ShopScrollController(
    this.coordinator, {
    double initialScrollOffset = 0.0,
    bool keepScrollOffset = true,
    String debugLabel,
  })  : assert(initialScrollOffset != null),
        assert(keepScrollOffset != null),
        _initialScrollOffset = initialScrollOffset,
        super(keepScrollOffset: keepScrollOffset, debugLabel: debugLabel);

  final ShopScrollCoordinator coordinator;

  // @override
  double get initialScrollOffset => _initialScrollOffset;
  final double _initialScrollOffset;

  // final bool keepScrollOffset;

  // final String? debugLabel;

  @protected
  Iterable<ScrollPosition> get positions => _positions;
  final List<ScrollPosition> _positions = <ScrollPosition>[];

  bool get hasClients => _positions.isNotEmpty;

  ScrollPosition get position {
    assert(_positions.isNotEmpty,
        'ScrollController not attached to any scroll views.');
    assert(_positions.length == 1,
        'ScrollController attached to multiple scroll views.');
    return _positions.single;
  }

  double get offset => position.pixels;

  Future<void> animateTo(
    double offset, {
    @required Duration duration,
    @required Curve curve,
  }) async {
    assert(_positions.isNotEmpty,
        'ScrollController not attached to any scroll views.');
    await Future.wait<void>(<Future<void>>[
      for (int i = 0; i < _positions.length; i += 1)
        _positions[i].animateTo(offset, duration: duration, curve: curve),
    ]);
  }

  void jumpTo(double value) {
    assert(_positions.isNotEmpty,
        'ScrollController not attached to any scroll views.');
    for (final ScrollPosition position in List<ScrollPosition>.from(_positions))
      position.jumpTo(value);
  }

  void attach(covariant ScrollPosition position) {
    assert(!_positions.contains(position));
    _positions.add(position);
    position.addListener(notifyListeners);
  }

  void detach(ScrollPosition position) {
    assert(_positions.contains(position));
    position.removeListener(notifyListeners);
    _positions.remove(position);
  }

  @override
  void dispose() {
    for (final ScrollPosition position in _positions)
      position.removeListener(notifyListeners);
    super.dispose();
  }

  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition oldPosition,
  ) {
    return ShopScrollPosition(
      coordinator: coordinator,
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
    );
  }

  @override
  String toString() {
    final List<String> description = <String>[];
    debugFillDescription(description);
    return '${describeIdentity(this)}(${description.join(", ")})';
  }

  @override
  @mustCallSuper
  void debugFillDescription(List<String> description) {
    super.debugFillDescription(description);
    if (debugLabel != null) description.add(debugLabel);
    if (initialScrollOffset != 0.0)
      description.add(
          'initialScrollOffset: ${initialScrollOffset.toStringAsFixed(1)}, ');
    if (_positions.isEmpty) {
      description.add('no clients');
    } else if (_positions.length == 1) {
      // Don't actually list the client itself, since its toString may refer to us.
      description.add('one client, offset ${offset.toStringAsFixed(1)}');
    } else {
      description.add('${_positions.length} clients');
    }
  }
}
