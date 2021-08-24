import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final Map<String, dynamic> profile;

  ProfileState(
      {this.profile = const {
        'email': 'vinly@gmail.com',
        'name': 'vinly',
        'role': 'member'
      }});

  ProfileState copyWith({Map<String, dynamic> profile}) {
    return ProfileState(profile: profile ?? this.profile);
  }
}

profileReducer(ProfileState state, dynamic action) {
  return state;
}
