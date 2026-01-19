= Analyses et conclusions

== Analyse de la translation latitudinale

=== Synthèse des résultats obtenus

Les résultats présentés dans le chapitre précédent révèlent une migration climatique progressive vers le Sud au fil des décennies. Pour la période passée (1970), environ 48% des villes trouvent leurs analogues climatiques au Nord, suggérant déjà un début de réchauffement par rapport à des périodes antérieures. Les shifts moyens oscillent entre -0.81° et +0.34°.

La @fig:mean_shift révèle que cette tendance s'accentue drastiquement pour la période future (2050). Les shifts deviennent majoritairement négatifs et la proportion de villes ayant leurs analogues au Sud augmente significativement. Ce glissement continu et accentué des zones climatiques vers le sud démontre la progression du réchauffement climatique projeté par les scénarios SSP : les climats européens "descendent" géographiquement, adoptant des caractéristiques de plus en plus méridionales.

=== Approfondissement : Analyse par ville individuelle

Les résultats précédents s'appuient sur la moyenne des 5 meilleurs analogues climatiques, offrant une vue d'ensemble. Pour affiner l'analyse, examinons maintenant le meilleur analogue unique de chaque ville.

#figure(
  image("./images/best_analog_analysis.png", width: 100%),
  caption: [Distribution des analogues climatiques par période. Chaque ville est classée selon son meilleur analogue : Stable (soi-même), Nord ou Sud. Distance Mahalanobis.]
) <fig:best_analog>

Pour le passé (1970), 22% en moyenne des villes européennes ont conservé un climat stable, leur meilleur analogue climatique est elles-mêmes. Les 78% restants se répartissent équitablement entre Nord et Sud, sans direction dominante.

Pour le futur (2050), la stabilité climatique s'effondre à en moyenne 7% : 93% des villes européennes auront un climat différent de leur climat actuel. La répartition Nord/Sud se déséquilibre : 38% Nord contre 54% Sud.

Le transfert est remarquable : la perte de 15 points de stabilité climatique (22% à 7%) correspond presque exactement au gain de 16 points vers le Sud (38% à 54%). Ce basculement symétrique démontre que les villes qui étaient climatiquement stables deviennent majoritairement des zones à climat "méridional".

=== Comparaison des méthodes

Pour le futur, les trois méthodes de réduction de dimensionnalité produisent des résultats très similaires. Les embeddings montrent plus d'instabilités au profit d'analogues au Sud. Cela peut s'expliquer par la capacité des autoencodeurs à capturer des relations non-linéaires complexes, qui pourraient mieux refléter les dynamiques climatiques futures.

Pour le passé, les résultats divergent plus. Les embeddings identifient à nouveau plus de villes non stables et la méthode utilisant toutes les features montre une préférence pour les analogues au Sud, contrairement aux autres méthodes. Cela peut indiquer que les features corrélées éliminées capturent des nuances climatiques spécifiques à la période passée, qui orientent les analogues vers le Sud, contrairement à ce qui est attendu d'après létat de l'art des analogues climatiques. 

== Conclusion

Ce projet a identifié des analogues climatiques pour les villes européennes en combinant données historiques et projections futures (scénarios GIEC). L'approche multi-méthodes (plusieurs techniques de réduction de dimensionnalité, deux métriques de distance, trois scénarios SSP) a permis d'observer une convergence des résultats malgré les différences techniques.

La tendance est claire : les villes européennes "descendent" climatiquement vers le Sud au fil du temps. Cette migration s'accentue entre les périodes passées (relativement stables) et futures (déplacement systématique vers des conditions méridionales), démontrant une transformation climatique à l'échelle européenne avec des implications majeures pour l'agriculture, les ressources en eau et les infrastructures urbaines.