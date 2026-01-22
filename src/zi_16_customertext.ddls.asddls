@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'View für Textelement'

define view entity ZI_16_CustomerText
  as select from /dmo/customer

{
  key customer_id                                                                       as CustomerId,

      @EndUserText.label: 'Customer Name'
      @EndUserText.quickInfo: 'Customer Name'
      case when title is initial then concat_with_space(first_name, last_name, 1)
      else concat_with_space(concat_with_space(title, first_name, 1), last_name, 1) end as CustomerName
}
