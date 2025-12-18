import streamlit as st
import pandas as pd
import plotly.express as px

# =========================
# Configuration Streamlit
# =========================
st.set_page_config(
    page_title="Carte Climatique Europe",
    layout="wide"
)

st.title("Similitude Climatique en Europe")

# =========================
# Sélecteurs
# =========================
city = st.selectbox(
    "Select city:",
    ("Paris", "London", "Berlin", "Rome", "Madrid", "Stockholm", "Copenhagen", "Brussels"),
)

period = st.selectbox(
    "Select period:",
    ("1970-1979", "1980-1989", "1990-1999", "2000-2009", "2010-2019", "2020-2029")
)

st.write(
    f"You're looking for cities that today have a similar climate to "
    f"{city} during the period {period}."
)

# =========================
# Données
# =========================
data = pd.DataFrame({
    "lat": [48.8566, 51.5074, 52.5200, 41.9028, 40.4168, 59.3293, 55.6761, 50.8503],
    "lon": [2.3522, -0.1278, 13.4050, 12.4964, -3.7038, 18.0686, 12.5683, 4.3517],
    "city": [
        "Paris",
        "London",
        "Berlin",
        "Rome",
        "Madrid",
        "Stockholm",
        "Copenhagen",
        "Brussels"
    ],
    "climate_similarity": [0.0, 1.2, 1.5, 3.8, 3.2, 5.5, 2.1, 0.8]
})

# =========================
# Carte Mapbox
# =========================
fig = px.scatter_mapbox(
    data,
    lat="lat",
    lon="lon",
    color="climate_similarity",
    size="climate_similarity",
    size_max=30,                     # points bien visibles
    zoom=3.2,                        # cadrage Europe
    center=dict(lat=52, lon=10),     # centre Europe
    hover_name="city",
    hover_data={
        "lat": False,
        "lon": False,
        "climate_similarity": ':.2f'
    },
    color_continuous_scale="Greens_r"
)

fig.update_layout(
    mapbox=dict(
        style="carto-positron",
        center=dict(lat=52, lon=10),
        zoom=3.2,
    ),
    height=550,
    margin=dict(l=0, r=0, t=40, b=0),
    coloraxis_colorbar=dict(
        title="Distance Climatique",
        thickness=18
    )
)


# =========================
# Affichage
# =========================
st.plotly_chart(
    fig,
    use_container_width=True,
    config={
        "scrollZoom": True,          # molette souris
        "displayModeBar": False
    }
)
