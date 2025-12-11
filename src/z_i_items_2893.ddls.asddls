@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z_I_ITEMS_2893
  as projection on Z_R_ITEMS_2893
{
  key ItemUuid,
      HeaderUuid,
      Id,
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
      /* Associations */
      _Header : redirected to parent Z_I_HEADER_2893,
      _Products
}
