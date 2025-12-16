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
      
      @Search.defaultSearchElement: true
      Id,
      
      @Search.defaultSearchElement: true
          @ObjectModel.text.element: [ 'Name' ]
          @Consumption.valueHelpDefinition: [{ entity: { name: 'Z_I_Products_2893',
                                                         element: 'Name'},
                                               additionalBinding: [{ localElement: 'Description',
                                                                     element: 'Description',
                                                                     usage: #RESULT  }, 
                                                                   { localElement: 'Releasedate',
                                                                     element: 'Releasedate',
                                                                     usage: #RESULT  },
                                                                   { localElement: 'Discontinueddate',
                                                                     element: 'Discontinueddate',
                                                                     usage: #RESULT  },
                                                                   { localElement: 'Price',
                                                                     element: 'Price',
                                                                     usage: #RESULT  },
                                                                   { localElement: 'Height',
                                                                     element: 'Height',
                                                                     usage: #RESULT  },
                                                                   { localElement: 'Width',
                                                                     element: 'Width',
                                                                     usage: #RESULT  },
                                                                   { localElement: 'Depth',
                                                                     element: 'Depth',
                                                                     usage: #RESULT  },
                                                                   { localElement: 'Unitofmeasure',
                                                                     element: 'Unitofmeasure',
                                                                     usage: #RESULT  }
                                                                     ],
                                               useForValidation: true }]

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
