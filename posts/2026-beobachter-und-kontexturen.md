---
title: Beobachter und Kontexturen. Eine Einladung an die Systemtheorie (Teil 2)
author: Johannes Drever (mit Claude)
date: 2026-11-10
tags: "#Maschinenraun"
---

[Teil 1](2026-reentry-ohne-paradox.html) endete mit einer Beobachtung: Welchen Wert der Re-entry $K = \langle K \rangle$ hat, hängt vom Rahmen ab, in dem man fragt. Mit zwei Werten gibt es keinen, mit einem Wert für das Unentschiedene ist es $\bot$, mit Zeit ist es die Oszillation. Daraus ergibt sich die nächste Frage: Wenn verschiedene Beobachter verschiedene Rahmen wählen, wie verhalten sich ihre Antworten zueinander?

Das ist eine Frage, die in der Systemtheorie zu Hause ist. Bei Luhmann heißt Beobachten Unterscheiden und Bezeichnen, und Beobachtung zweiter Ordnung heißt beobachten, mit welcher Unterscheidung ein anderer beobachtet. Gotthard Günther hat die Welt als Gefüge vieler Kontexturen beschrieben. Jede einzelne ist zweiwertig und klassisch, aber es gibt keine Superkontextur, in der alle aufgehen. Rudolf Kaehr hat daraus eine radikale Folgerung gezogen: „es gibt kein Objekt ausserhalb der Thematisierung“ (SKIZZE, 2004, S. 108).

Die Kategorientheorie hat für genau diese Lage zwei Werkzeuge: das Yoneda-Lemma und die Garben. Wie in meinen früheren Posts versuche ich anzugeben, wo die Übersetzung trägt, wo sie nur ein Bild ist und wo sie offen bleibt.

## Kein Objekt außerhalb der Beobachtung

In einer Kategorie kann man ein Objekt $A$ von jedem anderen Objekt $X$ aus ansehen. Die Pfeile $X \to A$ sind die Weisen, wie $A$ von $X$ aus erscheint. Mathematiker nennen sie verallgemeinerte Elemente von $A$ „in Hinsicht $X$“. Die Gesamtheit dieser Sichten, für alle $X$ zugleich, schreibt man $\mathrm{Hom}(-, A)$.

Wechselt man den Standpunkt entlang eines Pfeils $Y \to X$, so übersetzt sich jede Sicht von $X$ aus in eine Sicht von $Y$ aus, indem man den Pfeil davorsetzt. Die Sichten hängen also nicht lose nebeneinander, sondern sind durch Standpunktwechsel miteinander verbunden.

Das Yoneda-Lemma sagt nun: Zwei Objekte sind genau dann isomorph, wenn ihre Systeme von Sichten verträglich isomorph sind. Ein Objekt *ist*, bis auf Isomorphie, nichts anderes als die Gesamtheit der Weisen, wie es von überallher beobachtet werden kann. Kaehrs Satz wird hier zu einem Theorem, allerdings mit einer Zusatzbedingung: Die Beobachtungen müssen zueinander passen. Ein Haufen beliebiger Sichten bestimmt noch kein Objekt.

In Haskell gibt es eine besonders knappe Form davon. Ein Beobachter eines Werts vom Typ `a` ist eine Funktion `a -> r`, für irgendein `r`. Ein Wert, der nur noch als Gesamtheit seiner Beobachtungen vorliegt, hat diesen Typ:

```haskell
{-# LANGUAGE RankNTypes #-}

newtype Beobachtet a = Beobachtet (forall r. (a -> r) -> r)

beobachte :: a -> Beobachtet a
beobachte x = Beobachtet (\b -> b x)

rekonstruiere :: Beobachtet a -> a
rekonstruiere (Beobachtet o) = o id
```

`rekonstruiere (beobachte 42)` ergibt `42`. Die beiden Funktionen sind zueinander invers, das ist die Yoneda-Aussage für diesen einfachen Fall. Bemerkenswert ist, *wie* man den Wert zurückbekommt: mit genau einer Beobachtung, der Identität `id`. Das ist die Sicht des Objekts von seinem eigenen Standpunkt aus. Der Beweis des allgemeinen Yoneda-Lemmas läuft genauso: Alles hängt an der Identität $\mathrm{id}_A$, und alle anderen Sichten folgen aus ihr durch Standpunktwechsel.

## Beobachtung zweiter Ordnung

Das Yoneda-Lemma hat eine zweite Lesart, die mir für Luhmann interessant scheint. Sei $F$ irgendein System von Beobachtungen: Für jeden Standpunkt $X$ ist $F(X)$ das, was man von $X$ aus beobachten kann, und Standpunktwechsel übersetzen verträglich. Eine solche Struktur heißt Prägarbe. Das Lemma sagt dann:

