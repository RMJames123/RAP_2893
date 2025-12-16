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

   READ ENTITIES OF Z_R_HEADER_2893 IN LOCAL MODE
       ENTITY Header
       FIELDS ( OrderStatus )
       WITH CORRESPONDING #( keys )
       RESULT DATA(headers)
       FAILED failed.

    result  = VALUE #( FOR header IN headers ( %tky = header-%tky
                                               %field-Email = COND #( WHEN header-OrderStatus = order_status-accepted
                                                                           THEN if_abap_behv=>fc-f-read_only
                                                                           ELSE if_abap_behv=>fc-f-unrestricted )
                                               %action-acceptOrder = COND #( WHEN header-OrderStatus = order_status-accepted
                                                                           THEN if_abap_behv=>fc-o-disabled
                                                                           ELSE if_abap_behv=>fc-o-enabled )
                                                %action-rejectOrder =  COND #( WHEN header-OrderStatus = order_status-rejected
                                                                           THEN if_abap_behv=>fc-o-disabled
                                                                           ELSE if_abap_behv=>fc-o-enabled )
                                                %assoc-_Items =  COND #( WHEN header-OrderStatus = order_status-rejected
                                                                           THEN if_abap_behv=>fc-o-disabled
                                                                           ELSE if_abap_behv=>fc-o-enabled ) ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.

    DATA: update_requested TYPE abap_bool,
          delete_requested TYPE abap_bool,
          update_granted   TYPE abap_bool,
          delete_granted   TYPE abap_bool.

    READ ENTITIES OF z_r_header_2893 IN LOCAL MODE
      ENTITY Header
        FIELDS ( Email )
        WITH CORRESPONDING #( keys )
        RESULT DATA(headers)
        FAILED failed.

    CHECK headers IS NOT INITIAL.

    "Decide business check
    DATA(lv_technical_user) = cl_abap_context_info=>get_user_technical_name(  ).

    update_requested = COND #( WHEN requested_authorizations-%update      = if_abap_behv=>mk-on
                                 OR requested_authorizations-%action-Edit = if_abap_behv=>mk-on
                               THEN abap_true ELSE abap_false ).

    delete_requested = COND #( WHEN requested_authorizations-%delete      = if_abap_behv=>mk-on
                               THEN abap_true ELSE abap_false ).


    LOOP AT headers INTO DATA(header).

      IF header-Email IS NOT INITIAL.

        "Business check
        IF lv_technical_user EQ 'CB9980002893' AND header-Email NE '70021'. "WHAT EVER.
          update_granted = delete_granted = abap_true.
*          delete_granted = abap_true.
        ELSE.
          update_granted = delete_granted = abap_false.
*           = abap_false.
        ENDIF.

        "check for update
        IF update_requested = abap_true.

          IF update_granted = abap_false.
            APPEND VALUE #( %tky = header-%tky
                            %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text = 'Invalid Email for Update!'
                                   )
                            %element-Email = if_abap_behv=>mk-on
                           ) TO reported-header.
          ENDIF.
        ENDIF.

        "check for delete
        IF delete_requested = abap_true.

          IF delete_granted = abap_false.
            APPEND VALUE #( %tky = header-%tky
                            %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text = 'Invalid Email for Delete!'
                                   )
                            %element-Email = if_abap_behv=>mk-on
                           ) TO reported-header.
          ENDIF.
        ENDIF.

        " operations on draft instances and on active instances
        " new created instances
      ELSE.
        update_granted = delete_granted = abap_true. "REPLACE ME WITH BUSINESS CHECK
        IF update_granted = abap_false.
          APPEND VALUE #( %tky = header-%tky
                            %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text = 'Invalid Email for Update/Delete!'
                                   )
                          %element-Email = if_abap_behv=>mk-on
                        ) TO reported-header.
        ENDIF.
      ENDIF.

