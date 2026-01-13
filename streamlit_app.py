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
        ("all", "pca", "embedding")
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
        min_value=5,
        max_value=100,
        value=5,
        step=5
    )

    period = st.selectbox(
        "Select period:",
        ("1940-1970", "2021-2050")
    )

    scenario = None
    if period == "2021-2050":
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
    # La matrice a des colonnes numérotées 1, 2, 3... sans index
    return pd.read_csv(filepath)

# Load cities from the period datasets to get correct order
@st.cache_data
def load_period_cities(period, scenario=None):
    """Load the cities in the order they appear in the period's climate features file."""
    if scenario:
        filename = f"climate_features_{period}_{scenario}.csv"
    else:
        filename = f"climate_features_{period}.csv"
    
    filepath = os.path.join("datasets", filename)
    df = pd.read_csv(filepath)
    return df['city'].values

try:
    distance_matrix = load_distance_matrix(method, distance_metric, period, scenario)
    
    # Get the city order for the selected period
    period_cities = load_period_cities(period, scenario)
    # Cities in columns are always 1994-2024
    current_cities = load_period_cities('1994-2024', None)
    
    # Find city index in the period array
    try:
        city_idx_in_period = list(period_cities).index(city)
    except ValueError:
        st.error(f"City '{city}' not found in period {period} {scenario if scenario else ''}")
        st.stop()
    
    # Get the row for the selected city
    distances = distance_matrix.iloc[city_idx_in_period]
    
    # Map distances to current cities
    data = cities_df.copy()
    
    # Create a mapping from current_cities to distance values
    distance_map = {}
    for idx, city_name in enumerate(current_cities):
        if idx < len(distances):
            distance_map[city_name] = distances.iloc[idx]
    
    data['climate_similarity'] = data['name'].map(distance_map)
    data = data.dropna(subset=['climate_similarity'])
    data = data.sort_values('climate_similarity')
    data = data.head(top_n)
        
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
        width='stretch',
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
    
    # Get the coordinates of the filter-selected city
    filter_city_row = cities_df[cities_df['name'] == city]
    filter_city_lat = filter_city_row['latitude'].iloc[0] if not filter_city_row.empty else None
    filter_city_lon = filter_city_row['longitude'].iloc[0] if not filter_city_row.empty else None
    
    if selected_city_data is not None:
        # Highlight table-selected city
        data_not_selected = data[data['name'] != selected_city_data['name']]
        
        fig = px.scatter_map(
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
        
        # Add table-selected city marker (filled red)
        fig.add_scattermap(
            lat=[selected_city_data['latitude']],
            lon=[selected_city_data['longitude']],
            mode='markers',
            marker=dict(size=18, color='red'),
            text=[selected_city_data['name']],
            hovertemplate='<b>%{text}</b><br>SELECTED<extra></extra>',
            name='Selected from table'
        )
    else:
        fig = px.scatter_map(
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
    
    # Add filter-selected city marker (red circle)
    if filter_city_lat and filter_city_lon:
        fig.add_scattermap(
            lat=[filter_city_lat],
            lon=[filter_city_lon],
            mode='markers',
            marker=dict(
                size=20, 
                color='red'
            ),
            text=[city],
            hovertemplate='<b>%{text}</b><br>FILTER SELECTED<extra></extra>',
            name='Filter selected',
            showlegend=False
        )
    
    fig.update_layout(
        map=dict(
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
        width='stretch',
        config={
            "scrollZoom": True,
            "displayModeBar": False
        }
    )

# Distribution of distances section
st.divider()
st.subheader("Distance Distribution Analysis")

col_dist1, col_dist2 = st.columns([2, 1])

with col_dist1:
    # Flatten the distance matrix to get all distances
    all_distances = distance_matrix.values.flatten()
    
    # Create histogram
    import numpy as np
    fig_hist = px.histogram(
        x=all_distances,
        nbins=50,
        labels={'x': 'Distance', 'y': 'Frequency'},
        title=f"Distribution of {distance_metric.capitalize()} Distances"
    )
    
    # Add vertical line for the selected city's distances
    city_distances = distance_matrix.iloc[city_idx_in_period].values
    mean_city_distance = np.mean(city_distances)
    
    fig_hist.add_vline(
        x=mean_city_distance,
        line_dash="dash",
        line_color="red",
        annotation_text=f"{city} avg: {mean_city_distance:.2f}",
        annotation_position="top right"
    )
    
    fig_hist.update_layout(
        showlegend=False,
        height=400
    )
    
    st.plotly_chart(fig_hist, width='stretch')

with col_dist2:
    st.markdown("### Statistics")
    
    # Overall statistics
    st.markdown("**Overall Distribution:**")
    stats_df = pd.DataFrame({
        'Metric': ['Min', 'Q1 (25%)', 'Median', 'Q3 (75%)', 'Max', 'Mean', 'Std Dev'],
        'Value': [
            f"{np.min(all_distances):.4f}",
            f"{np.percentile(all_distances, 25):.4f}",
            f"{np.median(all_distances):.4f}",
            f"{np.percentile(all_distances, 75):.4f}",
            f"{np.max(all_distances):.4f}",
            f"{np.mean(all_distances):.4f}",
            f"{np.std(all_distances):.4f}"
        ]
    })
    st.dataframe(stats_df, hide_index=True, width='stretch')
    
    st.markdown(f"**For {city}:**")
    city_stats_df = pd.DataFrame({
        'Metric': ['Min', 'Mean', 'Max'],
        'Value': [
            f"{np.min(city_distances):.4f}",
            f"{np.mean(city_distances):.4f}",
            f"{np.max(city_distances):.4f}"
        ]
    })
    st.dataframe(city_stats_df, hide_index=True, width='stretch')
    
    # Interpretation
    st.markdown("---")
    st.markdown("**Interpretation:**")
    if mean_city_distance < np.percentile(all_distances, 25):
        st.success("✅ Small distances - High similarity")
    elif mean_city_distance < np.percentile(all_distances, 75):
        st.info("📊 Medium distances - Moderate similarity")
    else:
        st.warning("⚠️ Large distances - Low similarity")