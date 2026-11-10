---
title: Reflexivität und Kategorien
author: Johannes Drever (mit Claude)
date: 2026-11-05
tags: Kategorientheorie, Reflexivität, Garben, "#Maschinenraun"
description: Eine kategorientheoretische Lektüre des ersten Teils von Daniel-Pascal Zorns Dissertation "Vom Gebäude zum Gerüst"
---

Ich habe den ersten Teil von Daniel-Pascal Zorns Dissertation *Vom Gebäude
zum Gerüst. Entwurf einer Komparatistik reflexiver Figurationen in der
Philosophie* (Logos, Berlin 2016) gelesen, und zwar mit den Werkzeugen, die
ich habe: Kategorientheorie, Typentheorie, ein bisschen Modallogik. Das Buch
liegt frei bei [peDOCS](https://www.pedocs.de/frontdoor.php?source_opus=33358).
Grundlage sind die Problemstellung, der Schluss von Kap. 2.3, Kap. 3 und
Kap. 4.1–4.3. Seitenangaben beziehen sich auf die Logos-Ausgabe.

Vorweg zur Hinsicht: Das hier ist keine Behauptung, Zorns Buch sei
„eigentlich“ Kategorientheorie. Zorn warnt selbst davor, eine
Lektürehinsicht vorher in Geltung zu setzen und im Text dann nur das Eigene
wiederzufinden (S. 18–24). An diesem Maßstab will ich mich messen lassen. Ich
versuche deshalb zu zeigen, wo die Übersetzung trägt, wo sie nur ein Bild
liefert und wo sie bricht. Die Bruchstellen sind vermutlich das
Interessanteste.

# Was Zorn entwickelt

Zorns Ausgangsfrage lautet: Wie lassen sich philosophische Ansätze
vergleichen, ohne ein „äußeres Drittes“ vorauszusetzen (S. 24)? Seine Antwort:
Das *tertium comparationis* ist die Reflexivität, die jeder philosophische
Text an sich selbst zeigt. Den Begriffsapparat übernimmt er von Urs
Schällibaum (*Reflexivität und Verschiebung*, 2001) und baut ihn aus.

- **Operativ/inhaltlich** (Fink, Schobinger): An jeder Rede lassen sich
  Sagen und Gesagtes unterscheiden. Jedes x ist schon „x“, gesagt von einer
  Aussageposition aus (S. 106–107).
- **Hinsicht**: „Man kann sich nicht überhaupt oder bloß auf etwas
  beziehen“ (S. 108). Identische Selbstreferenz xRx ist unmöglich, „Referenz
  enthält je bereits eine bestimmte Hinsicht“ (S. 110).
- **Reflexives Verhältnis**: „A über B und zugleich B über etwas an A“, ohne
  dass volle Symmetrie gewährleistet sein müsste (S. 111).
- **Drei Stufen**: Die *Reflexions-Form* ist die formale Reflexivität jeder
  Setzung. In der *Reflexions-Struktur* thematisiert das Worüber das Worin,
  einfach über Immanenzbegriffe („im Text“), kompliziert über Strukturbegriffe
  (Methoden, Regeln). Die *Reflexivitäts-Struktur* ist das Verhältnis zum
  Woher, das nie eingeholt wird (S. 113–117).
- **Fünf Strukturmomente**: Asymmetrie, Nachträglichkeit, reflexive
  Verschiebung (x → „x“), Differenz mit nur einem Relat, Grenze ohne Außen
  (S. 119–129).
- **Logische Position und MMRK** (Kap. 4): ein quasi-formales „Modell für
  Modelle reflexiver Komplizierung“, das ausdrücklich keine Grundstruktur
  sein soll (S. 145, 163–168). Dazu kommen zwei Richtungssinne der Auslegung,
  ein logischer und ein ontologischer (S. 170).

# Eine Begriffskarte

Am stärksten tragen drei Stellen: die Unmöglichkeit des absoluten
Selbstbezugs (Lawvere), die logische Position im MMRK (Modallogik und
geschützte Rekursion) und das „Von-wo-aus“ jeder Setzung (Kontexte,
verallgemeinerte Elemente). „Stark“ heißt in der Tabelle, dass sich eine
Strukturgleichheit angeben lässt. „Bild“ heißt, dass es eine anregende
Analogie gibt, aber keinen Satz.

| Zorn / Schällibaum | Stelle | Kategorientheoretischer Kandidat | Passung |
|---|---|---|---|
| Jedes x ist „x“, gesagt von einer Aussageposition aus | S. 106–107, 113 | Urteil im Kontext $\Gamma \vdash a : A$. Ein Element ist immer ein verallgemeinertes Element $T \to A$, „in Hinsicht $T$“ | stark |
| „Beziehen-Können unbeschränkt, Bezogen-haben immer bestimmt“ | S. 102, Anm. 254 | Hom-Menge $\mathrm{Hom}(T, A)$ vs. ein gewählter Morphismus $f$ | stark |
| Kein Bezug „überhaupt“, nur in Hinsichten | S. 108 | Yoneda: $A$ ist durch die Gesamtheit seiner Hinsichten $\mathrm{Hom}(-, A)$ bestimmt | stark |
| Kritik an xRx: „sich selbst“ ist nur die Identität der Stellen | S. 110 | Die Diagonale $\Delta : A \to A \times A$. Selbstbezug mit Hinsicht braucht mehr, nämlich $A \to B^A$ | stark |
| „A über B und zugleich B über etwas an A“, ohne volle Symmetrie | S. 111 | Reflexives Objekt $U$ mit $U^U$ als Retrakt von $U$ (Scott): enthalten, aber nicht isomorph | mittel |
| Kein Sagen kann sich selbst sagen, aber Sätze thematisieren ihr Sagen „in bestimmter Hinsicht“ | S. 110, 117 Anm. 297 | Lawveres Fixpunktsatz | stark |
| Worin als Immanenzbegriff | S. 114 | Wahrheitswertobjekt $\Omega$, internes Universum: ein Objekt, das im Topos über den Topos spricht | mittel |
| „Das Worin ist immer schon ein ‚Worin‘“, das Woher bleibt uneingeholt | S. 116 | Universenhierarchie $U_0 : U_1 : \dots$ (`Type : Type` ist inkonsistent, Girard). In Lean eingebaut | stark |
| Logische Position „…“ vs. ihre Auslegung $p$ | S. 163–167 | Externes Urteil $\vdash$ vs. interne Modalität $\Box$; der Abstand ist der Satz von Löb | stark |
| Regress (Figur φ) vs. „intensive“ Komplizierung (Figur μ) | S. 165–169 | Kette $\boxdot g, \boxdot\boxdot g, \dots$ vs. geschützter Fixpunkt $X \cong g \wedge \triangleright X$ | stark |
| Nachträglichkeit, futurum exactum | S. 117, 120 | Später-Modalität $\triangleright$ im Baum-Topos; Objekte, die nur durch ihre universelle Eigenschaft bestimmt sind | mittel |
| Reflexive Verschiebung x → „x“, „Philosophie ist unabschließbar“ | S. 121–122 | Einheit $\eta : A \to TA$, Yoneda-Einbettung $C \to \mathrm{Psh}(C)$: volltreu, nicht surjektiv; jede Iteration verlangt ein größeres Universum | mittel |
| Grenze ohne Außen | S. 125–128 | Intuitionistische Negation $\neg A = A \Rightarrow \bot$; Lawveres Ko-Heyting-Rand $\partial A = A \wedge {\sim}A$ | mittel |
| Differenz mit nur einem Relat | S. 124–125 | kein überzeugender Kandidat | offen |
| Geometrischer Logos: den Punkt setzen, „von dem aus“ gezeichnet wurde | S. 164–165 | Iterierter Kegel, Simplizes $\Delta^n$. Limiten sind universelle Kegel | stark |
| Zwei Richtungssinne: logisch (Voraussetzung) vs. ontologisch (Hervorgang) | S. 170 | Dualität, Adjunktion: rechts Bedingung/Limes, links freie Erzeugung/Kolimes | Bild |
| MMRK als „Modell für Modelle“; Kritik an „bloß formaler Logik“ | S. 109, 145 | Funktorielle Semantik (Lawvere 1963): Theorie als Kategorie, Modelle als Funktoren | stark |
| Der Palast, „von diesem einen Raum aus umgebaut“ | S. 104 | Basiswechsel, Slice-Kategorie $C/X$ | Bild |
| Tertium comparationis als vorausgesetztes Drittes | S. 15–17 | Spann $X \leftarrow T \rightarrow Y$; Vergleich über Morphismen statt Einbettung in ein festes Universum | mittel |

Ein Punkt verdient besondere Erwähnung. Zorn grenzt seine „Denklogik“ von
einer „bloß formalen Logik“ ab, die vom Inhalt zwar abstrahiert, aber die
Perspektive auf das bloß Inhaltliche beibehält und die Position, von der
aus gesprochen wird, nicht mit einbezieht (S. 109). Kategoriale Logik und
Typentheorie sind in diesem Sinn gerade *keine* bloß formale Logik: Jedes
Urteil trägt seinen Kontext mit, jedes Element seine Stufe.

# Drei Kernstellen

## 1. Die Unmöglichkeit des absoluten Selbstbezugs ist Lawveres Fixpunktsatz

Schällibaum behauptet zweierlei: „Kein Sagen eines Gesagten kann sich selber
sagen“, und doch gibt es Sätze, „die ihr eigenes Sagen in bestimmter Hinsicht
zum Gegenstand machen“ (zitiert bei Zorn, S. 117, Anm. 297). Lawvere (1969)
zeigt, dass beides ein einziger Satz ist. In jeder kartesisch abgeschlossenen
Kategorie gilt:

$$
\varphi : A \to B^A \text{ punkt-surjektiv} \;\Longrightarrow\; \text{jedes } f : B \to B \text{ hat einen Fixpunkt.}
$$

Meine Lesart: $A$ ist das Gesagte, $B$ die Hinsicht (etwa Wahrheitswerte
$\Omega$), und $\varphi$ ordnet jedem Gesagten zu, was es über jedes Gesagte
sagt. Punkt-surjektiv heißt, dass jedes mögliche Sagen über $A$ als ein
Gesagtes in $A$ eingeholt ist. Da die Negation auf $\Omega$ keinen Fixpunkt
hat, ist diese vollständige Einholung unmöglich. Das sind Cantor, Russell und
Tarski in einem. Wo die Einholung dagegen in einer *bestimmten* Hinsicht
gelingt, etwa bei der Arithmetisierung der Beweisbarkeit, erzwingt derselbe
Satz einen Selbstbezug: Gödels Diagonallemma. Schällibaums Asymmetrie ist
hier also nicht bloß ein Bild, sondern ein Theorem. Eine zugängliche
Darstellung gibt Yanofsky (2003).

## 2. Das MMRK als Modallogik

Zorns Positionen (2) bis (4) sehen so aus (S. 165–167):

$$
\ldots : g \qquad \ldots : g \wedge (p : g) \qquad \ldots : g \wedge (p : g) \wedge (p : (g \wedge p : g))
$$

Dabei steht „…“ für die logische Position, $p$ für ihre inhaltliche Auslegung
und $g$ für den Gegenstand. Ist $C_n$ der Inhalt hinter „… :“, folgt das einem
Bildungsgesetz:

$$
C_1 = g, \qquad C_{n+1} = C_n \wedge (p : C_n).
$$

Liest man „$p :$“ als normale Modalität $\Box$, ist das die Iteration des
Operators $\boxdot X = X \wedge \Box X$ aus der Beweisbarkeitslogik. Weil
$\Box$ über $\wedge$ distribuiert, wird $C_3$ zu
$g \wedge \Box g \wedge \Box\Box g$. Daraus ergibt sich eine scharfe Weiche:

- **Ohne Axiom 4** ($\Box g \to \Box\Box g$) entsteht ein strikter Turm
  $g, \Box g, \Box\Box g, \dots$, also der Regress der Figur φ.
- **Mit Axiom 4** („wer etwas sagt, hat schon gesagt, dass er es sagt“, die
  Reflexions-Form als Gesetz) sind $C_3$ und $C_2$ logisch äquivalent.
  Zorns Position (4) fiele dann in (3) zusammen.
- **Der dritte Weg ist die geschützte Rekursion.** Die Gleichung
  $X \cong g \wedge \triangleright(p : X)$ hat in geschützter Typentheorie
  (Nakano 2000; Birkedal u. a. 2011) genau eine Lösung. Die Modalität
  $\triangleright$ („später“) ist eine formale Nachträglichkeit.
  Ungeschützter Selbstbezug $X \cong (X \Rightarrow \Omega)$ ist inkonsistent,
  verschobener Selbstbezug ist konsistent.

Das dritte entspricht recht genau Zorns Figur μ: Die Möglichkeit jedes
weiteren Anschlusses ist „bereits formuliert“ (S. 168). Seine Unterscheidung
von extensivem und intensivem Einholversuch entspricht der von Kette und
Fixpunkt.

Die äußere Position „…“ bleibt in allen drei Fällen draußen. Dass die interne
Auslegung $p$ nie mit „…“ zusammenfällt, ist in der Beweisbarkeitslogik der
Satz von Löb:

$$
\Box(\Box A \to A) \to \Box A.
$$

## 3. Der geometrische Logos und die universelle Eigenschaft

Zorns Konstruktion fügt jeweils den Punkt hinzu, „von dem aus“ die bisherige
Figur gezeichnet wurde: Strecke, Dreieck, Tetraeder, Pentachoron (S. 165).
Das ist der iterierte Kegel, aus dem die Simplizes entstehen. Ein Limes ist
ein *universeller* Kegel: die Position, von der aus ein Diagramm gesehen wird
und über die jede andere solche Position eindeutig faktorisiert. Das Produkt
$A \times B$ ist die beste Position, von der aus $A$ und $B$ zugleich gesehen
werden. Das war auch das Thema meines Posts über
[die universelle Konstruktion](2026-universelle-konstruktion.html).

Hier liegt vermutlich der beste Berührungspunkt. Die universelle Eigenschaft
gibt das Woher nicht als Sache an, sondern nur durch sein Verhältnis zu allen
anderen Positionen. Sie bestimmt es nur bis auf Isomorphie und erst im
Nachhinein. Das kommt Zorns „Wo Thema ist, scheint Vor gewesen zu sein“
(S. 124) nahe, ohne es zu ersetzen.

# Garben als Perspektiven

Vielleicht passt keine Struktur besser auf Zorn als die Garbe. Das Buch
beginnt mit Platons Satz, der Mensch sei Mensch, „weil er zusammenschaut, was
er gesehen hat“ (S. 9). Zusammenschauen ist ziemlich wörtlich *Gluing*.
Lokale Sichten sind Schnitte $F(U)$ über Hinsichten $U$. Eine globale Sicht
wird nicht vorausgesetzt, sondern aus verträglichen lokalen Sichten
verklebt.

- **Tertium von innen.** Zwei Sichten werden auf ihrem Überlapp $U \cap V$
  verglichen, nicht in einem Raum darüber. Der Überlapp ist ein Drittes, das
  aus beiden Hinsichten kommt (vgl. S. 24).
- **Der Bestätigungsfehler als erzwungene Verklebung.** Eine Passage für
  „wesentlich“ zu erklären und den Rest als „unwesentlich“ auszusortieren
  (S. 21), heißt, die Überdeckung so lange zu verkleinern, bis die Daten
  verkleben.
- **Pluralität als Obstruktion.** Sichten können lokal konsistent sein und
  trotzdem keinen globalen Schnitt haben. Das misst die erste Kohomologie;
  Abramsky und Brandenburger beschreiben so Kontextualität. Pluralität ist
  dann weder Relativismus noch ein behebbarer Fehler.
- **Die Reflexions-Form als Forcing.** In der Kripke-Joyal-Semantik heißt
  $U \Vdash \varphi$: „von $U$ aus gilt $\varphi$“. Das ist Zorns „… : g“ mit
  explizitem Woher.
- **Lektürehinsichten als Topologien.** Verschiedene Lawvere-Tierney-Topologien
  auf derselben Prägarbenkategorie legen fest, was als ausreichendes
  Zusammenschauen gilt. Die Doppelnegations-Topologie macht die Logik
  klassisch.
- **Garbifizierung als Verschiebung.** Wer eine Prägarbe zur Garbe macht,
  fügt Schnitte hinzu und identifiziert andere. Das Verkleben verändert, was
  verklebt wird.

Damit lässt sich Zorns These knapp fassen. Die Prägarbe der *Inhalte*
philosophischer Texte hat keinen globalen Schnitt, sonst gäbe es keinen
Streit. Zorns Behauptung betrifft die Prägarbe der *reflexiven Strukturen*,
die in einer Hinsicht sichtbar sind: Sie hat einen globalen Schnitt, nämlich
Reflexivität. Die Inhalte verkleben nicht, die Strukturen schon.

Und hier bricht auch diese Brille. Jede Garbe lebt auf einem Situs, und die
Position, von der aus er gewählt wird, liegt nicht in ihm. Lawveres
Unterscheidung von *petit* und *gros* Topos macht diesen Schritt nach außen
selbst zur Struktur. Im petit Topos $\mathrm{Sh}(X)$ sieht man von einem Raum
aus. Im gros Topos ist $X$ ein Objekt unter anderen, und der petit Topos
erscheint (in günstigen Fällen) als Slice über $X$, also als der gros Topos
von $X$ aus gesehen. Der Rest bleibt trotzdem: Der gros Topos ist kein Objekt
seiner selbst und braucht ein größeres Universum. Zorn und Lawvere sehen also
denselben Punkt. Zorn beschreibt den Entzug, Lawvere macht den Schritt nach
außen zu einem Funktor.

# Wo die Übersetzung bricht

Die Kategorientheorie kann die Struktur des Woher modellieren, aber sie kann
nicht selbst das Woher sein. Zorn würde diese Lektüre zu Recht als eine
Reflexions-Struktur lesen, deren Reflexivitäts-Struktur der Leser sieht.
Bemerkenswert ist, dass die Kategorientheorie dem zustimmt: Nach Lawvere gibt
es keinen Rahmen, der sich selbst vollständig enthält.

- **Differenz mit nur einem Relat.** Hier finde ich keinen guten Kandidaten.
  Nicht-darstellbare Prägarben oder freie Konstruktionen, deren Erzeuger erst
  vom Ergebnis her sichtbar wird, sind Annäherungen, aber keine
  Strukturgleichheit.
- **Person, Gericht, Protokoll.** Kontexte $\Gamma$ sind Positionen, aber kein
  „jemand“. Zorn fasst „jemand“ zwar zunächst als Position (S. 107,
  Anm. 266), doch die pragmatische Seite (wer sagt was mit welcher Funktion)
  bleibt draußen.
- **Einübung.** Operationale Aufmerksamkeit ist für Zorn eine *téchne*, die
  nur durch Ausübung gelernt wird (S. 108). Ein Formalismus kann das stützen,
  aber nicht ersetzen. Hier hat Lean allerdings ein Argument: Auch Beweisen
  wird dort geübt, nicht gelesen.
- **Die Kanten der Mathematik.** Die modallogische Lesart setzt voraus, dass
  $\wedge$ klassisch ist und „$p :$“ über Konjunktion distribuiert. Zorn
  nennt sein $\wedge$ ausdrücklich „und zugleich, reflexiv“ (S. 163).
  Möglicherweise ist es gar keine Konjunktion.
- **Die Gefahr der Aktualisierung.** Zorn kritisiert, einen Philosophen „in
  unsere Zeit übersetzen“ zu wollen (S. 23). Dieser Post versteht sich
  deshalb als Frage, nicht als Auflösung.

# Offene Fragen

1. Gilt für „$p :$“, dass wer etwas sagt, auch sagt, dass er es sagt
   (Axiom 4)? Wenn ja, fallen Position (3) und (4) logisch zusammen. Wenn
   nein, warum endet das MMRK bei (4)?
2. Ist das $\wedge$ im MMRK eine Konjunktion oder ein eigener Operator? Was
   wäre seine Regel?
3. Wäre ein geschützter Fixpunkt, also Selbstbezug mit eingebauter
   Nachträglichkeit, eine „intensive Einholung“ oder schon eine dogmatische
   Setzung?
4. Zählt Lawveres Fixpunktsatz als Reflexions-Struktur der Mathematik, also
   als ein Text, der seine eigene Grenze thematisiert?
5. Trägt die Unterscheidung zweier Prägarben: Inhalte ohne globalen Schnitt,
   reflexive Strukturen mit globalem Schnitt? Und ist der Schritt vom petit
   zum gros Topos eine Einholung des Woher oder nur eine weitere
   Verschiebung?
6. Was steht in Schällibaums Anhang „Reflexive Phänomene in den
   Wissenschaften“ (*Reflexivität und Verschiebung*, S. 118–129; vgl. Zorn,
   S. 143, Anm. 373)?

Der Punkt, dass sich der Analytiker immer weiter nach außen verschieben
kann, wird bleiben. Zorn hat ihn gefunden, Lawvere auch. Mich interessiert,
was passiert, wenn man die beiden Wege nebeneinanderlegt.

# Literatur

- Zorn, Daniel-Pascal: *Vom Gebäude zum Gerüst. Entwurf einer Komparatistik
  reflexiver Figurationen in der Philosophie*, Berlin 2016
  ([peDOCS](https://www.pedocs.de/frontdoor.php?source_opus=33358)).
- Schällibaum, Urs: *Reflexivität und Verschiebung*, Wien 2001.
- Lawvere, F. William: *Functorial Semantics of Algebraic Theories*,
  Dissertation, Columbia University 1963.
- Lawvere, F. William: Diagonal Arguments and Cartesian Closed Categories,
  1969.
- Lawvere, F. William: Intrinsic Co-Heyting Boundaries and the Leibniz Rule
  in Certain Toposes, 1991.
- Yanofsky, Noson S.: A Universal Approach to Self-Referential Paradoxes,
  Incompleteness and Fixed Points, 2003.
- Nakano, Hiroshi: A Modality for Recursion, 2000.
- Birkedal, Lars u. a.: First Steps in Synthetic Guarded Domain Theory, 2011.
- Scott, Dana: Relating Theories of the λ-Calculus, 1980.
- Abramsky, Samson / Brandenburger, Adam: The Sheaf-Theoretic Structure of
  Non-Locality and Contextuality, 2011.
