CLASS zcl_params_management DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS:
      BEGIN OF gc_program,
        name        TYPE string VALUE 'SAPLZPARAMS_MANAGEMENT' ##NO_TEXT,
        status      TYPE string VALUE 'STATUS_0100' ##NO_TEXT,
        title       TYPE string VALUE 'TITLE_0100' ##NO_TEXT,
        title_class TYPE string VALUE 'TITLE_0100_CLASS' ##NO_TEXT,
      END OF gc_program.

    CONSTANTS:
      BEGIN OF gc_fcode,
        undo        TYPE ui_func VALUE 'UNDO' ##NO_TEXT,
        default     TYPE ui_func VALUE 'SET_DEF' ##NO_TEXT,
        default_all TYPE ui_func VALUE 'SET_DEF_ALL' ##NO_TEXT,
        save        TYPE ui_func VALUE 'SAVE' ##NO_TEXT,
        back        TYPE ui_func VALUE 'BACK' ##NO_TEXT,
        exit        TYPE ui_func VALUE 'EXIT' ##NO_TEXT,
        cancel      TYPE ui_func VALUE 'CANCEL' ##NO_TEXT,
        transport   TYPE ui_func VALUE 'TRANSPORT' ##NO_TEXT,
      END OF gc_fcode.

    CONSTANTS:
      BEGIN OF gc_tr_object,
        pgmid   TYPE pgmid VALUE 'R3TR' ##NO_TEXT,
        objtype TYPE trobjtype VALUE 'TABU' ##NO_TEXT,
        objname TYPE trobj_name VALUE 'ZPARAMS' ##NO_TEXT,
      END OF gc_tr_object.

    CLASS-METHODS call_from_tx.

    METHODS constructor
      IMPORTING
        !iv_filter_package TYPE csequence OPTIONAL
        !iv_filter_class   TYPE csequence OPTIONAL
      RAISING
        zcx_params .

    METHODS destroy .

    METHODS pai
      IMPORTING
        !iv_ucomm      TYPE syucomm
      RETURNING
        VALUE(rv_exit) TYPE abap_bool.

    METHODS before_pbo.

    METHODS pbo.

    METHODS after_pbo.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA:
      mo_main_class     TYPE REF TO cl_oo_class,
      mv_filter_class   TYPE seoclsname,
      mv_filter_package TYPE devclass,
      mo_container_tree TYPE REF TO cl_gui_docking_container,
      mo_alv_tree       TYPE REF TO cl_gui_alv_tree,
      mo_container      TYPE REF TO cl_gui_custom_container,
      mo_alv            TYPE REF TO cl_gui_alv_grid,
      mv_container_name TYPE scrfname VALUE 'CC_PARAMS',
      mt_classes        TYPE zparams_t_class,
      mt_classes_tree   TYPE zparams_t_class,
      mt_attributes     TYPE zparams_t_attribute,
      mt_attributes_db  TYPE zparams_t_attribute,
      mv_crud_mode      TYPE lrm_crud_mode,
      mo_msg_container  TYPE REF TO lcl_messages_container,
      mo_event_handler  TYPE REF TO lcl_event_handler.

    DATA:
      BEGIN OF ms_activity,
        activity   TYPE tractivity,
        objectname TYPE ob_object,
        objecttype TYPE ob_typ,
        subobject  TYPE ob_subobj,
      END OF ms_activity.

    METHODS after_event.

    METHODS get_class
      IMPORTING
        !iv_class       TYPE seoclsname
        !iv_refresh     TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rs_class) TYPE zparams_s_class.

    METHODS get_classes
      IMPORTING
        !iv_refresh       TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rt_classes) TYPE zparams_t_class.

    METHODS get_class_description
      IMPORTING
        !iv_class             TYPE seoclsname
      RETURNING
        VALUE(rv_description) TYPE string.

    METHODS get_class_params
      IMPORTING
        !iv_class      TYPE seoclsname
      RETURNING
        VALUE(rt_attr) TYPE seo_attributes .

    METHODS get_main_class
      RETURNING
        VALUE(ro_main_class) TYPE REF TO cl_oo_class .

    METHODS is_edit_allowed
      RETURNING
        VALUE(rv_allowed) TYPE abap_bool.

    METHODS is_func_disabled
      IMPORTING
        !iv_fcode          TYPE csequence
      RETURNING
        VALUE(rv_disabled) TYPE abap_bool.

    METHODS lock_class
      IMPORTING
        !iv_class TYPE seoclsname
      RAISING
        zcx_params.

    METHODS open_class
      IMPORTING
        !iv_class TYPE seoclsname.

    METHODS set_filter
      IMPORTING
        !iv_filter_package TYPE csequence OPTIONAL
        !iv_filter_class   TYPE csequence OPTIONAL
      RAISING
        zcx_params .

    METHODS unlock_class
      IMPORTING
        !iv_class TYPE seoclsname.

    METHODS alv_get_fieldcatalog
      RETURNING
        VALUE(rt_fieldcatalog) TYPE lvc_t_fcat .

    METHODS alv_get_layout
      RETURNING
        VALUE(rs_layout) TYPE lvc_s_layo .

    METHODS alv_get_toolbar_exclude
      RETURNING
        VALUE(rt_toolbar_excluding) TYPE ui_functions .

    METHODS alv_get_variant
      RETURNING
        VALUE(rs_variant) TYPE disvariant .

    METHODS alv_prepare
      RAISING
        zcx_params .

    METHODS alv_set_handler .

    METHODS alv_tree_add_node
      IMPORTING
        !ig_outtab_line TYPE any OPTIONAL
        !iv_node_text   TYPE csequence
        !iv_is_folder   TYPE abap_bool OPTIONAL
        !iv_relat_key   TYPE lvc_nkey OPTIONAL
      RETURNING
        VALUE(rv_nkey)  TYPE lvc_nkey .

    METHODS alv_tree_build .

    METHODS alv_tree_build_hierarchy .

    METHODS alv_tree_get_header
      RETURNING
        VALUE(rs_header) TYPE treev_hhdr .

    METHODS alv_tree_get_variant
      RETURNING
        VALUE(rs_variant) TYPE disvariant .

    METHODS alv_tree_set_handler .

    METHODS call_function
      IMPORTING
        !iv_ucomm      TYPE syucomm
      RETURNING
        VALUE(rv_exit) TYPE abap_bool
      RAISING
        zcx_params.

    METHODS check
      RAISING
        zcx_params .

    METHODS check_changes
      RETURNING
        VALUE(rt_changed) TYPE zparams_t_attribute .

    METHODS check_data_type
      IMPORTING
        !ig_value TYPE any
        !iv_type  TYPE csequence
      RAISING
        zcx_params .

    METHODS try_save_changes
      RETURNING
        VALUE(rv_save_done) TYPE abap_bool
      RAISING
        zcx_params .

    METHODS cmd_default
      RAISING
        zcx_params .

    METHODS cmd_default_all
      RAISING
        zcx_params .

    METHODS cmd_transport
      RAISING
        zcx_params .

    METHODS cmd_undo
      RAISING
        zcx_params .

    METHODS complete_construction
      IMPORTING
        !iv_filter_package TYPE csequence OPTIONAL
        !iv_filter_class   TYPE csequence OPTIONAL
      RAISING
        zcx_params .

    METHODS fill_def_value
      IMPORTING
        !iv_value       TYPE csequence
      RETURNING
        VALUE(rv_value) TYPE string .

    METHODS fill_table
      RAISING
        zcx_params .

    METHODS refresh
      RAISING
        zcx_params .

    METHODS save
      RAISING
        zcx_params .

