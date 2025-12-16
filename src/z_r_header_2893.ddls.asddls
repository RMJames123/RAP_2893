@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_R_HEADER_2893
  as select from zheader_2893

  composition [1..*] of Z_R_ITEMS_2893    as _Items

  association [0..1] to Z_R_CUSTOMER_2893 as _Customer on $projection.Email = _Customer.Email

{
  key header_uuid           as HeaderUuid,
      id                    as Id,
      email                 as Email,
      firstname             as Firstname,
      lastname              as Lastname,
      country               as Country,
      createon              as Createon,
      deliverydate          as Deliverydate,
      orderstatus           as Orderstatus,
      imageurl              as Imageurl,
      
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,

      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,

      //Local ETag field - OData
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      //Total ETag
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      _Items,
      _Customer

}
