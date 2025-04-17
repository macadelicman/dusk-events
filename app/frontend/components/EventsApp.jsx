// app/frontend/components/EventsApp.jsx
import React, { useEffect, useState } from "react";
import EventList from "./EventList";
import EventForm from "./EventForm";
import { Alert, AlertTitle, AlertDescription } from "./Alert"; // Assuming you have these components
import { Button } from "./Button";

const EventsApp = () => {
  const [events, setEvents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showForm, setShowForm] = useState(false);

  useEffect(() => {
    fetch("/api/events", {
      credentials: "same-origin",
    })
      .then((response) => response.json())
      .then((data) => {
        setEvents(data);
        setLoading(false);
      })
      .catch((err) => {
        setError("Failed to fetch events.");
        setLoading(false);
      });
  }, []);

  const handleEventCreated = (newEvent) => {
    setEvents([...events, newEvent]);
  };

  if (loading) return <div>Loading events...</div>;
  if (error)
    return (
      <Alert>
        <AlertTitle>Error</AlertTitle>
        <AlertDescription>{error}</AlertDescription>
      </Alert>
    );

  return (
    <div className="p-4">
      <div className="flex justify-between items-center mb-4">
        <h1 className="text-2xl font-bold">Events</h1>
        <Button onClick={() => setShowForm(!showForm)}>
          {showForm ? "Close Form" : "Add New Event"}
        </Button>
      </div>
      {showForm && <EventForm onEventCreated={handleEventCreated} />}
      <EventList events={events} />
    </div>
  );
};

export default EventsApp;
