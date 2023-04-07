import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class OtherUserPage extends StatelessWidget {
  OtherUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deportesProvider = Provider.of<DeportesProvider>(context);
    final user = ModalRoute.of(context)!.settings.arguments as UserDto;
    final List<DeportesLocal> listDeportes = deportesProvider.deportes.where((element) => _filterDeportes(element.id, user.gustos)).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtils.white,
        title: Text(
          user.username,
          style: TextUtils.kanit_18_grey,
        ),
        centerTitle: true,
        leadingWidth: 100.0,
        leading: PopButton(
          text: 'Atras',
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: ColorsUtils.white,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        user.seguidores.toString(),
                        style: TextUtils.kanitItalic_24_blue,
                      ),
                      const Text(
                        'Seguidores',
                        style: TextUtils.kanit_18_black,
                      )
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.urlImagen),
                    radius: 50.0,
                  ),
                  Column(
                    children: [
                      Text(
                        user.seguidos.length.toString(),
                        style: TextUtils.kanitItalic_24_blue,
                      ),
                      const Text(
                        'Seguidos',
                        style: TextUtils.kanit_18_black,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Text(
                '${user.nombre} ${user.apellidos}',
                style: TextUtils.kanitItalic_24_black,
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: user.logros.length,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CardAchievement(),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 80.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonInput(
                          text: 'Seguir',
                          funcion: () {},
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      IconButton(
                        onPressed: () {
                          print('Enviar');
                        },
                        icon: const Icon(Icons.chat),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listDeportes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ToastCard(
                        active: true,
                        nombre: listDeportes[index].nombre,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 0 + 1,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      'image/usuario_no_tiene_evento.png',
                      height: size.height * 0.4,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _filterDeportes(int id, List<int> gustos) {
    return gustos.contains(id);
  }
}
