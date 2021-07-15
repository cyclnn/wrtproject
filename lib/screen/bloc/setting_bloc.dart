import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wrtproject/mesin/const.dart';

enum ColorEvent { to_pink, to_transparent }
enum ColorEvent2 { to_pink, to_transparent }

class ColorBloc extends HydratedBloc<ColorEvent, Color> {
  ColorBloc() : super(Colors.transparent);

  @override
  Stream<Color> mapEventToState(ColorEvent event) async* {
    yield (event == ColorEvent.to_pink) ? Const.baseColor : Colors.transparent;
  }

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color(json['notif'] as int);
  }

  @override
  Map<String, int> toJson(Color state) {
    return {'notif': state.value};
  }
}

class ColorBloc2 extends HydratedBloc<ColorEvent2, Color> {
  ColorBloc2() : super(Const.baseColor);

  @override
  Stream<Color> mapEventToState(ColorEvent2 event) async* {
    yield (event == ColorEvent2.to_pink) ? Const.baseColor : Colors.transparent;
  }

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color(json['notif2'] as int);
  }

  @override
  Map<String, int> toJson(Color state) {
    return {'notif2': state.value};
  }
}
