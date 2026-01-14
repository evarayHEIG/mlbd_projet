= Analyses et conclusions

== Analyse de la translation latitudinale

=== Synthèse des résultats obtenus

Les résultats présentés dans le chapitre précédent révèlent une évolution marquée entre les périodes passée et future. Pour la période passée (1940-1970), la distribution des analogues climatiques montre une tendance au déplacement vers le Nord : environ 48% des villes ont leurs analogues au Nord, avec des shifts moyens oscillant entre -0.81° et +0.34°. Cette répartition suggère que les villes européennes cherchaient leurs analogues climatiques à des latitudes légèrement plus élevées.

La @fig:mean_shift révèle que la période future (2021-2050) confirme l'existence d'une tendance, mais dans le sens inverse. Les shifts deviennent négatifs et la proportion de villes ayant leurs analogues au Sud augmente significativement. Ce renversement clair de la tendance démontre un basculement des zones climatiques vers le sud, confirmant quantitativement l'impact du réchauffement climatique projeté par les scénarios SSP.

=== Approfondissement : Analyse par ville individuelle

Les résultats précédents s'appuient sur la moyenne des 5 meilleurs analogues climatiques, offrant une vue d'ensemble. Pour mieux comprendre l'ampleur réelle des changements à l'échelle individuelle, examinons maintenant le meilleur analogue unique de chaque ville.

#figure(
  image("./images/best_analog_analysis.png", width: 100%),
  caption: [Distribution des analogues climatiques par période. Pour chaque ville, on identifie son meilleur analogue et on classe selon trois catégories : Stable (analogue = soi-même), Nord (analogue au nord), ou Sud (analogue au sud). Les valeurs représentent la moyenne de toutes les configurations (distances Euclidean et Mahalanobis, scénarios SSP126/370/585 pour le futur).]
) <fig:best_analog>

Pour la période passée (1940-1970), environ 24% des villes européennes ont conservé un climat stable, leur meilleur analogue climatique est elles-mêmes. Les 76% restants se répartissent équitablement entre Nord (38%) et Sud (38%), sans direction dominante.

Pour le futur (2021-2050), la stabilité climatique s'effondre à 8% : 92% des villes européennes auront un climat différent de leur climat actuel. La répartition Nord/Sud n'est plus équilibrée : 38% Nord contre 54% Sud.

Le transfert est remarquable : la perte de 16 points de stabilité climatique (24% à 8%) correspond presque exactement au gain de 16 points vers le Sud (38% à 54%). Ce basculement symétrique démontre que les villes qui étaient climatiquement stables deviennent majoritairement des zones à climat "méridional".

== Conclusion

Ce projet s'est attaché à identifier des analogues climatiques pour les villes européennes en exploitant des données historiques et des projections futures basées sur les scénarios du GIEC. En l'absence de vérité de référence absolue pour valider ces analogues — une limitation inhérente à ce type d'analyse prospective — nous avons adopté une approche méthodologique diversifiée combinant plusieurs techniques de réduction de dimensionnalité, deux métriques de distance, et trois scénarios climatiques. Cette diversité méthodologique s'est révélée être une force, permettant d'observer la convergence des résultats au-delà des choix techniques.

Malgré les différences d'approches, une tendance générale cohérente se dessine clairement : les villes européennes tendent à "descendre" climatiquement vers le Sud. Cette migration des zones climatiques se manifeste par un déséquilibre croissant entre les périodes passées relativement stables et les projections futures marquées par un déplacement systématique vers des conditions méridionales. Bien que ce projet ne prétende pas fournir une réponse absolue sur les analogues climatiques exacts de chaque ville, il démontre avec robustesse l'existence d'une transformation climatique à l'échelle européenne, soulignant l'urgence d'anticiper les implications pour l'agriculture, la gestion des ressources en eau, et l'adaptation des infrastructures urbaines.