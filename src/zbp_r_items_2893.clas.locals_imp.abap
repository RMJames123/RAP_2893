CLASS lhc_items DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR items RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR items RESULT result.

    METHODS CalculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR items~CalculateTotalPrice.

    METHODS validatePrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR items~validatePrice.

    METHODS validateProducts FOR VALIDATE ON SAVE
      IMPORTING keys FOR items~validateProducts.

ENDCLASS.

CLASS lhc_items IMPLEMENTATION.

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

ENDCLASS.