ENDCLASS.



CLASS zcl_params_management IMPLEMENTATION.


  METHOD call_from_tx.

    CALL FUNCTION 'ZPARAMS_MANAGE'.

  ENDMETHOD.


  METHOD after_event.
    cl_gui_cfw=>set_new_ok_code( 'REFR' ).
  ENDMETHOD.


  METHOD before_pbo.

    DATA: lv_description TYPE string.

    SET PF-STATUS gc_program-status OF PROGRAM gc_program-name.

    IF mv_filter_class IS INITIAL.
      SET TITLEBAR gc_program-title OF PROGRAM gc_program-name.
    ELSE.
      lv_description = get_class_description( mv_filter_class ).
      SET TITLEBAR gc_program-title_class OF PROGRAM gc_program-name WITH lv_description.
    ENDIF.

  ENDMETHOD.


  METHOD after_pbo.

    mo_msg_container->display_messages( ).

  ENDMETHOD.


  METHOD constructor.

    complete_construction( iv_filter_package = iv_filter_package
                           iv_filter_class   = iv_filter_class ).

  ENDMETHOD.


  METHOD destroy.

    IF mo_alv IS BOUND.
      mo_alv->free( ).
      CLEAR: mo_alv.
    ENDIF.

    IF mo_container IS BOUND.
      mo_container->free( ).
      CLEAR: mo_container.
    ENDIF.

    IF mo_alv_tree IS BOUND.
      mo_alv_tree->free( ).
      CLEAR: mo_alv_tree.
    ENDIF.

    IF mo_container_tree IS BOUND.
      mo_container_tree->free( ).
      CLEAR: mo_container_tree.
    ENDIF.

  ENDMETHOD.


  METHOD get_classes.

    DATA: ls_class    LIKE LINE OF rt_classes,
          lv_obj_name TYPE sobj_name.

    IF iv_refresh = abap_true.
      CLEAR: mt_classes.
    ENDIF.

    IF mt_classes IS NOT INITIAL.
      rt_classes = mt_classes.
      RETURN.
    ENDIF.

    DATA(lo_main_class) = get_main_class( ).
    IF lo_main_class IS NOT BOUND.
      RETURN.
    ENDIF.

    DATA(lt_classes) = lo_main_class->get_subclasses( ).

    IF mv_filter_class IS NOT INITIAL.
      DELETE lt_classes WHERE clsname <> mv_filter_class.
    ENDIF.

    LOOP AT lt_classes INTO DATA(ls_class_key).
      CLEAR: ls_class.

      CREATE OBJECT ls_class-param_obj TYPE (ls_class_key-clsname).

      IF ms_activity-subobject IS NOT INITIAL AND ls_class-param_obj->get_img_subobject( ) <> ms_activity-subobject.
        CONTINUE.
      ENDIF.

      IF mv_filter_package IS INITIAL.
        SELECT SINGLE devclass INTO @ls_class-devclass
          FROM  tadir
          WHERE pgmid    = 'R3TR'
            AND object   = 'CLAS'
            AND obj_name = @ls_class_key-clsname.
      ELSE.
        SELECT SINGLE devclass INTO @ls_class-devclass
          FROM  tadir
          WHERE devclass = @mv_filter_package
            AND pgmid    = 'R3TR'
            AND object   = 'CLAS'
            AND obj_name = @ls_class_key-clsname.
      ENDIF.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      TRY.
          ls_class-class_obj = cl_oo_class=>get_instance( ls_class_key-clsname ).
        CATCH cx_class_not_existent. " Class Does Not Exist
          CLEAR: ls_class-class_obj.
      ENDTRY.

      IF ls_class-class_obj IS NOT BOUND.
        CONTINUE.
      ENDIF.

      lv_obj_name = ls_class_key-clsname.

      CALL FUNCTION 'TRINT_GET_NAMESPACE'
        EXPORTING
          iv_pgmid            = 'R3TR'
          iv_object           = 'CLAS'
          iv_obj_name         = lv_obj_name
        IMPORTING
          ev_namespace        = ls_class-namespace
        EXCEPTIONS
          invalid_prefix      = 1
          invalid_object_type = 2
          OTHERS              = 3.
      IF sy-subrc <> 0.
        CLEAR ls_class-namespace.
      ENDIF.

      ls_class-clsname = ls_class_key-clsname.

      INSERT ls_class INTO TABLE rt_classes.

    ENDLOOP.

  ENDMETHOD.


  METHOD get_class.

    DATA(lt_classes) = get_classes( iv_refresh ).

    TRY.
        rs_class = lt_classes[ clsname = iv_class ].
      CATCH cx_sy_itab_line_not_found.
        CLEAR: rs_class.
    ENDTRY.

  ENDMETHOD.


  METHOD get_class_description.

    DATA(ls_class) = get_class( iv_class ).

    rv_description = COND #( WHEN ls_class IS INITIAL         THEN '<DESCR_NOT_FOUND>'
                             WHEN ls_class-param_obj IS BOUND THEN CONV #(
                                            LET descr = ls_class-param_obj->get_description( )
                                                IN COND #( WHEN descr IS INITIAL THEN  ls_class-clsname
                                                                                 ELSE descr ) )
                                                              ELSE ls_class-clsname ) ##NO_TEXT.

  ENDMETHOD.


  METHOD get_class_params.

    IF iv_class IS INITIAL.
      RETURN.
    ENDIF.

    TRY.
        DATA(lo_class) = cl_oo_class=>get_instance( iv_class ).
      CATCH cx_class_not_existent. " Class Does Not Exist
        CLEAR: lo_class.
    ENDTRY.

    IF lo_class IS NOT BOUND.
      RETURN.
    ENDIF.

    DATA(lt_attr) = lo_class->get_attributes( public_attributes_only = seox_true ).

    DELETE lt_attr WHERE typtype <> seoo_typtype_type.
    DELETE lt_attr WHERE attdecltyp <> seoo_attdecltyp_statics.

    rt_attr = lt_attr.

  ENDMETHOD.


  METHOD get_main_class.

    ro_main_class = mo_main_class.

  ENDMETHOD.


  METHOD is_edit_allowed.

    IF mv_crud_mode <> zif_params_constants=>crud-update AND mv_crud_mode <> zif_params_constants=>crud-create.
      RETURN.
    ENDIF.

    rv_allowed = abap_true.

  ENDMETHOD.


  METHOD is_func_disabled.

    rv_disabled = abap_true.

    IF mv_filter_class IS INITIAL.
      RETURN.
    ENDIF.

    IF iv_fcode IS INITIAL.
      RETURN.
    ENDIF.

    CASE iv_fcode.
      WHEN gc_fcode-transport.
        rv_disabled = abap_false.

      WHEN OTHERS.

        IF is_edit_allowed( ) = abap_false.
          rv_disabled = abap_true.
        ELSE.
          rv_disabled = abap_false.
        ENDIF.

    ENDCASE.

  ENDMETHOD.


  METHOD lock_class.

    mv_crud_mode = zif_params_constants=>crud-read.

    IF mo_alv IS BOUND.
      mo_alv->set_ready_for_input( 0 ).
    ENDIF.

    IF iv_class IS INITIAL.
      RETURN.
    ENDIF.

    CALL FUNCTION 'ENQUEUE_EZPARAMS'
      EXPORTING
        clsname        = iv_class   " 02th enqueue argument
      EXCEPTIONS
        foreign_lock   = 1                " Object already locked
        system_failure = 2                " Internal error from enqueue server
        OTHERS         = 3.
    IF sy-subrc <> 0.
      zcx_params=>raise_by_syst( ).
    ENDIF.

    mv_crud_mode = zif_params_constants=>crud-update.

    IF mo_alv IS BOUND.
      mo_alv->set_ready_for_input( 1 ).
    ENDIF.

  ENDMETHOD.


  METHOD open_class.

    TRY.
        IF try_save_changes( ) IS INITIAL.
          RETURN.
        ENDIF.

        unlock_class( mv_filter_class ).

      CATCH zcx_params INTO DATA(lx_exception).
        mo_msg_container->add_exception( lx_exception ).
    ENDTRY.

    TRY.
        mv_filter_class = iv_class.
        lock_class( mv_filter_class ).
      CATCH zcx_params INTO lx_exception.
        mo_msg_container->add_exception( lx_exception ).
    ENDTRY.

    TRY.
        fill_table( ).
      CATCH zcx_params INTO lx_exception.
        mo_msg_container->add_exception( lx_exception ).
    ENDTRY.

  ENDMETHOD.


  METHOD pai.

    TRY.
        rv_exit = call_function( iv_ucomm ).
      CATCH zcx_params INTO DATA(lx_exception).
        mo_msg_container->add_exception( lx_exception ).
    ENDTRY.

    IF rv_exit = abap_true.
      unlock_class( mv_filter_class ).
    ENDIF.

  ENDMETHOD.


  METHOD pbo.


    TRY.
        alv_prepare( ).
      CATCH zcx_params INTO DATA(lx_exception).
        mo_msg_container->add_exception( lx_exception ).
    ENDTRY.

  ENDMETHOD.


  METHOD set_filter.

    mv_filter_class   = iv_filter_class.
    mv_filter_package = iv_filter_package.

    DATA(lt_classes) = get_classes( ).
    IF lines( lt_classes ) = 1.
      READ TABLE lt_classes INTO DATA(ls_class) INDEX 1.
      IF sy-subrc <> 0.
        CLEAR: ls_class.
      ENDIF.
    ENDIF.

    open_class( ls_class-clsname ).

  ENDMETHOD.


  METHOD unlock_class.

    IF iv_class IS INITIAL.
      RETURN.
    ENDIF.

    CALL FUNCTION 'DEQUEUE_EZPARAMS'
      EXPORTING
        clsname = iv_class.

  ENDMETHOD.


  METHOD alv_get_fieldcatalog.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZPARAMS_S_ATTRIBUTE'
      CHANGING
        ct_fieldcat            = rt_fieldcatalog
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    LOOP AT rt_fieldcatalog ASSIGNING FIELD-SYMBOL(<ls_fcat>).

      CASE <ls_fcat>-fieldname.
        WHEN 'CLSNAME'   " Class Name
          OR 'CMPNAME'.  " Attribute Name
          CONTINUE.

        WHEN 'DESCRIPT'. " Description
          <ls_fcat>-outputlen = 50 ##NUMBER_OK.

        WHEN 'ATTVALUE'. " Initial Value
          <ls_fcat>-outputlen = 30 ##NUMBER_OK.

        WHEN 'TYPE'.     " Data type
          <ls_fcat>-outputlen = 20 ##NUMBER_OK.

        WHEN 'VALUE'.    " Actual value
          <ls_fcat>-outputlen = 30 ##NUMBER_OK.
          <ls_fcat>-edit      = abap_true.
          <ls_fcat>-col_pos   = 3.

        WHEN OTHERS.
          <ls_fcat>-tech = abap_true.

      ENDCASE.

    ENDLOOP.

  ENDMETHOD.


  METHOD alv_get_layout.

    rs_layout-zebra = abap_true.

  ENDMETHOD.


  METHOD alv_get_toolbar_exclude.

    INSERT cl_gui_alv_grid=>mc_fc_auf INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_average INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_back_classic INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_abc INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_chain INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_crbatch INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_crweb INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_lineitems INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_master_data INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_more INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_report INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_xint INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_xml_export INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_call_xxl INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_col_invisible INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_count INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_detail INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_expcrdata INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_expcrdesig INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_expcrtempl INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_expmdb INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_extend INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_graph INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_help INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_html INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_info INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_loc_append_row INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_loc_copy_row INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_loc_cut INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_loc_delete_row INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_loc_insert_row INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_loc_move_row INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_loc_paste INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_loc_paste_new_row INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_loc_undo INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_maximum INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_minimum INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_pc_file INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_refresh INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_reprep INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_select_all INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_subtot INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_sum INTO TABLE rt_toolbar_excluding.
    INSERT cl_gui_alv_grid=>mc_fc_word_processor INTO TABLE rt_toolbar_excluding.

  ENDMETHOD.


  METHOD alv_get_variant.

    rs_variant-report = sy-repid.
    rs_variant-handle = 'GRID'.

  ENDMETHOD.


  METHOD alv_prepare.

    alv_tree_build( ).

    IF mo_alv IS BOUND.
      mo_alv->refresh_table_display( ).
      RETURN.
    ENDIF.

    mo_container = NEW cl_gui_custom_container( mv_container_name ).

    mo_alv = NEW cl_gui_alv_grid( mo_container ).

    mo_alv->register_edit_event( i_event_id = cl_gui_alv_grid=>mc_evt_enter ).
    mo_alv->register_edit_event( i_event_id = cl_gui_alv_grid=>mc_evt_modified ).

    alv_set_handler( ).

    DATA(lt_fcat) = alv_get_fieldcatalog( ).

    mo_alv->set_table_for_first_display(
      EXPORTING
        i_structure_name              = 'ZPARAMS_S_ATTRIBUTE'
        is_variant                    = alv_get_variant( )    " Layout
        i_save                        = 'A'           " Save Layout
        i_default                     = abap_true
        is_layout                     = alv_get_layout( )     " Layout
        it_toolbar_excluding          = alv_get_toolbar_exclude( )
      CHANGING
        it_outtab                     = mt_attributes " Output Table
        it_fieldcatalog               = lt_fcat       " Field Catalog
      EXCEPTIONS
        invalid_parameter_combination = 1             " Wrong Parameter
        program_error                 = 2             " Program Errors
        too_many_lines                = 3             " Too many Rows in Ready for Input Grid
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      zcx_params=>raise_by_syst( ).
    ENDIF.

  ENDMETHOD.


  METHOD alv_set_handler.

    SET HANDLER mo_event_handler->on_toolbar FOR mo_alv ACTIVATION abap_true.
    SET HANDLER mo_event_handler->on_user_command FOR mo_alv ACTIVATION abap_true.

  ENDMETHOD.


  METHOD alv_tree_add_node.

    DATA: lv_node_text   TYPE lvc_value,
          lt_item_layout TYPE lvc_t_layi,
          ls_node_layout TYPE lvc_s_layn.

    IF iv_is_folder = abap_true.
      ls_node_layout-isfolder = iv_is_folder.
    ELSE.
      ls_node_layout-n_image  = icon_oo_class.
    ENDIF.

    INSERT VALUE #( fieldname = cl_gui_alv_tree=>c_hierarchy_column_name
                    style     = cl_gui_column_tree=>style_default ) INTO TABLE lt_item_layout.

    " add node
    lv_node_text = iv_node_text.
    mo_alv_tree->add_node( EXPORTING i_relat_node_key = iv_relat_key
                                     i_relationship   = cl_gui_column_tree=>relat_last_child
                                     i_node_text      = lv_node_text
                                     is_outtab_line   = ig_outtab_line
                                     is_node_layout   = ls_node_layout
                                     it_item_layout   = lt_item_layout
                           IMPORTING e_new_node_key   = rv_nkey ).

    IF iv_relat_key IS NOT INITIAL.
      mo_alv_tree->expand_node( EXPORTING  i_node_key = iv_relat_key
                                EXCEPTIONS OTHERS     = 0 ).
    ENDIF.

  ENDMETHOD.


  METHOD alv_tree_build.

    IF mv_filter_class IS NOT INITIAL OR mo_alv_tree IS BOUND OR lines( get_classes( ) ) <= 1.
      RETURN.
    ENDIF.

    mo_container_tree = NEW cl_gui_docking_container( extension = 300 ) ##NUMBER_OK.

    mo_alv_tree = NEW cl_gui_alv_tree( parent = mo_container_tree no_html_header = abap_true ).

    alv_tree_set_handler( ).

    mo_alv_tree->set_table_for_first_display( EXPORTING i_structure_name     = 'ZPARAMS_S_CLASS'
                                                        is_variant           = alv_tree_get_variant( )
                                                        i_save               = 'A'
                                                        is_hierarchy_header  = alv_tree_get_header( )
                                              CHANGING  it_outtab            = mt_classes_tree ).

    alv_tree_build_hierarchy( ).

    mo_alv_tree->frontend_update( ).

  ENDMETHOD.


  METHOD alv_tree_build_hierarchy.

    DATA:
      ls_class_last   TYPE zparams_s_class,
      lv_nkey_ns      TYPE lvc_nkey,
      lv_nkey_package TYPE lvc_nkey.

    DATA(lt_classes) = get_classes( ).

    SORT lt_classes ASCENDING BY namespace clsname.

    LOOP AT lt_classes INTO DATA(ls_class).

      IF ls_class_last-namespace <> ls_class-namespace.
        lv_nkey_ns = alv_tree_add_node( ig_outtab_line = VALUE zparams_s_class( namespace = ls_class-namespace )
                                        iv_node_text   = ls_class-namespace
                                        iv_is_folder   = abap_true ).
      ENDIF.

      IF ls_class_last-devclass <> ls_class-devclass.
        lv_nkey_package = alv_tree_add_node( ig_outtab_line = VALUE zparams_s_class( devclass  = ls_class-devclass
                                                                                     namespace = ls_class-namespace )
                                             iv_node_text   = ls_class-devclass
                                             iv_is_folder   = abap_true
                                             iv_relat_key   = lv_nkey_ns ).
      ENDIF.

      alv_tree_add_node( ig_outtab_line = ls_class
                          iv_node_text   = ls_class-param_obj->get_description( )
                          iv_relat_key   = lv_nkey_package ).

      ls_class_last = ls_class.

    ENDLOOP.

  ENDMETHOD.


  METHOD alv_tree_get_header.
    rs_header-heading   = 'Parameter Classes'(011).
    rs_header-width     = 40 ##NUMBER_OK.
    rs_header-width_pix = ''.
  ENDMETHOD.


  METHOD alv_tree_get_variant.

    rs_variant-report = sy-repid.
    rs_variant-handle = 'GRID'.

  ENDMETHOD.


  METHOD alv_tree_set_handler.

    mo_alv_tree->get_registered_events( IMPORTING  events = DATA(lt_events)
                                        EXCEPTIONS OTHERS = 0 ).

    INSERT VALUE cntl_simple_event( eventid = cl_gui_column_tree=>eventid_item_double_click ) INTO TABLE lt_events.

    mo_alv_tree->set_registered_events( EXPORTING  events = lt_events
                                        EXCEPTIONS OTHERS = 0 ).

    SET HANDLER mo_event_handler->on_tree_item_doble_clic FOR mo_alv_tree.

  ENDMETHOD.


  METHOD call_function.

    IF mo_alv IS BOUND.
      mo_alv->check_changed_data( ).
    ENDIF.

    CASE iv_ucomm.
      WHEN gc_fcode-default.
        cmd_default( ).

      WHEN gc_fcode-default_all.
        cmd_default_all( ).

      WHEN gc_fcode-undo.
        cmd_undo( ).

      WHEN gc_fcode-save.
        save( ).

      WHEN gc_fcode-transport.
        cmd_transport( ).

      WHEN gc_fcode-back OR gc_fcode-exit.
        rv_exit = try_save_changes( ).

      WHEN gc_fcode-cancel.
        rv_exit = abap_true.

    ENDCASE.

  ENDMETHOD.


  METHOD check.

    LOOP AT mt_attributes INTO DATA(ls_attribute).
      check_data_type( ig_value = ls_attribute-value
                        iv_type  = ls_attribute-type ).
    ENDLOOP.

  ENDMETHOD.


  METHOD check_changes.

    IF mv_crud_mode <> zif_params_constants=>crud-update AND mv_crud_mode <> zif_params_constants=>crud-create.
      RETURN.
    ENDIF.

    mo_alv->check_changed_data( ).  " Refresh data from ALV

    LOOP AT mt_attributes INTO DATA(ls_attribute).

      IF ls_attribute-value = ls_attribute-old_value.
        CONTINUE.
      ENDIF.

      INSERT ls_attribute INTO TABLE rt_changed.

    ENDLOOP.

  ENDMETHOD.


  METHOD check_data_type.

    DATA: lr_data TYPE REF TO data.

    CREATE DATA lr_data TYPE (iv_type).
    IF lr_data IS NOT BOUND.
      RAISE EXCEPTION TYPE zcx_params
        EXPORTING
          textid = zcx_params=>error_generating_data_type
          text1  = CONV #( iv_type ).
    ENDIF.

    ASSIGN lr_data->* TO FIELD-SYMBOL(<lg_data>).
    IF <lg_data> IS NOT ASSIGNED.
      RAISE EXCEPTION TYPE zcx_params
        EXPORTING
          textid = zcx_params=>error_generating_data_type
          text1  = CONV #( iv_type ).
    ENDIF.

    TRY.
        <lg_data> = ig_value.
      CATCH cx_root.
        RAISE EXCEPTION TYPE zcx_params
          EXPORTING
            textid = zcx_params=>value_not_valid
            text1  = CONV #( ig_value )
            text2  = CONV #( iv_type ).
    ENDTRY.

  ENDMETHOD.


  METHOD try_save_changes.

    DATA: lv_ans TYPE c.

    IF check_changes( ) IS INITIAL.
      rv_save_done = abap_true.
      RETURN.
    ENDIF.

    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        titlebar              = 'Changes pending'(007)   " Title of dialog box
        text_question         = 'Save before continue?'(008) " Question text in dialog box
        text_button_1         = 'Save'(009)              " Text on the first pushbutton
        icon_button_1         = icon_system_save         " Icon on first pushbutton
        text_button_2         = 'Exit'(010)              " Text on the second pushbutton
        icon_button_2         = icon_system_end          " Icon on second pushbutton
        default_button        = '1'                      " Cursor position
        display_cancel_button = abap_false               " Button for displaying cancel pushbutton
        popup_type            = icon_message_warning     " Icon type
      IMPORTING
        answer                = lv_ans                   " Return values: '1', '2', 'A'
      EXCEPTIONS
        text_not_found        = 1                        " Diagnosis text not found
        OTHERS                = 2.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    CASE lv_ans.
      WHEN '1'.
        save( ).
        rv_save_done = abap_true.
      WHEN '2'.
        rv_save_done = abap_true.
      WHEN 'A'.
        rv_save_done = abap_false.
    ENDCASE.

  ENDMETHOD.


  METHOD cmd_default.

    mo_alv->get_selected_rows( IMPORTING et_index_rows = DATA(lt_sel_rows) ).
    IF lt_sel_rows IS INITIAL.
      RETURN.
    ENDIF.

    LOOP AT lt_sel_rows INTO DATA(ls_sel_row).

      READ TABLE mt_attributes ASSIGNING FIELD-SYMBOL(<ls_attribute>) INDEX ls_sel_row-index.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      <ls_attribute>-value = fill_def_value( <ls_attribute>-attvalue ).

    ENDLOOP.

  ENDMETHOD.


  METHOD cmd_default_all.

    LOOP AT mt_attributes ASSIGNING FIELD-SYMBOL(<ls_attribute>).
      <ls_attribute>-value = fill_def_value( <ls_attribute>-attvalue ).
    ENDLOOP.

  ENDMETHOD.


  METHOD cmd_transport.

    DATA: lv_trkorr    TYPE trkorr,
          lt_tr_object TYPE tr_objects,
          lt_tr_key    TYPE tr_keys.

    IF mt_attributes_db IS INITIAL.
      RETURN.
    ENDIF.

    IF try_save_changes( ) IS INITIAL.
      RETURN.
    ENDIF.

    CALL FUNCTION 'TR_ORDER_CHOICE_CORRECTION'
      EXPORTING
        iv_category            = 'CUST'
        iv_cli_dep             = abap_true
      IMPORTING
        ev_task                = lv_trkorr
      EXCEPTIONS
        invalid_category       = 1
        no_correction_selected = 2
        OTHERS                 = 3.
    CASE sy-subrc.
      WHEN 2.
        CLEAR lv_trkorr.
      WHEN 1 OR 3.
        zcx_params=>raise_by_syst( ).
    ENDCASE.

    IF lv_trkorr IS INITIAL.
      RETURN.
    ENDIF.


    INSERT VALUE e071( pgmid    = gc_tr_object-pgmid
                       object   = gc_tr_object-objtype
                       obj_name = gc_tr_object-objname
                       activity = ms_activity-activity ) INTO TABLE lt_tr_object.

    LOOP AT mt_attributes_db INTO DATA(ls_attr).
      INSERT VALUE e071k( pgmid      = gc_tr_object-pgmid
                          object     = gc_tr_object-objtype
                          objname    = gc_tr_object-objname
                          mastertype = gc_tr_object-objtype
                          mastername = gc_tr_object-objname
                          tabkey     = |{ sy-mandt ALPHA = IN }{ ls_attr-clsname ALPHA = IN }{ ls_attr-cmpname }|
                          activity   = ms_activity-activity ) INTO TABLE lt_tr_key.
    ENDLOOP.

    " Transport
    CALL FUNCTION 'TR_APPEND_TO_COMM_OBJS_KEYS'
      EXPORTING
        wi_suppress_key_check = abap_true
        wi_trkorr             = lv_trkorr
      TABLES
        wt_e071               = lt_tr_object
        wt_e071k              = lt_tr_key
      EXCEPTIONS
        OTHERS                = 1.
    IF sy-subrc <> 0.
      zcx_params=>raise_by_syst( ).
    ENDIF.

  ENDMETHOD.


  METHOD cmd_undo.

    mo_alv->get_selected_rows( IMPORTING et_index_rows = DATA(lt_sel_rows) ).
    IF lt_sel_rows IS INITIAL.
      RETURN.
    ENDIF.

    LOOP AT lt_sel_rows INTO DATA(ls_sel_row).

      READ TABLE mt_attributes ASSIGNING FIELD-SYMBOL(<ls_attribute>) INDEX ls_sel_row-index.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      <ls_attribute>-value = <ls_attribute>-old_value.

    ENDLOOP.

  ENDMETHOD.


  METHOD complete_construction.

    mo_msg_container = NEW #( ).
    mo_event_handler = NEW #( me ).

    " Build the transport object.
    CALL FUNCTION 'READ_IMG_ACTIVITY_FROM_MEMORY'
      IMPORTING
        img_activity = ms_activity-activity.

    IF ms_activity-activity IS NOT INITIAL.
      GET PARAMETER ID 'CUT' FIELD ms_activity-objecttype.
      GET PARAMETER ID 'CUO' FIELD ms_activity-objectname.
      GET PARAMETER ID 'CUS' FIELD ms_activity-subobject.
    ENDIF.

    TRY.
        mo_main_class = NEW cl_oo_class( 'ZCL_PARAMS' ).
      CATCH cx_class_not_existent INTO DATA(lx_class).
        RAISE EXCEPTION TYPE zcx_params
          EXPORTING
            previous = lx_class.
    ENDTRY.

    set_filter( iv_filter_package = iv_filter_package
                iv_filter_class   = iv_filter_class ).

  ENDMETHOD.


  METHOD fill_def_value.

    DATA: lv_len TYPE i.

    IF iv_value IS INITIAL.
      RETURN.
    ENDIF.

    IF iv_value(1) = ''''.  " Fixed value

      lv_len = strlen( iv_value ) - 2.
      rv_value = iv_value+1(lv_len).

    ELSE.

      ASSIGN (iv_value) TO FIELD-SYMBOL(<lg_value>).
      IF sy-subrc <> 0 OR <lg_value> IS NOT ASSIGNED.
        RETURN.
      ENDIF.

      rv_value = <lg_value>.

    ENDIF.

  ENDMETHOD.


  METHOD fill_table.

    DATA: ls_output    LIKE LINE OF mt_attributes,
          lt_params    TYPE seo_attributes,
          ls_attkey    TYPE seocmpkey,
          lv_reference TYPE string.

    CLEAR: mt_attributes.

    DATA(lt_classes) = get_classes( ).

    DELETE lt_classes WHERE clsname <> mv_filter_class.

    LOOP AT lt_classes INTO DATA(ls_class).
      INSERT LINES OF get_class_params( ls_class-clsname ) INTO TABLE lt_params.
    ENDLOOP.

    LOOP AT lt_params INTO DATA(ls_param).
      CLEAR: ls_output, lv_reference.

      ls_attkey-clsname = ls_param-clsname.
      ls_attkey-cmpname = ls_param-cmpname.

      CALL FUNCTION 'SEO_ATTRIBUTE_GET'
        EXPORTING
          attkey       = ls_attkey
        IMPORTING
          attribute    = ls_param
        EXCEPTIONS
          not_existing = 1
          deleted      = 2
          is_method    = 3
          is_event     = 4
          is_type      = 5
          OTHERS       = 6.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      ls_output = CORRESPONDING #( ls_param ).

      lv_reference = |{ ls_param-clsname }=>{ ls_param-cmpname }|.

      ASSIGN (lv_reference) TO FIELD-SYMBOL(<lg_ref>).
      IF sy-subrc = 0 AND <lg_ref> IS ASSIGNED.
        ls_output-value = <lg_ref>.
      ENDIF.

      ls_output-old_value = ls_output-value.

      INSERT ls_output INTO TABLE mt_attributes.

    ENDLOOP.

    mt_attributes_db = mt_attributes.

    IF mo_alv IS BOUND.
      mo_alv->refresh_table_display( ).
    ENDIF.

  ENDMETHOD.


  METHOD refresh.

    DATA(lt_attributes) = mt_attributes.

    SORT lt_attributes ASCENDING BY clsname.
    DELETE ADJACENT DUPLICATES FROM lt_attributes COMPARING clsname.

    LOOP AT lt_attributes INTO DATA(ls_attribute).
      zcl_params=>fill_params( ls_attribute-clsname ).
    ENDLOOP.

    fill_table( ).

  ENDMETHOD.


  METHOD save.

    DATA:
      lt_data_mod TYPE zparams_t_update,
      ls_data_mod LIKE LINE OF lt_data_mod,
      lt_data_old TYPE zparams_t_update,
      ls_data_old LIKE LINE OF lt_data_old.

    DATA(lt_changed) = check_changes( ).

    IF lt_changed IS INITIAL.
      RETURN.
    ENDIF.

    check( ).

    LOOP AT lt_changed INTO DATA(ls_attribute).
      CLEAR: ls_data_mod, ls_data_old.

      ls_data_mod = CORRESPONDING #( ls_attribute ).

      SELECT SINGLE *
        INTO CORRESPONDING FIELDS OF @ls_data_old
        FROM zparams
        WHERE clsname = @ls_attribute-clsname
          AND cmpname = @ls_attribute-cmpname.
      IF sy-subrc = 0.
        INSERT ls_data_old INTO TABLE lt_data_old.
        ls_data_mod-crud_mode = zif_params_constants=>crud-update.
      ELSE.
        ls_data_mod-crud_mode = zif_params_constants=>crud-create.
      ENDIF.

      INSERT ls_data_mod INTO TABLE lt_data_mod.

    ENDLOOP.

    CALL FUNCTION 'ZPARAMS_DB_UPDATE' IN UPDATE TASK
      EXPORTING
        it_data     = lt_data_mod
        it_data_old = lt_data_old.

    COMMIT WORK AND WAIT.

    refresh( ).

  ENDMETHOD.


ENDCLASS.
