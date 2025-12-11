@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items - View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_R_ITEMS_2893
  as select from zitems_2893

  association        to parent Z_R_HEADER_2893 as _Header   on $projection.HeaderUuid = _Header.HeaderUuid

  association [0..1] to Z_R_PRODUCTS_2893      as _Products on $projection.Name = _Products.Name

{
  key item_uuid             as ItemUuid,
      header_uuid           as HeaderUuid,
      id                    as Id,
      name                  as Name,
      description           as Description,
      releasedate           as Releasedate,
      discontinueddate      as Discontinueddate,
      price                 as Price,

      @Semantics.quantity.unitOfMeasure: 'Unitofmeasure'
      height                as Height,

      @Semantics.quantity.unitOfMeasure: 'Unitofmeasure'
      width                 as Width,

      depth                 as Depth,
      quantity              as Quantity,
      unitofmeasure         as Unitofmeasure,

      //Local ETag field - OData
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Header,
      _Products
}
