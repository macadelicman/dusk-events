// app/frontend/components/EventForm.jsx
import React, { useState } from "react";
import { Input } from "./Input";
import { Textarea } from "./Textarea";
import { Select } from "./Select";
import { Button } from "./Button";
import { Alert, AlertTitle, AlertDescription } from "./Alert";

const EventForm = ({ onEventCreated }) => {
  const [formData, setFormData] = useState({
    name: "",
    description: "",
    location: "",
    start_time: "",
    end_time: "",
    price: "",
    capacity: "",
    duration: "",
    discount: "",
  });
  const [error, setError] = useState(null);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setError(null);

    fetch("/api/events", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": getCsrfToken(),
      },
      credentials: "same-origin",
      body: JSON.stringify(formData),
    })
      .then(async (response) => {
        if (!response.ok) {
          const res = await response.json();
          throw res;
        }
        return response.json();
      })
      .then((data) => {
        onEventCreated(data);
        setFormData({
          name: "",
          description: "",
          location: "",
          start_time: "",
          end_time: "",
          price: "",
          capacity: "",
          duration: "",
          discount: "",
        });
      })
      .catch((err) => {
        setError(err.error || "Failed to create event.");
      });
  };

  const getCsrfToken = () => {
    const meta = document.querySelector('meta[name="csrf-token"]');
    return meta && meta.getAttribute("content");
  };

  return (
    <form onSubmit={handleSubmit} className="mb-6">
      {error && (
        <Alert>
          <AlertTitle>Error</AlertTitle>
          <AlertDescription>{error}</AlertDescription>
        </Alert>
      )}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
        <Input
          name="name"
          label="Event Name"
          value={formData.name}
          onChange={handleChange}
          required
        />
        <Input
          name="location"
          label="Location"
          value={formData.location}
          onChange={handleChange}
          required
        />
        <Textarea
          name="description"
          label="Description"
          value={formData.description}
          onChange={handleChange}
          required
        />
        <div>
          <label
            htmlFor="start_time"
            className="block text-sm font-medium text-zinc-700 dark:text-zinc-300"
          >
            Start Time
          </label>
          <input
            type="datetime-local"
            name="start_time"
            id="start_time"
            value={formData.start_time}
            onChange={handleChange}
            required
            className="mt-1 block w-full rounded-md border-zinc-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm dark:border-white/20 dark:bg-zinc-800 dark:text-white"
          />
        </div>
        <div>
          <label
            htmlFor="end_time"
            className="block text-sm font-medium text-zinc-700 dark:text-zinc-300"
          >
            End Time
          </label>
          <input
            type="datetime-local"
            name="end_time"
            id="end_time"
            value={formData.end_time}
            onChange={handleChange}
            required
            className="mt-1 block w-full rounded-md border-zinc-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm dark:border-white/20 dark:bg-zinc-800 dark:text-white"
          />
        </div>
        <Input
          name="price"
          label="Price"
          type="number"
          step="0.01"
          value={formData.price}
          onChange={handleChange}
          required
        />
        <Input
          name="capacity"
          label="Capacity"
          type="number"
          value={formData.capacity}
          onChange={handleChange}
          required
        />
        <Input
          name="duration"
          label="Duration (hours)"
          type="number"
          step="0.1"
          value={formData.duration}
          onChange={handleChange}
        />
        <Input
          name="discount"
          label="Discount (%)"
          type="number"
          step="0.1"
          value={formData.discount}
          onChange={handleChange}
        />
      </div>
      <div className="mt-4">
        <Button type="submit">Create Event</Button>
      </div>
    </form>
  );
};

export default EventForm;
