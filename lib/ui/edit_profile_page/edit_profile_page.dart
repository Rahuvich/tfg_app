import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jumpets_app/app_localizations.dart';
import 'package:jumpets_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:jumpets_app/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:jumpets_app/data/repositories/user_repository.dart';
import 'package:jumpets_app/models/users/user.dart';
import 'package:jumpets_app/ui/components/forms/profile_forms.dart';
import 'package:jumpets_app/ui/components/profile_icon.dart';

class EditProfilePage extends StatelessWidget {
  final User user;
  EditProfilePage(this.user);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(
          user: user,
          authBloc: context.bloc<AuthBloc>(),
          repository: RepositoryProvider.of<UserRepository>(context)),
      child: BlocListener<EditProfileBloc, EditProfileState>(
        listenWhen: (previous, current) => current.status.isSubmissionSuccess,
        listener: (context, state) {
          Navigator.pop(context);
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => Navigator.pop(context)),
            title: Text(
              AppLocalizations.of(context).translate('edit_account'),
              style: Theme.of(context).textTheme.headline3,
            ),
            iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.grey),
          ),
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: ListView(shrinkWrap: true, children: [
                    ProfileEmailInput(
                      email: user.email,
                    )
                  ]),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  left: 10,
                  child: ProfileEditButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
