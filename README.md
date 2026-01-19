# MLBD Project - Climate Analogs for European Cities

## Installation

### Prerequisites

- Python 3.13+
- pip

### Install dependencies

```bash
pip install -r requirements.txt
```

## Streamlit Application

An interactive Streamlit application to explore climate analogs for European cities.

### Running the application

```bash
streamlit run streamlit_app.py
```

The application will be available at: `http://localhost:8501`


## Notebooks

- `extract_climate_features_historical.ipynb`: Notebook for extracting climate features from monthly historical data.
- `extract_temperature_features_historical.ipynb`: Notebook for extracting temperature features from hourly historical data.
- `extract_climate_features_future_30_years.ipynb`: Notebook for extracting climate features from future projections over a 30-year period.
- `pca.ipynb`: Notebook for performing Principal Component Analysis (PCA) on the extracted features.
- `climate_analogs.ipynb`: Notebook for identifying climate analogs based on the extracted features.
- `encoder.ipynb`: Notebook for training and evaluating an encoder model on the climate data.