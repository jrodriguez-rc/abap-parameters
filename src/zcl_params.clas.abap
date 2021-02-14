CLASS zcl_params DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC

  GLOBAL FRIENDS zcl_params_management.

  PUBLIC SECTION.

    INTERFACES zif_params
      ABSTRACT METHODS get_img_subobject get_description.

  PROTECTED SECTION.
    CLASS-METHODS fill_params
      IMPORTING
        !iv_clsname TYPE seoclsname.

  PRIVATE SECTION.
    TYPES:
      tt_params TYPE STANDARD TABLE OF zparams WITH KEY clsname cmpname.

    CLASS-METHODS read_params
      IMPORTING
        iv_class         TYPE seoclsname
      RETURNING
        VALUE(rt_params) TYPE tt_params.

ENDCLASS.



CLASS zcl_params IMPLEMENTATION.


  METHOD fill_params.

    TRY.
        DATA(lo_class) = cl_oo_class=>get_instance( iv_clsname ).
      CATCH cx_class_not_existent. " Class Does Not Exist
        CLEAR: lo_class.
    ENDTRY.

    IF lo_class IS NOT BOUND.
      RETURN.
    ENDIF.

    DATA(lt_attr) = lo_class->get_attributes( public_attributes_only = seox_true ).

    DELETE lt_attr WHERE typtype <> seoo_typtype_type.
    DELETE lt_attr WHERE attdecltyp <> seoo_attdecltyp_statics.

    IF lt_attr IS INITIAL.
      RETURN.
    ENDIF.

    DATA(lt_param) = read_params( iv_clsname ).

    LOOP AT lt_attr INTO DATA(ls_attr).

      READ TABLE lt_param INTO DATA(ls_param) WITH KEY clsname = ls_attr-clsname cmpname = ls_attr-cmpname.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      DATA(lv_reference) = |{ ls_attr-clsname }=>{ ls_attr-cmpname }|.
      ASSIGN (lv_reference) TO FIELD-SYMBOL(<lg_param>).
      IF sy-subrc <> 0 OR <lg_param> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.

      TRY.
          <lg_param> = ls_param-value.
        CATCH cx_root.
          UNASSIGN <lg_param>.
          CONTINUE.
      ENDTRY.

      UNASSIGN <lg_param>.

    ENDLOOP.

  ENDMETHOD.


  METHOD read_params.

    SELECT *
      INTO TABLE @rt_params
      FROM zparams
      WHERE clsname = @iv_class.
    IF sy-subrc <> 0.
      CLEAR: rt_params.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
