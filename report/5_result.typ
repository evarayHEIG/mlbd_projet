= Résultats

== Exemple de résultat : Paris

Voici un exemple de résultats obtenus. Pour Paris, nous avons obtenu que la ville analogue climatique la plus proche est Orléans (voir @fig:paris_analog). Cela signifie que le climat de Paris en 2021-2050 (selon le scénario SSP585) ressemblera au climat d'Orléans d'aujourd'hui.

#figure(
  image("./images/paris_analog.png", width: 90%),
  caption: [Application interactive montrant les analogues climatiques de Paris pour la période 2021-2050 (scénario SSP585, méthode Embeddings, distance de Mahalanobis). Les 5 villes les plus proches sont : Orléans, Tours, Paris, Perpignan et Aix-en-Provence.]
) <fig:paris_analog>

Toutefois, ce résultat est peu parlant : est-il juste ? Comment peut-on valider nos résultats sans données de référence ?

== Contexte de validation

Dans le cadre de ce projet, nous nous trouvons dans une situation particulière : l'absence de "ground truth". En effet, il n'existe pas de vérité absolue permettant de valider nos analogues climatiques, car le concept même d'analogue climatique est relatif et dépend des critères choisis.

Toutefois, suite à la lecture de plusieurs articles traitant des analogues climatiques (@AmericanCA, @EuropeCA), nous avons identifié une métrique récurrente dans les études sur les analogues climatiques : la _translation latitudinale_ des villes. En effet, l'état de l'art montre que les analogues climatiques backward (passé) ont tendance à se situer plus au nord des villes cibles, tandis que les analogues climatiques forward (futur) se trouvent plus au sud. Ainsi, cette métrique permet d'obtenir des chiffres quantitatifs sur nos résultats, sans pour autant constituer une validation absolue.

== Configurations analysées

Notre analyse comparative porte sur 24 configurations différentes, résultant de la combinaison de :

- *3 méthodes de réduction de dimensionnalité* : Aucune (all features), PCA, Embeddings (autoencoder)
- *2 métriques de distance* : Euclidienne, Mahalanobis
- *4 périodes temporelles* : Passé (1970), Futur (2050) SSP126, SSP370, SSP585

== Résultats : Translation latitudinale

=== Période passée (1970)

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
  caption: [Translation latitudinale moyenne des analogues climatiques pour la période 1970.]
)

=== Comparaison passé-futur

Les résultats du passé montrent une tendance au déplacement vers le Nord des analogues climatiques. La @fig:mean_shift permet d'examiner si cette tendance se confirme pour les projections futures. Le graphique de gauche présente le passé (1970) et celui de droite le futur (2050, moyenne des scénarios SSP126, SSP370 et SSP585), chacun comparant les résultats obtenus avec les distances Euclidienne et Mahalanobis pour les trois approches.

#figure(
  image("./images/mean_shift.png", width: 90%),
  caption: [Translation latitudinale moyenne par méthode et métrique de distance. Gauche : Période passée (1970). Droite : Période future (2050, moyenne des 3 scénarios SSP).]
) <fig:mean_shift>