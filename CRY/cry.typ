#align(center)[
  #heading()[= Crittografia]
]


#let Aa = $cal(A)$
#let Mm = $cal(M)$
#let Cc = $cal(C)$
#let Pp = $cal(P)$
#let Kk = $cal(K)$
#let Gen = $mono("Gen")$
#let Enc = $mono("Enc")$
#let Dec = $mono("Dec")$
#let PrivK = $mono("PrivK")_(Mm,Pi)^mono("eav")$
#let Space = "    "
#let PS = {
  text(style: "italic", "perfect secrecy")
}
#let PI = {
  text(style: "italic", "perfect indistinguishability")
}
// #let PS = #emph[perfect secrecy]
// #let PI = #emph[perfect indistinguishability]

#v(1em)
= Introduzione
Uno schema di crittografia *a chiave privata* è una tripla
di algoritmi:
- $Gen$ è un algoritmo _probabilistico_ per generare le chiavi
- $Enc$ è un algoritmo _probabilistico_ per crittografare un messaggio
- $Dec$ è un algoritmo _deterministico_ per decifrare un messaggio crittografato 

Possiamo definire lo schema nel seguente modo:
$ forall k arrow.l Gen(). space forall m in Pp | Dec_k (Enc_k (m)) = m $

Dove $Pp$ è il *set* di tutti i messaggi, $k$ è una chiave e $m$ è un messaggio.\
Definiamo subito anche altri due set:
- $Cc$, il set di tutti i messaggi crittografati
- $Kk$, il set di tutte le chiavi
#v(1em)
== Shift cypher
Andiamo a definire come esempio lo schema dello
_Shift cypher_ applicato a una sola lettera.

Il set $Pp$ è definito da tutte le lettere,
che andremo a definire come tutte le lettere da
0 a 25 per semplificare la rappresentazione e le
operazioni:
$
Pp = {0,1,2,...,25} = (ZZ_26, +)\
parallel\
Pp = {a,b,c,...,z} = (ZZ_26, +)\
$
Di seguito definiamo invece i tre algoritmi:
$
Gen() = "numero casuale tra 0 e 25"\
Enc_k (m) = m + k\
Dec_k (c) = c - k\
$
Possiamo quindi dimostrare la definizione che
abbiamo dato prima di schema a chiave privata:
$
Dec_k (Enc_k (m)) = Dec_k (Enc_k (m+k)) = (m+k)-k = m + (k-k) ) m+0 = m
$
\
Per generalizzare le definizioni precedenti per estenderle allo Shift cypher su un messaggio di _più lettere_ dobbiamo cambiare la definizione di $Pp$, di $Enc_k()$ e di $Dec_k()$ nel seguente modo:
$
Pp = Cc = ZZ_26^*\
Enc_k (m) = (m[0]+k)(m[1]+k)...(m[-1]+k)\
Dec_k (m) = (m[0]-k)(m[1]-k)...(m[-1]-k)\
$
#v(1em)
== ECB (Electronic Code Block)
#upper("è") un modo molto semplice di operare
dove il _cyphertext_ (messaggio crittografato)
è ottenuto applicando il _block cypher_ (la
chiave con più lettere) a ogni blocco del
messaggio da crittografare.

== Shift cypher in ECB
Uno degli esempio più semplici è lo _Schema di
Vigenere_ dove il messaggio è suddiviso in più
blocchi di lunghezza pari alla chiave, e ogni
blocco viene crittografato con la stessa chiave
$k$.\ Quindi abbiamo:
$
Pp = ZZ_26^(l t)\
Kk = ZZ_26^t
$
dove $l$ è il numero di blocchi e $t$ è la
lunghezza della chiave.

