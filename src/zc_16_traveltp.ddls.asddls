@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel Consumption View'

@Metadata.allowExtensions: true

@Search.searchable: true

define root view entity ZC_16_TravelTP
  provider contract transactional_query
  as projection on ZR_16_TravelTP

{
  key TravelId,

      @Consumption.valueHelpDefinition: [ { entity: { name: '/dmo/I_Agency_StdVH', element: 'AgencyID' } }]

      AgencyId,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_16_CustomerVH', element: 'CustomerId' } } ]
      CustomerId,

      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CurrencyStdVH', element: 'Currency' } } ]

      CurrencyCode,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Description,

      Status,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      // Transient Data
      StatusCriticality,
      CustomerName,

      // Association
      _Bookings : redirected to composition child ZC_16_BOOKINGTP
}
