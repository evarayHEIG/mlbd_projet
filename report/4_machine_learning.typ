= Techniques de machine learning

== Distance Mahalanobis

La distance de Mahalanobis permet de mesurer la similarité entre deux vecteurs climatiques en tenant compte des corrélations entre les variables, ce que ne fait pas la distance euclidienne. Elle évite ainsi d'exagérer les différences lorsque des variables sont fortement liées, ce qui est fréquent dans les données climatiques. La distance de Mahalanobis est définie comme suit, pour deux vecteurs $x$ et $y$ où S est la matrice de covariance des données :
$ d_M(x, y) = sqrt((x - y)^T S^(-1) (x - y)) $

== Réduction de dimensionnalité par autoencodeur

En complément de la PCA, nous avons exploré une méthode de réduction non-linéaire basée sur un autoencodeur MLP. Cette approche permet de capturer des relations complexes entre les variables climatiques que la PCA, limitée aux transformations linéaires, ne peut modéliser.

Les données d'entrainement sont les observations historiques fusionnées (1940-1970 et 1994-2024), qui ont été divisées en un ensemble d'entraînement (80%) et de validation (20%). Les données ont été normalisées avec un scaler entrainé uniquement sur l'ensemble d'entraînement pour éviter toute fuite de données.
L'architecture consiste en un encodeur (30 - 32 - 4) et un décodeur symétrique (4 - 32 - 30), avec des activations tangente hyperbolique (tanh), pour capturer des relations non-linéaires, et une sortie linéaire. Le nombre de neurones de la couche cachée (32) a été choisi pour permettre de réorganiser l'information dans un espace plus riche tout en évitant l'overfitting. Il aurait été envisageable d'ajouter plus de couches cachées ou de neurones mais la performance était déjà satisfaisante avec cette architecture. La dimension de sortie de 4 a été choisie pour correspondre aux nombre de PCA, permettant une comparaison équitable des deux approches. Le modèle minimise l'erreur quadratique moyenne (MSE) entre les données d'entrée normalisées et leur reconstruction, en utilisant l'optimiseur Adam avec un taux d'apprentissage de 0.01.

#figure(
  image("./images/loss.png", width: 80%),
  caption: [Évolution de la perte (MSE) durant l'entraînement de l'autoencodeur.]
) <fig:autoencoder_loss>

L'entraînement converge vers une loss de 0.0405 (train) et 0.0564 (validation), indiquant une reconstruction fidèle et pas d'overfitting. L'encodeur entraîné a ensuite été appliqué aux projections futures (SSP126, SSP370, SSP585) en utilisant le même scaler, garantissant une représentation cohérente à travers toutes les périodes temporelles. Les embeddings générés constituent ainsi la deuxième méthode de réduction de dimensionnalité pour l'analyse des analogues climatiques.