$$\mathrm{Nat}(\mathrm{Hom}(-, X), F) \;\cong\; F(X).$$

Links steht eine Beziehung zwischen zwei Systemen: dem Beobachter $X$, selbst aufgefasst als System von Sichten, und dem Beobachteten $F$. Rechts steht einfach eine Beobachtung, die $X$ macht. Was erster Ordnung ein Element ist, „$X$ sieht dies“, ist zweiter Ordnung ein Pfeil vom Beobachter zum Beobachteten. Und Pfeile kann man vergleichen, verketten und von anderen Beobachtern aus ansehen.

Ich würde das nicht als Formalisierung von Luhmanns Beobachtung zweiter Ordnung ausgeben. Aber die Bewegung ist dieselbe: Der Beobachter wird selbst zu einem Objekt unter anderen, und seine Beobachtung wird zu einer Beziehung, die man von außen beobachten kann.

## Kontexturen als Garbe

Nun zu Günther. Nehmen wir drei Beobachter. Jeder trifft eine Unterscheidung zwischen zwei von drei Größen $a$, $b$, $c$, die jeweils markiert oder unmarkiert sein können:

- der erste beobachtet $a$ und $b$ und stellt fest: $a \neq b$,
- der zweite beobachtet $b$ und $c$ und stellt fest: $b \neq c$,
- der dritte beobachtet $c$ und $a$ und stellt fest: $c \neq a$.

Jeder Beobachter hat eine Kontextur im Sinne Günthers, ein Paar von Größen mit klassischer, zweiwertiger Logik. In jeder Kontextur gibt es genau zwei mögliche Zustände. Man nennt sie die lokalen Schnitte.

```haskell
type Var      = Char
type Belegung = [(Var, Bool)]

data Kontext = Kontext Var Var (Bool -> Bool -> Bool)

lokal :: Kontext -> [Belegung]
lokal (Kontext x y r) =
  [ [(x, u), (y, v)] | u <- [False, True], v <- [False, True], r u v ]

ungerade :: [Kontext]
ungerade = [Kontext 'a' 'b' (/=), Kontext 'b' 'c' (/=), Kontext 'c' 'a' (/=)]
```

Die Kontexturen überlappen sich. Der erste und der zweite Beobachter teilen sich $b$. Auf diesen Überlappungen widersprechen sie sich nicht: Was der eine über $b$ für möglich hält, nämlich beides, hält auch der andere für möglich. Das prüft das Programm im Begleitcode nach.

Eine globale Sicht wäre eine Belegung aller drei Größen, die in jeder Kontextur möglich ist. Eine Garbe ist eine Prägarbe, in der verträgliche lokale Sichten sich eindeutig zu einer globalen verkleben lassen. Die Suche nach einer globalen Sicht ist schnell geschrieben, und sie findet nichts:

```haskell
-- global "abc" ungerade  ==  []
```

Ändert man eine einzige Unterscheidung, etwa $c = a$ statt $c \neq a$, gibt es sofort zwei globale Sichten. Entscheidend ist die Parität. Eine ungerade Zahl von Negationen im Kreis verhindert die globale Sicht, eine gerade erlaubt sie. Das ist dieselbe Parität wie beim Lügnerzyklus und dieselbe Negation wie beim Re-entry in Teil 1. Was dort in der Zeit als Oszillation erschien, erscheint hier im Raum der Beobachter als fehlende Verklebung.

Samson Abramsky und Adam Brandenburger haben 2011 gezeigt, dass genau diese Struktur der Kern der Kontextualität in der Quantenmechanik ist: Messungen, die lokal konsistent sind und sich auf Überlappungen nicht widersprechen, aber keine globale Belegung zulassen. Die Mathematik misst diese Hindernisse sogar, mit Kohomologie. Für die Systemtheorie heißt das: Polykontexturalität ist weder Relativismus noch ein Fehler, den man beheben könnte. Sie ist eine präzise beschreibbare Eigenschaft eines Systems von Beobachtungen.

## Lokal klassisch, global nicht

Ein weiterer Satz passt erstaunlich gut zu Günther. Prägarben über einer Kategorie von Kontexten bilden einen Topos, eine Welt, in der man Mathematik treiben kann. Jede einzelne Menge $F(U)$ ist dabei eine ganz gewöhnliche Menge mit klassischer Logik. Die Logik des Topos als Ganzes ist aber im Allgemeinen nicht klassisch, sondern intuitionistisch: Das ausgeschlossene Dritte gilt nicht mehr global.

Bei Günther ist jede Kontextur zweiwertig, und die Vermittlung der Kontexturen lässt sich nicht in einer einzigen zweiwertigen Logik ausdrücken. Ob Günthers Stellenwertlogik und die Logik eines Prägarbentopos dasselbe beschreiben, weiß ich nicht. Aber die Grundfigur, lokal klassisch und global nicht, ist in beiden dieselbe.

