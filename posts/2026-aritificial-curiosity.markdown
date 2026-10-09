---
title: Warum eine KI Primzahlen (und Prägarben) interessant finden könnte
author: Johannes Drever, Gemini, Claude
date: 2026-10-09
tags: artifical curiosity, pre sheaves
description: Ein Gedankenexperiment über intrinsische Motivation, Kompression und die Frage, was „Bausteine“ eigentlich auszeichnet.
---
# Künstliche Neugier: Warum eine KI Primzahlen (und Prägarben) interessant finden könnte

*Ein Gedankenexperiment über intrinsische Motivation, Kompression und die Frage, was „Bausteine“ eigentlich auszeichnet.*

## Wie baut man eine neugierige KI?

Im klassischen Reinforcement Learning wird ein Agent durch externe Belohnungen gesteuert: Punkte für eine gewonnene Schachpartie, für das Erreichen eines Ziels. Doch wie modelliert man den Antrieb, die Welt einfach verstehen zu wollen, ganz ohne äußeres Ziel?

Diese Frage gehört zur Forschung an *intrinsischer Motivation*. Jürgen Schmidhuber entwickelte seit Anfang der 1990er Jahre eine informationstheoretisch formulierte Theorie der *Artificial Curiosity*.

## Schmidhubers Idee: Belohnt wird der Lernfortschritt

Schmidhubers Agent besitzt ein Modell der Welt, das Beobachtungen vorhersagt oder komprimiert. Die intrinsische Belohnung ist nicht die Qualität dieser Kompression, sondern ihre *Verbesserung*: Interessant ist, was der Agent gerade noch nicht versteht, aber bald verstehen kann.

Daraus folgt, dass zwei Extreme uninteressant sind. Was der Agent bereits perfekt komprimiert, langweilt ihn, denn es gibt nichts mehr zu lernen. Was er mit seinem Modell grundsätzlich nicht vorhersagen kann (echtes Zufallsrauschen), langweilt ihn ebenfalls, denn auch dort gibt es keinen Fortschritt. Interessant ist der Bereich dazwischen.

## Das Gedankenexperiment: ein Agent in der Welt der ganzen Zahlen

Stellen wir uns einen Agenten vor, dessen Wahrnehmung aus einem Strom ganzer Zahlen besteht. Sein einziges Werkzeug ist die Multiplikation. Er beschreibt eine Zahl, indem er sie als Produkt von Einträgen aus seinem *Wörterbuch* schreibt. Anfangs enthält das Wörterbuch nur die 2.

Die 64 ist für ihn leicht: 2⁶ statt einer langen Zahl. Die 17 dagegen kann er nicht zerlegen. Wichtig ist hier eine Präzisierung: Die 17 ist nicht „zufällig“ oder „Rauschen“. Sie ist völlig deterministisch. Sie ist lediglich *relativ zu diesem Kompressor* nicht weiter zerlegbar. Ein anderer Beschreibungsformalismus (etwa „die 7. Primzahl“) könnte sie durchaus kurz kodieren. Unkomprimierbarkeit ist stets eine Eigenschaft von Daten *und* Kompressor, nicht von den Daten allein.

Auch ist „nicht zerlegbar“ nicht dasselbe wie „nicht komprimierbar“ im Sinne der Kolmogorov-Komplexität: Eine riesige Primzahl wie 2¹²⁷ − 1 hat eine winzige Beschreibung, obwohl sie prim ist. Im Experiment gilt die Einschränkung auf den multiplikativen Kompressor ausdrücklich.

## Der Agent als Wörterbuch-Kompressor

Betrachten wir den Agenten als wörterbuchbasierten Kompressor, ähnlich in der Idee (nicht im Detail) zu Verfahren wie LZW. Die Primzahlen bilden das Grundalphabet seiner Welt, denn jede natürliche Zahl größer als 1 ist eindeutig ein Produkt von Primzahlen.

- **Die Kosten:** Trifft der Agent auf eine neue Primzahl, etwa 17, muss er sein Wörterbuch um einen Eintrag erweitern. Das kostet Speicher, und die Zahl selbst wird dadurch nicht kürzer.
- **Der Gewinn:** Zahlen wie 34 = 2 × 17, 51 = 3 × 17 oder 289 = 17² lassen sich ab jetzt kürzer beschreiben. Das Modell des Agenten verbessert sich, und genau diese Verbesserung ist nach Schmidhuber die Belohnung.

Der Agent interessiert sich also nicht für Primzahlen, weil sie selbst komprimierbar wären, sondern weil sie als Wörterbucheinträge viele *andere* Zahlen komprimierbar machen.

## Woher weiß der Agent, was er als Nächstes lernen soll?

Das ist die eigentliche Frage der Neugier-Theorie, und das Experiment beantwortet sie überraschend gut. Sieht der Agent Zahlen aus einem großen Bereich, ist ein Anteil von etwa 1/p davon durch die Primzahl p teilbar. Ein Wörterbucheintrag für die 2 hilft also bei der Hälfte aller Zahlen, einer für die 3 bei einem Drittel, einer für die 17 nur noch bei etwa 6 %.

