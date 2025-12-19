# Nomenclature

## Datasets

To store inside `datasets` directory.

### Historical data

```
climate_features_<period>_era5
ex: climate_features_2010-2020_era5
```


### Predicted future data

```
climate_features_<period>_isimip3b
ex: climate_features_2040-2050_isimip3b
```

## Distance matrices

To store inside `distance_matrices` directory.

### Historical distance matrices

```
<method>_<distance_metric>_<period>
ex: pca_euclidean_1970-1979
```

- method: pca or embedding
- distance_metric: euclidean, mahalanobis

### Predicted future distance matrices

```
<method>_<distance_metric>_<period>_<scenario>
ex: pca_euclidean_2041-2050_ssp370
```

- scenario: ssp126, ssp370, ssp585