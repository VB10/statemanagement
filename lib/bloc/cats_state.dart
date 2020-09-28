import 'package:flutter/foundation.dart';
import 'package:statemanagement/bloc/cat.dart';

abstract class CatsState {
  const CatsState();
}

class CatsInitial extends CatsState {
  const CatsInitial();
}

class CatsLoading extends CatsState {
  const CatsLoading();
}

class CatsCompleted extends CatsState {
  final List<Cat> response;

  const CatsCompleted(this.response);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CatsCompleted && listEquals(o.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class CatsError extends CatsState {
  final String message;
  const CatsError(this.message);
}
