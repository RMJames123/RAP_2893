@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity Z_C_HEADER_2893
  provider contract transactional_query
  as projection on Z_R_HEADER_2893
{
  key     HeaderUuid,

          @Search.defaultSearchElement: true
          Id,

          @Search.defaultSearchElement: true
          @ObjectModel.text.element: [ 'Email' ]
          @Consumption.valueHelpDefinition: [{ entity: { name: 'Z_I_Customer_2893',
                                                         element: 'Email'},
                                               additionalBinding: [{ localElement: 'Firstname',
                                                                     element: 'Firstname',
                                                                     usage: #RESULT  }, 
                                                                   { localElement: 'Lastname',
                                                                     element: 'Lastname',
                                                                     usage: #RESULT  },
                                                                   { localElement: 'Country',
                                                                     element: 'Country',
                                                                     usage: #RESULT  },
                                                                   { localElement: 'Imageurl',
                                                                     element: 'Imageurl',
                                                                     usage: #RESULT  }                                                                     
                                                                     ],
                                               useForValidation: true }]


          Email,
          Firstname,
          Lastname,
          Country,
          Createon,
          Deliverydate,
          Orderstatus,
          Imageurl,

          @EndUserText.label: 'Total Order'
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_TOTALPRICE_2893'
  virtual TotalPrice : zde_price_2893,

          @Semantics.systemDateTime.localInstanceLastChangedAt: true
          LocalLastChangedAt,

          @Semantics.systemDateTime.lastChangedAt: true
          LastChangedAt,

          /* Associations */
          _Customer,
          _Items : redirected to composition child Z_C_ITEMS_2893
}
