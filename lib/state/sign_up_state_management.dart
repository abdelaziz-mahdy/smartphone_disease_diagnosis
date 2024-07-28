import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/new_user_info/gender.dart';

final genderProvider =
    StateProvider<String>((ref) => Gender.unselected.toShortString());
final ageProvider = StateProvider<int>((ref) => 0);
final heightProvider = StateProvider<int>((ref) => 180);
final weightProvider = StateProvider<double>((ref) => 0.0);
