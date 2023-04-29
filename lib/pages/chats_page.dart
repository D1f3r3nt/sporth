import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    final UserDto currentUser = Provider.of<UserProvider>(context).currentUser!;
    final EventosProvider eventosProvider =
        Provider.of<EventosProvider>(context);

    chatProvider.getChats();
    List<ChatDto> chats = chatProvider.chats;

    atras() => Navigator.pushReplacementNamed(context, 'home');

    tapChat(ChatDto chatDto) => Navigator.pushReplacementNamed(
          context,
          'chat-personal',
          arguments: chatDto,
        );

    refresh() async {
      chatProvider.refresh();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: EffectUtils.linearBlues,
        ),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              PopButton(
                text: 'Atras',
                onPressed: atras,
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorsUtils.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70.0)),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Chats',
                          style: TextUtils.kanitItalic_24_black,
                        ),
                      ),
                      Expanded(
                        child: chats.isEmpty
                            ? Center(
                                child: Image.asset('image/no_tienes_chats.png'))
                            : RefreshIndicator(
                                onRefresh: refresh,
                                child: ListView.builder(
                                  itemCount: chats.length,
                                  itemBuilder: (context, index) {
                                    ChatDto chat = chats[index];

                                    if (chat.event == null) {
                                      UserDto otherUser =
                                          chat.getOtherAnfitrion(
                                              currentUser.idUser);

                                      return ChatCard(
                                        onTap: () => tapChat(chat),
                                        nombre: otherUser.nombre,
                                        username: otherUser.username,
                                        image: otherUser.urlImagen,
                                      );
                                    } else {
                                      return ChatCard(
                                        onTap: () {
                                          eventosProvider.eventoChat =
                                              chat.event;
                                          tapChat(chat);
                                        },
                                        nombre: chat.event!.name,
                                        username:
                                            '${chat.event!.diaFormat} - ${chat.event!.timeFormat}',
                                        image: chat.event!.imagen,
                                      );
                                    }
                                  },
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