*      data(upd_auth) = cond #( when update_granted = abap_true
*                               then if_abap_behv=>auth-allowed
*                               else if_abap_behv=>auth-unauthorized ).
*
*      data(del_auth) = cond #( when delete_granted = abap_true
*                               then if_abap_behv=>auth-allowed
*                               else if_abap_behv=>auth-unauthorized ).


      APPEND VALUE #(
                      LET upd_auth = COND #( WHEN update_granted = abap_true
                                             THEN if_abap_behv=>auth-allowed
                                             ELSE if_abap_behv=>auth-unauthorized )
                          del_auth = COND #( WHEN delete_granted = abap_true
                                             THEN if_abap_behv=>auth-allowed
                                             ELSE if_abap_behv=>auth-unauthorized )
                      IN
                       %tky = header-%tky
                       %update                = upd_auth
                       %action-Edit           = del_auth

                       %delete                = del_auth
                    ) TO result.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_global_authorizations.

    DATA(lv_technical_user) = cl_abap_context_info=>get_user_technical_name(  ).

    "lv_technical_user = 'ANOTHER'.

    IF requested_authorizations-%create EQ if_abap_behv=>mk-on.

      IF lv_technical_user EQ 'CB9980002893'.
        result-%create = if_abap_behv=>auth-allowed.
      ELSE.
        result-%create = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #(
                            %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text = 'User not authorized!'
                                   )
                        %global = if_abap_behv=>mk-on ) TO reported-header.
      ENDIF.
    ENDIF.

    IF requested_authorizations-%update      EQ if_abap_behv=>mk-on OR
       requested_authorizations-%action-Edit EQ if_abap_behv=>mk-on.

      IF lv_technical_user EQ 'CB9980002893'.
        result-%update = if_abap_behv=>auth-allowed.
        result-%action-Edit = if_abap_behv=>auth-allowed.
      ELSE.
        result-%update = if_abap_behv=>auth-unauthorized.
        result-%action-Edit = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #(
                            %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text = 'User not authorized!'
                                   )
                        %global = if_abap_behv=>mk-on ) TO reported-header.
      ENDIF.
    ENDIF.

    IF requested_authorizations-%delete EQ if_abap_behv=>mk-on.

      IF lv_technical_user EQ 'CB9980002893'.
        result-%delete = if_abap_behv=>auth-allowed.
      ELSE.
        result-%delete = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #(
                            %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text = 'User not authorized!'
                                   )
                        %global = if_abap_behv=>mk-on ) TO reported-header.
      ENDIF.
    ENDIF.

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

    DATA customers TYPE SORTED TABLE OF zcustomer_2893 WITH UNIQUE KEY client email.

    READ ENTITIES OF Z_R_HEADER_2893 IN LOCAL MODE
         ENTITY Header
         FIELDS ( Email )
         WITH CORRESPONDING #( keys )
         RESULT DATA(headers).

    customers = CORRESPONDING #( headers DISCARDING DUPLICATES MAPPING email = Email EXCEPT * ).

    IF customers IS NOT INITIAL.
      SELECT FROM zcustomer_2893 AS ddbb
             INNER JOIN @customers AS http_req ON ddbb~email EQ http_req~email
             FIELDS ddbb~email
             INTO TABLE @DATA(valid_customers).
    ENDIF.

    LOOP AT headers INTO DATA(header).

      IF header-Email IS INITIAL.

        APPEND VALUE #( %tky = header-%tky ) TO failed-header.

        APPEND VALUE #( %tky                = header-%tky
                        %state_area         = 'VALIDATE_CUSTOMER'
                        %element-Email = if_abap_behv=>mk-on ) TO reported-header.

      ELSEIF header-Email IS NOT INITIAL AND NOT line_exists( valid_customers[ email = header-Email ] ).

        APPEND VALUE #( %tky = header-%tky ) TO failed-header.

        APPEND VALUE #( %tky                = header-%tky
                        %state_area         = 'VALIDATE_CUSTOMER'
                        %element-Email = if_abap_behv=>mk-on ) TO reported-header.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
