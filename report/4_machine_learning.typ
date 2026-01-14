= Techniques de machine learning

== Distance Mahalanobis

La distance de Mahalanobis permet de mesurer la similarité entre deux vecteurs climatiques en tenant compte des corrélations entre les variables, ce que ne fait pas la distance euclidienne. Elle évite ainsi d’exagérer les différences lorsque des variables sont fortement liées, ce qui est fréquent dans les données climatiques. La distance de Mahalanobis est définie comme suit, pour deux vecteurs $x$ et $y$ où S est la matrice de covariance des données :
$ d_M(x, y) = sqrt((x - y)^T S^(-1) (x - y)) $

== Encoder