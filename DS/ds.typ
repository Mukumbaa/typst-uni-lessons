#align(center)[
  #heading()[= Decision Science]
]

#let Space = "    "
#v(1em)
= Lezione 1
== Ottimizzazione

Un problema di ottimizzazione consiste nel
determinare un vettore $x in RR^n$, in modo
tale che sia minima una funzione $f(x)$, detta
*Funzione Obiettivo* e siano soddisfatti
alcuni vincoli $x in X subset.eq RR^n$, in cui
$X$ è detto *Spazio Ammissibile*. Un problema
di ottimizzazione si può scrivere come:

#v(1em)
$
cases(min f(x), x in X)
space
"oppure"
space
cases(min f(x), g_i (x) <= 0 ", " i=1...l)
$
#v(1em)

Si ricerca, quindi, fra tutte le soluzione
ammissibili, quella che forinsce il valore
ottimo della funzione obiettivo.

Il particolare, studieremo questi problemi
di ottimizzazione in cui le componenti di $x$
(o _variabili decisionali_) sono legate in
modo lineare ai dati. Questi problemi sono
detti di Programmazione Lineare (PL) o
Ottimizzazione Lineare e sono tipicamente
presentati in due forme: quella *canonica*
oppure quella *standard*.

Un problema di PL in forma canonica è del
tipo:

