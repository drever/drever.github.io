---
title: Objekt und Prozess. Eine Einladung an die Systemtheorie (Teil 3)
author: Johannes Drever (mit Claude)
date: 2026-11-10
tags: "#Maschinenraun"
---

In [Teil 1](2026-reentry-ohne-paradox.html) ging es um den Re-entry, in [Teil 2](2026-beobachter-und-kontexturen.html) um Beobachter und Kontexturen. Dieser letzte Teil nimmt eine Frage auf, die Rudolf Kaehr sein Leben lang beschäftigt hat: Kann man Objekt und Prozess, Relatum und Relation, zugleich in den Blick nehmen? Oder zwingt jede Formalisierung dazu, sich für eine Seite zu entscheiden?

Kaehr hat diese Frage an die Kategorientheorie gerichtet, und er kannte sie gut. In seinen Folien *Diagrammatik und Komplementarität* (2010) steht das Interchange-Gesetz für Komposition und Juxtaposition, also der Kern der monoidalen Kategorien. In der SKIZZE von 2004 zitiert er die Definition einer Kategorie korrekt und kennt Joseph Goguens Hinweis, dass man Kategorien allein mit Morphismen definieren kann. Und doch kommt er zu dem Schluss, die Kategorientheorie sei eine „dualistische Theorie“ von Objekten und Morphismen, die es „aus logischen Gründen“ nicht vermöge, beide Fokussierungen simultan zu vollziehen (S. 104–106). Deshalb hat er eine eigene polykontexturale Kategorientheorie entworfen, mit Diamonds, Chiasmen und Saltisationen.

Ich glaube, dass die Kategorientheorie hier mehr kann, als Kaehr ihr zugetraut hat. Ich glaube auch, dass seine Fragen genau die richtigen sind. Dieser Post zeigt einige Konstruktionen, die es dafür schon gibt, und fragt, ob sie das treffen, was Kaehr gesucht hat.

## Pfeile allein genügen

Kaehr schreibt, es fehle „eine fundierende Theorie der reinen Morphismen, die nicht mengentheoretisch ist“ (S. 106). Hier lohnt ein Blick auf William Lawvere. Lawvere hat 1964 die Kategorie der Mengen selbst durch Axiome über Pfeile beschrieben und 1966 vorgeschlagen, die Kategorie der Kategorien als Grundlage der Mathematik zu nehmen. Beide Theorien sprechen nicht über Elemente und Enthaltensein, sondern nur über Pfeile und ihre Komposition.

Schon die Definition einer Kategorie kommt ohne Objekte aus. Man nimmt nur Pfeile und eine teilweise definierte Komposition. Die Identitäten sind dann die Pfeile $e$, die jeden Pfeil, mit dem sie sich verketten lassen, unverändert lassen. Die „Objekte“ sind nichts anderes als diese Identitäten. Mac Lane führt diese Lesart gleich im ersten Kapitel von *Categories for the Working Mathematician* vor. Der Dualismus von Objekt und Morphismus ist also keine Voraussetzung der Theorie, sondern eine bequeme Schreibweise.

## Objekt und Morphismus zugleich

Kaehrs stärkerer Einwand ist, dass man nicht *gleichzeitig* auf Objekte und Morphismen schauen könne. In seinem „Conceptual Graph“ zeichnet er zwei gegenläufige Kategorientheorien: „Was in Kat1 Morphismus ist in Kat2 Objekt“ (S. 110).

Diese Konstruktion gibt es, und zwar in mehreren Formen:

