@EndUserText.label: 'Consumption for Travel'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_TRAVEL_ROOT_INCH_U
  provider contract transactional_query
  as projection on ZI_TRAVEL_ROOT_INCH_U as travel
{
   
   key TravelId,
   
   @Consumption.valueHelpDefinition: [{ entity:{ name: '/DMO/I_Agency', element:'AgencyID'} }]
   @ObjectModel.text.element:['AgencyName']
   @Search.defaultSearchElement: true
   AgencyId,
   _Agency.Name as AgencyName,
   
   @Consumption.valueHelpDefinition: [{ entity: { name:'/DMO/I_Customer', element: 'CustomerID'}}]
   @Search.defaultSearchElement: true
   @ObjectModel.text.element: ['Name']
   CustomerId,
   _Customer.FirstName as Name,
   
   BeginDate,
   
   EndDate,
   
   BookingFee,
   
   TotalPrice,
   
   @Consumption.valueHelpDefinition: [{ entity:{ name:'I_Currency', element:'Currency' }}]
   CurrencyCode,  
   
   @Consumption.valueHelpDefinition: [{ entity:{ name:'/DMO/I_Overall_Status_VH', element:'' }}]
   @ObjectModel.text.element: ['Text']
   OverAllStatus,
   _Status._Text.Text as Text : localized,
   
   LastChangedAt,
   
   _Booking : redirected to composition child ZC_BOOKING_INCH_U,
   _Customer,
   _Agency,
   _Currency,
   _Status
}  
