@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Entity'

define root view entity ZI_TRAVEL_ROOT_INCH_U
    as select from /dmo/travel as Travel
  composition [0..*] of ZI_BOOKING_INCH_U as _Booking
  association [0..1] to /DMO/I_Agency as _Agency on $projection.AgencyId = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer as _Customer on $projection.CustomerId = _Customer.CustomerID
  association [0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency
  association [1..1] to /DMO/I_Travel_Status_VH as _Status on $projection.OverAllStatus = _Status.TravelStatus
{
   key Travel.travel_id     as TravelId,
       
       Travel.agency_id     as AgencyId,
       
       Travel.customer_id   as CustomerId,
       
       Travel.begin_date    as BeginDate,
       
       Travel.end_date      as EndDate,
       
       @Semantics.amount.currencyCode: 'CurrencyCode'
       Travel.booking_fee   as BookingFee,
       
       @Semantics.amount.currencyCode: 'CurrencyCode'
       Travel.total_price   as TotalPrice,
       
       Travel.currency_code as CurrencyCode,
       
       
       Travel.status        as OverAllStatus,
       
       Travel.description   as Description,
       
       Travel.lastchangedat as LastChangedAt,
       
       _Booking,
       _Agency,
       _Customer,
       _Currency,
       _Status
}    
