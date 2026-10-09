@EndUserText.label: 'Consumption view for Booking'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZC_BOOKING_INCH_U
  as projection on ZI_BOOKING_INCH_U
{

     key BookingId,
    
     key TravelId, 
     
     CarrierId,
     
     CustomerId,
     
     ConnectionId,
     
     FlightPrice,
     
     CurrencyCode,
     
     FlightDate,
     
     _Carrier,
     _Connection,
     _Customer,
     _Travel : redirected to parent ZC_TRAVEL_ROOT_INCH_U 
   
}  
