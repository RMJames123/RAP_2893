@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_R_HEADER_2893
  as select from zheader_2893
  
  composition [1..*] of Z_R_ITEMS_2893 as _Items

{
  key header_uuid  as HeaderUuid,
      id           as Id,
      email        as Email,
      firstname    as Firstname,
      lastname     as Lastname,
      country      as Country,
      createon     as Createon,
      deliverydate as Deliverydate,
      orderstatus  as Orderstatus,
      imageurl     as Imageurl,
      
      _Items

}