Prendiamo come esempio il seguente:
$
k &= mono("abba")\
m &= mono("nelm|ezzo|delc|ammi|ndin|ostr|avit|axxx")\
c &= mono("nfmm|eaao|")...
$
Questo schema è ovviamente molto insicuro poichè
se mettiamo in colonna i blocchi crittografati,
considerando ogni singola colonna, le lettere in
in quest'ultima sono state tutte crittografate
con la stessa chiave. #upper("è") quindi
possibile risolvere il codice facendo uno studio
sulla frequenza delle lettere nel messaggio
e paragonarle alla frequenza delle lettere
nella lingua inglese.
Assumendo che l'attaccante riesca a trovare la
lunghezza $t$ della chiave, con il procedimento
descritto prima si riuscirebbe a decifrare il
messaggio.
#v(1em)
= Perfect Secrecy
Prima di definire la _Perfect secrecy_ è
necessario dare prima delle definizioni
preliminari. Nelle prossime definizioni ci
riferiremo alle distribuzioni di probabilità
su #Kk, #Pp e #Cc.

La distribuzione su #Kk è quella definita
facendo eseguire la funzione #Gen e
prendendone il risultato. #upper("è") quasi
sempre il caso che la funzione #Gen scelga una
chiave in modo uniforme da #Kk. Definiamo $K$
una variabile casuale che inidica il valore
dell'output di #Gen; allora, per ogni
$k in Kk, Pr(K=k)$ indica la probabilità che la
chiave generata da #Gen è $k$.

In modo simile, definiamo $M$ una variabile
casuale che idica la probabilità che il
messaggio assuma il valore $m in Pp$. La
distribuzione di probabilità del messaggio non
è determinata dallo schema di crittografia di
per se, ma invece riflette la probabilità di
diversi messaggi mandati della diverse parti
usando lo schema, così come l'incertezza dell'avversario su ciò che verrà inviato.

Prendiamo come esempio lo Shift cypher:
$
("shift cypher"):Gen(){Kk arrow.l ZZ_26}.space Pr(K)=1/26.space forall k in Kk
$
in questo caso abbiamo la generazione di $k$
appartiene a una distribuzione uniforme. Si
può fare anche un esempio dove la distribuzione
non è uniforme:
$
Gen(){b arrow.l {0,1}; "se b=0 allora" k=25" altrimenti" k arrow.l ZZ_25;k}\
\
"dove"\
Pr(k=25)=1/2 Space Pr(K!=25)=1/50
$

$K$ e $M$ è necessario che siano variabili
indipendenti, ovvero cosa viene comunicato
dalle due parti deve essere indipendente dalla
chiave che condividono. Questo ha senso poichè
la distribuzione su #Kk è determinata dallo
schema stesso, mentre la distribuzione su #Pp
dipende dal contesto dove lo schema viene usato.

Quindi definiamo $C$ una variabile casuale
che indica il messaggio crittografato che assume
il valore $c in Cc$ e scriviamo $Pr(C = c)$ per
indicare la probabilità che il messaggio
crittografato abbia il valore uguale a $c$.

Possiamo adesso definire formalmente la
proprietà che deve essere soddisfatta in modo
che uno schema abbia _perfect secrecy_:

$
forall m in Pp. space forall c in Cc : Pr(P=m | C=c)=Pr(P=m)\
"per ogni distribuzione di probabilità su " Pp 
$
#v(1em)
Cerchiamo di fare un esercizio prendendo in
considerazione sempre lo shift cypher ma su 2
lettere con chiave lunga 1, definiamo le
seguenti:
$
Pp=Cc=ZZ_26^2 Space Kk=ZZ_26\
Gen(){K arrow.l ZZ_26}\
Enc_k (x_1,x_2) = (x_1 +k)(x_2 +k)\
Dec_k (y_1,y_2) = (y_1 -k)(y_2 +k)
$
Per provare che questo schema rispetta la
definizione di _perfect secrecy_, dobbiamo
negare la definizione che abbiamo detto prima.
Quindi dobbiamo provare che:
$
exists P. space exists m. space exists k. space Pr(P=m | C=c) != Pr(P=m)
$
Consideriamo il caso dove $m=00$ e $c=01$. Possiamo dire che $Pr(P=00,C=01)=0$ ma $Pr(P=00)>0$.
#v(1em)
== Substitution cypher
Uno degli schemi più semplici dove ogni lettera
è mappata a un'altra. Di conseguenza $K$ è una
funzione biunivoca $sigma:ZZ_26 arrow ZZ_26$.\
Definiamo quindi #Gen nel seguente modo:


