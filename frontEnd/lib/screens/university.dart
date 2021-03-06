import 'package:feriavirtual/components/components.dart';
import 'package:feriavirtual/models/universities_model.dart';
import 'package:feriavirtual/providers/universities_provider.dart';
import 'package:feriavirtual/screens/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feriavirtual/constants/global_variables.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:feriavirtual/components/downloadButton.dart';
import 'package:feriavirtual/components/universityInfo.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_whatsapp/open_whatsapp.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../models/models.dart';

class University extends StatelessWidget {
  static const String routeName = '/details';
  const University({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final universitiesProvider = Provider.of<UniversitiesProvider>(context);

    final int idUniversity = ModalRoute.of(context)!.settings.arguments as int;

    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: universitiesProvider.getOnDisplayUniversityInfo(idUniversity),
        builder: (_, AsyncSnapshot<UniversityInfo> snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              appBar: HeaderInfo(),
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final university = snapshot.data!;

          int welcomeId = university.videos.indexWhere((e) => e.seccionId == 1);

          //Configuración para los videos
          YoutubePlayerController controller = YoutubePlayerController(
            initialVideoId: YoutubePlayerController.convertUrlToId(
                    university.videos[welcomeId].recurso)
                .toString(),
            params: const YoutubePlayerParams(
              showFullscreenButton: true,
            ),
          );
          return Scaffold(
              appBar: const HeaderInfo(),
              body: Center(
                child: SizedBox(
                  width: screenWidth * 0.9,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        WelcomeWidget(
                            university: university, controller: controller),
                        const SizedBox(height: 40),
                        EducationWidget(university: university),
                        const SizedBox(height: 40),
                        if (university.becas[0].recurso != "NA")
                          ScholarShipsWidget(university: university),
                        const SizedBox(height: 40),
                        VideosWidget(
                          university: university,
                          controller: controller,
                          screenWidth: screenWidth,
                        ),
                        const SizedBox(height: 40),
                        CarouselWidget(university: university),
                        const SizedBox(height: 40),
                        DownloadButton(
                            url: university.admision,
                            fileName: "PROCESO DE ADMISIÓN"),
                        const SizedBox(height: 40),
                        ContactWidget(
                            screenWidth: screenWidth, university: university),
                        const SizedBox(height: 40),
                        /*Container(
    child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(widget.galleryItems[index].image),
          initialScale: PhotoViewComputedScale.contained * 0.8,
          heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
        );
      },
      itemCount: galleryItems.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          ),
        ),
      ),
      backgroundDecoration: widget.backgroundDecoration,
      pageController: widget.pageController,
      onPageChanged: onPageChanged,
    )
  );*/
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    Key? key,
    required this.screenWidth,
    required this.university,
  }) : super(key: key);

  final double screenWidth;
  final UniversityInfo university;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Contacto',
          textAlign: TextAlign.center,
          style: GlobalVariables.h2B,
        ),
        const SizedBox(height: 20),
        Information(screenWidth: screenWidth, university: university),
        const SizedBox(height: 20),
        Social(university: university)
      ],
    );
  }
}

class Social extends StatelessWidget {
  const Social({
    Key? key,
    required this.university,
  }) : super(key: key);

  final UniversityInfo university;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var item in university.redesSociales)
          if (item.nombre == "FACEBOOK")
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.facebookF,
                    size: 30,
                    color: Color.fromARGB(255, 24, 119, 242),
                  ),
                  onPressed: () {
                    if (item.recurso.startsWith('https') ||
                        item.recurso.startsWith('www.')) {
                      launch(item.recurso);
                    } else {
                      launch('https://www.facebook.com/' +
                          item.recurso.substring(1));
                    }
                  }),
            )
          else if (item.nombre == "INSTAGRAM")
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.instagram,
                  size: 30,
                  color: Color.fromARGB(255, 225, 48, 108),
                ),
                onPressed: () {
                  if (item.recurso.startsWith('https') ||
                      item.recurso.startsWith('www.')) {
                    launch(item.recurso);
                  } else {
                    launch('https://www.instagram.com/' +
                        item.recurso.substring(1));
                  }
                },
              ),
            )
          else if (item.nombre == "WHATSAPP")
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    size: 30,
                    color: Color.fromARGB(255, 7, 94, 84),
                  ),
                  onPressed: () {
                    if (item.recurso.startsWith('https') ||
                        item.recurso.startsWith('www.')) {
                      launch(item.recurso);
                    } else {
                      FlutterOpenWhatsapp.sendSingleMessage(item.recurso,
                          "Hola, me gustaría solicitar información respecto a...");
                    }
                  }),
            )
          else if (item.nombre == "TWITTER")
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.twitter,
                  size: 30,
                  color: Color.fromARGB(255, 29, 160, 242),
                ),
                onPressed: () => launch(item.recurso),
              ),
            )
          else if (item.nombre == "PAGINA WEB")
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.globe,
                  size: 30,
                  color: GlobalVariables.primaryColor,
                ),
                onPressed: () => launch(item.recurso),
              ),
            )
      ],
    );
  }
}

