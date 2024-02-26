import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const Aplicativo());
}

class Aplicativo extends StatefulWidget {
  const Aplicativo({super.key});

  @override
  State<Aplicativo> createState() => _EstadoAplicativo();
}

//variaveis
//"_" indica que a classe é privada
class _EstadoAplicativo extends State<Aplicativo> {
  int contador1 = 0;
  int contador2 = 0;
  var _tempo = 60;
  late Timer _timer;
  bool _clique = true;
  Color cor1 = Colors.black;
  Color cor2 = Colors.black;
  double posicao = 0;

  void movimentar(){
    setState(() {
      if (contador1 > contador2) {
        posicao = 50.0;
      } else if (contador2 > contador1) {
        posicao = MediaQuery.of(context).size.width - 150.0;

      } else {  
        posicao = MediaQuery.of(context).size.width / 2 - 50;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _iniciarTimer();
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _iniciarTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_tempo > 0) {
          _tempo--;
        } else {
          _timer.cancel;
          _clique = false;
        }
      });
    });
  }

  void mudarCor() {
    if (contador1 > contador2) {
      cor1 = Colors.red;
      cor2 = Colors.black;
    } else if (contador2 > contador1) {
      cor1 = Colors.black; 
      cor2 = Colors.red;
    } else {
      cor1 = Colors.blue;
      cor2 = Colors.blue;
    }
  }

  void _reiniciar() {
    setState(() {
      contador1 = 0;
      contador2 = 0;
      _tempo = 60;
      _clique = true;
    });
    _timer.cancel();
    _iniciarTimer();
  }

  @override
  Widget build(BuildContext context) {
    mudarCor();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 0, 79),
          title: const Text(
            'Jogo contador',
            style: TextStyle(color: Colors.white),
          ),
        ),

        //corpo do aplicativo +  centralização
        body: Stack(
          children: [
         Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contador 1: $contador1',
                style: TextStyle(fontSize: 30, color: cor1),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Contador 2: $contador2',
                style: TextStyle(fontSize: 30, color: cor2),
              ),
              const SizedBox(height: 30),

              Text('Tempo restante: $_tempo segundos',
               style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          bottom: 100.0,
          left: posicao,
          curve:  Curves.easeInOut,
          child: Image.network(
            'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAh1BMVEX///+RkZEAAAD8/PyTk5OPj4/5+floaGjv7++IiIiWlpZeXl5kZGS3t7fIyMiMjIwvLy+Dg4MbGxvKysqlpaVRUVFbW1sUFBSurq5/f38ICAjp6enz8/PT09PZ2dkrKysjIyN3d3efn58RERFBQUE0NDRvb2+ysrJMTEzf399GRka/v787OzsYvSFgAAAROklEQVR4nO1diXqiMBAGciCRJeKBRcFz626Xvv/z7cwEEBVqbSvUfvx2txYi5ndC5ky0rB49evTo0aNHjx49evTo0aNHjx49evTo0aNHjx8PJi0Gj4vDlsRH3alHgzQcz8AYncD/fwQuaQA5esgfwDDyfT+sGYrMenF9fzhtv0dfDQfw9/IwDN0UT8Xt9+jrYASXM2Tn56RcOQvHCR95qmEoqJwhO59TgNcKT4U469TNRQ+B5WAwSJzxeBwNlslSygoLuVwm2WazmcdJMlhKINldNz+BGQpp5wke4ZNllcQODmw8pZWLp349KsO/eKNxrgXQWDhJ9dQUeD17Nuc+PJkHDzpImZEht4VPMqyemwLlUSyEjaf2mXxQGdLgVIITDWdQPYUyHIVcqyEynNCxh1L+cvlvFkWRO/R9BUPRrWfoKc7j4dCFlv9mHBVIV/29HSxBTsMdF5y/xRCmGiUU32PjC535vbHESSYSyhZvMRT4CWg7XBPDxzLDl8jJ5SF/U4Z4VghNDF3roaYbNqBRyvmOZEgzzYmAnlAfhjCX2jbX3pgYPpZSHBgZAj0bSSgAHomAZkZPdnCEzsFZbwNH/K67fCNOGdr4iwSFDOckXrsEJxn2DL8beoaPzJDRDzH0Kyxs0cjQ1pt8Lu267+8C6gRwBA1DwVXBUDQyFCXDx1D4jGKg0uhDu+TxFkOe68NHMWkYW06yIAPPfu5zW6urDG0VPm/Gm8NkMgm67vx7IGVy2O/3a+2FoUdj8CpDboee9qL5fOx03fv3IUEbbcxtpY6D9ApDaKnIsuu67+8Ck2hnjwUYpLb5ucYQz9q2+zAMrQpD+10yNOgZfiP0DH8cQ57/nzNkVkZRGcVt/tgMj7Mo+PigHG3j5ibMCvDJzPNCT/GfwRAcDHc0Gq2z1SpNGRh0k3S10pvR6Hf4M2QoCm2egO+AkX3yIEwk6mcwBOdI+85i4QwYBtOQH/zeQZtn/agMMVDvcK64iUKBB0W9p8xMERNFGa7jcqaFxg/DEChk0+l0NxsOo5ibUWrHEfy1g8MZzKUv8HsawhFX5/Os9uG0j6/quvfvQZ7Npai+X0YTuRJ8gUqijCYqzothzL35Y0UxMGktE4zqH+M0wFBt4F6M4APIFvCkLk7zMKluyiAlZ5EoYSukcYBTgVMbiXIfhh9jKei77JQh/K+f1+v1drJaTX+P1hv3guEMXpV23ft3QUpK62Jeu8oQHHlw+vHUCH6HVUVBDBeLB5hLqRhPMkmpX5ppdNX25HnGdxQWwZt8AAuKtRGsb12VYYrxwG4ZlgwxklGBYfgc8lOGvMLQOqlJ+WYwpXjw61D0N+K2PnEgVESKXp26ViocVxh+65giFeO5rj8EdQ6ItvzMRVLbCFS7p+yTwwo1vsHWHfqiaxrNKIrxhjvBEQpDiSdTCh5USuC9d3oYk4n4C18+65qHQVnby6yiwsAU45EpU95hZzKkrD0ITfDqYSGUNoyJ4UmZX92zFiArpXaMlen3ohgvOplIbkHOsFLml1+dtVwtjX4eVuVhYd5gwPKMSl6MNx4PtbhOpp7h4rzML8H3WeIjeatHXw3MvZRKLxrkHy+6fBtwajWMug8L8bzMLyvexsnaZIiUfPO+C8cvdLQpxsMw98cZ6vMyv2Dh5I9WszYYj/BLGSayYIjFeFzr8yjaLTI8L/P7NSZ+jjP+1SZD1AuukaDjbIuDT2SRcQ42ygXDBsroNorTaRXL/BZOKcPJOLdY962OUpzflO8fhhj5fJ3NohnimYJLMELDyD3C57xZonWNuYuczCVns39I9zfYEdtW/Q7UEPg7Le3JAljIJfyTQ1ib2MSwprFNDBcnR6f0nm0yNMt5LBmUXs+RIRA6nHb6LL5/ctudN4Yxq4hhcdkF/kwtmbTLkOxrYBnMi15UZKjFoXrE2QnRKMSLxmDRmcrvrmWYI73oy0aDhTk8OfSEFWwN80xt43qG7aJ863LGo2AZ9FdjHeXTRWP/kh0MXcpkXDZ24To7PFXO0tPi/bZt2W4lw2U+drI9hc+g0yPzkVPAjZEtQJ2uZ9jUWGlOgbnEOtoShLhdhnD/DBgBLQ8THS06TZFBRi7/dYbnjcHtUijDQyLN5bti6BzLfgOT9KyIhQ6ThN8hw/PGYLjjBbcFnZJh2A4/y3o12nj41/eNpgat7fuhfey0TP5kf6bL943Si8aac98fYrTAXD9X/9E/1XaEI9jnn+1Ia5jnq2JJns0sIvNOo8KoKg3+RmOwazS6/aX7cpxLW3YSWTbPu/AcCoU2ZqXTfx1cznRkqKhopoFhXWMhhoWqnBbv2HqQKitiZKMQ3J6qDK3BK3YaTZ+802bhxRHXGkPrMxleLPC7I4IJVtkFE1XKMNZanHQ68V//jf6UkwcMYRVqoUvY1xoLzUtjIEzp/bJs1RZDZ04YF7ehsx+Px3v/RB8uB8lAlpMHjLtwPT5i/o7Gm3lh9O7N+80Xrc2lzjmoI6AteFWJM5MuKxXAuPqKmxqX6IzhgjIxQ650SJ0uwmNW0WkfxhzflI0X72u8qPyYPztiWDg6Q5ghw3q7NEJVOf9w4xKtLfyuuOW++xveeR2Bgo7Bt/OGoKr59OmIP6ixY4xPwCn39+LGxovh4VC+13DaQRZVWh4Mn3VoFAC3MTh/6rZzgYF8it4IKqy5pfFikbIyG8XAD26dICAEhs+gD3le1K3OOo3hM1tRxMKouJsaO6vS95UUqO2EIWp8o9Kxmlmch15QYAr/Qb+jWxsDw3Jktp49lewF1HBwGD2PfofYr9wcU+56dMSm6t8rf31j49E0+BW8tMrrCGZlm/1i72KVoYA+5+kjZQs4cER12YEOMZl/S+P4dbHvIIqRM2QTqhKByaEoWye5aKX00f489ZmwqvSmxmFh2XVDERzfhePbQuOUUVbM4spXXttrYWuN0nt/Y9tbd8cQgxeol12T7C26h0mLpgApVkbRbPn+xttuZIjpSrQlMang+PzYY9vkr6teEkcbzLDAhnbelniKi8ZVGZIHBbYrRoRb1xJ5oSjJ0Bdv50Np9lc5N57/hwpP8HckUmPDsIuoPsbZM7wPD2/kJRCK7roytV/QFoo3R/uP0Bjg2LG2s9zFFl0pFeNd6SlNJJjOwEkFH/hECUPyKsNjPK7dEA0bsJfVKv3zul5vXM3fTPmiftjtdop+CMo81O46Qe79BjtA45sNrvfrKxlalCEdxaDtub6S04aBmQ3kIKkA/pSDwfLpOkOF9gDuArNpNcvNwMancnVtooR1fStz3TCGw9reSfl0Wjckaq8E0xQFbIJWN+jLKxXGXuNsqOwitAbKUk/qdhVkyVNFVeAeIQ33JYWk9lmb0cREmlG6CRsHKGpyQdBce5PLazBpDXZalNCCVlo2MhxnVosb9PkH38ViO/+yJKGUIUUcKeoIP8uai4BE0kkFT7opk8q30dCPojY36MPbwic93jCuhD7LMFx8+Mw631EoCIVqGvQ7cPqf24zTUCgJJgbVdB/CHSWL1fVNypqdZiHkRDSaqFjhGCPD1jboQ4aX6aRCfDgpCn5zJezK4/n8dPGxldH0VqOJTQxx3ycYvWpw48fNUnCsNO3XczkkvhVDEOGE8rk3B1WwoCS0vz9DUBIT2g/pRoImZhif19x+Q4bQwYkpmrpRhPSCuFZhtMnwuCVpZCwQ8P500St0dj2tveBYGX3xapb7z3UnkSFYoVQZfrwmNz/hpmB4X9tNen//zma4O26MFhc+CctqUs71bgJeQJ1+z7EMJkEqm3cxCdKX1S8iJ/IBgdH8LehejasAhrO/0XByX+ONNntUgqZ1W5OPX8gQrDS9G8g3c7UTrcNp0pyPx8qalThGNEz2JkLPEq0LLIK7dyntX2KIpc6oFqjqpTAnUY9NB0XtTx0kMFRiKq8wNMPUjAu6/XxjmNuatgKd3Nc6NRt22kTKVC655boYrkCGb+kJZk3A/Jq+NQsBw7Qa2PKeHay2UlSVi4WZuNnpXUEMi2iSHpsP2NwzehvHylSgNxIIQmjzhgxwBGRxHJdr20KMRPnKbMdEaZxxcN+glLkPzeoXOzTRRDOo9IWLxKoBJMbiMN5im8SL421e05xXe7GLD4VXGUa47A0/0jY2rJ3lGSKzthcZuvlto2tGT5WhxNqECa5t29nCC0qGllUTSWMno9RXmvyOFhlSkFdp28TauKpneGrZMJzyU+jdcgcvDfIWlqnHPd/m68gQZxrcREOrVmWowJ1RcPfnEeEmhlXlDDIMvRBH6WAaevFxlOZCrGeYawuFBZltyhAHaTz03QNo4WFo84ZRygarl7QQFmOYbFxieCbNgsLrB4mmq9VlkKNkSBrfR23f1n0YGW3BqaxujLcgx/FzzpD6IIM4DLeFpcZYIbLiPP01wfzhxTr1kiEVgGGcZhO3w9Cs8YVRSdnp8XEJ17kMafuL1FM8bko5mBHMJpgwlUS2MljL+xBhVg9DO3rTeXbfgNQMC3dwg2MTTeQNDM2CjDTkOqbygjpLW0pM8KS41e7FhoInDEmG69BW4mBk2IJdCjeiP99sno/RxDOGkiUw8lLMOVVXKFYoMFrjBxYM3+12Uhr/sF6G3F9sNq8hfKy0OOPOW9TjckDpbDZzX3heaDcxZMmUC+9FJlJuheI1piQQSv5oPJXI5RQ+spdqMckpQ61tb/tKXzMwuPvXDLDiCx1wJ3Kly2ji+X0o4bT3go3Bqb00d6h6PXkCJTDB8aq4irGysp4hGfW5B8za+aqIPJqo+XEZ8/koxU7rFOcE0CZ1UX3oazKFuTJgprGHjZsYgisTj9qOJoK9X12zdTFKlRfGE/QUXU/XZGZw5lxOwxDJHxs3MdxpW4/ajAgPD+hvn0T1L2Q4maQp6ncrTdPJpdePt9JgtYJTuNdL0bhcMn16H5qofpuVe5IVmZlGGRqLMykiNjW5p3yFX2EM5I2LsxfaYpy1WrlX5J6a9SGzjI4zpnUdwTwcJ83UWDamkzUM9xlrs3Ivz5BujtuR1dk0uVldu5t8abaxk8bl6QuGi6zNyj388N+2aT59/QuG83ZXq1vWXRnWyfBnMexleH/c+z6s855aZnhai0H1d3diSCUoUfujNN9TYaOLUrz7MSwCUC3vqQAPnyILQlO64p6jVJs1DPt2a6LgH8VOFBc7U5Z+p7kUFzWamFC7e5ugh3ZYLObjmLaWb4qXfuYdShGGXuxFzt7ZtDzTSCsNguDp+fV5baov7yVDrE0c6SDIavyTFmA2GijyFneRYdhhJbuVV7L73L6fDI/rTLvA/Rie5y1+HsNehm2hWFGSf4vF1zPE63a6KijfId+1cZsZMGy+miHuasM7XRWUyGA9n+99AWpfcBHWhH0/fnFkqGPtbUfzeYcruxhWAG/nm/FrzFVdqfPHL42JNX+zGT8/BfUlxq3A5N+LNaTeF4/SfHvBVXffbCmlCZUVDL96lAqbFiFMOli+fewGPWJM7gmu69IvH74uwy1bSYZp57vusl3ku37kHvxdOsnSz+/ByZYZ3N2uO6QygcPq9lLcr4XJF9FGNZGnveknVydR5lgLEaIeor2+KFX8+X5+ArgBtNkJa2grvvv0tMesFW5YRLVIsthAu0uYOj3z5Thc27tPrzCTbIWL95DhEFOLsuvvDJS0GukXZRSnavd0/RVX8VJ88exQytPauK6B+5cS1MevUVzC6XoCrYXZVQ3uyD8f/9BLhstvI7gKyn3jPjFUKwy/Ib6UYat7W78Xv/7lO+Pq7OnXx5CZS0Szf8tvOEiP2DofRtddfw+YTKLrTB6aIWP+dSaPzFBagx8uQ7AlB8tk8EF03fv3oLbW8kfhZ7Pr0aNHjx49evTo0aNHjx49evTo0aNHjx49evTo0aNHj0fAf7BQHfXhikZ/AAAAAElFTkSuQmCC',
             width: 100,
             height: 100,
             ), 
          ),
        ],
        ),

        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: FloatingActionButton(
                //onPressed: _clique ? (){setState(() {});} :null,
                onPressed: () {
                  setState(() {
                    if (_clique == true){
                    contador1++;
                    movimentar();
                    }
                  });
                },

                tooltip: 'Incrementar Contador 1',
                child: const Icon(Icons.add),
              ),
            ),
            FloatingActionButton(
              onPressed: _reiniciar,
              tooltip: 'Zerar Contagem',
              child: const Icon(Icons.refresh),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.00),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if(_clique = true){
                    contador2++;
                    movimentar();
                    }
                  });
                },
                tooltip: 'Incrementar contador 2',
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
