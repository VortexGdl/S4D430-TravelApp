CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS ValidateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~ValidateCustomer.
    METHODS DeterminStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR Travel~DeterminStatus.
    METHODS CancelTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~CancelTravel. " RESULT result.

ENDCLASS.


CLASS lhc_Travel IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ValidateCustomer.
    " Wir benutzen Entity Manipulatipn Language
    DATA travels TYPE TABLE FOR READ RESULT ZR_16_TravelTP.

    " Read Travels
    READ ENTITIES OF ZR_16_TravelTP IN LOCAL MODE
         ENTITY Travel
         FIELDS ( CustomerID )
         WITH CORRESPONDING #( keys )
         RESULT travels.

    " process Travels
    LOOP AT travels INTO DATA(travel).

      " Validate Customer and Create Error Message
      SELECT SINGLE FROM /dmo/customer
        FIELDS @abap_true
        WHERE customer_id = @travel-customerId
        INTO @DATA(exists).

      IF exists IS INITIAL.
        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
        DATA(message) = NEW zcm_00_travel( textid      = zcm_00_travel=>no_customer_found
                                           customer_id = travel-CustomerId
                                           severity    = if_abap_behv_message=>severity-error ).

        APPEND VALUE #( %tky                = travel-%tky
                        %msg                = message
                        %element-CustomerId = if_abap_behv=>mk-on ) TO reported-travel.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD DeterminStatus.
    DATA travels TYPE TABLE FOR UPDATE zr_16_traveltp.

    LOOP AT keys INTO DATA(key).
      APPEND VALUE #( %tky   = key-%tky
                      Status = 'N' ) TO travels.
    ENDLOOP.

    MODIFY ENTITIES OF zr_16_traveltp IN LOCAL MODE
           ENTITY Travel
           UPDATE
           FIELDS ( Status )
           WITH travels.
  ENDMETHOD.

  METHOD CancelTravel.
    DATA(message) = NEW zcm_00_travel( textid    = zcm_00_travel=>test_message
                                       user_name = sy-uname
                                       severity  = if_abap_behv_message=>severity-information ).

    APPEND message TO reported-%other.
  ENDMETHOD.
ENDCLASS.
