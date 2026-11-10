---
title: Re-entry ohne Paradox. Eine Einladung an die Systemtheorie (Teil 1)
author: Johannes Drever (mit Claude)
date: 2026-11-10
tags: "#Maschinenraun"
---

Brendan Fong und David Spivak haben ihr Lehrbuch *An Invitation to Applied Category Theory* genannt. Diese kleine Serie ist im selben Sinn gemeint: als Einladung. Sie richtet sich an Leserinnen und Leser aus der Systemtheorie, an Luhmannianer ebenso wie an die Schülerinnen und Schüler von Gotthard Günther und Rudolf Kaehr. Ich komme aus der Softwareentwicklung, nicht aus der Soziologie. Was ich anbieten kann, sind Werkzeuge für Fragen, die in der Systemtheorie schon lange gestellt werden.

Die Verbindung ist nicht neu. Francisco Varela hat in *Principles of Biological Autonomy* (1979) mit Kategorien und adjungierten Funktoren gearbeitet. Louis Kauffman verfolgt seit Jahrzehnten das Zusammenspiel von *Laws of Form*, Rekursion und Kategorientheorie. Rudolf Kaehr hat eine polykontexturale Kategorientheorie skizziert, Walter Tydecks hat versucht, den Formkalkül in Pfeilen zu schreiben. Alle haben gesehen, dass hier etwas zusammengehört. Ich möchte eine Tür aufnehmen, die Kauffman ausdrücklich offen gelassen hat.

Teil 1 handelt vom Re-entry. Teil 2 wird von Beobachtern und Kontexturen handeln, Teil 3 vom Umtausch von Objekt und Prozess.

## Kauffmans Frage

In seinem Aufsatz über die Mathematik Varelas (*Constructivist Foundations* 13/1, 2017) führt Kauffman die Kategorientheorie mit einem schönen Beispiel ein. Die einfachste Kategorie hat ein Objekt $O$ und nur die Identität. Die nächst einfachste hat zusätzlich einen Pfeil $f: O \to O$. Aus ihm entstehen die Kompositionen $f, ff, fff, \ldots$, eine für jeden Umlauf. Kauffman nennt das „self-reference is infinity in finite guise“ (§38).

Dann macht er einen Schritt, der mich lange irritiert hat. Er betrachtet die *unendliche* Komposition $C = fff\ldots$ und stellt fest, dass $fC = C$ gilt, denn ein $f$ mehr ändert am Unendlichen nichts (§39). $C$ ist eine erste Eigenform. Kauffman weiß, dass er damit die gewöhnliche Kategorientheorie verlässt, und sagt es auch.

Warum braucht er diesen Schritt? Weil es unter den endlichen Kompositionen keinen Fixpunkt gibt. Die Gleichung $f \circ g = g$ hat in dieser Kategorie keine Lösung, denn $f \circ f^n = f^{n+1}$, und die Längen addieren sich. Wer eine Eigenform will, muss etwas hinzufügen.

Dass $C$ nicht zur Kategorie gehört, sieht man an einem Detail: $C$ schluckt ein $f$ nur auf einer Seite. Ein $f$ *vor* der unendlichen Folge verschwindet, ein $f$ *danach* nicht. Bei den Ordinalzahlen ist es genauso: $1 + \omega = \omega$, aber $\omega + 1 \neq \omega$. $C$ ist keine Komposition, sondern ein Punkt im Unendlichen.

Bemerkenswert ist, dass Kauffman selbst wenige Absätze später einen anderen Weg geht. Mit dem Fixpunktsatz von Church und Curry erzeugt er den Re-entry, wie er schreibt, ohne Ausflug ins Unendliche (§52–53). Dieser zweite Weg ist der kategorientheoretische. Um ihn geht es hier.

## Form und Wert

Zuerst eine Trennung, die viel aufräumt: Die Form ist das eine, ihr Wert das andere. In Haskell lässt sich das in wenigen Zeilen hinschreiben.

