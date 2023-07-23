import 'package:demoapps/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


import '../database/model.dart';
import '../utils/text_field_widget.dart';

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

  final FocusNode _emailFocusNode =FocusNode();
  final FocusNode _fullNameFocusNode =FocusNode();
  final FocusNode _codeFocusNode =FocusNode();
  final FocusNode _descriptionFocusNode =FocusNode();
  final FocusNode _numberFocusNode =FocusNode();
  final UserBloc _userBloc = UserBloc();
  var selectedDate ;

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
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                               selectedDate.toString(),
                            email: _emailController.text,
                            employeecode: _emailController.text,
                            phonenumber: _numberController.text)));
                        }
                        Navigator.pop(context);
                      },
                      child: const Text('Save')),
                ],
              ),
              TextFieldWidget(
                _emailController,
                'Email',
                _emailFocusNode,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                _fullNameController,
                'Full Name',
                _fullNameFocusNode,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                _codeController,
                'Employee code',
                _codeFocusNode,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                _descriptionController,
                'Designation',
                _descriptionFocusNode,
                textInputAction: TextInputAction.next,
              ),


              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                _numberController,
                'Phone Number',
                _numberFocusNode
                ,


                textInputAction: TextInputAction.done,
              ),

              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child:  Text(selectedDate ==null? 'Select date':selectedDate.toString()),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final String formatted = formatter.format(picked);
        selectedDate = formatted;
      });
    }
  }
}
