@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Booking Consumption View'

define view entity ZC_16_BOOKINGTP
  as projection on ZR_16_BookingTP

{
  key TravelId,
  key BookingId,

      BookingDate,
      CustomerId,
      CarrierId,
      ConnectionId,
      FlightDate,
      FlightPrice,
      CurrencyCode,
      /* Associations */
      _Travel : redirected to parent ZC_16_TravelTP
}