#v(1em)
$
cases(min l'x = min limits(sum)_(j=1)^n l_j x_j, A x >= b, x>=0)
space
space
#table(
  columns: 1,
  stroke: none,
  align: left, 
[funzione obiettivo con vettore di costi l#hide[$min limits(sum)_(j=1)^n$]], [vincoli tecnologici],[vincoli di non negatività]
)
$

#set math.mat(delim: "[")
$
A = mat(a_11,a_j,a_(1 n);
a_(i 1),a_(i j), a_(i n);
a_(m 1), a_(m j), a_(m n))
Space
x = mat(x_1;dots.v;x_j;dots.v;x_n)
Space
b = mat(b_1;dots.v;b_i;dots.v;b_m)
Space
l' = mat(l_1,...,l_n)
$

Detto $a'_i$ l'i-esimo vettore riga di $A$, un
problema di PL in forma canonica si può
riscrivere come:

#v(1em)
$
cases(
min limits(sum)_(j=1)^n l_j x_j,
limits(sum)_(j=1)^n a_(i j) x_j >= b_i ", "i=1...m arrow.r.double a'_i x >= b_1 arrow.r.double a'_i x + b_i <= 0,
x_j >= 0 ", " j=1...n arrow.r.double x_j <= 0
)
$

Se tutti i vincoli tecnologici sono ugualianze
, un problema di PL ha una forma *standard*.
#pagebreak()
== Note generali sui problemi di Ottimizzazione#v(1em)
+ Si studiano solo problemi di minimizzazione,
 perchè\ $max{f(x) : x in X} = - min{-f(x) : x in X}$

+ Un problema di ottimizzazione in cui NON esiste alcuna soluzione che soddisfa tutti i vincoli è detto INAMMISSIBILE. In tal caso, per convenzione, si ha che $min{f(x) : x in X} = +oo$

+ Un problema di ottimizzazione in cui $f(x)$ NON è limitato inferiormente si dice ILLIMITATO : $min{f(x) : x in X} = -oo$

+ Risolvere un problema di ottimizzazione significa determinare un vettore (o punto) $x^*$, se esiste, tale che $f(x^*) <= f(x), forall x in X$. Questo punto $x^*$ si chiama *ottimo globale* del problema.

+ Una soluzione $accent(x, macron)$ di un problema di ottimizzazione è un punto di OTTIMO LOCALE se esiste un $epsilon > 0 : f(accent(x, macron)) <= f(x), forall x in X$ tale che $|x-accent(x,macron)| <= epsilon$.\ In alternativa, si può scrivere che $f(accent(x,macron)) <= f(x), forall x in I_epsilon (accent(x, macron)),$ dove $I_epsilon(accent(x,macron))$ è un intorno di ampiezza #math.epsilon di $accent(x, macron)$.

#v(1em)
== Ottimizzazione di problemi connessi
#v(1em)
In alcuni problemi di ottimizzazione (tra cui
quelli di PL) si minimizza una funzione convessa su un dominio connesso.
Si impiegano in questo caso le seguenti definizioni:
#v(1em)
#set math.mat(delim: "(")
- *Definizione 1*.
Dati $x^1$ e $x^2 in RR^n$ e $lambda in [0,1]$ (cioè $lambda in RR : 0 <= lambda <= 1$), si definisce *combinazione connessa* ogni $z in RR^n$ ottenuto dalla relazione $z = lambda x^1 + (1-lambda) x^2$.\ La combinazione connessa si dice _stretta_ se $lambda in (0,1)$, equivalmente, $lambda in RR : 0 < lambda < 1$.

Esempio:\
$n=2,space x^1 = mat(1;1),space x^2=mat(3;2),space lambda=0.5$

$ z=0.5 mat(1;1) + (1-0.5) mat(3;2) = mat(0.5;0.5)+mat(1.5;1)=mat(2;15)$

$ "se" lambda=1,space z=x^1=mat(1;1);space$

$ "se" lambda=0,space z=x^2=mat(3;2).$
#v(1em)
Si dice *combinazione connessa di K vettori* $x^1,...,x^k "di" RR^n$ l'insieme di punti ottenuti dalla relazione $z=sum_(i=1)^k lambda_i x_i " con " lambda_i ... lambda_k >= 0 " e " sum_(i=1)^k lambda_i = 1$.

Esempio:\
$n = 2,space k=3,space x^1=mat(1;1),space x^2=mat(3;2),space x^3=mat(2;3)$

$z=lambda_1 mat(1;1)+lambda_2 mat(3;2)+lambda_3 mat(2;3) " con " lambda_1, lambda_2, lambda_3 >= 0," "lambda_1+lambda_2+lambda_3 = 1$

$"se " lambda_1=1, z=x^1=mat(1;1);$

$"se " lambda_1=0, z "è la congiungente di" x^2 "e " x^3$
#v(1em)
Analizzando i casi $lambda_2=1, lambda_2=0, lambda_3=1, lambda_3=0$, si osserva che la combinazione connessa individua tutti i punti interni al triangolo di vertici $x^1, x^2, x^3$.
#upper("è") questo un esempio di insieme convesso.
 
- *Definizione 2.*

Un insieme $X subset.eq RR^n$ si dice convesso se, $forall x,y in X, Z=[lambda x + (1-lambda)y] in X, lambda in [0,1]$.

- *Definizione 3.*

Una funzione $f: X arrow RR$ definita su un insieme convesso $X subset.eq RR^n$ si dice convessa se, $forall x,y in X$ e $ lambda in [0,1]$, definito $Z = lambda x + (1-lambda)y, f(z) <= lambda f(x) + (1-lambda)f(y)$.

$lambda f(x) + (1-lambda)f(y)$ è l'insieme dei punti segmento che congiunge $(x, f(x))$ e $(y,f(y))$.

Quindi, una funzieno è convessa tra $x$ e $y$ se sta _"sotto"_ o _"coincide"_ con il segmento che congiunge $(x,f(x))$ e $(y,f(y))$.

- *Proposizione.*

L'intersezione tra 2 insiemi convessi è un insieme convesso.

*Dimostrazione:*
Siano dati due punti $x$ e $y$ che appartengono entrambi a due insieme convessi $A$ e $B : x in A, y in A, x in B, y in B$. Preso un qualunque punto $z = lambda x + (1-lambda) y, z in A$ per la convessità di $A, z in B$ per la convessità di $B$, quindi $z in A inter B$.

- *Teorema 1.*

Se $X = {x in RR^n : g_i (x) <=0, i=1...l}$ e $g_i : RR^n arrow RR, i = 1...l$ sono funzioni convesse, X è un insieme convesso. Quindi, se $X$ è spazio ammissibile di un problema di ottimizzazione e i suoi vincoli sono funzione convesse, in base a questo teoriema, $X$ è convesso.

Visita la precedente proposizione, il teorema si dimostra mostrando che $X_i = {x in RR^n : g_i (x) <= 0}$ è un insieme convesso se $g_i (x)$ è una funzione convessa. Presi $x " e " y in X_i$, per l'ipotesi di convessità di $g_i (x)$, si ha $g_i (z) = g_i (lambda x + (1-lambda)y) <= lambda g_i (x) + (1-lambda) g_i (y) <= 0$ perchè $lambda <= 0, (1-lambda)>=0, g_i(x)<= 0 " e " g_i(y) <= 0$. Quindi $z in X_i$, che è convesso.

- *Teorema 2.*

Dato il problema $min{f(x) : x in X}$ un cui $X$ è un insieme convesso e $f:X arrow RR$ è una funzione convessa, ogni punto di ottimo locale in $X$ è un punto di ottimo globale.

*Dimostrazione:*
Ipotizzando che $accent(x, tilde) in X$ sia un punto di ottimo locale e che $y in X$.
#linebreak()
Sia $z = lambda accent(x,tilde) + (1-lambda)y.space f(accent(x,tilde)) <= f(z) = f(lambda accent(x,tilde) + (1-lambda)y) <= lambda f(accent(x,tilde)) + (1-lambda)f(y)$ 
$f(accent(x,tilde)) - lambda f(accent(x,tilde)) = (1-lambda)f(accent(x,tilde)) <= (1-lambda)f(y) arrow.r.double f(accent(x,tilde)) <= f(y)$.

Per la generalità di $accent(x,tilde)$ e $y, accent(x,tilde)$ è un punto di ottimo globale. Quindi, in PL gli ottimi locali sono ottimi globali per la proprietà di convessità.
#linebreak()
#linebreak()
== Esempio
Il seguente esempio mostra come trasformando un generico problema di PL in un problema di PL in forma canonica:

#table(
  columns: 2,
  stroke:none,
  [
    $min space 2x_1-x_2+4x_3\
    x_1+x_2+x_4<=2\
    3x_2-x_3=5\
    x_3+x_4>=3\
    x_1>=0\
    x_3<=0$
  ],
  [Questo problema NON è in forma canonica, perchè:
  - alcuni vincoli tecnologici non sono del tipo $>=$
  - $x_2, x_3 "e " x_4$ non sono soggette ai vincoli di non negatività]
)