- **Die Pfeilkategorie.** Zu jeder Kategorie $C$ gibt es die Kategorie $C^{\to}$. Ihre Objekte sind die Pfeile $f: A \to B$ von $C$. Ein Morphismus von $f$ nach $g: A' \to B'$ ist ein kommutierendes Quadrat, also ein Paar $u: A \to A'$, $v: B \to B'$ mit $v \circ f = g \circ u$. Was in $C$ Prozess war, ist in $C^{\to}$ Gegenstand.
- **2-Kategorien.** In der Kategorie der Kategorien sind Funktoren Morphismen. Zwischen zwei Funktoren gibt es aber selbst wieder Morphismen, die natürlichen Transformationen. Zwischen zwei Kategorien $C$ und $D$ bilden die Funktoren eine eigene Kategorie, in der sie Objekte sind. Ein Funktor ist also beides zugleich: Morphismus auf der einen Stufe, Objekt auf der nächsten. Man muss sich nicht entscheiden, beide Rollen sind in derselben Struktur da.
- **Der reflexive Bereich.** Die radikalste Form kennen wir aus Teil 1. In Kauffmans reflexivem Bereich $D$ ist jedes Element zugleich eine Transformation von $D$, „every ‚person' is also an ‚agent'“ (Kauffman 2017, §49). Was das kostet, hat Teil 1 gezeigt: Man braucht Scotts geordnete Bereiche, und die Negation bekommt einen Fixpunkt.

## Komposition und Juxtaposition

Kaehrs Folien unterscheiden zwischen klassischer Kategorientheorie, die nur Komposition kennt, und moderner, die Komposition und Juxtaposition zugleich hat. Das trifft genau den Übergang zu den monoidalen Kategorien. Dort gibt es zwei Arten, Prozesse zu verbinden: hintereinander ($\circ$) und nebeneinander ($\otimes$). Das Interchange-Gesetz, das auf Kaehrs Folie steht, sagt, dass es nicht darauf ankommt, in welcher Reihenfolge man beides tut:

$$(f \otimes g) \circ (h \otimes k) = (f \circ h) \otimes (g \circ k).$$

In Haskell ist das Nebeneinander für Funktionen der Operator `***`, und man kann das Gesetz direkt nachprüfen:

```haskell
import Control.Arrow ((***))

f, g, h, k :: Int -> Int
f = (+ 1); g = subtract 3; h = (* 2); k = (^ 2)

interchange :: Bool
interchange = and [ ((f *** g) . (h *** k)) x == ((f . h) *** (g . k)) x
                  | x <- [ (m, n) | m <- [0 .. 9], n <- [0 .. 9] ] ]
-- interchange == True
```

Joyal und Street haben 1991 bewiesen, dass man in monoidalen Kategorien mit Bildern rechnen kann: mit Stringdiagrammen, in denen Prozesse Kästen und Objekte Drähte sind. Das Interchange-Gesetz ist dann keine Gleichung mehr, die man nachrechnen muss, sondern es ist im Bild schon sichtbar. Kaehrs eigene Diagramme mit sequentiellen und parallelen Kästen sind genau solche Stringdiagramme. Hier war er der Mathematik seiner Zeit nicht hinterher, sondern ziemlich nah an ihr.

## Umtausch: Chu-Räume

Kaehr unterscheidet einen „Pfeil der Ordnung“ von einem „Pfeil des Umtausches“. Der erste ist die gewöhnliche Komposition. Der zweite steht für Dialektik, Polarität und den Rollentausch der Proömialrelation Günthers, in der das Relatum der einen Ebene zum Relator der anderen wird.

Für einen solchen Rollentausch gibt es eine schöne Konstruktion: die Chu-Räume, die Vaughan Pratt in den 1990er Jahren bekannt gemacht hat. Ein Chu-Raum besteht aus Punkten, Zuständen und einer Beziehung zwischen ihnen. Man kann ihn als Matrix lesen: Zeilen sind Dinge, Spalten sind Beobachter, und der Eintrag sagt, ob der Beobachter das Ding markiert.

```haskell
data Chu p s = Chu [p] [s] (p -> s -> Bool)

-- Das Duale: Punkte und Zustände tauschen die Rollen
dual :: Chu p s -> Chu s p
dual (Chu ps ss r) = Chu ss ps (flip r)

welt :: Chu String String
welt = Chu ["Stein", "Baum", "Hund"] ["lebt?", "bewegt sich?"] r
  where
    r "Baum" "lebt?" = True
    r "Hund" _       = True
    r _      _       = False
```

