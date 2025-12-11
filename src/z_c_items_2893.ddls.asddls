@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@Search.searchable: true

define view entity Z_C_ITEMS_2893
  as projection on Z_R_ITEMS_2893
{
  key ItemUuid,
      HeaderUuid,
      Id,
      
      @Search.defaultSearchElement: true
      Name,
      Description,
      Releasedate,
      Discontinueddate,
      Price,
      
      @Semantics.quantity.unitOfMeasure: 'Unitofmeasure'
      Height,
      
      @Semantics.quantity.unitOfMeasure: 'Unitofmeasure'
      Width,
      Depth,
      Quantity,
      Unitofmeasure,
      
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      /* Associations */
      _Header : redirected to parent Z_C_HEADER_2893,
      _Products
}
