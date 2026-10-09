CLASS lhc__Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
       entities FOR UPDATE _Booking.

    METHODS delete FOR MODIFY
       keys FOR DELETE _Booking.

    METHODS read FOR READ
       keys FOR READ _Booking RESULT result.

    METHODS rba_Travel FOR READ
       keys_rba FOR READ _Booking\_Travel FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc__Booking IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Travel.
  ENDMETHOD.

ENDCLASS.
