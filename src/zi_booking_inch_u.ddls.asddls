@AbapCatalog.viewEnhancementCategory: [#NONE]
@EndUserText.label: 'Booking Entity'

define view entity ZI_BOOKING_INCH_U
   as select from /dmo/booking as Booking
   association to parent ZI_TRAVEL_ROOT_INCH_U as _Travel on $projection.TravelId = _Travel.TravelId 
   association [1..1] to /dmo/carrier as _Carrier on $projection.CarrierId = _Carrier.carrier_id
   association [1..1] to /dmo/connection as _Connection on $projection.ConnectionId = _Connection.connection_id
                                                        and $projection.CarrierId = _Connection.carrier_id
   association [1..1] to /dmo/customer   as _Customer on $projection.CustomerId = _Customer.customer_id
{
    key Booking.booking_id    as BookingId,
    
    key Booking.travel_id     as TravelId,
    
        Booking.carrier_id    as CarrierId,
    
        Booking.connection_id as ConnectionId,
    
        Booking.customer_id   as CustomerId,
    
        @Semantics.amount.currencyCode: 'CurrencyCode'
        Booking.flight_price  as FlightPrice,
    
        Booking.currency_code as CurrencyCode,
        
        Booking.flight_date   as FlightDate,
        
        _Travel,
        _Carrier,
        _Connection,
        _Customer
}   