for i=0 to 25:\
$"  "sigma$[i]$arrow.l$ x;\
$"  "$x$:=$x\\$sigma$[i]

La cardinalità delle chiavi è $ |Kk| =26!$, in
più $Enc_sigma (m) = sigma(m)$ e $Dec_sigma (c) = sigma^(-1)c$
#v(1em)
== Concetti di probabilità
Definiamo #math.cal("U") un set finito o
contabile. Un distribuzione di probabilità
discreta su #math.cal("U") è una funzione:
$
Pr: cal("U") arrow [0,1] | sum_(x in cal(U)) Pr(x) = 1
$
Ad esempio:\
$("fair coin") : cal(U)={0,1} | Pr(0)=Pr(1)=1/2$\
$("3 toss of a fair coins") : cal("U")={0,1}^3={000,001,010,011,100,101,110,111} | Pr(x) = (1/2)^3=1/8 (forall x in cal("U"))$

Definiamo anche il set di eventi $cal(A)$ tale che $cal(A) subset.eq cal("U")$ dove $ Pr(cal(A)) = sum_(x in cal(A)) Pr(x) $

Ad esempio:
$
cal(A) = "There are more 1s then 0s"\
cal(A) = {011,101,110,111}\
Pr(cal(A)) = 4 dot 1/8 = 1/2
$
Definiamo $Pr$ la distribuzione di probabilità
su $cal(U)$. Una variabile casuale è una funzione $X:cal(U) arrow V$, la $Pr'$ distribuzione di probabilità
su $V:Pr'(X=v)=Pr(X^(-1)({v}))$\
Ad esempio:
$
("toss of 3 fair coins") : X(y)=cases("1 if y contiene più 1s che 0s","0 altrimenti")\
Pr'(X=1)=Pr(X^(-1)({1}))=Pr({011,101,110,111}) = 1/2
$
Definiamo $cal(U)$ come finito. $r arrow.l cal(U)$ per le variabili casuali uniformi.
Siano $X,Y$ due variabili casuali. Definiamo la
probabilità combinata $Pr(X=x,Y=y)$. Diciamo che $X$ e $Y$ sono indipendenti quando $Pr(X=x,Y=y)=Pr(X=x)Pr(Y=y) forall x,y$.

Definiamo $X,Y$ due variabili casuali. La probabilità condizionata $Pr(X=x|Y=y)$ di $x$ dato $y$ è definito come:
$
Pr(X=x|Y=y) = Pr(Y=y)Pr(X=x|Y=y)\
"e viceversa"\
Pr(Y=y|X=x) = Pr(X=x)Pr(Y=y|X=x)
$
Ad esempio, abbiamo che $X="somma di 3 monete", Y="valore del primo lancio":$
$
Pr(X=0|Y=1)=0=Pr(X=0,Y=1)/(...)=0\
"oppure"\
Pr(X=1|Y=1) = 1/4
$
#v(1em)



#pagebreak()
== Esempi di esercizi dove si prova o no la _perfect secrecy_
Ricordiamo la definizione di _perfect secrecy_:
$
forall m in Pp. space forall c in Cc : Pr(P=m | C=c)=Pr(P=m)
$
=== Esempio 1
Consideriamo la seguente tabella che indica i possibili messaggi, messaggi crittografati e chiavi:
#table(
  columns: 3,
  [$Enc_k$], [a], [b],
  [$k_1$], [1], [2],
  [$k_2$], [2], [3]
)
definiamo:
$
Pp = {a,b} Space Kk={k_1,k_2} Space Cc = {1,2,3}\
Gen(){Kk arrow.l {k_1,k_2}}\
Pr(k_1)=1/2=Pr(k_2)
$
Calcoliamo la probabilità per ogni messaggio crittografato:


$Pr(c=1)=limits(sum)_(Enc_k (m) = 1) Pr(k)Pr(m)=Pr(k=1)Pr(a)=1/2 dot 3/4=3/8\
Pr(c=2) = Pr(k_1)Pr(b) + Pr(k_2)Pr(a) = 1/2(Pr(b)+Pr(a)) = 1/2\
Pr(c=3) = Pr(k_2)Pr(b) = 1/8
$