Un problema equivalente (di uguale soluzione) si ottiene:
- moltiplicando il 1° vincolo per -1 e cambiando il "$<=$" in "$>=$";
- suddividendo il vincolo "$=$" in un vincolo di "$<=$" e uno di "$>=$":

$3x_2-3x_3=5 Space 3x_2-x_3<=5 arrow.r.double -3x_2+3x_3 >= -5$
#linebreak()
#hide($3x_2-3x_3=5 Space$) $3x_2-x_3>=5$#hide($ arrow.r.double -3x_2+3x_3 >= -5$)

Quindi il problema diventa:

#table(
  columns: 3,
  stroke: none,
  [
    $min space 2x_1-x_2+4x_3\
    -x_1-x_2-x_4>=-2\
    -3x_2+x_3>=-5\
    3x_2+x_3>=5\
    x_3+x_4>=3\
    x_1>=0\
    -x_3>=0$
  ],
  [$Space Space$],
  [
    Per avere i vinculo di non negatività\
    su tutte le variabili decisionali e\
    ottenere una soluzione equivalente\
    facciamo queste sostituzioni:
    #linebreak()
    #linebreak()
    $x_3=-x_5\
    x_2=x_6-x_7 "con " x_6>=0 "e " x_7>=0\
    x_4=x_8-x_9 "con " x_8>=0 "e " x_9>=0
    $
  ]
)

Infine, il problema diventa:
#linebreak()
#linebreak()
$min space 2x_1 -x_6+x_7-4x_5\
-x_1-x_6+x_7-x_8+x_9>=-2\
-3x_6+3x_7-x_5>=-5\
3x_6-3x_7+x_5>=5\
-x_5+x_8-x_9>=3\
x_1, x_6, x_7, x_5, x_8, x_9 >=0$

Questo problema di PL in forma canonica risolve equivalmente il probleema iniziale.

#pagebreak()
= Lezione 2
== Geometria della Programmazione Lineare

I problemi di PL sono problemi di ottimizzazione in cui si minimizza una funzione obiettivo convessa e l'insieme delle soluzione ammissibili è conveso. Quindi, se si trova un ottimo locale inin un problema di PL, questo è anche un ottimo globale. In PL ci sono relazioni lineari tra le variabili decisionali e i  dati del problema.

#table(
  columns: 3,
  stroke: none,
  [
    *Problema generale di ottimizzazione convessa*
    
    $min f(x)\
    g_i (x)<=0, i=1...l$
  ],
  [
    *Problema di PL in forma canonica*

    $min l'x\
    a'_i x>=b_i, i=1...m\
    x_j>=0, j=1...n$
  ],
  [ $Space$
  
    #linebreak()
    $min l'x\
    -a'_i x + b_i <=, i=1...m\
    -x_j<=0, j=1...n$ 
  ]
)

$l'$ è un vettore riga di dimensione n, $x$ è un vettore colonna di dimensione $n$, $a'_i$ è l'i-esima riga di una matrice $A$ con m ighe e n colonne, $b_i$ è l'i-esima componente di un vettore b di dimensione m. Quindi un problema di PL si può scrivere in modo compatto come:

$min {l'x : A x >= b, x >= 0}$

che è detto problema in _forma canonica_.

- *Esempio.*


