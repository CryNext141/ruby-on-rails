import { Application } from "@hotwired/stimulus"
import { useLoading } from "@hotwired/stimulus-loading"


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
