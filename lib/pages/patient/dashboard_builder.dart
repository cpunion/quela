import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/pages/patient/dashboard_body.dart';
import 'package:quela/utils/hex_code.dart';
import 'package:quela/widgets/info_bar.dart';

class PatientDashboardBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    final PatientsBloc _patientBlock = BlocProvider.of<PatientsBloc>(context);
    return BlocBuilder(
      bloc: _patientBlock,
      builder: (BuildContext context, PatientState state) {
        final patient = (state as PatientLoaded).patient;
        return Scaffold(
          //backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: HexColor("#0f1923"),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Patient Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 17.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    authBloc.dispatch(LoggedOut());
                  },
                  child: Icon(Icons.power_settings_new),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              InfoBar(person: patient),
              Container(
                margin: EdgeInsets.only(
                  top: 140.0,
                ),
                child: ScreenBuilder(patient: patient),
              ),
            ],
          ),
        );
      },
    );
  }
}
