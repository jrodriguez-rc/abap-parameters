FUNCTION zparams_db_update.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TCODE) TYPE  CDHDR-TCODE DEFAULT SY-UCOMM
*"     VALUE(IV_UTIME) TYPE  CDHDR-UTIME DEFAULT SY-UZEIT
*"     VALUE(IV_UDATE) TYPE  CDHDR-UDATE DEFAULT SY-DATUM
*"     VALUE(IV_USERNAME) TYPE  CDHDR-USERNAME DEFAULT SY-UNAME
*"     VALUE(IT_DATA) TYPE  ZPARAMS_T_UPDATE
*"     VALUE(IT_DATA_OLD) TYPE  ZPARAMS_T_UPDATE
*"----------------------------------------------------------------------
  TYPES:
    BEGIN OF ty_writedoc,
      clsname  TYPE seoclname,
      data     TYPE zparams_wd_zparamss,
      data_old TYPE zparams_wd_zparamss,
    END OF ty_writedoc,
    ty_writedocs TYPE STANDARD TABLE OF ty_writedoc WITH KEY clsname.

  DATA:
    ls_parameter_db TYPE zparams,
    lt_writedoc     TYPE ty_writedocs,
    ls_writedoc     TYPE zparams_wd_zparams.

  LOOP AT it_data INTO DATA(ls_data).
    CLEAR: ls_parameter_db.

    ls_parameter_db = CORRESPONDING #( ls_data ).
    ls_writedoc = CORRESPONDING #( ls_data ).

    CASE ls_data-crud_mode.
      WHEN zif_param_constants=>crud-create.
        ls_writedoc-kz = 'I'.
        INSERT zparams FROM ls_parameter_db.
        IF sy-subrc <> 0.
          MESSAGE ID zcx_params=>error_at_creation-msgid
                  TYPE 'A'
                  NUMBER zcx_params=>error_at_creation-msgno
                  WITH ls_parameter_db-clsname ls_parameter_db-cmpname.
        ENDIF.

      WHEN zif_param_constants=>crud-update.
        ls_writedoc-kz = 'U'.
        UPDATE zparams FROM ls_parameter_db.
        IF sy-subrc <> 0.
          MESSAGE ID zcx_params=>error_at_update-msgid
                  TYPE 'A'
                  NUMBER zcx_params=>error_at_update-msgno
                  WITH ls_parameter_db-clsname ls_parameter_db-cmpname.
        ENDIF.

      WHEN zif_param_constants=>crud-delete.
        ls_writedoc-kz = 'D'.
        DELETE FROM zparams WHERE clsname = ls_data-clsname
                                    AND cmpname = ls_data-cmpname.
        IF sy-subrc <> 0.
          MESSAGE ID zcx_params=>error_at_delete-msgid
                  TYPE 'A'
                  NUMBER zcx_params=>error_at_delete-msgno
                  WITH ls_parameter_db-clsname ls_parameter_db-cmpname.
        ENDIF.

    ENDCASE.

    READ TABLE lt_writedoc ASSIGNING FIELD-SYMBOL(<ls_writedoc>)
      WITH KEY clsname = ls_data-clsname.
    IF sy-subrc <> 0.
      INSERT INITIAL LINE INTO TABLE lt_writedoc ASSIGNING <ls_writedoc>.
      <ls_writedoc>-clsname = ls_data-clsname.
    ENDIF.

    INSERT ls_writedoc INTO TABLE <ls_writedoc>-data.

    READ TABLE it_data_old INTO DATA(ls_data_old)
      WITH KEY clsname = ls_data-clsname cmpname = ls_data-cmpname.
    IF sy-subrc <> 0.
      CONTINUE.
    ENDIF.

    ls_writedoc = CORRESPONDING #( ls_data_old ).
    INSERT ls_writedoc INTO TABLE <ls_writedoc>-data_old.

  ENDLOOP.

  LOOP AT lt_writedoc INTO DATA(ls_writedoc_class).
    CALL FUNCTION 'ZPARAMS_WRITE_DOCUMENT'
      EXPORTING
        objectid    = CONV cdobjectv( ls_writedoc_class-clsname )
        tcode       = iv_tcode
        utime       = iv_utime
        udate       = iv_udate
        username    = iv_username
        upd_zparams = 'U'
        xzparams    = ls_writedoc_class-data
        yzparams    = ls_writedoc_class-data_old.
  ENDLOOP.

ENDFUNCTION.