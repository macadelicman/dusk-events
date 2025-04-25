/*
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="react-component"
export default class extends Controller {
  connect() {
  }
}
*/
import { Controller } from "@hotwired/stimulus";
import React from "react";
import { createRoot } from "react-dom/client";

export default class extends Controller {
  static values = {
    name: String,
    props: Object
  }

  connect() {
    import(`../components/${this.nameValue}.jsx`)
      .then((module) => {
        this.root = createRoot(this.element);
        this.root.render(
          React.createElement(module.default, this.propsValue)
        );
      })
      .catch((e) => console.error("React mount failed:", e));
  }

  disconnect() {
    if (this.root) this.root.unmount();
  }
}
