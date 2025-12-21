import streamlit as st
import pandas as pd
import plotly.express as px
import os

# Streamlit configuration
st.set_page_config(
    page_title="Climate Map Europe",
    layout="wide"
)

st.title("Climate Similarity in Europe")

# Load cities data
@st.cache_data
def load_cities():
    df = pd.read_csv("datasets/european_cities.csv")
    df['city_index'] = range(1, len(df) + 1)
    return df

cities_df = load_cities()

# Sidebar filters
with st.sidebar:
    st.header("Filters")
    
    method = st.selectbox(
        "Select method:",
        ("pca", "embedding")
    )

    distance_metric = st.selectbox(
        "Select distance metric:",
        ("euclidean", "mahalanobis")
    )

    city = st.selectbox(
        "Select city:",
        sorted(cities_df['name'].unique()),
        index=sorted(cities_df['name'].unique()).index('Lausanne') if 'Lausanne' in cities_df['name'].values else 0
    )

    top_n = st.slider(
        "Number of closest cities to display:",
        min_value=10,
        max_value=100,
        value=10,
        step=5
    )

    period = st.selectbox(
        "Select period:",
        ("1970-1979", "2041-2050")
    )

    scenario = None
    if period == "2041-2050":
        scenario = st.selectbox(
            "Select scenario:",
            ("ssp126", "ssp370", "ssp585")
        )
    
    st.divider()
    st.info(
        f"Looking for cities that today have a similar climate to "
        f"**{city}** during the period **{period}**."
    )

# Load distance matrix
@st.cache_data
def load_distance_matrix(method, distance_metric, period, scenario=None):
    if scenario:
        filename = f"{method}_{distance_metric}_{period}_{scenario}.csv"
    else:
        filename = f"{method}_{distance_metric}_{period}.csv"
    
    filepath = os.path.join("distance_matrices", filename)
    return pd.read_csv(filepath, index_col=0)

try:
    distance_matrix = load_distance_matrix(method, distance_metric, period, scenario)
    
    city_row = cities_df[cities_df['name'] == city]
    if city_row.empty:
        st.error(f"City '{city}' not found in database")
        st.stop()
    
    city_index = city_row['city_index'].iloc[0]
    
    if str(city_index) in distance_matrix.columns:
        distances = distance_matrix[str(city_index)]
        
        data = cities_df.copy()
        data['climate_similarity'] = data['city_index'].map(lambda idx: distances.iloc[idx-1] if idx <= len(distances) else None)
        data = data.dropna(subset=['climate_similarity'])
        data = data.sort_values('climate_similarity')
        data = data.head(top_n)
        
    else:
        st.error(f"City index '{city_index}' not found in distance matrix")
        st.stop()
        
except FileNotFoundError:
    st.error(f"Distance matrix file not found. Please check the file exists.")
    st.stop()
except Exception as e:
    st.error(f"Error loading data: {str(e)}")
    st.stop()

# Two column layout
col1, col2 = st.columns([2, 1])

# Table with city selection
with col2:
    st.subheader(f"Top {len(data)} closest cities")
    
    display_data = data[['name', 'latitude', 'longitude', 'climate_similarity']].copy()
    display_data = display_data.reset_index(drop=True)
    
    display_table = display_data.copy()
    display_table.columns = ['City', 'Latitude', 'Longitude', 'Distance']
    display_table['Distance'] = display_table['Distance'].apply(lambda x: f"{x:.4f}")
    display_table.index = display_table.index + 1
    
    event = st.dataframe(
        display_table,
        use_container_width=True,
        height=600,
        on_select="rerun",
        selection_mode="single-row"
    )
    
    # Get selected city data
    selected_city_data = None
    if event.selection and len(event.selection.rows) > 0:
        selected_idx = event.selection.rows[0]
        selected_city_data = display_data.iloc[selected_idx]

# Map with city highlighting
with col1:
    st.subheader("Map")
    
    if selected_city_data is not None:
        # Highlight selected city
        data_not_selected = data[data['name'] != selected_city_data['name']]
        
        fig = px.scatter_mapbox(
            data_not_selected,
            lat="latitude",
            lon="longitude",
            color="climate_similarity",
            zoom=5,
            center=dict(lat=selected_city_data['latitude'], lon=selected_city_data['longitude']),
            hover_name="name",
            hover_data={
                "latitude": False,
                "longitude": False,
                "climate_similarity": ':.2f'
            },
            color_continuous_scale="Greens_r"
        )
        
        fig.add_scattermapbox(
            lat=[selected_city_data['latitude']],
            lon=[selected_city_data['longitude']],
            mode='markers',
            marker=dict(size=18, color='red'),
            text=[selected_city_data['name']],
            hovertemplate='<b>%{text}</b><br>SELECTED<extra></extra>',
            name='Selected'
        )
    else:
        fig = px.scatter_mapbox(
            data,
            lat="latitude",
            lon="longitude",
            color="climate_similarity",
            zoom=3.2,
            center=dict(lat=52, lon=10),
            hover_name="name",
            hover_data={
                "latitude": False,
                "longitude": False,
                "climate_similarity": ':.2f'
            },
            color_continuous_scale="Greens_r"
        )
    
    fig.update_layout(
        mapbox=dict(
            style="carto-darkmatter",
        ),
        height=550,
        margin=dict(l=0, r=0, t=40, b=0),
        coloraxis_colorbar=dict(
            title="Climate Distance",
            thickness=18
        ),
        showlegend=False
    )
    
    fig.update_traces(marker=dict(size=12), selector=dict(mode='markers'))
    
    st.plotly_chart(
        fig,
        use_container_width=True,
        config={
            "scrollZoom": True,
            "displayModeBar": False
        }
    )