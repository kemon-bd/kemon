import '../shared.dart';

class ChooseUploadMethodWidget extends StatelessWidget {
  const ChooseUploadMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return AlertDialog(
          backgroundColor: theme.backgroundPrimary,
          contentPadding: EdgeInsets.zero,
          title: Text(
            "Choose a method",
            style:
                TextStyles.subTitle(context: context, color: theme.textPrimary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Divider(color: theme.backgroundTertiary, height: .25),
              ListTile(
                leading: Icon(Icons.linked_camera_outlined,
                    color: theme.textPrimary),
                title: Text(
                  "Camera",
                  style: TextStyles.body(
                      context: context, color: theme.textPrimary),
                ),
                onTap: () {
                  context.pop(ImageSource.camera);
                },
              ),
              Divider(color: theme.backgroundTertiary, height: .25),
              ListTile(
                leading: Icon(Icons.photo_size_select_actual_outlined,
                    color: theme.textPrimary),
                title: Text(
                  "Gallery",
                  style: TextStyles.body(
                      context: context, color: theme.textPrimary),
                ),
                onTap: () {
                  context.pop(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
