import 'package:flutter/material.dart';

class AbvCard extends StatelessWidget {
  const AbvCard({
    Key key,
    @required double abv,
    @required double restWord,
  }) : _abv = abv, _restWord = restWord, super(key: key);

  final double _abv;
  final double _restWord;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                "Alkoholgehalt",
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                "Alkoholgehalt berechnet aus Stammwürze und falls vorhanden Restextrakt. (Berechnung ohne Restextrakt ist sehr ungenau!)",
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'ABV: ${_abv != null ? "${_abv.toStringAsFixed(2)}%" : "---"}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            _restWord == null
                ? Text(
              'Da kein Restextrakt angegeben wurde, wird die ungenaue Abschätzung verwendet',
              style: TextStyle(
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            )
                : null,
          ].where((element) => element != null).toList(),
        ),
      ),
    );
  }
}