```haskell
import Data.Function (fix)

-- Ein Raum enthält Marken, eine Marke umschließt einen Raum.
newtype Space = Space [Mark]
data Mark     = Cross Space

void, mark :: Space
void = Space []               -- der leere Raum: unmarkiert
mark = Space [Cross void]     -- < >

-- Ein Raum ist markiert, wenn er eine Marke enthält,
-- deren Inneres unmarkiert ist.
value :: Space -> Bool
value (Space ms) = or [ not (value inner) | Cross inner <- ms ]
```

Die beiden Gesetze von Spencer-Brown kommen heraus, ohne dass man sie hineinschreibt. `value (Space [Cross mark])` ist `False`, das ist das Gesetz des Kreuzens: $\langle\langle\,\rangle\rangle = \;$. `value (Space [Cross void, Cross void])` ist `True`, das ist das Gesetz des Nennens: $\langle\,\rangle\langle\,\rangle = \langle\,\rangle$.

Und nun der Re-entry $K = \langle K \rangle$:

```haskell
k :: Space
k = fix (\s -> Space [Cross s])    -- K = <K>
```

Das kompiliert und läuft. Haskell wertet verzögert aus, die unendliche Verschachtelung $\langle\langle\langle\ldots\rangle\rangle\rangle$ ist ein ganz gewöhnlicher Wert. Technisch ist sie ein Element einer finalen Koalgebra. Kauffmans $C = fff\ldots$ ist in derselben Weise unproblematisch: `fix (f :)` ist die Liste, die mit `f` beginnt und dann wieder sich selbst enthält.

Die unendliche Form springt also nicht aus der Form heraus. Heraus springt erst die Frage nach ihrem Wert. `value k` rechnet ewig und liefert keine Antwort.

## Warum der Wert fehlt

Dass es hier keinen Wert geben *kann*, ist kein Mangel des Programms, sondern ein Satz. William Lawvere hat 1969 gezeigt, dass hinter Cantors Diagonalargument, Russells Antinomie, Tarskis Undefinierbarkeit der Wahrheit und Gödels Diagonallemma ein einziger Satz steht:

> **Lawveres Fixpunktsatz.** Ist in einer kartesisch abgeschlossenen Kategorie $\varphi: A \to B^A$ punkt-surjektiv, so hat jede Abbildung $f: B \to B$ einen Fixpunkt.

Punkt-surjektiv heißt: Jede Abbildung von $A$ nach $B$ ist als ein Element von $A$ eingeholt. Der Beweis ist eine Zeile. Man setzt $g(a) = f(\varphi(a)(a))$. Weil $\varphi$ punkt-surjektiv ist, gibt es ein $a_0$ mit $\varphi(a_0) = g$. Dann ist $g(a_0) = f(\varphi(a_0)(a_0)) = f(g(a_0))$, also ein Fixpunkt von $f$.

Das ist genau Kauffmans Beweis des Satzes von Church und Curry (§51): $Gx = F(xx)$, also $GG = F(GG)$. Kauffmans „reflexive domain“, in dem jedes Element zugleich eine Transformation ist, ist ein Objekt $D$ mit einer punkt-surjektiven Abbildung $D \to D^D$.

Liest man den Satz umgekehrt, sagt er: Die Negation auf den zwei Werten markiert und unmarkiert hat keinen Fixpunkt. Also kann es in der Welt der Mengen mit zwei Wahrheitswerten keinen reflexiven Bereich geben, und $K = \langle K \rangle$ hat dort keinen Wert. Kauffman fordert für die Kybernetik eine „freedom of foundations“ (§50). Der Fixpunktsatz sagt genau, was diese Freiheit kostet: Man muss die Kategorie wechseln. Es gibt mindestens zwei Arten, das zu tun, und sie führen zu zwei verschiedenen Antworten.

## Erster Ausweg: ein Wert für das Unentschiedene

Dana Scott hat reflexive Bereiche $D \cong D^D$ konstruiert, indem er Mengen durch geordnete Strukturen ersetzt hat. Zu jedem Typ kommt ein Element $\bot$ hinzu, „noch keine Information“. In dieser Welt hat jede stetige Abbildung einen kleinsten Fixpunkt, und man bekommt ihn als Grenzwert der Näherungen:

