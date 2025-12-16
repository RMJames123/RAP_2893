@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true

@Search.searchable: true

define view entity Z_I_CUSTOMER_2893
  as select from Z_R_CUSTOMER_2893
{

      @UI.lineItem: [{ position: 10, importance: #HIGH }]
  key Email,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.lineItem: [{ position: 20, importance: #HIGH }]

      Firstname,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.lineItem: [{ position: 30, importance: #HIGH }]
      Lastname,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.lineItem: [{ position: 40, importance: #HIGH }]
      Country,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.hidden: true
      Imageurl
}
