CLASS lhc__Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      keys REQUEST requested_features FOR _Travel RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR _Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR _Travel RESULT result.

    METHODS create FOR MODIFY
       entities FOR CREATE _Travel.

    METHODS update FOR MODIFY
       entities FOR UPDATE _Travel.

    METHODS delete FOR MODIFY
       keys FOR DELETE _Travel.

    METHODS read FOR READ
       keys FOR READ _Travel RESULT result.

    METHODS lock FOR LOCK
       keys FOR LOCK _Travel.

    METHODS rba_Booking FOR READ
       keys_rba FOR READ _Travel\_Booking FULL result_requested RESULT result LINK association_links.

    METHODS cba_Booking FOR MODIFY
       entities_cba FOR CREATE _Travel\_Booking.

    TYPES: tt_failed   TYPE TABLE FOR FAILED EARLY zi_travel_root_inch_u\\_travel,
           tt_reported TYPE TABLE FOR REPORTED EARLY zi_travel_root_inch_u\\_travel.

    METHODS map_messages
      IMPORTING
        cid          TYPE abp_behv_cid
        messages     TYPE /dmo/t_message
      EXPORTING
        failed_added TYPE abap_bool
      CHANGING
        failed       TYPE tt_failed
        reported     TYPE tt_reported.

ENDCLASS.

CLASS lhc__Travel IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA: ls_travel       TYPE /dmo/travel,
          ls_travel_out   TYPE /dmo/travel,
          lt_messages     TYPE /dmo/t_message,
          lv_failed_added TYPE abap_bool.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entities>).

      ls_travel = CORRESPONDING #( <lfs_entities> MAPPING FROM ENTITY USING CONTROL ).

      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_CREATE'
        EXPORTING
          is_travel         = CORRESPONDING /dmo/s_travel_in( ls_travel )
*         it_booking        =
*         it_booking_supplement =
          iv_numbering_mode = /dmo/if_flight_legacy=>numbering_mode-late
        IMPORTING
          es_travel         = ls_travel_out
*         et_booking        =
*         et_booking_supplement =
          et_messages       = lt_messages.

      map_messages(
         EXPORTING
            cid = <lfs_entities>-%cid
            messages = lt_messages
         IMPORTING
            failed_added = lv_failed_added
         CHANGING
            failed = failed-_travel
            reported = reported-_travel
      ).

      IF lv_failed_added = abap_false.

        INSERT VALUE #( %cid = <lfs_entities>-%cid
                        travelid = <lfs_entities>-TravelId
                       ) INTO TABLE mapped-_travel.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Booking.
  ENDMETHOD.

  METHOD cba_Booking.
  ENDMETHOD.


  METHOD map_messages.

    failed_added = abap_false.

    LOOP AT messages INTO DATA(ls_messages).

      IF ls_messages-msgty = 'E' OR ls_messages-msgty = 'O'.

        APPEND VALUE #( %cid = cid
                        %fail-cause = zcl_aux_inch_class=>get_cause_from_message(
                                        msgid        = ls_messages-msgid
                                        msgno        = ls_messages-msgno
*                                               is_dependent = abap_true
                                      )
                        ) TO failed.

        failed_added = abap_true.

        reported = VALUE #( ( %cid = cid
                              %msg = new_message(
                                         id = ls_messages-msgid
                                         number = ls_messages-msgno
                                         severity = if_abap_behv_message=>severity-error
                                         v1 = ls_messages-msgv1
                                         v2 = ls_messages-msgv2
                                         v3 = ls_messages-msgv3
                                         v4 = ls_messages-msgv4
                                     )
                             ) ).

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_TRAVEL_ROOT_INCH_U DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS adjust_numbers REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_TRAVEL_ROOT_INCH_U IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD adjust_numbers.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