Calcoliamo ora la probabilità condizionata di un messaggio crittografato su il messaggio:

#table(
  stroke: none,
  columns: 2,
  [$Pr(1|a) = Pr(k_1) = 1/2$],[$Pr(2|a) = 1/2$],[$Pr(3|a) = 0$],[$Pr(1|b) = 0$], [$Pr(2|b) = 1/2$], [$Pr(3|b) = 1/2$]
)

Ora abbiamo tutto per verificare o meno la _perfect secrecy_, prendiamo e risolviamo il seguente esempio:

$Pr(a|1)=(Pr(1|a)Pr(a))/Pr(1) = (1/2 dot 3/4)/(3/8) = 1\
"ergo":\
Pr(a) = 3/4 != Pr(a|1) = 1
$

Abbiamo dimostrato che questo esempio non gode
della proprietà di _perfect secrecy_.
#v(1em)
=== Esempio 2
Riprendiamo nuovamente lo shift cypher definendolo:
$
Pp = Cc = Kk = ZZ_26\
Enc_k (m) = m + k\
Dec_k (c) = c - k\
Gen(){Kk arrow.l ZZ_26}
$

Sarebbe troppo lungo e inutile calcolare tutte le
probabilità necessarie come abbiamo fatto prima,
quindi terremo i calcoli simbolici:

$Pr(C=y) = limits(sum)_(Enc_k (x) = y) Pr(P=x)Pr(K=k) = 1/26 limits(sum)_(Enc_k (x) = y) Pr(x) =1/26 limits(sum)_(x in ZZ_26) Pr(x) = 1/26 dot 1 = 1/26
$

Calcoliamo ora la probabilità condizionata:

$Pr(C=y|P=x) = limits(sum)_(Enc_k (x) = y) Pr(k) = 1/26 limits(sum)_(Enc_k (x) = y) 1 = 1/26 dot 1 = 1/26
$

Verifichiamo adesso la _perfect secrecy_:

$Pr(P=x|C=y) = (Pr(C=y|P=x)Pr(P=x))/Pr(C=y) = (1/26 dot Pr(P=x))/(1/26) = Pr(P=x)
$

Abbiamo quindi dimostrato che lo shift cypher, se
usato per crittografare una sola lettera, gode
della proprietà della _perfect secrecy_.

#pagebreak()
= Altri modi per definire la _perfect secrecy_
In questo capitolo verranno presentati nuovi modi per definire
la _perfect secrecy_. Partiamo ricordando la prima definizone data:
Sia $Pi = (Gen, Enc, Dec)$ uno schema di crittografia a chiave privata. Diciamo che $Pi$ gode di _perfect secracy_ se e solo se
$forall$ distribuzione di probabilità su $Pp$:
$
  forall m in Pp. forall c in Cc. Pr(P=m|C=c)=Pr(P=m)
$

Prendiamo nuovamente l'esempio dello shift cypher:

$
  Pr(k=25)=1/2 Space Pr(K=k)=1/50 forall k in 0...24
$

assumiamo:

$
  forall m in Pp : Pr(P=m)>0 
$

Per dimostrare che non ha _perfect secrecy_ dobbiamo trovare un
caso in cui $Pr(P=m|C=c) != Pr(P=m)$. Dimostriamo quindi che, per esempio, $Pr(P=0|C=25) != Pr(P=0)$.
#linebreak()
#linebreak()
$Pr(P=0|C=25) = (Pr(C=25|P=0)Pr(P=0))/(Pr(C=25))$

Andiamo ad analizzare il numeratore e denominatore separatamente:
#linebreak()
#linebreak()
$Pr(C=25|P=0) = limits(sum)_(Enc_k(m) = 25) Pr(K=k) = Pr(K=25) = 1/2$
#linebreak()
#linebreak()
$Pr(C=25) = limits(sum)_(Enc_k(m) = 25) Pr(K=k)Pr(P=m)\ =Pr(K=25)=Pr(P=0) + [Pr(K=0)Pr(P=25)+Pr(K=1)Pr(P=24)+...]\
= 1/2 Pr(P=0) + 1/50 limits(sum)_(x=1)^25 Pr(P=x) Space "tutte le " Pr(K=k) "sono le stesse"\
=1/2 Pr(P=0) + 1/50 (1-Pr(P=0)) " che è " < 1/2Pr(P=0) + 1/2(1-Pr(P=0))$

