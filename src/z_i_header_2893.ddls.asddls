@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header - Inteface Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_I_HEADER_2893
  provider contract transactional_interface
  as projection on Z_R_HEADER_2893
{
  key HeaderUuid,
      Id,
      Email,
      Firstname,
      Lastname,
      Country,
      Createon,
      Deliverydate,
      Orderstatus,
      Imageurl,
      /* Associations */
      _Customer,
      _Items : redirected to composition child Z_I_ITEMS_2893
}
