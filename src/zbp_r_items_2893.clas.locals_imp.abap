CLASS lhc_Items DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Items RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Items RESULT result.

    METHODS CalculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Items~CalculateTotalPrice.

    METHODS validatePrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR Items~validatePrice.

    METHODS validateProducts FOR VALIDATE ON SAVE
      IMPORTING keys FOR Items~validateProducts.

    METHODS setItemNumber FOR DETERMINE ON SAVE
      IMPORTING keys FOR Items~setItemNumber.

ENDCLASS.

CLASS lhc_Items IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CalculateTotalPrice.
  ENDMETHOD.

  METHOD validatePrice.
  ENDMETHOD.

  METHOD validateProducts.
  ENDMETHOD.

  METHOD setItemNumber.

    READ ENTITIES OF z_r_header_2893 IN LOCAL MODE
         ENTITY Items BY \_Header
         FIELDS ( HeaderUuid )
         WITH CORRESPONDING #( keys )
         RESULT DATA(headers).

    LOOP AT headers INTO DATA(header).

      SELECT SINGLE FROM zitems_2893
             FIELDS MAX( id )
             WHERE header_uuid = @header-HeaderUuid
             INTO @DATA(lv_max_id).

      READ ENTITIES OF z_r_header_2893 IN LOCAL MODE
           ENTITY Header BY \_Items
           FIELDS ( Id )
           WITH VALUE #( ( %tky = header-%tky ) )
           RESULT DATA(items).

      DELETE items WHERE Id IS NOT INITIAL.

      MODIFY ENTITIES OF Z_r_header_2893 IN LOCAL MODE
         ENTITY Items
         UPDATE
         FIELDS ( Id )
         WITH VALUE #( FOR item IN items INDEX INTO i ( %tky = item-%tky
                                                        Id   = lv_max_id + i )  ).
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
