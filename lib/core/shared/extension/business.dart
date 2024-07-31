import '../../../features/business/business.dart';
import '../shared.dart';

extension BusinessEntityExtension on BusinessEntity {}

extension BusinessModelExtension on BusinessModel {}

extension FindBusinessesByCategoryStateExtension
    on FindBusinessesByCategoryState {
  FindBusinessesByCategoryState copyWith({
    ListingType? type,
  }) {
    if (this is FindBusinessesByCategoryError) {
      final state = this as FindBusinessesByCategoryError;
      return FindBusinessesByCategoryError(
        type: type ?? this.type,
        failure: state.failure,
      );
    } else if (this is FindBusinessesByCategoryLoading) {
      return FindBusinessesByCategoryLoading(type: type ?? this.type);
    } else if (this is FindBusinessesByCategoryDone) {
      final state = this as FindBusinessesByCategoryDone;
      return FindBusinessesByCategoryDone(
        type: type ?? this.type,
        businesses: state.businesses,
      );
    } else {
      return FindBusinessesByCategoryInitial(type: type ?? this.type);
    }
  }
}
