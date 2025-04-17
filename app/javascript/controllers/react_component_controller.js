/*
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="react-component"
export default class extends Controller {
  connect() {
  }
}
*/
// app/javascript/controllers/react_component_controller.js
import { Controller } from "@hotwired/stimulus"
import { createRoot } from 'react-dom/client';
import EventDetail from '~/components/EventDetail';
import EventForm from '~/components/EventForm';
import EventList from '~/components/EventList.jsx';

const COMPONENTS = {
  'event-detail': EventDetail,
  'event-form': EventForm,
  'event-list': EventList
};

export default class extends Controller {
  static values = {
    name: String,
    props: Object
  }

  connect() {
    const Component = COMPONENTS[this.nameValue];
    if (!Component) return;

    const root = createRoot(this.element);
    root.render(React.createElement(Component, this.propsValue || {}));
  }
}
