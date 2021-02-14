CLASS lcl_messages_container DEFINITION.

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF severity,
        error       TYPE symsgty VALUE 'E',
        warning     TYPE symsgty VALUE 'W',
        information TYPE symsgty VALUE 'I',
        exception   TYPE symsgty VALUE 'X',
        abort       TYPE symsgty VALUE 'A',
      END OF severity,
      error_types TYPE string VALUE 'AEX'.

    METHODS add_message
      IMPORTING
        !iv_msgty     TYPE sy-msgty DEFAULT severity-error
        !iv_msgid     TYPE sy-msgid
        !iv_msgno     TYPE sy-msgno
        !ig_msgv1     TYPE any OPTIONAL
        !ig_msgv2     TYPE any OPTIONAL
        !ig_msgv3     TYPE any OPTIONAL
        !ig_msgv4     TYPE any OPTIONAL
        !iv_parameter TYPE bapiret2-parameter OPTIONAL
        !iv_row       TYPE bapiret2-row OPTIONAL
        !iv_field     TYPE bapiret2-field OPTIONAL.

    METHODS add_messages
      IMPORTING
        !it_messages TYPE bapirettab.

    METHODS add_exception
      IMPORTING
        ix_exception TYPE REF TO cx_root.

    METHODS display_messages
      IMPORTING
        initialize_after_display TYPE abap_bool DEFAULT abap_true.

    METHODS get_messages
      RETURNING
        VALUE(rt_messages) TYPE bapiret2_t.

    METHODS initialize.

  PRIVATE SECTION.
    DATA:
      mt_messages TYPE bapiret2_t.

    METHODS message_vars_prepare
      IMPORTING
        !ig_msgv1 TYPE any OPTIONAL
        !ig_msgv2 TYPE any OPTIONAL
        !ig_msgv3 TYPE any OPTIONAL
        !ig_msgv4 TYPE any OPTIONAL
      EXPORTING
        ev_msgv1  TYPE syst_msgv
        ev_msgv2  TYPE syst_msgv
        ev_msgv3  TYPE syst_msgv
        ev_msgv4  TYPE syst_msgv.

    METHODS fill_return_param
      IMPORTING
        !iv_msgty        TYPE syst_msgty
        !iv_msgid        TYPE syst_msgid
        !iv_msgno        TYPE syst_msgno
        !iv_msgv1        TYPE syst_msgv OPTIONAL
        !iv_msgv2        TYPE syst_msgv OPTIONAL
        !iv_msgv3        TYPE syst_msgv OPTIONAL
        !iv_msgv4        TYPE syst_msgv OPTIONAL
        !iv_parameter    TYPE bapiret2-parameter OPTIONAL
        !iv_row          TYPE bapiret2-row OPTIONAL
        !iv_field        TYPE bapiret2-field OPTIONAL
      RETURNING
        VALUE(rs_return) TYPE bapiret2.

ENDCLASS.

CLASS lcl_event_handler DEFINITION DEFERRED.
CLASS zcl_params_management DEFINITION LOCAL FRIENDS lcl_event_handler.
CLASS lcl_event_handler DEFINITION
  FRIENDS zcl_params_management.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        params_management TYPE REF TO zcl_params_management.

  PRIVATE SECTION.
    DATA:
      params_management TYPE REF TO zcl_params_management.

    METHODS on_tree_item_doble_clic
        FOR EVENT item_double_click OF cl_gui_alv_tree
      IMPORTING
        !fieldname
        !node_key.

    METHODS on_toolbar
        FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING
        !e_object
        !e_interactive.

    METHODS on_user_command
        FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING
        !e_ucomm.

ENDCLASS.
