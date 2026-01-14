= Data pre-processing et feature extraction

== Sélection des villes 

Les jeux de données initiaux couvrent une grille européenne ou mondiale, mais pour cette étude, l’analyse a été restreinte à un échantillon de 300 villes européennes, sélectionnées pour leur intérêt touristique @Europeancities. L'extraction des features pour chaque ville a été réalisée en considérant un rayon de 50km (\~0.45°) autour des coordonnées géographiques (latitude et longitude) de chaque ville, et en moyennant les valeurs des points de grille situés dans ce rayon. Après extraction, seulement 292 villes restent, les autres étant trop loin des points de grille disponibles dans les données climatiques.

== Traitement des variables climatiques

Les features "nombre de jours au dessus de 30°C" et "nombre de jours consécutifs au dessus de 30°C" ont été créées à partir des données journalières de température maximale. Pour chaque année, le nombre de jours où la température maximale dépasse 30°C a été comptabilisé, ainsi que le nombre maximum de jours consécutifs au dessus de ce seuil. Pour les données historiques, la température maximale journalière a été extraite des données horaires en prenant la valeur maximale sur chaque journée. Pour les projections futures, la température maximale journalière était déjà disponible.

Les données mensuelles brutes ont été transformées pour correspondre à l’échelle temporelle et saisonnière souhaitée. Les données historiques et les projections futures ont été fusionnées pour couvrir les périodes de 30 ans: 1940-1970 (passé), 1994-2024 (présent) et 2020-2050 (futur). Pour chaque période, les variables ont été moyénnées d'abord par saison, distinguant l'hiver (décembre à février), le printemps (mars à mai), l'été (juin à août) et l'automne (septembre à novembre), puis sur l'entierté de la période de 30 ans. La période de 30 ans est choisie car c'est le nombre d'années minimal pour défnir un climat, selon l'Organisation Météorologique Mondiale @Climat. 

#figure(image("images/data_transfo2.png", width: 100%), caption: "Transformation des données climatiques brutes en features saisonnières.")

Enfin, les features climatiques présentant des unités et des ordres de grandeur très différents, telles que la température en Kelvin, les précipitations en mètres ou la vitesse du vent en mètres par seconde, une normalisation est nécessaire pour éviter qu’une variable domine l’apprentissage. 

== PCA

Pour limiter le "curse of dimensionality" affectant le calcul des distances, une Analyse en Composantes Principales (PCA) a été appliquée pour réduire la dimension de l'espace des features. Avant la PCA, les features hautement corrélées (> 0.8) ont été supprimées pour éviter la redondance : pour chaque paire de features corrélées, une seule a été conservée. Ce filtrage a réduit le nombre de features de 30 à 9. Un scaler a été calculé sur ces 9 features des données historiques, puis appliqué aux données historiques et futures avant la transformation PCA. Quatre composantes principales ont été retenues, expliquant 90.18% de la variance totale.

#figure(image("images/pca.png", width: 60%), caption: "Variance expliquée en fonction du nombre de composantes principales retenues.")