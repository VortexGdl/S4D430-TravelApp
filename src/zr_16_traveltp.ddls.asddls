@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel Restricted'

define root view entity ZR_16_TravelTP
  as select from ZI_16_Travel

  composition [0..*] of ZR_16_BookingTP as _Bookings

{
  key TravelId,

      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,

      CurrencyCode,
      Description,
      Status,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      // Association
      _Bookings
}