Possiamo adesso sostituire i risultati ottenuti nell'equazione:

$
  Pr(P=0|C=25) = (Pr(C=25|P=0)Pr(P=0))/(Pr(C=25)) = (1/2 Pr(P=0))/(<1/2) arrow.r.double > Pr(P=0)
$

== *PS1*
Diamo una nuova definizione di _perfect secrecy_, che chiameremo *PS1*:

*Teorema 1*:
$
Pi "gode di" italic("perfect secrecy") arrow.l.r.double forall " distribuzione di probabilità su " Pp.\ space forall y in Cc. forall x in Pp. Pr(C=y | P=x) = Pr(C=y)
$

*Dimostrazione ($arrow.l.double$)*

Assumiamo che $Pi$ ha _perfect secrecy_, allora siano $y in Cc, x in Pp$:

$
  Pr(C=y|P=x) &= (Pr(P=x|C=y)Pr(C=y))/Pr(P=x) Space "per il teorema di Bayes"\
  &= (Pr(P=x)Pr(C=y))/Pr(P=x) Space "perchè assumiamo la " italic("perfect secrecy")\
  &= Pr(C=y)
$

*Dimostrazione ($arrow.r.double$)*

Assumiamo che $Pi$ ha _perfect secrecy_, allora siano $y in Cc, x in Pp$:

$
  Pr(P=x|C=y) &= (Pr(C=y|P=x)Pr(P=x))/Pr(C=y)\ &= (Pr(C=y)Pr(P=x))/Pr(C=y)\ &= Pr(P=x)
$


== *PS2*
Vediamo la seconda definizione di _perfect secrecy_:

*Teorema 2*
$Pi$ è perfetto $arrow.r.l.double$ per ogni distribuzione di probabilità su $Pp$:

$
  forall y in Cc. forall x_0,x_1 in Pp : Pr(C=y|P=x_0) = Pr(C=y|P=x)
$

TH: *PS* $arrow.l.r.double$ *PS2*

*Dimostrazione ($arrow.r.double$)*

Assumiamo che ci sia _perfect secrecy_:

$
  Pr(C=y|P=x_0) = Pr(C=y) = Pr(C=y|P=x_1)\
  #hide("") arrow.t #hide("______________") arrow.t\
  #hide("") "PS1" #hide("___________") "PS1"\
$

*Dimostrazione ($arrow.l.double$)*

Assumiamo la formula data prima:

$
  forall y in Cc. forall x_0,x_1 in Pp : Pr(C=y|P=x_0) = Pr(C=y|P=x)
$

Siano $x_0 in Pp, y in Cc$. Sia $P_y = Pr(C=y|P=x_0)$.

Per la formula riportata prima,
$
  Pr(C=y|P=x) = Pr(C=y|P=x_0) = P_y
$

Allora:

$
  Pr(C=y) &= limits(sum)_(x in Pp) Pr(c=y|P=x)Pr(P=x)\
  &= limits(sum)_(x in Pp) P_y Pr(P=x) Space &&"per quello spiegato sopra"\
  &= P_y limits(sum)_(x in Pp) Pr(P=x) Space &&"perchè" P_y "è una costante"\
  &= P_y
$


 == *PS3*
Aggiungiamo prima una variabile casuale che sarà autile:

Per ogni $x in Pp$, sia $E_k (x)$ una variabile casuale definita come:
$
  Pr(Enc_k (x) = y) = sum {Pr(K=k) | k in Kk, Enc_k (x) = y}
$


*Teorema 2*:\
$Pi$ è perfetto $arrow.r.l.double$
$
  forall y in Cc. forall x_0,x_1 in Pp. Pr(Enc_k (x_0) = y) = Pr(Enc_k (x_1) = y)
$

