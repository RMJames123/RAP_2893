CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF order_status,
        open     TYPE c LENGTH 8 VALUE 'Open',
        accepted TYPE c LENGTH 8 VALUE 'Accepted',
        rejected TYPE c LENGTH 8 VALUE 'Rejected',
      END OF order_status.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS acceptOrder FOR MODIFY
      IMPORTING keys FOR ACTION Header~acceptOrder RESULT result.

    METHODS rejectOrder FOR MODIFY
      IMPORTING keys FOR ACTION Header~rejectOrder RESULT result.

    METHODS Resume FOR MODIFY
      IMPORTING keys FOR ACTION Header~Resume.

    METHODS setOrderStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Header~setOrderStatus.

    METHODS setOrderNumber FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~setOrderNumber.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~validateCustomer.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD acceptOrder.

    MODIFY ENTITIES OF z_r_header_2893 IN LOCAL MODE
         ENTITY Header
         UPDATE
         FIELDS ( Orderstatus )
         WITH VALUE #( FOR key IN keys ( %tky          = key-%tky
                                         Orderstatus = order_status-accepted )  ).

    READ ENTITIES OF z_r_header_2893 IN LOCAL MODE
         ENTITY Header
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(headers).

    result = VALUE #( FOR header IN headers (  %tky   = header-%tky
                                               %param = header ) ).

  ENDMETHOD.

  METHOD rejectOrder.

    MODIFY ENTITIES OF z_r_header_2893 IN LOCAL MODE
       ENTITY Header
       UPDATE
       FIELDS ( Orderstatus )
       WITH VALUE #( FOR key IN keys ( %tky          = key-%tky
                                       Orderstatus = order_status-rejected )  ).

    READ ENTITIES OF z_r_header_2893 IN LOCAL MODE
         ENTITY Header
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(headers).

    result = VALUE #( FOR header IN headers (  %tky   = header-%tky
                                               %param = header ) ).

  ENDMETHOD.

  METHOD Resume.
  ENDMETHOD.

  METHOD setOrderStatus.

    READ ENTITIES OF z_r_header_2893 IN LOCAL MODE
         ENTITY Header
         FIELDS ( Orderstatus )
         WITH CORRESPONDING #( keys )
         RESULT DATA(headers).

    DELETE headers WHERE Orderstatus IS NOT INITIAL.

    CHECK headers IS NOT INITIAL.

    MODIFY ENTITIES OF z_r_header_2893 IN LOCAL MODE
       ENTITY Header
       UPDATE
       FIELDS ( Orderstatus )
       WITH VALUE #( FOR header IN headers INDEX INTO i ( %tky        = header-%tky
                                                          Orderstatus = order_status-open )  ).

  ENDMETHOD.

  METHOD setOrderNumber.

    READ ENTITIES OF z_r_header_2893 IN LOCAL MODE
           ENTITY Header
           FIELDS ( Id )
           WITH CORRESPONDING #( keys )
           RESULT DATA(headers).

    DELETE headers WHERE Id IS NOT INITIAL.

    CHECK headers IS NOT INITIAL.

    SELECT SINGLE FROM zheader_2893
           FIELDS MAX( id )
           INTO @DATA(lv_max_orderid).

    MODIFY ENTITIES OF z_r_header_2893 IN LOCAL MODE
       ENTITY Header
       UPDATE
       FIELDS ( Id )
       WITH VALUE #( FOR header IN headers INDEX INTO i ( %tky     = header-%tky
                                                          Id = lv_max_orderid + i )  ).

  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

ENDCLASS.