Der erwartete Lernfortschritt pro Wörterbucheintrag sinkt damit mit wachsendem p. Ein neugieriger Agent lernt deshalb ganz von selbst zuerst die kleinen Primzahlen, bei denen der Fortschritt am größten ist. Mit jedem weiteren Eintrag wird der Zuwachs kleiner, und die Neugier wandert irgendwann zu anderen Datenquellen weiter. Das ist exakt die Dynamik aus Langeweile und Interesse, die Schmidhubers Theorie beschreibt. Da es unendlich viele Primzahlen gibt, wird der Agent in dieser Welt nie „fertig“, aber sein Fortschritt pro Schritt geht gegen null.

## Der Sprung in die Kategorientheorie: Prägarben

Das Muster „wenige gute Bausteine erklären viel“ taucht auch in der Kategorientheorie auf. Tom Leinster beschreibt in *Basic Category Theory* das Density Theorem (oft auch Co-Yoneda-Lemma genannt): Jede Prägarbe ist ein Kolimes repräsentierbarer Prägarben.

Übertragen wir das Bild:

- **Die „Zahlen“:** Prägarben, also Funktoren `P: C^op → Set`.
- **Die „Atome“:** die repräsentierbaren Prägarben `y(c) = Hom(−, c)`, die Bilder der Yoneda-Einbettung.
- **Die „Zusammensetzung“:** das Bilden von Kolimites, also ein Zusammenkleben der Atome.

Der Satz lautet:

   $$P \cong \operatorname{colim}\left( \int P \to \mathcal{C} \xrightarrow{\ \mathbf{y}\ } [\mathcal{C}^{op}, \mathbf{Set}] \right)$$

Hier ist ∫P die Kategorie der Elemente von P.

### Wo die Analogie trägt und wo nicht

Hier ist Vorsicht geboten, denn der Satz ist ein *exakter Satz* und kein Kompressionsprinzip. Die Objekte der Kategorie ∫P sind gerade die Elemente von P(c) für alle c. Die Darstellung als Kolimes enthält also im Allgemeinen dieselbe Information wie P selbst, sie ist eine *Umformulierung* und keine Kompression.

Kompression entsteht erst, wenn P eine kleine Beschreibung besitzt. Ein Beispiel: Auf der Kategorie mit zwei Objekten und zwei parallelen Pfeilen sind Prägarben genau die gerichteten Graphen. Ein endlicher Graph lässt sich als Kolimes aus wenigen „Knoten“ und „Kanten“ (den repräsentierbaren Prägarben) beschreiben, zusammen mit einem Verklebungsplan. Diese Beschreibung ist viel kleiner als die Menge aller Daten, die Prägarben dieser Art formal enthalten können. Ob ein solcher kleiner Bauplan existiert, hängt aber von P ab. Genau das ist der Unterschied zum Zahlenbeispiel.

Auch die „Atome“ unterscheiden sich:

- Primfaktorzerlegungen sind eindeutig (Fundamentalsatz der Arithmetik). Kolimes-Darstellungen sind es nicht, und es gibt keinen „minimalen“ Bauplan, der ausgezeichnet wäre.
- Multiplikation ist assoziativ und kommutativ. Kolimites haben diese Struktur nicht in dieser Form.

Die Analogie ist daher eine Heuristik und keine Isomorphie.

## Fazit: Was bleibt von der Heuristik?

Beide Welten zeigen ein ähnliches Muster: Es kann sich lohnen, einen Anfangsaufwand für neue Basisbausteine zu investieren, wenn diese anschließend viele bislang undurchsichtige Objekte kürzer beschreibbar machen. Genau dort entsteht nach Schmidhuber Lernfortschritt, und Lernfortschritt ist es, der einen neugierigen Agenten antreibt.

Offene Fragen, die ich spannend finde:

- Gibt es in der Kategorientheorie ein Maß, das den „Gewinn“ eines Bausteins analog zum 1/p-Argument quantifiziert?
- Wie würde ein Agent entscheiden, welche repräsentierbaren Prägarben er zuerst lernt, wenn die Welt aus Prägarben besteht?
- Welcher Kompressionsbegriff (Kolmogorov-Komplexität, MDL) passt hier am besten?

## Literatur

- J. Schmidhuber: *A Possibility for Implementing Curiosity and Boredom in Model-Building Neural Controllers* (1991).
- J. Schmidhuber: *Formal Theory of Creativity, Fun, and Intrinsic Motivation (1990–2010)*, IEEE Transactions on Autonomous Mental Development (2010).
- T. Leinster: *Basic Category Theory*, Cambridge University Press (2014).
- M. Li, P. Vitányi: *An Introduction to Kolmogorov Complexity and Its Applications*, Springer.
