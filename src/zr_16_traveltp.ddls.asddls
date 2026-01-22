@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel Restricted'



define root view entity ZR_16_TravelTP
  as select from ZI_16_Travel
  
  association [1..1] to ZI_16_CustomerText as _CustomerText on $projection.CustomerId = _CustomerText.CustomerId

  composition [0..*] of ZR_16_BookingTP as _Bookings

{
  key TravelId,

      AgencyId,
      @ObjectModel.text.element: [ 'CustomerName' ]
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
      
      // Transient Data also daten die nur während der Laufzeit existieren
      case Status when 'X' then 1
                  when 'P' then 2
                  when 'B' then 3
                  else 0 end as StatusCriticality,
                  
       _CustomerText.CustomerName as CustomerName,
      

      // Association
      _Bookings
}