$$\mathrm{fix}(f) = \bigsqcup_n f^n(\bot).$$

Hier ist Kauffmans unendliche Komposition auf einmal legitim. Sie ist aber kein Pfeil der Kategorie, sondern ein Limes von Näherungen, und dieser Limes existiert nur, weil man vorher eine Ordnung eingeführt hat, die sagt, wann Näherungen zusammenlaufen.

Der kleinste Fixpunkt der Negation ist $\bot$ selbst. Genau das passiert, wenn Haskell `value k` oder `fix not` auszuwerten versucht: Die Rechnung kommt nie zu einem Ende, und in Scotts Semantik ist ihr Wert $\bot$.

Varela ist 1975 in *A Calculus for Self-Reference* einen ähnlichen Weg gegangen. Er hat dem Formkalkül einen dritten, „autonomen“ Wert hinzugefügt, der sich selbst bezeichnet und beim Kreuzen unverändert bleibt. 1979 hat er daraus eine dreiwertige Logik gemacht. Sein autonomer Wert verhält sich gegenüber der Negation wie $\bot$.

## Zweiter Ausweg: Zeit

Spencer-Brown selbst hat im elften Kapitel der *Laws of Form* einen anderen Weg vorgeschlagen. Der Re-entry hat keinen Wert, sondern einen Verlauf: Er oszilliert zwischen markiert und unmarkiert, so wie $i$ zwischen $1$ und $-1$, wenn man es immer wieder mit sich selbst multipliziert.

Auch das lässt sich hinschreiben. Statt den Wert von $K$ auf einmal zu verlangen, fragt man nach der Näherung bis zur Tiefe $n$ und setzt ganz innen den unmarkierten Zustand ein:

```haskell
approx :: Int -> Space -> Bool
approx 0 _          = False
approx n (Space ms) = or [ not (approx (n - 1) inner) | Cross inner <- ms ]

-- [ approx n k | n <- [0..7] ]
--   == [False,True,False,True,False,True,False,True]
```

Die Näherungen konvergieren nicht, sie schwingen. Man kann die Schwingung auch direkt als Strom schreiben. Kauffman und Varela haben 1980 in *Form Dynamics* die beiden Phasen als Wellenformen $i$ und $j$ eingeführt:

```haskell
i, j :: [Bool]
i = True  : map not i     -- True, False, True, False, ...
j = False : map not j     -- False, True, False, True, ...
```

`j` ist genau die Folge der Näherungen von `k`. Diese Definitionen sind *geschützt*: Bevor sich `i` auf sich selbst bezieht, steht schon ein Wert da, ein Schritt Zeit ist vergangen. Für solche Gleichungen gibt es einen allgemeinen Satz. In geschützter Typentheorie (Nakano 2000) und im Topos der Bäume (Birkedal u. a. 2012) hat jede geschützte Fixpunktgleichung genau eine Lösung. Ungeschützter Selbstbezug führt in den Widerspruch oder ins $\bot$. Selbstbezug mit eingebauter Verzögerung ist eindeutig lösbar.

## Ein Re-entry, vier Antworten

| Rahmen | Lösung von $K = \langle K \rangle$ | bei wem |
|---|---|---|
| Mengen, zwei Werte | keine (Lawvere) | Spencer-Brown, das Problem in Kap. 11 |
| geordnete Bereiche (Scott) | $\bot$, der kleinste Fixpunkt | Varelas autonomer Wert (1975) |
| Ströme, geschützte Rekursion | Oszillation $i$ bzw. $j$ | Spencer-Browns imaginärer Wert, Kauffman/Varela (1980) |
| reflexiver Bereich | jede Transformation hat eine Eigenform | Kauffman (2017, §49–53) |

