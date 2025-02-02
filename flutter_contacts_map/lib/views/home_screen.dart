import 'package:flutter/material.dart';
import 'package:flutter_contacts_map/views/contacts_screen.dart';
import 'package:flutter_contacts_map/views/maps_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('App de Contatos'),
        automaticallyImplyLeading: false, // Desativa o ícone de voltar
        backgroundColor: Colors.yellow,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Image.asset(
              'assets/ifpi_logo.png',
              height: 180,
            ),
            SizedBox(height: 40),

            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSquare('Contatos', context),
                      SizedBox(width: 5),
                      _buildSquare('Mapas', context),
                    ],
                  ),

                  SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSquare('Extra', context),
                      SizedBox(width: 5),
                      _buildSquare('Extra', context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Método de navegação para os botões
  Widget _buildSquare(String text, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text == 'Contatos') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactsScreen()),
          );
        } else if (text == 'Mapas') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapsScreen()),
          );
        }
      },

      child: Container(
        width: 160,
        height: 160,

        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),

        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