class Information extends StatelessWidget {
  const Information({
    Key? key,
    required this.screenWidth,
    required this.university,
  }) : super(key: key);

  final double screenWidth;
  final UniversityInfo university;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.phone,
                  size: 20,
                  color: GlobalVariables.primaryColor,
                ),
                onPressed: () =>
                    launchUrl(Uri.parse("tel:" + university.telefono)),
              ),
              Text(
                university.telefono,
                style: GlobalVariables.bodyTextB,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.at,
                  size: 20,
                  color: GlobalVariables.primaryColor,
                ),
                onPressed: () => launchUrl(Uri.parse("mailto:" +
                    university.correoElectronico +
                    "?subject=Acerca de la universidad&body=Hola, me gustaría solicitar más información sobre...")),
              ),
              Flexible(
                child: Text(
                  university.correoElectronico,
                  style: GlobalVariables.bodyTextB,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.locationDot,
                  size: 20,
                  color: GlobalVariables.primaryColor,
                ),
                onPressed: null,
              ),
              Flexible(
                child: Text(
                  university.direccion,
                  style: GlobalVariables.bodyTextB,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key? key,
    required this.university,
  }) : super(key: key);

  final UniversityInfo university;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Fotos',
          textAlign: TextAlign.center,
          style: GlobalVariables.h2B,
        ),
        const SizedBox(height: 20),
        InteractiveViewer(
          minScale: 0.1,
          maxScale: 3,
          scaleEnabled: true,
          panEnabled: false,
          child: CarouselSlider.builder(
            options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
            itemCount: university.fotos.length,
            itemBuilder: (context, index, realIndex) {
              if (university.fotos[index].recurso == "NA")
                return Image.network(university.rutaEscudo);
              else
                return Image.network(university.fotos[index].recurso);
            },
          ),
        )
      ],
    );
  }
}

class VideosWidget extends StatelessWidget {
  const VideosWidget({
    Key? key,
    required this.university,
    required this.controller,
    required this.screenWidth,
  }) : super(key: key);

  final UniversityInfo university;
  final YoutubePlayerController controller;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Videos',
            textAlign: TextAlign.center,
            style: GlobalVariables.h2B,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: ListView.builder(
                controller: ScrollController(),
                itemCount: university.videos.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) => Container(
                      width: screenWidth * 0.75,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          YoutubePlayerIFrame(
                            controller: controller,
                            aspectRatio: 16 / 9,
                          ),
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}

class EducationWidget extends StatelessWidget {
  const EducationWidget({
    Key? key,
    required this.university,
  }) : super(key: key);

  final UniversityInfo university;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Oferta educativa',
          textAlign: TextAlign.center,
          style: GlobalVariables.h2B,
        ),
        const SizedBox(
          height: 20,
        ),
        /*Text(
          'Licenciatura',
          textAlign: TextAlign.center,
          style: GlobalVariables.h3Blue,
        ),
        const SizedBox(
          height: 10,
        ),*/
        SizedBox(
          height: 50,
          child: ListView.builder(
              controller: ScrollController(),
              itemCount: university.carreras.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => DownloadButton(
                    url: university.carreras[index].recurso,
                    fileName: university.carreras[index].nombre,
                  )),
        ),
      ],
    );
  }
}

class ScholarShipsWidget extends StatelessWidget {
  const ScholarShipsWidget({
    Key? key,
    required this.university,
  }) : super(key: key);

  final UniversityInfo university;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Becas',
          textAlign: TextAlign.center,
          style: GlobalVariables.h2B,
        ),
        const SizedBox(
          height: 20,
        ),
        /*Text(
          'Licenciatura',
          textAlign: TextAlign.center,
          style: GlobalVariables.h3Blue,
        ),
        const SizedBox(
          height: 10,
        ),*/
        SizedBox(
          height: 50,
          child: ListView.builder(
              controller: ScrollController(),
              itemCount: university.becas.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => DownloadButton(
                    url: university.becas[index].recurso,
                    fileName: university.becas[index].nombre,
                  )),
        ),
      ],
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    Key? key,
    required this.university,
    required this.controller,
  }) : super(key: key);

  final UniversityInfo university;
  final YoutubePlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UniversityImage(image: university.rutaEscudo),
        const SizedBox(height: 10),
        Text(
          university.nombre,
          textAlign: TextAlign.center,
          style: GlobalVariables.h2B,
        ),
        const SizedBox(height: 20),
        Text(
          'Bienvenida',
          textAlign: TextAlign.center,
          style: GlobalVariables.h3Blue,
        ),
        const SizedBox(
          height: 10,
        ),
        YoutubePlayerIFrame(
          controller: controller,
          aspectRatio: 16 / 9,
        ),
      ],
    );
  }
}
