CLASS zcl_totalprice_2893 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_totalprice_2893 IMPLEMENTATION.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    CASE iv_entity.

      WHEN 'Z_C_ITEMS_2893'.

        INSERT CONV #( 'PRICE' ) INTO TABLE et_requested_orig_elements.
        INSERT CONV #( 'QUANTITY' ) INTO TABLE et_requested_orig_elements.

    ENDCASE.

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA: lt_header_data TYPE STANDARD TABLE OF z_c_header_2893 WITH DEFAULT KEY.

    lt_header_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_header_data ASSIGNING FIELD-SYMBOL(<fs_header_data>).
      <fs_header_data>-TotalPrice = 0.

      READ ENTITY z_r_header_2893
       BY \_Items
       FIELDS ( Price Quantity )
       WITH VALUE #( (  %key-HeaderUuid = <fs_header_data>-HeaderUuid ) )
      RESULT DATA(items).

      LOOP AT items ASSIGNING FIELD-SYMBOL(<fs_items>).
        <fs_header_data>-TotalPrice = <fs_header_data>-TotalPrice + <fs_items>-Price * <fs_items>-Quantity.
      ENDLOOP.

    ENDLOOP.


    ct_calculated_data = CORRESPONDING #( lt_header_data ).

  ENDMETHOD.



ENDCLASS.
