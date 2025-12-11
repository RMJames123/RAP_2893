@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer - View Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z_R_CUSTOMER_2893
  as select from zcustomer_2893
  
{
  key email         as Email,
      firstname     as Firstname,
      lastname      as Lastname,
      country       as Country,
      imageurl      as Imageurl
}
