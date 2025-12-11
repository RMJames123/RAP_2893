CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

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
  ENDMETHOD.

  METHOD rejectOrder.
  ENDMETHOD.

  METHOD Resume.
  ENDMETHOD.

  METHOD setOrderStatus.
  ENDMETHOD.

  METHOD setOrderNumber.
  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

ENDCLASS.
