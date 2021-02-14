FUNCTION zparams_manage.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_FILTER_PACKAGE) TYPE  DEVCLASS OPTIONAL
*"     REFERENCE(IV_FILTER_CLASS) TYPE  SEOCLSNAME OPTIONAL
*"----------------------------------------------------------------------
  CLEAR: go_prc, gv_ucomm_0100.

  TRY.
      go_prc = NEW zcl_params_management( iv_filter_package = iv_filter_package
                                          iv_filter_class   = iv_filter_class ).

      CALL SCREEN 0100.

      go_prc->destroy( ).
      CLEAR: go_prc.

    CATCH zcx_params INTO DATA(lx_exception).
      MESSAGE lx_exception TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.

ENDFUNCTION.
