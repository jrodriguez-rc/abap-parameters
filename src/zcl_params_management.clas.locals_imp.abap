CLASS lcl_messages_container IMPLEMENTATION.


  METHOD add_message.

    message_vars_prepare( EXPORTING ig_msgv1 = ig_msgv1
                                    ig_msgv2 = ig_msgv2
                                    ig_msgv3 = ig_msgv3
                                    ig_msgv4 = ig_msgv4
                          IMPORTING ev_msgv1 = DATA(lv_msgv1)
                                    ev_msgv2 = DATA(lv_msgv2)
                                    ev_msgv3 = DATA(lv_msgv3)
                                    ev_msgv4 = DATA(lv_msgv4) ).

    INSERT fill_return_param( iv_msgty     = iv_msgty
                              iv_msgid     = iv_msgid
                              iv_msgno     = iv_msgno
                              iv_msgv1     = lv_msgv1
                              iv_msgv2     = lv_msgv2
                              iv_msgv3     = lv_msgv3
                              iv_msgv4     = lv_msgv4
                              iv_parameter = iv_parameter
                              iv_row       = iv_row
                              iv_field     = iv_field ) INTO TABLE mt_messages.

  ENDMETHOD.


  METHOD add_messages.

    LOOP AT it_messages INTO DATA(ls_message).
      add_message( iv_msgty     = ls_message-type
                   iv_msgid     = ls_message-id
                   iv_msgno     = ls_message-number
                   ig_msgv1     = ls_message-message_v1
                   ig_msgv2     = ls_message-message_v2
                   ig_msgv3     = ls_message-message_v3
                   ig_msgv4     = ls_message-message_v4
                   iv_parameter = ls_message-parameter
                   iv_row       = ls_message-row
                   iv_field     = ls_message-field ).
    ENDLOOP.

  ENDMETHOD.


  METHOD get_messages.

    rt_messages = mt_messages.

  ENDMETHOD.


  METHOD initialize.
    CLEAR: mt_messages.
  ENDMETHOD.


  METHOD fill_return_param.

    CALL FUNCTION 'BALW_BAPIRETURN_GET2'
      EXPORTING
        type      = iv_msgty
        cl        = iv_msgid
        number    = iv_msgno
        par1      = iv_msgv1
        par2      = iv_msgv2
        par3      = iv_msgv3
        par4      = iv_msgv4
        parameter = iv_parameter
        row       = iv_row
        field     = iv_field
      IMPORTING
        return    = rs_return
      EXCEPTIONS
        OTHERS    = 0.

  ENDMETHOD.


  METHOD message_vars_prepare.

    DATA: lv_field_type.

    DESCRIBE FIELD ig_msgv1 TYPE lv_field_type.
    CASE lv_field_type.
      WHEN 'D'.
        ev_msgv1 = |{ CONV d( ig_msgv1 ) DATE = USER }|.
      WHEN 'T'.
        ev_msgv1 = |{ CONV t( ig_msgv1 ) TIME = USER }|.
      WHEN 'P' OR 'I'.
        WRITE ig_msgv1 TO ev_msgv1 LEFT-JUSTIFIED.
      WHEN OTHERS.
        WRITE ig_msgv1 TO ev_msgv1 USING EDIT MASK '==ALPHA'.
    ENDCASE.

    DESCRIBE FIELD ig_msgv2 TYPE lv_field_type.
    CASE lv_field_type.
      WHEN 'D'.
        ev_msgv2 = |{ CONV d( ig_msgv2 ) DATE = USER }|.
      WHEN 'T'.
        ev_msgv2 = |{ CONV t( ig_msgv2 ) TIME = USER }|.
      WHEN 'P' OR 'I'.
        WRITE ig_msgv2 TO ev_msgv2 LEFT-JUSTIFIED.
      WHEN OTHERS.
        WRITE ig_msgv2 TO ev_msgv2 USING EDIT MASK '==ALPHA'.
    ENDCASE.

    DESCRIBE FIELD ig_msgv3 TYPE lv_field_type.
    CASE lv_field_type.
      WHEN 'D'.
        ev_msgv3 = |{ CONV d( ig_msgv3 ) DATE = USER }|.
      WHEN 'T'.
        ev_msgv3 = |{ CONV t( ig_msgv3 ) TIME = USER }|.
      WHEN 'P' OR 'I'.
        WRITE ig_msgv3 TO ev_msgv3 LEFT-JUSTIFIED.
      WHEN OTHERS.
        WRITE ig_msgv3 TO ev_msgv3 USING EDIT MASK '==ALPHA'.
    ENDCASE.

    DESCRIBE FIELD ig_msgv4 TYPE lv_field_type.
    CASE lv_field_type.
      WHEN 'D'.
        ev_msgv4 = |{ CONV d( ig_msgv4 ) DATE = USER }|.
      WHEN 'T'.
        ev_msgv4 = |{ CONV t( ig_msgv4 ) TIME = USER }|.
      WHEN 'P' OR 'I'.
        WRITE ig_msgv4 TO ev_msgv4 LEFT-JUSTIFIED.
      WHEN OTHERS.
        WRITE ig_msgv4 TO ev_msgv4 USING EDIT MASK '==ALPHA'.
    ENDCASE.

  ENDMETHOD.


  METHOD add_exception.

    IF ix_exception IS NOT BOUND.
      RETURN.
    ENDIF.

    add_exception( ix_exception->previous ).

  ENDMETHOD.


  METHOD display_messages.

    CALL FUNCTION 'MESSAGES_INITIALIZE'
      EXCEPTIONS
        OTHERS = 0.

    DATA(lt_messages) = get_messages( ).

    LOOP AT lt_messages INTO DATA(ls_message).
      CALL FUNCTION 'MESSAGE_STORE'
        EXPORTING
          arbgb  = ls_message-id
          msgty  = ls_message-type
          msgv1  = ls_message-message_v1
          msgv2  = ls_message-message_v2
          msgv3  = ls_message-message_v3
          msgv4  = ls_message-message_v4
          txtnr  = ls_message-number
        EXCEPTIONS
          OTHERS = 0.
    ENDLOOP.

    CALL FUNCTION 'MESSAGES_SHOW'
      EXCEPTIONS
        OTHERS = 0.

    IF initialize_after_display = abap_true.
      initialize( ).
    ENDIF.

  ENDMETHOD.


