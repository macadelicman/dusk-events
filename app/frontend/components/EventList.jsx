// app/frontend/components/EventList.jsx
import React from "react";
import {
  Table,
  TableHead,
  TableRow,
  TableHeader,
  TableBody,
  TableCell,
} from "./Table";

const EventList = ({ events }) => {
  return (
    <Table striped>
      <TableHead>
        <TableRow>
          <TableHeader>Name</TableHeader>
          <TableHeader>Location</TableHeader>
          <TableHeader>Start Time</TableHeader>
          <TableHeader>End Time</TableHeader>
          <TableHeader>Price</TableHeader>
          <TableHeader>Actions</TableHeader>
        </TableRow>
      </TableHead>
      <TableBody>
        {events.map((event) => (
          <TableRow key={event.id}>
            <TableCell>{event.name}</TableCell>
            <TableCell>{event.location}</TableCell>
            <TableCell>{new Date(event.start_time).toLocaleString()}</TableCell>
            <TableCell>{new Date(event.end_time).toLocaleString()}</TableCell>
            <TableCell>${parseFloat(event.price).toFixed(2)}</TableCell>
            <TableCell>
              <a href={`/events/${event.id}`} className="btn btn-secondary">
                View
              </a>
              <a
                href={`/events/${event.id}/edit`}
                className="btn btn-secondary"
              >
                Edit
              </a>
            </TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  );
};

export default EventList;
