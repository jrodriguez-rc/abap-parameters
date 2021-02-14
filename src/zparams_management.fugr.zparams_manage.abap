FUNCTION zparams_manage.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_FILTER_PACKAGE) TYPE  DEVCLASS OPTIONAL
*"     REFERENCE(IV_FILTER_CLASS) TYPE  SEOCLSNAME OPTIONAL
*"----------------------------------------------------------------------

  DATA:
    lx_exception TYPE REF TO zcx_params.

  CLEAR: go_prc, gv_ucomm_0100.

  TRY.
      CREATE OBJECT go_prc
        EXPORTING
          iv_filter_package = iv_filter_package
          iv_filter_class   = iv_filter_class.

      CALL SCREEN 0100.

      go_prc->destroy( ).
      CLEAR: go_prc.

    CATCH zcx_params INTO lx_exception.
      MESSAGE lx_exception TYPE 'E' DISPLAY LIKE 'S'.
  ENDTRY.

ENDFUNCTION.