ENDCLASS.

CLASS lcl_event_handler IMPLEMENTATION.


  METHOD on_toolbar.

    DATA: lt_toolbar LIKE e_object->mt_toolbar.

    INSERT VALUE #( function  = params_management->gc_fcode-undo
                    icon      = icon_system_undo
                    quickinfo = 'Undo changes'(002)
                    text      = 'Undo'(001)
                    disabled  = params_management->is_func_disabled( params_management->gc_fcode-undo )
                    butn_type = cntb_btype_button ) INTO TABLE lt_toolbar.

    INSERT VALUE #( butn_type = cntb_btype_sep ) INTO TABLE lt_toolbar.

    INSERT VALUE #( function  = params_management->gc_fcode-default
                    icon      = icon_failure
                    quickinfo = 'Set selected parameters to initial value'(004)
                    text      = 'Default'(003)
                    disabled  = params_management->is_func_disabled( params_management->gc_fcode-default )
                    butn_type = cntb_btype_button ) INTO TABLE lt_toolbar.

    INSERT VALUE #( function  = params_management->gc_fcode-default_all
                    icon      = icon_failure
                    quickinfo = 'Set all parameters to initial value'(006)
                    text      = 'Default all'(005)
                    disabled  = params_management->is_func_disabled( params_management->gc_fcode-default_all )
                    butn_type = cntb_btype_button ) INTO TABLE lt_toolbar.

    INSERT VALUE #( butn_type = cntb_btype_sep ) INTO TABLE lt_toolbar.

    INSERT VALUE #( function  = params_management->gc_fcode-transport
                    icon      = icon_transport
                    quickinfo = 'Transport parameters'(012)
                    text      = 'Transport'(013)
                    disabled  = params_management->is_func_disabled( params_management->gc_fcode-transport )
                    butn_type = cntb_btype_button ) INTO TABLE lt_toolbar.

    INSERT VALUE #( butn_type = cntb_btype_sep ) INTO TABLE lt_toolbar.

    INSERT LINES OF e_object->mt_toolbar INTO TABLE lt_toolbar.

    e_object->mt_toolbar = lt_toolbar.

  ENDMETHOD.


  METHOD on_tree_item_doble_clic.

    DATA: ls_class LIKE LINE OF params_management->mt_classes.

    params_management->mo_alv_tree->get_outtab_line( EXPORTING  i_node_key     = node_key
                                  IMPORTING  e_outtab_line  = ls_class
                                  EXCEPTIONS node_not_found = 1
                                             OTHERS         = 4 ).
    IF sy-subrc <> 0 OR ls_class-clsname IS INITIAL.
      RETURN.
    ENDIF.

    params_management->open_class( ls_class-clsname ).

    params_management->after_event( ).

  ENDMETHOD.


  METHOD on_user_command.

    TRY.
        params_management->call_function( e_ucomm ).
      CATCH zcx_params INTO DATA(lx_exception). " Resulto Base: Static Exception
        params_management->mo_msg_container->add_exception( lx_exception ).
    ENDTRY.

    params_management->after_event( ).

  ENDMETHOD.


  METHOD constructor.
    me->params_management = params_management.
  ENDMETHOD.


ENDCLASS.
