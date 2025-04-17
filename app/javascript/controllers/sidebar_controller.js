import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["currentIndicator", "item"]

  connect() {
    this.updateCurrentIndicator()

    // Listen for Turbo navigation events
    document.addEventListener("turbo:load", this.updateCurrentIndicatorBound = this.updateCurrentIndicator.bind(this))

    // Add resize listener to handle window size changes
    window.addEventListener("resize", this.updateIndicatorBound = this.updateCurrentIndicator.bind(this))
  }

  disconnect() {
    document.removeEventListener("turbo:load", this.updateCurrentIndicatorBound)
    window.removeEventListener("resize", this.updateIndicatorBound)
  }

  updateCurrentIndicator() {
    const currentItem = this.itemTargets.find(item =>
      item.dataset.current === "true"
    )

    if (currentItem && this.hasCurrentIndicatorTarget) {
      // Get the position relative to the sidebar
      const sidebarRect = this.element.getBoundingClientRect()
      const itemRect = currentItem.getBoundingClientRect()

      const indicator = this.currentIndicatorTarget

      // Position the indicator relative to the sidebar
      indicator.style.top = `${itemRect.top - sidebarRect.top + 8}px` // +8px for inset-y-2
      indicator.style.height = `${itemRect.height - 16}px` // -16px for inset-y-2
      indicator.style.opacity = "1"
      indicator.style.display = "block"
    } else if (this.hasCurrentIndicatorTarget) {
      this.currentIndicatorTarget.style.opacity = "0"
    }
  }
}


/*
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  connect() {
  }
}
*/
