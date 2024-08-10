import 'package:flutter/material.dart';
import 'package:spectacle/api/salle_service.dart';
import 'package:spectacle/api/salle_service.dart';
import 'package:spectacle/models/salle_model.dart';
import 'package:spectacle/modules/proprietaire/proprietaire_screen.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/stylish_dropdown.dart';

class SalleForm extends StatefulWidget {
  final SalleModel salle;
  final Function(SalleModel)? onSubmit;

  SalleForm({Key? key, required this.salle,  this.onSubmit}) : super(key: key);

  @override
  _SalleFormState createState() => _SalleFormState();
}

class _SalleFormState extends State<SalleForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titreController;
  late TextEditingController _subTitreController;
  late TextEditingController _descriptionController;
  late TextEditingController _prixController;
  late TextEditingController _occupationController;
  late TextEditingController _localNameController;
  late TextEditingController _nbrPlaceController;
  late TextEditingController _starController;
  late TextEditingController _typeSalleController;
  late TextEditingController _idProController;

   late SalleService salleService;
  
  
  String? selectedValue;
  List<String> dropdownItems = [
    'Occupée',
    'Libre',
    
  ];

  @override
  void initState() {
    super.initState();
    salleService = SalleService();
   
    _titreController = TextEditingController(text: widget.salle?.titre ?? '');
    _subTitreController = TextEditingController(text: widget.salle?.subTitre ?? '');
    _descriptionController = TextEditingController(text: widget.salle?.description ?? '');
    _prixController = TextEditingController(text: widget.salle?.prix.toString() ?? '');
   // _occupationController =  (selectedValue.toString() == 'Occupée' ? 1 : 0) as TextEditingController; //TextEditingController(text: widget.salle?.occupation.toString() ?? '');
    _localNameController = TextEditingController(text: widget.salle?.localName ?? '');
    _nbrPlaceController = TextEditingController(text: widget.salle?.nbrPlace.toString() ?? '');
    _starController = TextEditingController(text: widget.salle?.star.toString() ?? '');
    _typeSalleController = TextEditingController(text: widget.salle?.typeSalle ?? '');
    _idProController = TextEditingController(text: widget.salle?.idPro.toString() ?? '');

    
  }

  void add(SalleModel salle) async {
    if(await salleService.add(salle)){
      FocusScope.of(context).unfocus();
      NavigationServices(context).gotoSalleImage();
    }else{
      print("erreru de l'envoye");
    }
  }

  @override
  void dispose() {
    _titreController.dispose();
    _subTitreController.dispose();
    _descriptionController.dispose();
    _prixController.dispose();
    _occupationController.dispose();
    _localNameController.dispose();
    _nbrPlaceController.dispose();
    _starController.dispose();
    _typeSalleController.dispose();
    _idProController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.salle == null ? 'Ajouter une salle' : 'Modifier la salle'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFormField(_titreController, 'Titre', (value) => value!.isEmpty ? 'Veuillez entrer un titre' : null),
                _buildTextFormField(_subTitreController, 'Sous-titre', (value) => value!.isEmpty ? 'Veuillez entrer un sous-titre' : null),
                _buildTextFormField(_descriptionController, 'Description', (value) => value!.isEmpty ? 'Veuillez entrer une description' : null),
                _buildTextFormField(_prixController, 'Prix', (value) => value!.isEmpty ? 'Veuillez entrer un prix' : null, keyboardType: TextInputType.number),
               _buildDropdownField(dropdownItems),
                _buildTextFormField(_localNameController, 'Nom du local', (value) => value!.isEmpty ? 'Veuillez entrer le nom du local' : null),
                _buildTextFormField(_nbrPlaceController, 'Nombre de places', (value) => value!.isEmpty ? 'Veuillez entrer le nombre de places' : null, keyboardType: TextInputType.number),
                _buildTextFormField(_starController, 'Étoiles', (value) => value!.isEmpty ? 'Veuillez entrer le nombre d\'étoiles' : null, keyboardType: TextInputType.number),
                _buildTextFormField(_typeSalleController, 'Type de salle', (value) => value!.isEmpty ? 'Veuillez entrer le type de salle' : null),
                _buildTextFormField(_idProController, 'ID du propriétaire', (value) => value!.isEmpty ? 'Veuillez entrer l\'ID du propriétaire' : null, keyboardType: TextInputType.number),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed:_submitForm,
                    child: Text(widget.salle == null ? 'Ajouter' : 'Modifier'),
                    style: ElevatedButton.styleFrom(
                      //primary: AppTheme.primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label, String? Function(String?) validator, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownField(List<String> dropdownItems) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0,),
      child: StylishDropdown(
          selectedValue: selectedValue,
          items: dropdownItems,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
          },
          hintText: 'Choisissez une option',
        ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final salle = SalleModel(
        idSalle: widget.salle?.idSalle ?? 0,
        titre: _titreController.text,
        subTitre: _subTitreController.text,
        description: _descriptionController.text,
        prix: double.parse(_prixController.text),
        occupation: selectedValue == 'Occupée' ? 1 : 0,
        localName: _localNameController.text,
        nbrPlace: int.parse(_nbrPlaceController.text),
        star: int.parse(_starController.text),
        typeSalle: _typeSalleController.text,
        idPro: int.parse(_idProController.text),
        createDate: widget.salle?.createDate ?? DateTime.now().toIso8601String(),
        updateDate: DateTime.now().toIso8601String(),
      );
print('app');
      //widget.onSubmit!(salle);
      add(salle);
      
    }
  }
}