Die Matrix von `welt` hat drei Zeilen und zwei Spalten. Die Matrix von `dual welt` ist ihre Transponierte. Jetzt sind die Beobachter die Dinge und die Dinge die Beobachter, und zweimal dualisieren führt zurück. Entscheidend ist, was ein Morphismus zwischen Chu-Räumen ist: ein Paar aus einer Abbildung der Punkte *vorwärts* und einer Abbildung der Zustände *rückwärts*, sodass die Beziehung erhalten bleibt. Ordnung und Umtausch sind hier in einem einzigen Begriff verschränkt. Die Kategorie der Chu-Räume ist zu sich selbst dual. Das ist mehr als die bloße Umkehrung aller Pfeile, die man in jeder Kategorie hat.

An Teil 2 schließt das direkt an. Dort war ein Objekt die Gesamtheit seiner Beobachtungen. Im Chu-Raum ist dieser Gedanke symmetrisch geworden: Ein Beobachter ist ebenso die Gesamtheit dessen, was er markiert.

## Gegenläufigkeit

Kaehrs Diamond verbindet jede Komposition mit einer gegenläufigen Bewegung, die er Saltisation nennt. Ich habe die Diamond-Texte nicht gründlich genug gelesen, um zu sagen, was der Diamond mathematisch ist. Aber es gibt einen Kandidaten, den man prüfen könnte: die *Twisted-Arrow*-Kategorie. Ihre Objekte sind wieder die Pfeile $f: A \to B$. Ein Morphismus von $f$ nach $f': A' \to B'$ ist aber ein Paar $u: A' \to A$ und $v: B \to B'$ mit $f' = v \circ f \circ u$. Am Anfang des Pfeils läuft die Bewegung rückwärts, am Ende vorwärts. In ein und derselben Kategorie sind zwei gegenläufige Richtungen verschränkt. Ob das Kaehrs Gegenläufigkeit trifft, müssten Leser beurteilen, die seine Diamonds besser kennen als ich.

## Komplementarität als Adjunktion

Zum Schluss Varela. In *Principles of Biological Autonomy* hat er Komplementarität, etwa zwischen Autonomie und Kontrolle, mit adjungierten Funktoren beschrieben. Kauffman erklärt das am Verhältnis von Graphen und Kategorien (§36). Aus jedem Graphen entsteht frei eine Kategorie seiner Pfade, und jede Kategorie lässt sich als Graph vergessen. Die beiden Richtungen sind nicht invers. Jede ist aber die bestmögliche Annäherung an die Umkehrung der anderen.

Kauffmans Kategorie aus Teil 1, ein Objekt mit einem Pfeil $f$, ist die freie Kategorie über dem Graphen mit einer Schleife. Ihre Pfade $f, ff, fff, \ldots$ sind in Haskell einfach Listen. Die Adjunktion sagt: Eine strukturerhaltende Abbildung aus dem Freien ist dasselbe wie eine Abbildung auf den Erzeugern.

```haskell
frei :: Monoid m => (a -> m) -> ([a] -> m)
frei = foldMap

zurueck :: ([a] -> m) -> (a -> m)
zurueck hom = hom . (: [])

data F = F

umlaeufe :: [F] -> Sum Int
umlaeufe = frei (const (Sum 1))
-- umlaeufe [F, F, F] == 3
```

Lawvere hat adjungierte Funktoren als präzise Form dessen gelesen, was Hegel die Einheit der Gegensätze nennt (Lawvere 1991). Das ist vielleicht der beste Ort, an dem Systemtheorie und Kategorientheorie sich treffen können. Komplementarität heißt hier nicht, dass zwei Seiten gleich wären oder ineinander aufgingen. Es heißt, dass jede Seite durch ihre universelle Beziehung zur anderen bestimmt ist.

## Eine Begriffskarte

| Kaehr / Günther / Varela | Kategorientheorie | Passung |
|---|---|---|
| Theorie der reinen Morphismen | Kategorien allein aus Pfeilen; Lawveres ETCS und ETCC | stark |
| „Was in Kat1 Morphismus ist in Kat2 Objekt“ | Pfeilkategorie $C^{\to}$, 2-Kategorien | stark |
| Komposition und Juxtaposition | monoidale Kategorien, Interchange-Gesetz, Stringdiagramme | stark |
| Pfeil des Umtausches | Dualität; Chu-Räume als selbstduale Kategorie | mittel |
| Proömialrelation, Relator wird Relatum | Chu-Morphismen: vorwärts auf Punkten, rückwärts auf Zuständen | Bild |
| Diamond, Saltisation | Twisted-Arrow-Kategorie? | offen |
| jedes Ding zugleich Operator | reflexiver Bereich $D \cong D^D$ (Scott) | stark |
| Komplementarität (Varela) | Adjunktion | stark |
| Pfeil der Ähnlichkeit, Analogie | kein überzeugender Kandidat | offen |