*Dimostrazione*
Per il *Teorema 2* possiamo ridurre per mostrare che:
$
  forall x in Pp, y in Cc : Pr(Enc_k (x) = y) = Pr(C=y|P=x)
$
Passaggi:
$
  Pr(C=y|P=x) &= Pr(Enc_k (P) = y|P=x) Space &&"definizione di variabile casuale C"\
  &=  Pr(Enc_k (x) = y| P=x) Space &&"perchè" P=x\
  &= Pr(Enc_k (x)=y) Space &&"perchè" k "è indipendente da " P  
$

== Riassunto delle definzioni equaivalenti

Riporto di seguito sia la prima definzione data di _perfect secrecy_ che le equivalenti viste adesso, con il loro significato:

- _perfect secrecy_:
$
  forall x in Pp, forall y in Cc, Pr(P=x|C=y) = Pr(P=x)
$
sapere che il messaggio cifrato è $y$, non cambia la probabilità che il messaggio chiaro fosse $x$.

- *PS1*:
$
  Pi "è perfetto" arrow.r.l.double
  forall x in Pp, forall y in Cc, Pr(C=y|P=x) = Pr(C=y)
$
la probabilità di ottenere un certo cifrato $y$ non dipende dal messaggio $x$.

- *PS2*:
$
  Pi "è perfetto" arrow.r.l.double
  forall y in Cc, forall x_0,x_1 in Pp, Pr(C=y|P=x_0) = Pr(C=y|P=x_1)
$
tutti i messaggi producono lo stesso comportamente porbabilistico del cifrato. Ovvero guardando $y$, non puoi dire se il messaggio era $x_0 space"o"space x_1$.

- *PS3*:
$
  Pi "è perfetto" arrow.l.r.double
  forall y in Cc, forall x_0,x_1 in Pp, Pr(Enc_k (x_0) = y)=Pr(Enc_k (x_1) = y)
$
In questo caso si guarda direttamente alla funzione di cifratura casuale #Enc, cioè la distribuzione dei cifrati che produce ogni messaggio. #upper("è") l'evoluzione della *PS2* e ha lo stesso significato.

#v(1em)
#pagebreak()
= Perfect indistinguishability (Libro pag. 29)
La _perfect indistinguishability_ è un'altra definzione equivalente di _perfect secrecy_. Questa definzione è basata
su un esperimento che coinvolge un _adversary_ che osserva
passivamente un testo cifrato e poi prova a indovinare quale
fra due messaggi era stato cifrato.

Con la #PS dicevamo che guardando un messaggio cifrato, non si
doveva imparare niente sul messaggio originale. Con la #PI diciamo
la stessa cosa ma in modo operativo; anche se permettiamo al _adversary_ di scegliere due messaggi e mostrando il cifrato di
uno dei due, non ha nessun modo di capire quale dei due messaggi
è stato cifrato.  
#v(1em)
Definiamo l'esperimento di #PI $space PrivK$:
+ L'_adversary_ #Mm crea una coppia di messaggi $m_0,m_1 in Pp$
+ Una chiave $k in Kk$ casuale è generata, e un bit uniforme $b in {0,1}$ è scelto. Il messaggio $m_b$ viene scelto (ogni messaggio ha probabilità di $1/2$ perchè $b$ è uniforme) e crittografato con $k$. Il messaggio cifrato è dato ad #Mm
+ #Mm da una ipotesi su quale dei due messaggi è stato crittografato dando come output un bit $b'$
+ L'output dell'esperimento è $1$ se $b'=b$, $0$ altrimenti.
Scriviamo $PrivK=1$ se l'output dell'esperimento è 1 e in questo caso diciamo che #Mm ha avuto successo.

