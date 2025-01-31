

import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

part 'new_event.dart';
part 'new_state.dart';

class NewListingBloc extends Bloc<NewListingEvent, NewListingState> {
  final NewListingUseCase useCase;
  NewListingBloc({
    required this.useCase,
  }) : super(NewListingInitial()) {
    on<PublishNewListing>((event, emit) async {
      emit(NewListingLoading());

      final result = await useCase(
        name: event.name,
        urlSlug: event.urlSlug,
        about: event.about,
        logo: event.logo,
        type: event.type,
        phone: event.phone,
        email: event.email,
        website: event.website,
        social: event.social,
        industry: event.industry,
        category: event.category,
        subCategory: event.subCategory,
        address: event.address,
        division: event.division,
        district: event.district,
        thana: event.thana,
      );

      result.fold(
        (failure) => emit(NewListingError(failure: failure)),
        (urlSlug) => emit(NewListingDone(urlSlug: urlSlug)),
      );
    });
  }
}
