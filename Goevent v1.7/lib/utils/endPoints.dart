class EndPoints {
  // static const baseUrl =
  //     'https://pibwvpg9l7.execute-api.ap-south-1.amazonaws.com/api/v1';
  // static const baseUrl = 'https://devapi.hamaraticket.com/api/v1';
  // static const baseUrl = 'https://7e5a-103-182-133-23.ngrok-free.app/api/v1';
  static const baseUrl = 'http://192.168.1.34:4000/api/v1';
  
  static const loginWithEmail = '/auth/email-otp';
  static const loginWithGoogle = '/auth/mobile/google-signin';
  static const verifyEmailOtp = '/auth/verify-email-otp';

  
  /// User endPoints ///
  static const userEndpoint = "$baseUrl/users";
  
  /// HomepageEndpoints ///
  static const homeEndPoint = "$userEndpoint/home";

  /// Event Endpoints ///
  static const eventEndpoint = "$baseUrl/event";
  static const eventByIdEndpoint = eventEndpoint;

  /// Park Endpoints ///
  static const parkEndpoint = "$baseUrl/park";
  static const parkByIdEndpoint = parkEndpoint;

  /// Ticket Endpoints ///
  static const ticketEndpoint = "$baseUrl/ticket";
  static const getTickets = "$ticketEndpoint/tickets";

  /// Booking Endpoints ///
  static const getBookingsByUserId = userEndpoint;
}
