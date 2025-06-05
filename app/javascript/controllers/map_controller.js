import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    // 1) Set the access token
    mapboxgl.accessToken = this.apiKeyValue

    // 2) Initialize the map
    this.map = new mapboxgl.Map({
      container: this.element,                          // the <div data-controller="map"> element
      style: "mapbox://styles/mapbox/streets-v10",      // Mapbox style
      center: [0, 0],                                   // will be overridden once we fit to markers
      zoom: 2                                           // starting zoom (world view)
    })

    // 3) Add markers and popups
    this._addMarkersToMap()
    this._fitMapToMarkers()
  }

  _addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      // Create a popup using our rendered HTML
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create the marker and attach the popup
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  _fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    if (!bounds.isEmpty()) {
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
    }
  }
}
