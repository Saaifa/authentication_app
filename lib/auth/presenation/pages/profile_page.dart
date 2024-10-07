// import 'package:authentication/auth/presenation/cubit/auth_cubit.dart';
// import 'package:authentication/auth/presenation/pages/login_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:retrofit/retrofit.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => GetIt.I<AuthCubit>()..getProfile(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//               'Profile page'
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Center(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   shape: BeveledRectangleBorder(
//                       borderRadius: BorderRadius.all(
//                           Radius.circular(10)
//                       )
//                   ),
//                   textStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25.0,
//                   )
//               ),
//               onPressed: () {
//                 Navigator.pop(
//                     context
//                 );
//               },
//               child: Text(
//                   "log out"
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:authentication/auth/data/models/profile_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../cubit/auth_cubit.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("error")),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return _buildProfileView(state.profile);
          } else if (state is AuthFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return Center(child: Text('No profile information available.'));
        },
      ),
    );
  }

  Widget _buildProfileView(ProfileResponseModel profile) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Username: ${profile.success}", style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text("Email: ${profile.email}", style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          // Add more fields based on your ProfileResponseModel
        ],
      ),
    );
  }
}
