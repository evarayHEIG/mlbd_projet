= Résultats

== Exemple de résultat : Paris

Voici un exemple de résultats obtenus. Pour Paris, nous avons obtenu que la ville analogue climatique la plus proche est Orléans (voir @fig:paris_analog). Cela signifie que le climat de Paris en 2021-2050 (selon le scénario SSP585) ressemblera au climat d'Orléans d'aujourd'hui.

#figure(
  image("images/paris_analog.png", width: 90%),
  caption: [Application interactive montrant les analogues climatiques de Paris pour la période 2021-2050 (scénario SSP585, méthode Embeddings, distance de Mahalanobis). Les 5 villes les plus proches sont : Orléans, Tours, Paris, Perpignan et Aix-en-Provence.]
) <fig:paris_analog>

Toutefois, ce résultat est peu parlant : est-il juste ? Comment peut-on valider nos résultats sans données de référence ?

== Contexte de validation

Dans le cadre de ce projet, nous nous trouvons dans une situation particulière : l'absence de "ground truth". En effet, il n'existe pas de vérité absolue permettant de valider si nos analogues climatiques correspondent effectivement à une réalité mesurable. Cette limitation est inhérente à l'analyse des analogues climatiques, car nous cherchons à identifier des similitudes climatiques complexes qui ne peuvent être directement vérifiées par des mesures objectives.

Toutefois, suite à la revue de littérature présentée en annexe, nous avons identifié une métrique récurrente dans les études sur les analogues climatiques : la translation latitudinale des villes. Cette métrique permet d'obtenir des chiffres quantitatifs sur nos résultats, sans pour autant constituer une validation absolue.

== Configurations analysées

Notre analyse comparative porte sur 24 configurations différentes, résultant de la combinaison de :

- *3 méthodes de réduction de dimensionnalité* : All features, PCA, Embeddings (autoencoder)
- *2 métriques de distance* : Euclidienne, Mahalanobis
- *4 périodes temporelles* : Passé (1940-1970), Futur SSP126, SSP370, SSP585

Pour chaque configuration, nous avons calculé les 5 villes analogues les plus proches pour chacune des 115 villes européennes de notre dataset.

== Résultats : Translation latitudinale

=== Période passée (1940-1970)

#figure(
  block(
    width: 70%,
    table(
      columns: 4,
      align: (left, center, center, center),
      inset: 5pt,
      [*Méthode*], [*Distance*], [*Shift moyen (°)*], [*% villes Nord*],
      [All features], [Euclidienne], [+0.10], [46.2%],
      [All features], [Mahalanobis], [-0.81], [42.5%],
      [PCA], [Euclidienne], [+0.28], [48.6%],
      [PCA], [Mahalanobis], [+0.20], [49.0%],
      [Embeddings], [Euclidienne], [+0.29], [50.0%],
      [Embeddings], [Mahalanobis], [+0.34], [50.0%],
    )
  ),
  caption: [Translation latitudinale moyenne des analogues climatiques pour la période 1940-1970.]
)

=== Période future (2021-2050)

==== Scénario SSP585

#figure(
  block(
    width: 70%,
    table(
      columns: 4,
      align: (left, center, center, center),
      inset: 5pt,
      [*Méthode*], [*Distance*], [*Shift moyen (°)*], [*% villes Sud*],
      [All features], [Euclidienne], [-0.90], [58.9%],
      [All features], [Mahalanobis], [-0.50], [54.5%],
      [PCA], [Euclidienne], [-1.15], [59.2%],
      [PCA], [Mahalanobis], [-1.05], [59.2%],
      [Embeddings], [Euclidienne], [-1.21], [57.5%],
      [Embeddings], [Mahalanobis], [-1.34], [58.6%],
    )
  ),
  caption: [Translation latitudinale pour SSP585.]
)

=== Vue d'ensemble : Comparaison passé-futur

La @fig:mean_shift présente une vue globale de la translation latitudinale pour toutes les configurations. Le graphique de gauche montre le passé (1940-1970) et celui de droite montre le futur (moyenne des scénarios SSP126, SSP370 et SSP585). Chaque graphique compare les résultats obtenus avec la distance Euclidienne et la distance de Mahalanobis pour les trois méthodes.

#figure(
  image("/images/mean_shift.png", width: 90%),
  caption: [Translation latitudinale moyenne par méthode et métrique de distance. Gauche : Période passée (1940-1970). Droite : Période future (2021-2050, moyenne des 3 scénarios SSP).]
) <fig:mean_shift>