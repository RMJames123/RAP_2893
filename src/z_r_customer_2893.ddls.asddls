@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer - View Entity'

@Search.searchable: true

define view entity Z_R_CUSTOMER_2893
  as select from zcustomer_2893

{

      @Search.defaultSearchElement: true
  key email     as Email,

      @Search.defaultSearchElement: true
      firstname as Firstname,
      
      @Search.defaultSearchElement: true
      lastname  as Lastname,

     @Search.defaultSearchElement: true
      country   as Country,

     @Search.defaultSearchElement: true
      imageurl  as Imageurl
}
