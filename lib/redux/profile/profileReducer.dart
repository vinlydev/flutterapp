import 'package:flutterapp/redux/profile/profileAction.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final Map<String, dynamic> profile;

  ProfileState({this.profile
      // {this.profile = const {
      //   'email': 'mary@gmail.com',
      //   'name': 'Mary Jane',
      //   'role': 'member'
      // }}
      });

  ProfileState copyWith({Map<String, dynamic> profile}) {
    return ProfileState(profile: profile ?? this.profile);
  }
}

profileReducer(ProfileState state, dynamic action) {
  if (action is GetProfileAction) {
    return state.copyWith(profile: action.profileState.profile);
  }
  return state;
}
