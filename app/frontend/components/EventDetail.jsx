// app/frontend/components/EventDetail.jsx
import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom"; // Assuming you're using React Router
import { Alert, AlertTitle, AlertDescription } from "./Alert";

const EventDetail = () => {
  const { id } = useParams();
  const [event, setEvent] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetch(`/api/events/${id}`, {
      credentials: "same-origin",
    })
      .then((response) => response.json())
      .then((data) => {
        setEvent(data);
        setLoading(false);
      })
      .catch((err) => {
        setError("Failed to fetch event details.");
        setLoading(false);
      });
  }, [id]);

  if (loading) return <div>Loading event details...</div>;
  if (error)
    return (
      <Alert>
        <AlertTitle>Error</AlertTitle>
        <AlertDescription>{error}</AlertDescription>
      </Alert>
    );
  if (!event) return <div>Event not found.</div>;

  return (
    <div className="p-4">
      <h2 className="text-xl font-bold">{event.name}</h2>
      <p className="mt-2">{event.description}</p>
      <p className="mt-2">
        <strong>Location:</strong> {event.location}
      </p>
      <p className="mt-2">
        <strong>Start Time:</strong>{" "}
        {new Date(event.start_time).toLocaleString()}
      </p>
      <p className="mt-2">
        <strong>End Time:</strong> {new Date(event.end_time).toLocaleString()}
      </p>
      <p className="mt-2">
        <strong>Price:</strong> ${parseFloat(event.price).toFixed(2)}
      </p>
      <p className="mt-2">
        <strong>Capacity:</strong> {event.capacity}
      </p>
      {event.duration && (
        <p className="mt-2">
          <strong>Duration:</strong> {event.duration} hours
        </p>
      )}
      {event.discount && (
        <p className="mt-2">
          <strong>Discount:</strong> {event.discount}%
        </p>
      )}
      <div className="mt-4">
        <a href={`/events/${event.id}/edit`} className="btn btn-secondary mr-2">
          Edit
        </a>
        <a href="/events" className="btn btn-secondary">
          Back to Events
        </a>
      </div>
    </div>
  );
};

export default EventDetail;
