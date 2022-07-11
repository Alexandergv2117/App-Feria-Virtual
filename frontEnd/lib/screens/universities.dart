import 'package:feriavirtual/components/headers.dart';
import 'package:feriavirtual/models/models.dart';
import 'package:feriavirtual/providers/universities_provider.dart';
import 'package:flutter/material.dart';
import 'package:feriavirtual/constants/global_variables.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Universities extends StatefulWidget {
  const Universities({Key? key}) : super(key: key);

  @override
  State<Universities> createState() => _UniversitiesState();
}

class _UniversitiesState extends State<Universities> {
  @override
  Widget build(BuildContext context) {
    final universitiesProvider = Provider.of<UniversitiesProvider>(context);
    List<UniversitiesResponse> university = universitiesProvider.universities;

    List<UniversitiesResponse> filter = universitiesProvider.prueba;

    print(filter);

    return Scaffold(
        appBar: HeaderSearch(universities: university),
        body: ListView.builder(
            itemCount: filter.length,
            itemBuilder: (_, int index) =>
                ShowUniversities(universities: filter, index: index)));
  }
}

class EducativeOfferWidget extends StatelessWidget {
  final List<UniversitiesResponse> universities;
  final int index;
  final int kindOf;
  const EducativeOfferWidget({
    Key? key,
    required this.universities,
    required this.index,
    required this.kindOf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = '';
    int numberLic = universities[index].licenciatura;
    int numberMas = universities[index].maestria;
    int numberDoc = universities[index].doctorado;

    if (kindOf == 1) {
      if (universities[index].licenciatura == 1) {
        text = '$numberLic licenciatura';
      } else {
        text = '$numberLic licenciaturas';
      }
    } else if (kindOf == 2) {
      if (universities[index].licenciatura == 1) {
        text = '$numberMas maestría';
      } else {
        text = '$numberMas maestrías';
      }
    } else if (kindOf == 3) {
      if (universities[index].licenciatura == 1) {
        text = '$numberDoc doctorado';
      } else {
        text = '$numberDoc doctorados';
      }
    }

    return Row(
      children: [
        const Icon(
          FontAwesomeIcons.graduationCap,
          size: 12,
          color: GlobalVariables.grayColor,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: GlobalVariables.mediumTextG,
        )
      ],
    );
  }
}

class Becas extends StatelessWidget {
  int beca;
  Becas({Key? key, required this.beca}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (beca == 1) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Beca disponible',
          style: GlobalVariables.mediumTextGreen,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Beca no disponible',
          style: GlobalVariables.mediumTextRed,
        ),
      );
    }
  }
}

class Tipo extends StatelessWidget {
  String tipo;
  Tipo({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tipo == 'Privada') {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          tipo,
          style: GlobalVariables.mediumTextBlue,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          tipo,
          style: GlobalVariables.mediumTextYellow,
        ),
      );
    }
  }
}

class ShowUniversities extends StatefulWidget {
  final List<UniversitiesResponse> universities;
  final int index;

  const ShowUniversities(
      {Key? key, required this.universities, required this.index})
      : super(key: key);

  @override
  State<ShowUniversities> createState() => _ShowUniversitiesState();
}

class _ShowUniversitiesState extends State<ShowUniversities> {
  String? selectedKind = 'Mostrar ambas';
  String? selectedArea = 'Mostrar todas';
  @override
  Widget build(BuildContext context) {
    final universitiesProvider = Provider.of<UniversitiesProvider>(context);
    universitiesProvider.prueba = universitiesProvider.filter(
        selectedKind, selectedArea, universitiesProvider.universities);
    double screenWidth = MediaQuery.of(context).size.width;
    print(universitiesProvider.prueba);

    if (widget.universities[widget.index].getUniversities == null) {
      return Container();
    } else {
      return Column(
        children: [
          Text('Tipo de universidad', style: GlobalVariables.bodyTextB),
          Center(
            child: DropdownButton<String>(
              icon: const Icon(Icons.arrow_downward),
              underline:
                  Container(height: 2, color: GlobalVariables.yellowColor),
              style: GlobalVariables.bodyTextB,
              value: selectedKind,
              items: GlobalVariables.kindOf
                  .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value, style: const TextStyle(fontSize: 24)),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedKind = newValue;
                  print(selectedKind);
                });
              },
            ),
          ),
          Text('Areas', style: GlobalVariables.bodyTextB),
          Center(
            child: DropdownButton<String>(
              icon: const Icon(Icons.arrow_downward),
              style: GlobalVariables.bodyTextB,
              underline:
                  Container(height: 2, color: GlobalVariables.yellowColor),
              value: selectedArea,
              items: GlobalVariables.area
                  .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value, style: const TextStyle(fontSize: 24)),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedArea = newValue;
                  print(selectedArea);
                });
              },
            ),
          ),
          UniversityCard(
              universities: widget.universities,
              index: widget.index,
              screenWidth: screenWidth),
        ],
      );
    }
  }
}

class UniversityCard extends StatelessWidget {
  const UniversityCard({
    Key? key,
    required this.universities,
    required this.index,
    required this.screenWidth,
  }) : super(key: key);

  final List<UniversitiesResponse> universities;
  final int index;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'details',
            arguments: universities[index].universidadId),
        child: Container(
          width: screenWidth * 0.9,
          color: GlobalVariables.backgroundColor,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                  height: 150,
                  width: screenWidth * .5,
                  child: universities[index].rutaEscudo != "NA"
                      ? Image(
                          image: NetworkImage(universities[index].rutaEscudo),
                        )
                      : const Image(
                          image: AssetImage('assets/images/logo.png'),
                        )),
              const SizedBox(height: 5),
              Text(
                universities[index].nombre,
                textAlign: TextAlign.center,
                style: GlobalVariables.h3B,
              ),
              const SizedBox(height: 5),
              EducativeOfferWidget(
                  universities: universities, index: index, kindOf: 1),
              const SizedBox(height: 5),
              EducativeOfferWidget(
                  universities: universities, index: index, kindOf: 2),
              const SizedBox(height: 5),
              EducativeOfferWidget(
                  universities: universities, index: index, kindOf: 3),
              const SizedBox(height: 5),
              Tipo(tipo: universities[index].tipo),
              const SizedBox(height: 5),
              Becas(
                beca: universities[index].beca,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
