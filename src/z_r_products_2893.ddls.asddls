@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Products - View Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z_R_PRODUCTS_2893
  as select from zproducts_2893
{
  key name             as Name,
      description      as Description,
      releasedate      as Releasedate,
      discontinueddate as Discontinueddate,
      price            as Price,

      @Semantics.quantity.unitOfMeasure: 'Unitofmeasure'
      height           as Height,

      @Semantics.quantity.unitOfMeasure: 'Unitofmeasure'
      width            as Width,
      
      depth            as Depth,
      unitofmeasure    as Unitofmeasure
}
