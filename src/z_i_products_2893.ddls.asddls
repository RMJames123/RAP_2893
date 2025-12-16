@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Products - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true

@Search.searchable: true

define view entity Z_I_PRODUCTS_2893
  as select from Z_R_PRODUCTS_2893
{

      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 10, importance: #HIGH }]
  key Name,

      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 20, importance: #HIGH }]
      Description,

      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 30, importance: #HIGH }]
      Releasedate,

      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 40, importance: #HIGH }]
      Discontinueddate,

      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 50, importance: #HIGH }]
      Price,

      @Search.defaultSearchElement: true
      @Semantics.quantity.unitOfMeasure: 'Unitofmeasure'
      @UI.lineItem: [{ position: 60, importance: #HIGH }]
      Height,

      @Search.defaultSearchElement: true
      @Semantics.quantity.unitOfMeasure: 'Unitofmeasure'
      @UI.lineItem: [{ position: 70, importance: #HIGH }]
      Width,

      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 80, importance: #HIGH }]
      Depth,

      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 90, importance: #HIGH }]
      Unitofmeasure
}
