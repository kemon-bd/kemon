part of 'create_bloc.dart';

abstract class CreateReviewEvent extends Equatable {
  const CreateReviewEvent();

  @override
  List<Object> get props => [];
}

class CreateReview extends CreateReviewEvent {
  final Identity listing;
  final double rating;
  final String title;
  final String description;
  final String date;
  final List<XFile> attachments;

  const CreateReview({
    required this.listing,
    required this.rating,
    required this.title,
    required this.description,
    required this.date,
    required this.attachments,
  });

  @override
  List<Object> get props => [
        listing,
        rating,
        title,
        description,
        date,
        attachments,
      ];
}
