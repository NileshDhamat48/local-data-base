import 'package:demoapps/ui/add_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController =TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().fetchLocalProduct();
  }
Future<void> _onRefresh()async {
    if(_searchController.text !=null){
      context.read<UserBloc>().searchUser(_searchController.text, '');

    }else{
  context.read<UserBloc>().fetchLocalProduct();}

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text('Employees'),
          centerTitle: true,
          actions: [
            InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    isScrollControlled: true,
                    enableDrag: true,
                    isDismissible: true,
                    builder: (BuildContext context) {
                      return const AddUser();
                    },
                  );
                },
                child: const Icon(Icons.add)),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.fiber_dvr_rounded),
              ),
            )
          ]),
      body:                     RefreshIndicator(onRefresh:  _onRefresh,

        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UsersLoading || state is UsersInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UsersLoaded) {
              return /*state.user.isEmpty
                  ? const Center(
                      child: Text("No Employee found"),
                    )
                  :*/ Column(

                    children: [
                      CupertinoSearchTextField(
                        controller: _searchController,
                        onChanged: (value) {
                          context.read<UserBloc>().searchUser(value, '');
                        },
                        onSubmitted: (value) {},
                        autocorrect: true,
                      ),
                      state.user.isEmpty
                  ? const Expanded(
                    child: Center(
                        child: Text("No Employee found"),
                      ),
                  )
                  :  Expanded(
                        child: ListView.builder(
                            itemCount: state.user.length,
                            itemBuilder: (context, index) {
                              if (index < state.user.length) {
                                final usersData = state.user[index];
                                return InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(left: 8.0),
                                                child: Column(
                                                  children: [
                                                    Text(usersData?.fullname ?? ''),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      usersData?.description ?? '',
                                                      style: const TextStyle(
                                                          overflow:
                                                              TextOverflow.ellipsis),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                   Row(
                                                     children: [
                                                       InkWell(
                                                         onTap: () {
                                                           showModalBottomSheet<void>(
                                                             context: context,
                                                             backgroundColor: Colors.white,
                                                             shape: const RoundedRectangleBorder(
                                                               borderRadius: BorderRadius.vertical(
                                                                 top: Radius.circular(20),
                                                               ),
                                                             ),
                                                             clipBehavior: Clip.hardEdge,
                                                             isScrollControlled: true,
                                                             enableDrag: true,
                                                             isDismissible: true,                                                             builder: (BuildContext context) {
                                                               return  AddUser(usersData:usersData,editBool:true);
                                                             },
                                                           );
                                                         },
                                                         child: const Icon(
                                                          Icons.edit,
                                                  ),
                                                       ),  const SizedBox(width: 10,),InkWell(
                                                         onTap: () {
                                                           context.read<UserBloc>().deleteUsers(usersData?.id??0);
                                                         },
                                                         child: Icon(
                                                          Icons.delete,
                                                  ),
                                                       ),
                                                     ],
                                                   ),
                                                  Text(usersData?.phonenumber
                                                          .toString() ??
                                                      ""),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                      ),
                    ],
                  );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
