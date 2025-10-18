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

*Teorema 1*
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
  &= limits(sum)_(x in Pp) P_y Pr(P=x) Space "per quello spiegato sopra"\
  &= P_y limits(sum)_(x in Pp) Pr(P=x) Space "perchè" P_y "è una costante"\
  &= P_y
$


 == *PS3*
Aggiungiamo prima una variabile casuale che sarà autile:

Per ogni $x in Pp$, sia $E_k (x)$ una variabile casuale definita come:
$
  Pr(Enc_k (x) = y) = sum {Pr(K=k) | k in Kk, Enc_k (x) = y}
$


*Teorema 2*
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
  Pr(C=y|P=x) &= Pr(Enc_k (P) = y|P=x) Space "definizione di variabile casuale C"\
  &=  Pr(Enc_k (x) = y| P=x) Space "perchè " P=x\
  &= Pr(Enc_k (x)=y) Space "perchè " k "è indipendente da " P  
$
#v(1em)
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
= Perfect indistinguishability
Le _perfect indistinguishability_ è un'altra definzione equivalente di _perfect secrecy_. Questa definzione è basata
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
Scriviamo $PrivK=1$ se l'output dell'esperimento è $1$ e in questo caso diciamo che #Mm ha avuto successo.

#Mm ha successo se indovina in modo corretto. Uno schema di
crittografia ha #PI se _nessun adversary_ #Mm riesce in questo
esperimento con una probabilità maggiore di $1/2$ (non è
imposto nessun limite di computazione accessibile all'_adversary_ #Mm). La #PI richiede che sia impossibile per #Mm fare di meglio.

#v(1em)
*Definizione*: Uno schema $Pi$ è #PI se e solo se:
$
  forall Mm. space Pr(PrivK = 1) = 1/2
$

*Teorema 3*:
#align(center)[$Pi$ è #PS $arrow.r.l.double Pi$ è #PI] 





