@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel Consumption View'

@Metadata.allowExtensions: true

@Search.searchable: true

define root view entity ZC_16_TravelTP
  as projection on ZR_16_TravelTP

{
  key TravelId,

      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,
      CurrencyCode,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Description,

      Status,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      
      //Association
      _Bookings : redirected to composition child ZC_16_BOOKINGTP
}
