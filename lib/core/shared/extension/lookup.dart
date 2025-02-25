import '../../shared/shared.dart';

import '../../../features/lookup/lookup.dart';

extension LookupEntityExtension on LookupEntity {
  bool get name => text.same(as: 'name');
  bool get phone => text.same(as: 'phone');
  bool get phoneVerified => text.same(as: 'phoneVerified');
  bool get email => text.same(as: 'email');
  bool get emailVerified => text.same(as: 'emailVerified');
  bool get dob => text.same(as: 'DOB');
  bool get gender => text.same(as: 'Gender');
  bool get profilePicture => text.same(as: 'ProfilePicture');

  int get point => int.tryParse(value) ?? 0;

  Map<String, dynamic> get toMap {
    return {
      "dataValue" : value,
      "displayText" : text,
    };
  }
}

extension LookupModelExtension on LookupModel {}