#Mm ha successo se indovina in modo corretto. Uno schema di
crittografia ha #PI se _nessun adversary_ #Mm riesce in questo
esperimento con una probabilità maggiore di $1/2$ (non è
imposto nessun limite di computazione accessibile all'_adversary_ #Mm). La #PI richiede che sia impossibile per #Mm fare di meglio.

#v(1em)
*Definizione*:\ Uno schema $Pi$ è #PI se e solo se:
$
  forall Mm. space Pr(PrivK = 1) = 1/2
$

*Teorema 3*:\
#align(center)[$Pi$ gode di #PS $arrow.r.l.double Pi$ gode di #PI]

*Esempio*:\
Sia $Pi$ lo schema Vigenère per i messaggi di due caratteri, dove
il periodo (lunghezza della chiave) è scelto uniformemente in ${1,2}$. Per dimostrare che $Pi$ non è #PI, stabiliamo un _adversary_
#Mm per il quale $Pr(PrivK = 1) > 1/2$.

L'_adversary_ #Mm fa:
+ output $m_0="aa"$ and $m_1="ab"$
+ quando riceve il messaggio cifrato $c=c_1c_2$, se $c_1=c_2$ restiuisce 0; altrimenti 1.

Calcoliamo la $Pr(PrivK = 1)$:
$
  &Pr(PrivK=1)\
  &=1/2 Pr(PrivK =1 | b=0)+1/2 Pr(PrivK = 1 | b=1)\
  &=1/2 Pr(Mm "outputs" 0 | b=0)+1/2 Pr(Mm "outputs" 1 | b=1) 
$
dove $b$ è un bit uniforme che determina quale messaggio viene
crittografato. Come definito, #Mm da 0 se e solo se i due caratteri del cifrato $c=c_1c_2$ sono uguali. Quando $b=0$ (quindi
$m_0=mono("aa")$ viene cifrato) allora $c_1=c_2$ se (1) la chiave ha periodo 1, o (2) la chiava scelta di periodo 2 ha entrabi i caratteri uguali. Il primo si verifica con probabilità $1/2$, il secondo si verifica invece con probabilità $1/26$. Quindi:
$
  Pr(Mm "outputs" 0 | b = 0) = 1/2 + 1/2 dot 1/26 approx 0.52
$

Quando $b=1$ allora $c_1=c_2$ solo viene scelta una chiave di
periodo 2 e il primo carattere della chiave è di uno più grande
rispetto al secondo carattere della chiave. Questo avviene con
probabilità $1/2 dot 1/26$. Quindi:
$
  Pr(Mm "outputs" 1 | b=1) = 1-Pr(Mm "outputs" 0 | b=1) = 1 - 1/2 dot 1/26 approx 0.98
$

Possiamo ora sostituire questi risultati nella formula di prima dove abbiamo calcolato $Pr(PrivK = 1)$:
$
  Pr(PrivK = 1) = 1/2 dot (1/2 + 1/2 dot 1/26 + 1- 1/2 dot 1/26) = 0.75 > 1/2
$

che dimostra che lo schema non gode di #PI.

== Teorema di Shannon
*Teorema*:\
uno schema di crittografia ($Pp, Cc, Kk, Gen, Enc, Dec$) con $|Pp|=|Cc|=|Kk|$ è perfetto se e solo se:
#v(1em)
$
  1.& Space forall x in Pp. forall y in Cc. exists_1 k in Kk. Enc_k (x) = y\
  2.& Space forall k in Kk. Pr(k)=1/(|Kk|)
$

== L'impraticalità della #PS
La #PS non è pratica per la crittografia di massa, poichè richiede
che $|Kk| >= |Pp|$. Questo implica che, per scambiare un messaggio in segretezza di n bits su un channel publico, dobbiamo per forza
usare una chiave di $>=$ n bits su un channel privato.

#pagebreak()
= Segretezza Computazionale
Riprendiamo la definizione di #PS: "_il messaggio cifrato non da
nessun tipo di informazione sul messaggio_".
$
  forall m in Pp. forall c in Cc. Pr(m|c)=Pr(m)
$
Ricordiamo anche il *teorema*: se $Pi$ ha #PS, allora $|Kk|>=|Pp|$ (
$arrow.r.double$ la chiave deve essere almeno lunga quanto la lunghezza del messaggio). Questa è una limitazione molto importante; per superarla è necessario revisionare la definizione
di segretezza.

Questo è possibile con la _Computational secrecy_ : "_il messaggio cifrato non da (quasi) nessun tipo di informazioni che possono essere astratti in modo *efficace*_".

