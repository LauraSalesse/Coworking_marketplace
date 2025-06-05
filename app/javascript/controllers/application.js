import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }


// app/javascript/application.js
import "@hotwired/turbo-rails"
import "controllers"    // this will auto-load map_controller.js
