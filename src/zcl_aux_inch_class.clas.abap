CLASS zcl_aux_inch_class DEFINITION
  PUBLIC
 "" INHERITING FROM cl_abap_behv
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.

      CLASS-methods:
        get_cause_from_message
             importing
                msgid  TYPE symsgid
                msgno  type symsgno
                is_dependent type abap_bool default abap_true
             returning
                value(fail_cause) type if_abap_behv=>t_fail_cause.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aux_inch_class IMPLEMENTATION.

   method get_cause_from_message.
       fail_cause = if_abap_behv=>cause-unspecific.

       if msgid = '/DMO/CM_FLIGHT_LEGAC'.

         CASE msgno.
             WHEN '009'
                 OR '016'
                 OR '017'.
                IF is_dependent = abap_true.
                   fail_cause = if_abap_behv=>cause-dependency.
                else.
                   fail_cause = if_abap_behv=>cause-not_found.
                endif.
             WHEN '032'.
                fail_cause = if_abap_behv=>cause-locked.
             WHEN '046'.
                fail_cause = if_abap_behv=>cause-unauthorized.
         ENDCASE.
       ENDIF.
   endmethod.

ENDCLASS.