Entriamo nella branca delle Computational Complexity Theory, che si basa su Decision Problems, ovvero problemi le queli soluzioni
possono essere o _yes_ o _no_.

Formalmente, i problemi decisionali possono essere definiti come
_Linguaggi_, ad esempio:\
+ $L_1 = {w in {0,1}^* | |w| "is even"} = {epsilon, 00,01,10,11,0000,...}$
+ $L_2 = {0^n 1^m | n,m >0}$
+ $L_3 = {0^k 1^k | k > 0}$
+ $L_4 = {n | n "is prime"}$

Un linguaggio alla fine è un sub-set finito $Sigma$, dove $Sigma^*$ è il set di tutte le sequenze finite di simboli in $Sigma$. Quindi: $L subset.eq Sigma^*$.

Una classe di complessità è un set di problemi decisionali.
Facciamo ora delle decisioni sui prossimi problemi che faremo:

+ modello di computazione: Macchina di Turing
+ che tipo di risorse teniamo in considerazione? #underline("Time")/Space
+ Come misuriamo il costo di utilizzare le risorse? numero di steps della Macchina
+ Come misuriamo la grandezza dell'input? numero di celle occupate l'input nel tape della TM
+ Che tipo di analisi facciamo? #underline("caso peggiore")/caso medio

== Esempio di Macchina di Turing
Prendiamo il linguaggio:
$
  L_2={0^n 1^m|n,m > 0}
$
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#align(center)[
  
  #diagram(
    debug: false,
    spacing: 5em,
    node((0,0), $q_0$, stroke: 1pt),
    node((1,0),$q_1$, stroke: 1pt),
    node((2,0),$q_2$, stroke: 1pt),
    node((0,1),$q_3$, stroke: 1pt),
    node((2,1),$h$, stroke: 1pt),
  
    edge((0,0),(1,0), `0/_/R`, "->"),
    edge((1,0),(1,0), `0/_/R`, "->", bend:130deg),
    edge((1,0),(2,0), `1/_/R`, "->"),
    edge((0,0),(0,1),`1/_/R`, "->"),
    edge((0,1),(0,1),`0/_/R or 1/_/R`,"->" ,bend: -130deg),
    edge((0,1),(2,1),`_/0/R`, "->"),
    edge((2,0),(2,0),`1/_/R`,"->",bend: 130deg),
    edge((2,0),(2,1),`1/_/R`,"->")
  )
]
#v(1em)
Sia $M$ una TM deterministica. Sia $f: NN -> NN$ tale che: per ogni input $x$, $M(x)$ termina entro $f(|x|)$ step. In questo caso
diciamo che $M$ ha time complexity $f$.

Nel caso di prima, $M_2$ ha time complexity $f(n) = n$.

Sia $f: NN->NN$, definiamo il set di funzioni:
$
  O(g)={f: NN->NN | exists c,n_0. forall n >=n_0, f(n)<=c dot g(n)}
$
se $f in O(g)$ diciamo che $g$ è un asintoto superiore di $f$.

Prendiamo come esempio la $f(n) = 3n^3+2n+5$, in questo caso $f in O(n^2)$.

Consideriamo una $g:NN->NN$. La classe di complessità $"TIME"(g)$ è un set di problemi decisionali che sono decisi da delle TM con complessità di tempo in $O(g)$.

Questa definizone non è robusta, perchè la $"TIME"(g)$ può cambiare cambiando il numero di tape nella TM. Cosa dovremmo scegliere allora come punto di riferimento per la complessità?

Enunciamo il seguente teorema:\
*Teorema*:\
sia $L$ un problema decisionale deciso da una TM deterministica con k-tape in $O(g)$. Allora esiste una TM deterministica con 1
tape che decide $L$ in $O(g^2)$.

Definiamo quindi una nuova classe di complessità $P=limits(U)_(k>=0)"TIME"(n^k)$. In crittografia, algoritmi polinomiali sono considerati efficienti.

Quindi definiamo $N P={L|exists "non-deterministic TM that decides" L "in polinomial time"}$, e quindi $P subset.eq N P$.  








