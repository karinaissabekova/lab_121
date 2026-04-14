import 'package:bloc_lab/bloc/menu_bloc.dart';
import 'package:bloc_lab/bloc/menu_state.dart';
import 'package:bloc_lab/data/menu_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/menu_event.dart';



class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MenuBloc(MenuRepository())..add(LoadMenuEvent()),
      child: const MenuView(),
    );
  }
}

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        centerTitle: true,
      ),

      body: BlocListener<MenuBloc, MenuState>(
        listener: (context, state) {
          if (state is MenuError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },

        child: BlocBuilder<MenuBloc, MenuState>(
          builder: (context, state) {
            if (state is MenuLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MenuSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<MenuBloc>().add(LoadMenuEvent());
                },
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: const Icon(Icons.fastfood),
                        title: Text(item.name),
                        subtitle: Text("\$${item.price}"),
                      ),
                    );
                  },
                ),
              );
            }

            if (state is MenuError) {
              return const Center(
                child: Text("Error loading menu"),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}