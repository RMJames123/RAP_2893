CLASS zcl_load_data_2893 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_load_data_2893 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    DATA: lt_header    TYPE TABLE OF zheader_2893,
          lt_items     TYPE TABLE OF zitems_2893,
          lt_customer  TYPE TABLE OF zcustomer_2893,
          lt_products  TYPE TABLE OF zproducts_2893,
          lt_orderstat TYPE TABLE OF zorderstat_2893.


    DATA(lv_header_uuid) = cl_system_uuid=>create_uuid_x16_static(  ).

    lt_header = VALUE #(
     (
     header_uuid = lv_header_uuid
     id = 1
     email = 'RM.JAMES@HOTMAIL.COM'
     firstname = 'Raul'
     lastname = 'Jaramillo'
     country = 'Argentina'
     createon = '20251209'
     deliverydate = '20251209'
     orderstatus = 'Open'
     imageurl = 'https://rauljaramillo.neylify.app'
     )
     ).

    DELETE FROM zheader_2893.
    INSERT zheader_2893 FROM TABLE @lt_header.

    lt_items = VALUE #(
    (
 item_uuid = cl_system_uuid=>create_uuid_x16_static(  )
 header_uuid = lv_header_uuid
 id = 1
 name = 'NOTEBOOK DELL INSPIRON GAMER 1'
 description = 'i9 64GB DDR5 2TB SSD GTX 4050 15IN'
 releasedate = '20250101'
 discontinueddate = '20270101'
 price = 4500
 height = 15
 width = 20
 depth = 2
 quantity = 10
 unitofmeasure = 'IN'
  )
    (
 item_uuid = cl_system_uuid=>create_uuid_x16_static(  )
 header_uuid = lv_header_uuid
 id = 2
 name = 'NOTEBOOK DELL INSPIRON GAMER 2'
 description = 'i9 64GB DDR5 2TB SSD GTX 5030 15IN'
 releasedate = '20250101'
 discontinueddate = '20280101'
 price = 5500
 height = 15
 width = 20
 depth = 2
 quantity = 10
 unitofmeasure = 'IN'
  )

  ).

    DELETE FROM zitems_2893.
    INSERT zitems_2893 FROM TABLE @lt_items.

    lt_customer = VALUE #(
    (
    email = 'RM.JAMES@HOTMAIL.COM'
    firstname = 'Raúl'
    lastname = 'Jaramillo'
    country = 'Argentina'
    imageurl = 'https://rauljaramillo.netlify.app'
     )
    (
    email = 'MERLY_8181@HOTMAIL.COM'
    firstname = 'Merly'
    lastname = 'Sanchez'
    country = 'Argentina'
    imageurl = 'https://rauljaramillo.netlify.app'
     )
    (
    email = 'ALEJANDRAJS@HOTMAIL.COM'
    firstname = 'Alejandra'
    lastname = 'Jaramillo'
    country = 'Argentina'
    imageurl = 'https://rauljaramillo.netlify.app'
     )
    (
    email = 'PIEROJS@HOTMAIL.COM'
    firstname = 'Piero'
    lastname = 'Jaramillo'
    country = 'Argentina'
    imageurl = 'https://rauljaramillo.netlify.app'
     )
    (
    email = 'JESUSJS@HOTMAIL.COM'
    firstname = 'Jesús'
    lastname = 'Jaramillo'
    country = 'Argentina'
    imageurl = 'https://rauljaramillo.netlify.app'
     )

     ).

    DELETE FROM zcustomer_2893.
    INSERT zcustomer_2893 FROM TABLE @lt_customer.


    lt_products = VALUE #(
    (
     name = 'NOTEBOOK DELL INSPIRON GAMER 1'
     description = 'i9 64GB DDR5 2TB SSD GTX 4050 15IN'
     releasedate = '20250101'
     discontinueddate = '20270101'
     price = 4500
     height = 15
     width = 20
     depth = 2
     unitofmeasure = 'IN'
    )
    (
     name = 'NOTEBOOK DELL INSPIRON GAMER 2'
     description = 'i9 64GB DDR5 2TB SSD GTX 5030 15IN'
     releasedate = '20250101'
     discontinueddate = '20270101'
     price = 5800
     height = 15
     width = 20
     depth = 2
     unitofmeasure = 'IN'
    )

    ).

    DELETE FROM zproducts_2893.
    INSERT zproducts_2893 FROM TABLE @lt_products.

    lt_orderstat = VALUE #(

    ( id = 'Open' description = 'Open Order' )
    ( id = 'Accept' description = 'Order Accepted' )
    ( id = 'Reject' description = 'Order Rejected' )
     ).

    DELETE FROM zorderstat_2893.
    INSERT zorderstat_2893 FROM TABLE @lt_orderstat.

  ENDMETHOD.


ENDCLASS.