Auch Kaehrs „Polykontexturalisierung der Identität“ (SKIZZE, S. 107 f.) hat hier eine Entsprechung. In einer Prägarbe gibt es keine vorausgesetzte Identität eines Gegenstands über alle Kontexte hinweg. Ein Element von $F(U)$ und eines von $F(V)$ sind „dasselbe“ genau dann, wenn sie auf dem Überlapp von $U$ und $V$ übereinstimmen. Identität ist hier nicht gegeben, sondern lokal und muss hergestellt werden.

## Eine Begriffskarte

„Stark“ heißt, dass sich eine Strukturgleichheit angeben lässt. „Bild“ heißt, dass es eine anregende Analogie gibt, aber keinen Satz.

| Systemtheorie | Kategorientheorie | Passung |
|---|---|---|
| „kein Objekt ausserhalb der Thematisierung“ (Kaehr) | Yoneda: ein Objekt ist die Gesamtheit seiner Sichten | stark |
| Beobachtung aus einer Kontextur | Element von $F(U)$, verallgemeinertes Element | mittel |
| Beobachtung zweiter Ordnung (Luhmann) | Pfeil $\mathrm{Hom}(-, X) \to F$ statt Element von $F(X)$ | mittel |
| Kontextur (Günther) | Kontext $U$ mit klassischer Menge $F(U)$ | mittel |
| Vermittlung | Verklebung, Garbenbedingung | mittel |
| Polykontexturalität | lokale Konsistenz ohne globalen Schnitt (Abramsky) | stark |
| lokal zweiwertig, global nicht | Prägarbentopos ist nicht boolesch | mittel |
| Identität des Objekts über Kontexte | Übereinstimmung auf Überlappungen | mittel |
| Unterscheiden und Bezeichnen | Unterscheidung als Wahl in einer zweiwertigen Menge | Bild |
| Transjunktion | kein überzeugender Kandidat | offen |
| blinder Fleck | Lawvere (Teil 1)? Der Situs liegt nicht in der Garbe | offen |

## Offene Fragen

- Günthers Transjunktion verwirft eine Alternative als Ganzes, statt sich für eine ihrer Seiten zu entscheiden. Ist das ein Wechsel der Kontextur, also ein Pfeil zwischen Kontexten? Oder etwas, das sich in der Sprache der Garben nicht ausdrücken lässt?
- Der Yoneda-Beweis braucht genau eine ausgezeichnete Beobachtung, die des Objekts von seinem eigenen Standpunkt aus. Hat das etwas mit Luhmanns Selbstbeobachtung zu tun, oder ist das nur ein Wortspiel?
- Jede Garbe lebt über einer Kategorie von Kontexten, dem Situs, und die Wahl des Situs kommt in der Garbe selbst nicht vor. Ist das Luhmanns blinder Fleck, die Unterscheidung, die der Beobachter nicht zugleich beobachten kann?
- Abramskys Arbeiten zur Kontextualität kommen aus der Quantenphysik. Sind sie in der Systemtheorie bekannt? Und taugen sie als Modell für Kommunikation, in der jeder Teilnehmer lokal konsistent ist und es trotzdem keine gemeinsame Sicht gibt?

In Teil 3 geht es um die Frage, die Kaehr am meisten beschäftigt hat: ob die Kategorientheorie Objekt und Morphismus zugleich in den Blick nehmen kann. Wer mitdenken, widersprechen oder ergänzen möchte, ist herzlich eingeladen. Der Code läuft mit einem gewöhnlichen GHC.

## Literatur

- Abramsky, Samson / Brandenburger, Adam: The Sheaf-Theoretic Structure of Non-Locality and Contextuality, in: New Journal of Physics 13 (2011), 113036.
- Abramsky, Samson: Contextuality: At the Borders of Paradox, in: Landry, Elaine (Hg.): Categories for the Working Philosopher, Oxford 2017.
- Günther, Gotthard: Life as Poly-Contexturality, in: Fahrenbach, Helmut (Hg.): Wirklichkeit und Reflexion. Walter Schulz zum 60. Geburtstag, Pfullingen 1973.
- Kaehr, Rudolf: SKIZZE-0.9.5 – Towards PolyContextural Categories, Entwurf 2004, vordenker-Archiv.
- Luhmann, Niklas: Die Wissenschaft der Gesellschaft, Frankfurt am Main 1990.
- Mac Lane, Saunders / Moerdijk, Ieke: Sheaves in Geometry and Logic. A First Introduction to Topos Theory, New York 1992.
- Spivak, David I.: Category Theory for the Sciences, Cambridge (MA) 2014.
