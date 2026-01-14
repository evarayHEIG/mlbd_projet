= Database

Les données climatiques utilisées dans ce projet proviennent de projets reconnus au niveau international. Les données historiques sont issues du jeu de données *ERA5*, fourni par le _Climate Data Store_ (CDS) du programme européen Copernicus et produit par l’ECMWF. ERA5 fournit des réanalyses climatiques cohérentes et de haute qualité, largement utilisées pour l’étude du climat passé et récent. @Era5 Deux datasets on été utilisés, le premier avec des données moyénnées mensuellement @Era5monthly et le second avec des données horaires @Era5daily, afin de pouvoir en extraire des variables plus spécifiques. 

Les projections climatiques futures reposent sur le projet *CMIP6* _(Coupled Model Intercomparison Project Phase 6)_, à travers le modèle climatique global *IPSL-CM6A-LR*, mis à disposition dans le cadre du protocole *ISIMIP 3b*. @Isimip ISIMIP 3b utilise une technique de "bias correction" qui consite à comparer les données prédites par CMIP6 pour une période historique avec les données observées réelles, afin d'identifier les erreurs systématiques (ou biais) du modèle. Ces biais sont ensuite corrigés dans les projections futures pour améliorer leur précision. @IsimipBiasAdjustment Trois scénarios climatiques sont considérés : *SSP1-2.6*, *SSP3-7.0* et *SSP5-8.5*, représentant respectivement des trajectoires optimiste, intermédiaire et pessimiste.

Pour caractériser le climat local des villes étudiées, plusieurs variables météorologiques standard ont été sélectionnées :

- *Température de l'air à 2 mètres (t2m)* : température de l'air à 2m au-dessus de la surface, utilisée pour calculer les températures maximales et minimales journalières, le nombre de jours au dessus de 30°C par année, le nombre de jours consécutifs au dessus de 30°C par année et la différence entre les températures maximales et minimales journalières.
- *Précipitations totales (tp)* : somme des précipitations de pluie et de neige tombant à la surface terrestre
- *Chutes de neige (sf)* : neige accumulée tombant à la surface terrestre
- *Vitesse du vent à 10 mètres (si10)* : vitesse horizontale du vent à 10m au-dessus de la surface terrestre