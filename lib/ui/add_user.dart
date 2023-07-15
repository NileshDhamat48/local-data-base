import 'package:demoapps/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/model.dart';

class AddUser extends StatefulWidget {
  final User? usersData;
  final bool? editBool;
  const AddUser({Key? key,this.usersData ,this.editBool}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateOFJoinController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final UserBloc _userBloc = UserBloc();
@override
  void initState() {
  _fullNameController.text=widget.usersData?.fullname??'';
  _emailController.text=widget.usersData?.email??'';
  _codeController.text=widget.usersData?.employeecode??'';
  _descriptionController.text=widget.usersData?.description??'';
  _dateOFJoinController.text=widget.usersData?.dateofjoining??'';
  _numberController.text=widget.usersData?.phonenumber??'';
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Spacer(),
                TextButton(
                    onPressed: () {
                      if(widget.editBool ==true){context.read<UserBloc>().updateUser((User(
                          id: widget.usersData?.id,
                          fullname: _fullNameController.text,
                          description: _descriptionController.text,
                          dateofjoining:
                          DateTime.now().microsecondsSinceEpoch.toString(),
                          email: _emailController.text,
                          employeecode: _emailController.text,
                          phonenumber: _numberController.text)));}else{
                        context.read<UserBloc>().addUpdateUser((User(
                          fullname: _fullNameController.text,
                          description: _descriptionController.text,
                          dateofjoining:
                              DateTime.now().microsecondsSinceEpoch.toString(),
                          email: _emailController.text,
                          employeecode: _emailController.text,
                          phonenumber: _numberController.text)));
                      }
                      // insertUser(User(
                      //   id: int.parse(uniqueId()),
                      //     fullname: _fullNameController.text,
                      //     description: _descriptionController.text,
                      //     dateofjoining: '',
                      //     email: _emailController.text,
                      //     employeecode: _emailController.text,
                      //     phonenumber: _nameController.text));


                      Navigator.pop(context);
                    },
                    child: const Text('Save')),
              ],
            ),
            TextField(
              controller: _emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _fullNameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
                hintText: 'Enter Your Full Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _codeController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Employee code',
                hintText: 'Enter Employee code',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descriptionController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Designation',
                hintText: 'Enter Designation',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
                hintText: 'Enter Phone Number',
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            /*  DatePickerDialog(
                                restorationId: 'date_picker_dialog',
                                initialEntryMode: DatePickerEntryMode.calendarOnly,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2022),
                              ),*/
          ],
        ),
      ),
    );
  }
}