Die Mathematik entscheidet nicht, welche Zeile die richtige ist. Sie zeigt, dass die Frage „Welchen Wert hat der Re-entry?“ unvollständig ist, solange man nicht sagt, in welchem Rahmen gefragt wird. Und sie zeigt genau, was jeder Rahmen kostet: Wer zwei Werte und keine Zeit will, bekommt die Paradoxie. Wer ein drittes „Unentschiedenes“ zulässt, bekommt $\bot$. Wer Zeit zulässt, bekommt die Schwingung.

Mir scheint, hier liegt der eigentliche Berührungspunkt mit der Systemtheorie. Die Wahl des Rahmens ist eine Entscheidung darüber, wer beobachtet und wie: ein Beobachter, der auf einen Wert wartet, oder einer, der einen Verlauf verfolgt. Die Paradoxie verschwindet nicht, aber sie wird zu einer Aussage über den Beobachter.

## Offene Fragen

Diese Fragen kann ich nicht allein beantworten. Hier beginnt die Einladung.

- Luhmann spricht davon, dass Systeme zwischen den Seiten einer Unterscheidung oszillieren und Paradoxien durch Zeit entfalten. Ist das die Zeile mit den Strömen? Oder gibt es in der Systemtheorie auch Stellen, die eher dem $\bot$ entsprechen, also einem Wert, der sich nicht entscheidet?
- Kauffmans unendliche Komposition $C = fff\ldots$ ist ein Punkt im Unendlichen, der $f$ nur von einer Seite schluckt. Hat diese Einseitigkeit eine Bedeutung, etwa als Richtung der Zeit oder als Unterschied zwischen Anfang und Anschluss?
- Spencer-Browns Gleichungen zweiten Grades, etwa der Modulator, sind Systeme gekoppelter Re-entries. Lassen sie sich alle als geschützte Stromgleichungen schreiben? Dann hätten sie eindeutige Lösungen, und man könnte sie ausrechnen.
- Wenn verschiedene Beobachter verschiedene Rahmen wählen, wie verhalten sich ihre Antworten zueinander? Das wäre eine Frage nach Kontexturen und führt direkt zu Teil 2.

Wer mitdenken, widersprechen oder ergänzen möchte, ist herzlich eingeladen. Den Code aus diesem Post kann man mit einem gewöhnlichen GHC ausprobieren.

## Literatur

- Birkedal, Lars / Møgelberg, Rasmus E. / Schwinghammer, Jan / Støvring, Kristian: First Steps in Synthetic Guarded Domain Theory: Step-Indexing in the Topos of Trees, in: Logical Methods in Computer Science 8 (2012).
- Fong, Brendan / Spivak, David I.: An Invitation to Applied Category Theory. Seven Sketches in Compositionality, Cambridge 2019.
- Kauffman, Louis H.: Mathematical Work of Francisco Varela, in: Constructivist Foundations 13 (2017), H. 1, S. 11–17.
- Kauffman, Louis H. / Varela, Francisco J.: Form Dynamics, in: Journal of Social and Biological Structures 3 (1980), S. 171–206.
- Lawvere, F. William: Diagonal Arguments and Cartesian Closed Categories, in: Category Theory, Homology Theory and their Applications II, Lecture Notes in Mathematics 92, Berlin 1969.
- Nakano, Hiroshi: A Modality for Recursion, in: Proceedings of LICS 2000.
- Scott, Dana: Relating Theories of the λ-Calculus, in: Seldin, J. P. / Hindley, J. R. (Hg.): To H. B. Curry, London 1980.
- Spencer-Brown, George: Laws of Form, London 1969.
- Varela, Francisco J.: A Calculus for Self-Reference, in: International Journal of General Systems 2 (1975), S. 5–24.
- Varela, Francisco J.: The Extended Calculus of Indications Interpreted as a Three-Valued Logic, in: Notre Dame Journal of Formal Logic 20 (1979), S. 141 ff.
- Varela, Francisco J.: Principles of Biological Autonomy, New York 1979.
- Yanofsky, Noson S.: A Universal Approach to Self-Referential Paradoxes, Incompleteness and Fixed Points, in: Bulletin of Symbolic Logic 9 (2003), S. 362–386.
