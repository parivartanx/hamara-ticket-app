import '/models/event/event_model.dart';

final List<Event> events = [
  Event(
    id: "1",
    name: "Lagoon E Gulaal",
    description: "A vibrant Holi festival celebration with colors, music, and fun activities.",
    location: "Gandhi Maidan",
    city: "Patna",
    address: "Gandhi Maidan, Patna, Bihar",
    imageUrls: ["https://res.cloudinary.com/dmnzubnst/image/upload/v1740681112/uploads/yz86wqcm9xdtyshovxfl.jpg", "https://example.com/lagoon2.jpg"],
    videoUrls: ["https://example.com/lagoon_video.mp4"],
    tags: ["Holi", "Festival", "Music"],
    latitude: 25.6093,
    longitude: 85.1235,
    startDate: "2025-03-20",
    endDate: "2025-03-20",
    startTime: "10:00 AM",
    endTime: "06:00 PM",
    maxCapacity: 5000,
    adminId: "admin123",
    status: "Scheduled",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Event(
    id: "2",
    name: "Patna Food Festival 2025",
    description: "A grand food festival featuring Bihari and international cuisines.",
    location: "Eco Park",
    city: "Patna",
    address: "Rajdhani Vatika, Eco Park, Patna, Bihar",
    imageUrls: ["https://res.cloudinary.com/dmnzubnst/image/upload/v1740681112/uploads/yz86wqcm9xdtyshovxfl.jpg", "https://example.com/food2.jpg"],
    videoUrls: ["https://example.com/food_video.mp4"],
    tags: ["Food", "Festival", "Street Food"],
    latitude: 25.6097,
    longitude: 85.1415,
    startDate: "2025-04-10",
    endDate: "2025-04-12",
    startTime: "12:00 PM",
    endTime: "10:00 PM",
    maxCapacity: 10000,
    adminId: "admin456",
    status: "Scheduled",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Event(
    id: "3",
    name: "Bollywood Night Patna",
    description: "An electrifying Bollywood-themed dance and music party.",
    location: "P&M Mall Banquet",
    city: "Patna",
    address: "P&M Mall, Patliputra Industrial Area, Patna, Bihar",
    imageUrls: ["https://res.cloudinary.com/dmnzubnst/image/upload/v1740681112/uploads/yz86wqcm9xdtyshovxfl.jpg", "https://example.com/bollywood2.jpg"],
    videoUrls: ["https://example.com/bollywood_video.mp4"],
    tags: ["Bollywood", "Music", "Dance"],
    latitude: 25.6127,
    longitude: 85.1076,
    startDate: "2025-05-05",
    endDate: "2025-05-05",
    startTime: "08:00 PM",
    endTime: "02:00 AM",
    maxCapacity: 3000,
    adminId: "admin789",
    status: "Scheduled",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Event(
    id: "4",
    name: "Patna Tech Expo 2025",
    description: "A cutting-edge technology exhibition featuring AI, robotics, and more.",
    location: "Gyan Bhavan",
    city: "Patna",
    address: "Gyan Bhavan, Patna, Bihar",
    imageUrls: ["https://res.cloudinary.com/dmnzubnst/image/upload/v1740681112/uploads/yz86wqcm9xdtyshovxfl.jpg", "https://example.com/tech2.jpg"],
    videoUrls: ["https://example.com/tech_video.mp4"],
    tags: ["Technology", "Expo", "Innovation"],
    latitude: 25.6175,
    longitude: 85.1417,
    startDate: "2025-06-15",
    endDate: "2025-06-17",
    startTime: "09:00 AM",
    endTime: "06:00 PM",
    maxCapacity: 15000,
    adminId: "admin101",
    status: "Scheduled",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Event(
    id: "5",
    name: "Patna Marathon 2025",
    description: "A charity marathon to promote health and fitness.",
    location: "Patna Golf Club",
    city: "Patna",
    address: "Patna Golf Club, Bailey Road, Patna, Bihar",
    imageUrls: ["https://res.cloudinary.com/dmnzubnst/image/upload/v1740681112/uploads/yz86wqcm9xdtyshovxfl.jpg", "https://example.com/marathon2.jpg"],
    videoUrls: ["https://example.com/marathon_video.mp4"],
    tags: ["Marathon", "Charity", "Health"],
    latitude: 25.6010,
    longitude: 85.1311,
    startDate: "2025-07-10",
    endDate: "2025-07-10",
    startTime: "06:00 AM",
    endTime: "12:00 PM",
    maxCapacity: 8000,
    adminId: "admin202",
    status: "Scheduled",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
