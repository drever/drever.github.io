---
title: Zorn in Lean
author: Johannes Drever (mit Claude)
date: 2026-11-08
tags: Reflexivität, Garben, "#Maschinenraun"
description: 'Teil 2 der Lektüre von Daniel-Pascal Zorns "Vom Gebäude zum Gerüst": Formalisierung in Lean 4 und Vampire, Satz vom Widerspruch, Lügnerzyklen und eine Ironie'
---

Im [ersten Teil](2026-reflexivitaet-und-kategorien.html) habe ich den ersten
Teil von Daniel-Pascal Zorns *Vom Gebäude zum Gerüst* mit
kategorientheoretischen Werkzeugen gelesen. Seitdem ist einiges passiert:
Ich habe Kap. 5.3–5.4 (Satz vom Widerspruch, Paradoxien) gelesen, einen
Einwand von Franz Hoegl bekommen und angefangen, Teile des Buchs in Lean 4
und mit dem Theorembeweiser Vampire zu formalisieren. Das Projekt heißt
[count-dracurage](https://github.com/drever/count-dracurage). Seitenangaben
beziehen sich wieder auf die Logos-Ausgabe von 2016.

# Eine Ironie vorweg

Zorns Haupteinwand gegen mich war immer: Wer etwas hinter dem Busch
versteckt, findet genau das, was er versteckt hat. Wer mit Kategorientheorie
liest, findet Kategorientheorie. Und er hat mir unterstellt, ich wolle seine
Methode formalisieren.

Das wollte ich nie. Mein Punkt war immer die Garbenperspektive: dass lokale
Sichten sich teilweise zu einer globalen verkleben lassen, und dass die
Kategorientheorie dafür eine genaue Sprache hat. Zorns Standpunkt irgendwo
vollständig einzubetten, war nie das Ziel. Und doch sitze ich jetzt hier und
formalisiere VGZG in Lean.

Ehrlicherweise war die Idee meine. Auslöser war Nakamuras Formalisierung von
Spinozas *Ethica* in Lean. Aber man kann die Ironie noch eine Windung
weiterdrehen, und zwar mit Zorns eigenem Kap. 5.3. Dort steht Aristoteles'
elenktischer Beweis des Satzes vom Widerspruch, und sein Kern ist: „Die
Grundlage zum Beweise aber gibt nicht der Beweisende, sondern der, welcher
Rede steht“ (S. 260). Zorn legt in Kap. 4 selbst ein quasi-formales Modell
vor. Wer es formalisiert, nimmt ihn beim Wort. Die Formalisierung ist in
diesem Sinn elenktisch: Das Material hat der geliefert, der Rede steht.

Bleibt der Vorwurf mit dem Busch. Für ihn gibt es einen einfachen Test: Hat
die Lektüre etwas gefunden, das sie nicht erwartet hat? Wer nur findet, was
er versteckt hat, wird weder überrascht noch widerlegt. Diese Lektüre ist
beides geworden. Unten stehen drei Ergebnisse, mit denen ich nicht gerechnet
habe, und eine Stelle, an der die Übersetzung schlicht scheitert. Und das
Projekt bettet Zorn gerade nicht vollständig ein. Formalisiert sind nur die
Stellen, an denen er selbst quasi-formal wird, mit ausgewiesenen
Brückenannahmen. Lokale Schnitte, kein globaler. Das Projekt ist also selbst
ein Fall der Garbenperspektive, um die es mir ging.

# Das Setup

`count-dracurage` ist ein Lean-4-Projekt ohne Mathlib, dazu Probleme für
Vampire im TPTP-Format. Wie bei Nakamura sind die Annahmen in Schichten
getrennt: was bei Zorn steht (mit Seitenangabe) und was wir als Brücke
hinzufügen müssen, um überhaupt rechnen zu können. Die wichtigste Brücke:
Zorns $\wedge$ („und zugleich, reflexiv“, S. 163) wird als gewöhnliche
Konjunktion gelesen, sein „$p :$“ als Modaloperator. Zorn würde beides
vermutlich bestreiten. Genau dieser Streit wäre produktiv.

Ein Skript prüft alles auf einmal: Lean-Build, kein `sorry`, alle
Vampire-Probleme gegen ihr erwartetes Ergebnis, und welche Axiome die
Hauptsätze benutzen. Mit `nix-shell` läuft es auch lokal.

# Ergebnis 1: Zorns Modell hängt an einer Weiche

Zorns „Modell für Modelle reflexiver Komplizierung“ (MMRK, S. 163–168)
folgt dem Bildungsgesetz

$$
C_1 = g, \qquad C_{n+1} = C_n \wedge (p : C_n).
$$

Liest man „$p :$“ als Modalität $\Box$ mit Kripke-Semantik, beweist Lean:

- **Mit Axiom 4** ($\Box g \to \Box\Box g$, „wer etwas sagt, sagt auch, dass
  er es sagt“) ist jede Stufe ab Position (3) äquivalent zu (3). Zorns
  Reflexivitäts-Struktur (4) fiele logisch mit der Reflexions-Struktur (3)
  zusammen.
- **Ohne Axiom 4** sagt jede Stufe echt mehr als die vorige. Das ist Zorns
  Regress (Figur φ). Das Gegenmodell ist eine einfache Kette von Welten.
- **Figur μ**, die „intensive Einholung“, ist der größte Fixpunkt der
  Gleichung $X \leftrightarrow g \wedge (p : X)$. Er enthält jede endliche
  Stufe.

Vampire bestätigt das unabhängig. Den Kollaps beweist er automatisch, und im
zweiten Fall findet sein Model-Finder genau das Gegenmodell aus dem
Lean-Beweis: drei Welten in einer Kette, $g$ gilt in den ersten beiden. Und
auch mit Axiom 4 bleiben (2) und (3) verschieden. Der Kollaps setzt genau
zwischen (3) und (4) ein.

Daraus ergibt sich eine scharfe Frage an Zorn: Gilt für „$p :$“ Axiom 4?
Wenn ja, ist der Unterschied zwischen (3) und (4) kein logischer, sondern
einer der Auslegung. Wenn nein, warum endet das Modell bei (4)?

# Ergebnis 2: Der Satz vom Widerspruch ist kein Axiom

Zorns These in Kap. 5.3: Der Satz vom Widerspruch (SdW) ist kein
ontologisches Gesetz, sondern „die Explikation unseres Umgangs mit
Gesetztem“ (S. 257). Er lässt sich nicht formallogisch herleiten, „weil jede
formale Logik von Axiomen, d. h. von Geltungssetzungen ausgehen muss“
(S. 260).

Das ist eine Behauptung über formale Logik, und man kann sie prüfen. In Lean
gilt:

```lean
theorem sdw (A : Prop) : ¬ (A ∧ ¬ A) :=
  fun ⟨a, na⟩ => na a
```

`#print axioms sdw` meldet: *does not depend on any axioms*. Der SdW folgt
in Lean aus der Bedeutung der Negation, nicht aus einem Axiom. Zorn hat also
recht, und zwar genauer, als er vielleicht dachte. Und der Beweisterm hat die
Struktur des elenktischen Beweises: Die Setzung `a` des Opponenten wird
seiner eigenen Verneinung `na` übergeben. Den Beweisgrund liefert der
Opponent.

Der Satz vom ausgeschlossenen Dritten dagegen ist in Lean ein Axiom
(`Classical.em`). Zorns Unterscheidung zwischen dem unhintergehbaren SdW und
der dogmatischen Wahrheitswert-Setzung fällt damit fast genau auf die Grenze
zwischen konstruktiver und klassischer Logik. Auch „wer etwas setzt, hat
dieses und nicht jenes gesetzt“ (S. 262–263) braucht kein Axiom. Es folgt
daraus, dass verschiedene Konstruktoren verschieden sind.

# Ergebnis 3: Das Enthymem des Lügners sitzt woanders

Zorns Diagnose in Kap. 5.4: Die Lügner-Paradoxie startet erst durch ein
Enthymem, eine stillschweigende Prämisse „wenn der Satz wahr ist …“, also
eine Wahrheitswert-Zuweisung a priori (S. 271). Hier widerspricht Lean ihm
ein Stück:

```lean
theorem luegner_ohne_bivalenz (L : Prop) : ¬ (L ↔ ¬ L) := fun h =>
  have nl : ¬ L := fun l => h.1 l l
  nl (h.2 nl)
```

Das ist konstruktiv beweisbar, ohne ausgeschlossenes Drittes. Der Lügner
braucht also keine Bivalenz. Was er braucht, ist die Annahme, dass der
Lügnersatz überhaupt eine Proposition benennt, einen Fixpunkt der Negation.
Genau das schließt Lawveres Fixpunktsatz aus (Teil 1). Zorn liegt im Ergebnis
richtig, die Paradoxie lebt von einer versteckten Annahme. Aber die Annahme
ist eine andere. Der von Zorn zitierte Goldstein, der zwischen Sätzen und
Aussagen unterscheidet (Anm. 710), liegt näher an dieser Lesart als an der
Bivalenz.

# Ergebnis 4: Das Möbiusband ist wörtlich zu nehmen

Zorns Bild für die Auflösung von Paradoxien ist das Möbiusband: Die Illusion
gelingt, wenn man die Verdrillung und die Klebestelle ignoriert. „Es gilt
also bei Paradoxien immer, die Klebestelle zu finden“ (S. 277).

Das ist mathematisch exakt. Sein Zwei-Satz-Lügner („der folgende Satz ist
wahr“, „der vorige Satz ist falsch“) ist ein Zyklus, dessen Übergänge einmal
die Identität und einmal die Negation sind. Lean beweist allgemein:

> Ein Zyklus von „ist wahr“- und „ist falsch“-Sätzen lässt sich genau dann
> widerspruchsfrei belegen, wenn er eine gerade Zahl an Negationen hat.

Die Parität ist die Verdrillung. Lokal ist jeder Übergang unproblematisch,
global entscheidet der Umlauf. Garbentheoretisch ist das eine Obstruktion
gegen einen globalen Schnitt. Abramsky beschreibt Lügnerzyklen genau so, als
Fall von Kontextualität. Zorns „Klebestelle finden“ heißt dann: die
Übergangsabbildung explizit machen. Und seine „Verknappung der Kontexte“
(S. 275) ist die Wahl einer Überdeckung, die nur aus dem Zyklus besteht.

Ein schöner Nebenbefund: Der Wahrsager („dieser Satz ist wahr“) ist nicht
widersprüchlich, sondern unterbestimmt. Er hat zwei konsistente Belegungen.
Zwei globale Schnitte statt keinem. Vampire bestätigt das an drei Beispielen
und liefert im lösbaren Fall eine konkrete Belegung.

# Ergebnis 5: Akt und Aussage

Zorn unterscheidet den inhaltlichen Widerspruch (Inhalt gegen Inhalt) vom
performativen (Aussage gegen Akt, S. 254) und greift Mackies vier Typen der
Selbstwiderlegung auf (Anm. 726). Modelliert man Akte ausdrücklich, also so,
dass der Inhalt vom Akt abhängt, der ihn äußert, ergibt sich:

- „Ich sage nichts“ wird erst durch den Akt falsch, der es sagt. In einer
  Welt ohne Akte wäre der Inhalt wahr.
- „Ich weiß nichts“ widerlegt sich, weil Wissen faktiv ist.
- „Ich glaube nichts“ widerlegt sich nicht. Wer es glaubt, glaubt nur etwas
  Falsches.
- „Ich lüge immer“ ist, wie Zorn sagt (S. 278), kein Paradox, sondern schlicht
  falsch. Und daraus folgt sogar, dass der Sprecher irgendwann etwas Wahres
  gesagt hat. Nur dieser letzte Schritt braucht klassische Logik.

# Typentheorie, nur Regress?

Eine Reibungsstelle: Zorn schreibt, die Typentheorie verwirkliche
Reflexivität nur „negativ, als Regress“, weil sie reflexive Komplizierung
nicht ausdrücken könne (S. 275). Seine eigene Russell-Analyse, die Verdopplung
$M : (M : \ldots)$ gegen $M : \ldots$, und Wittgensteins Bemerkung, äußere und
innere Funktion hätten verschiedene Bedeutungen (TLP 3.333, bei Zorn
Anm. 715), beschreiben im Kern, dass $F(F)$ nicht typisierbar ist. Das trifft
die einfache Typenhierarchie. Geschützte Rekursion und reflexive Objekte
drücken dagegen kontrollierten Selbstbezug aus. Ob das „reflexive
Komplizierung“ in Zorns Sinn ist, ist eine offene Frage. „Nur Regress“ ist
es jedenfalls nicht.

# Franz Hoegls Einwand

Franz Hoegl hat eingewandt, Corfield registriere an mathematischen
Strukturen, was Schällibaum Reflexions-Struktur nennt, komme dabei aber nicht
zur Wahrnahme der eigenen Reflexivitäts-Struktur. Der Einwand trifft auch
meinen ersten Post: Lawvere als Beleg dafür anzuführen, dass „die Mathematik
den Punkt auch kennt“, ist wieder Reflexions-Struktur, nur auf höherer Ebene.

Aber der Einwand ist ein Catch-22. Nach Zorns eigener Definition ist die
Reflexivitäts-Struktur „immer für den Leser“ sichtbar (S. 118). Jede Antwort,
die ein Text darauf gibt, ist sofort wieder Gesagtes. Der Einwand lässt sich
also gegen jeden Text erheben, auch gegen Zorns eigenen, und keine Antwort
kann ihn erledigen. Ein solcher Einwand kann richtig sein, aber er trennt
nichts. Ich glaube ohnehin nicht, dass Texte etwas wahrnehmen. Dass Franz die
Reflexivitäts-Struktur an Corfield sieht, ist der Schritt, den der Text selbst
nicht machen kann. Und das ist kein Versagen, sondern genau so, wie es
Schällibaum beschreibt: „Einem bereits in sich Reflexiven ist nicht durch ein
Nicht-Reflexives zu begegnen, nur durch eine andere Reflexivität“
(bei Zorn S. 105).

# Meine eigene Position

Mich interessiert eine andere, positive Behauptung. In-der-Welt-Sein oder
Bewusstsein findet statt und strukturiert sich, gern auch konkret in Texten.
Platon reflektiert bereits seine Vorgänger und bringt ihre Strukturen in eine
Zusammenschau. Dieser Prozess wiederholt sich: Zusammenschauen werden selbst
wieder zusammengeschaut. Dabei stabilisieren sich Fixpunkte, und es gibt
kanonische, minimale Strukturen, die in verschiedenen Zusammenhängen als
dieselben erkannt werden. Das ist hegelianisch, und ich vertrete es als These,
nicht als Widerlegung von Zorn.

Mathematik betreibt diese Zusammenschau von Zusammenschauen in extremer Form.
Sie entwickelt dafür eigene Darstellungsformen, bis hin zur Art, an der Tafel
zu schreiben. Kommutative Diagramme und Pfeile sind Formen, um etwas zu
zeigen, und darum geht es in der Mathematik.

Die Kategorientheorie hat für meine These genaue Begriffe:

- **Kanonisch und minimal** heißt universelle Eigenschaft. Das Produkt in
  Set, in Top, in der Logik ($\wedge$) und bei Typen ist überall dasselbe,
  und die universelle Eigenschaft zeigt das.
- **Umfassen, ohne zu ersetzen**, heißt volltreue Einbettung. Die
  Yoneda-Einbettung nimmt eine Kategorie vollständig in eine größere auf.
  „Umfasst“ wäre übrigens das bessere Wort gewesen als das „veraltet“, mit dem
  die ganze Diskussion auf Twitter angefangen hat.
- **Fixpunkte sind keine Endpunkte.** Jede Einbettung lässt sich wieder
  einbetten. Die Fixpunkte sind Strukturen, die sich bei jedem Schritt
  wiederfinden, nicht ein letzter Standpunkt.

Und dann ist da die Syntax. Ein Diagramm $D : I \to C$ ist zugleich Bild und
Gegenstand: Man zeichnet es an die Tafel, und es ist ein Funktor, mit dem man
rechnet. Das Zeigemittel wird selbst Gegenstand der Theorie, ohne dass seine
Form verloren geht. Das ist die (Prä-)Garbenperspektive. Spivak erklärt sie
mit Datenbanken (Schema als Kategorie, Instanz als Funktor), Lawvere nutzt sie
für die funktorielle Semantik. An einem Diagramm lässt sich sogar
Schällibaums Dreiheit ablesen:

| Diagramm $D : I \to C$ | Schällibaum / Zorn |
|---|---|
| Indexkategorie $I$ | Hinsicht |
| Zielkategorie $C$ | Worin |
| der Funktor $D$ | Worüber |
| Limes von $D$ (falls er existiert) | Woher, bestimmt nur durch seine Beziehungen |

Zorn selbst zitiert, dass der edle Sophist den Widerspruch „durch die
Zusammenstellung selbst“ zeigt, *tithéntes dè epideiknúousin* (Soph. 230b,
bei Zorn S. 257). Zusammenstellung ist bei ihm also schon ein Zeigen. Ein
kommutatives Diagramm ist genau das: eine Zusammenstellung, die etwas zeigt.
Das ist der Punkt, den ich eigentlich machen wollte: dass es sich lohnt, sich
die Kategorientheorie anzusehen, weil das, was dort gezeigt wird, selbst
wieder selbstbezüglich ist.

# Offene Fragen

1. Gilt für „$p :$“ Axiom 4? Wenn ja, fallen Position (3) und (4) logisch
   zusammen. Wenn nein, warum endet das MMRK bei (4)?
2. Ist das $\wedge$ im MMRK eine Konjunktion oder ein eigener Operator?
3. Sitzt das Enthymem des Lügners in der Bivalenz oder in der Annahme, dass
   der Lügnersatz eine Proposition ist?
4. Ist geschützte Rekursion, also Selbstbezug mit eingebauter
   Nachträglichkeit, „reflexive Komplizierung“ oder nur ein raffinierterer
   Regress?
5. Was würde bei einem mathematikphilosophischen Text als Wahrnahme der
   eigenen Reflexivitäts-Struktur zählen, wenn nicht ein anderer Leser?

# Literatur

- Zorn, Daniel-Pascal: *Vom Gebäude zum Gerüst. Entwurf einer Komparatistik
  reflexiver Figurationen in der Philosophie*, Berlin 2016
  ([peDOCS](https://www.pedocs.de/frontdoor.php?source_opus=33358)).
- [count-dracurage](https://github.com/drever/count-dracurage): die
  Formalisierung in Lean 4 und Vampire.
- Nakamura, Yuki: *Bennett's Conjecture in Lean 4*, 2026,
  [arXiv:2605.02331](https://arxiv.org/abs/2605.02331).
- Rapp, Christof: Aristoteles über die Rechtfertigung des Satzes vom
  Widerspruch, in: Zeitschrift für philosophische Forschung 47 (1993),
  S. 521–541.
- Mackie, John L.: Self-Refutation – A Formal Analysis, in: The Philosophical
  Quarterly 14 (1964), S. 193–203.
- Abramsky, Samson: Contextuality: At the Borders of Paradox, in: Landry,
  Elaine (Hg.): *Categories for the Working Philosopher*, Oxford 2017.
- Lawvere, F. William: Diagonal Arguments and Cartesian Closed Categories,
  1969.
- Spivak, David I.: *Category Theory for the Sciences*, Cambridge (MA) 2014.
- Nakano, Hiroshi: A Modality for Recursion, 2000.