## Offene Fragen

- Ist Kaehrs Polykategorie eine 2-Kategorie, eine doppelte Kategorie oder etwas, das in keine dieser Strukturen passt? Wo genau läge der Unterschied?
- Trifft die Twisted-Arrow-Kategorie die Gegenläufigkeit des Diamonds, oder verfehlt sie etwas Wesentliches?
- Chu-Räume tauschen Dinge und Beobachter. Ist das der Umtausch der Proömialrelation, oder fehlt die Verschiebung der Ebene, die Günther wichtig war?
- Kaehrs „Pfeil der Ähnlichkeit“ soll nicht operationalisierbar sein, weil Operator und Operand zusammenfallen. Ist das der reflexive Bereich aus Teil 1 oder gerade das, was er ausschließt?
- Wenn Lawvere recht hat und Adjunktionen die Einheit der Gegensätze sind: Welche Unterscheidungen der Systemtheorie, etwa System und Umwelt oder Medium und Form, sind adjungiert?

## Zum Schluss der Serie

Über drei Teile hat sich ein Muster gezeigt. Die Fragen der Systemtheorie nach Re-entry, Beobachtern, Kontexturen und Umtausch sind keine Randfragen der Kategorientheorie, sondern stehen mitten in ihr. Fixpunkte, Yoneda, Garben, Dualität und Adjunktion sind ihre zentralen Begriffe. Varela, Kauffman, Günther und Kaehr haben das früh gesehen. Seitdem ist die Mathematik weitergegangen, oft in Richtungen, die ihnen gefallen hätten.

Ich würde gern mit Leuten aus der Systemtheorie darüber reden: über die Stellen, an denen die Übersetzung trägt, und noch lieber über die, an denen sie bricht. Wer Lust hat, ist herzlich eingeladen. Einen ersten Einstieg gibt Fong und Spivaks *Invitation*, mit mehr Philosophie Lawvere und Schanuels *Conceptual Mathematics*.

## Literatur

- Barr, Michael: \*-Autonomous Categories, Lecture Notes in Mathematics 752, Berlin 1979 (mit einem Anhang von Po-Hsiang Chu).
- Fong, Brendan / Spivak, David I.: An Invitation to Applied Category Theory. Seven Sketches in Compositionality, Cambridge 2019.
- Joyal, André / Street, Ross: The Geometry of Tensor Calculus I, in: Advances in Mathematics 88 (1991), S. 55–112.
- Kaehr, Rudolf: SKIZZE-0.9.5 – Towards PolyContextural Categories, Entwurf 2004, vordenker-Archiv.
- Kaehr, Rudolf: Diagrammatik und Komplementarität, Folien 2010, vordenker-Archiv 2017.
- Kauffman, Louis H.: Mathematical Work of Francisco Varela, in: Constructivist Foundations 13 (2017), H. 1, S. 11–17.
- Lawvere, F. William: An Elementary Theory of the Category of Sets, in: Proceedings of the National Academy of Sciences 52 (1964), S. 1506–1511.
- Lawvere, F. William: The Category of Categories as a Foundation for Mathematics, in: Proceedings of the Conference on Categorical Algebra, La Jolla 1965, Berlin 1966.
- Lawvere, F. William: Some Thoughts on the Future of Category Theory, in: Category Theory (Como 1990), Lecture Notes in Mathematics 1488, Berlin 1991.
- Lawvere, F. William / Schanuel, Stephen H.: Conceptual Mathematics. A First Introduction to Categories, Cambridge 1997.
- Mac Lane, Saunders: Categories for the Working Mathematician, New York 1971.
- Pratt, Vaughan: Chu Spaces, Lecture Notes, School on Category Theory and Applications, Coimbra 1999.
- Varela, Francisco J.: Principles of Biological Autonomy, New York 1979.
