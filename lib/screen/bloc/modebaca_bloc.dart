import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wrtproject/mesin/const.dart';

enum ColorEvent3 { to_pink, to_transparent }
enum ColorEvent4 { to_pink, to_transparent }
enum ColorEvent5 { to_pink, to_transparent }

class ModeBloc extends HydratedBloc<ColorEvent3, Color> {
  ModeBloc() : super(Colors.transparent);

  @override
  Stream<Color> mapEventToState(ColorEvent3 event) async* {
    yield (event == ColorEvent3.to_pink) ? Const.baseColor : Colors.transparent;
  }

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color(json['mode'] as int);
  }

  @override
  Map<String, int> toJson(Color state) {
    return {'mode': state.value};
  }
}

class ModeBloc2 extends HydratedBloc<ColorEvent4, Color> {
  ModeBloc2() : super(Colors.transparent);

  @override
  Stream<Color> mapEventToState(ColorEvent4 event) async* {
    yield (event == ColorEvent4.to_pink) ? Const.baseColor : Colors.transparent;
  }

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color(json['mode2'] as int);
  }

  @override
  Map<String, int> toJson(Color state) {
    return {'mode2': state.value};
  }
}

class ModeBloc3 extends HydratedBloc<ColorEvent5, Color> {
  ModeBloc3() : super(Colors.transparent);

  @override
  Stream<Color> mapEventToState(ColorEvent5 event) async* {
    yield (event == ColorEvent5.to_pink) ? Const.baseColor : Colors.transparent;
  }

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color(json['mode3'] as int);
  }

  @override
  Map<String, int> toJson(Color state) {
    return {'mode3': state.value};
  }
}
