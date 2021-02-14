CLASS zcx_params DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS:
      "! Error while creating parameter &1 &2
      BEGIN OF error_at_creation,
        msgid TYPE symsgid VALUE 'ZPARAMS',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'TEXT1',
        attr2 TYPE scx_attrname VALUE 'TEXT2',
        attr3 TYPE scx_attrname VALUE 'TEXT3',
        attr4 TYPE scx_attrname VALUE 'TEXT4',
      END OF error_at_creation.
    CONSTANTS:
      "! Error while updating parameter &1 &2
      BEGIN OF error_at_update,
        msgid TYPE symsgid VALUE 'ZPARAMS',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'TEXT1',
        attr2 TYPE scx_attrname VALUE 'TEXT2',
        attr3 TYPE scx_attrname VALUE 'TEXT3',
        attr4 TYPE scx_attrname VALUE 'TEXT4',
      END OF error_at_update.
    CONSTANTS:
      "! Error while deleting parameter &1 &2
      BEGIN OF error_at_delete,
        msgid TYPE symsgid VALUE 'ZPARAMS',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'TEXT1',
        attr2 TYPE scx_attrname VALUE 'TEXT2',
        attr3 TYPE scx_attrname VALUE 'TEXT3',
        attr4 TYPE scx_attrname VALUE 'TEXT4',
      END OF error_at_delete.
    CONSTANTS:
      "! Error generating data type &1
      BEGIN OF error_generating_data_type,
        msgid TYPE symsgid VALUE 'ZPARAMS',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'TEXT1',
        attr2 TYPE scx_attrname VALUE 'TEXT2',
        attr3 TYPE scx_attrname VALUE 'TEXT3',
        attr4 TYPE scx_attrname VALUE 'TEXT4',
      END OF error_generating_data_type.
    CONSTANTS:
      "! Value &1 is not compatible with data type &2
      BEGIN OF value_not_valid,
        msgid TYPE symsgid VALUE 'ZPARAMS',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'TEXT1',
        attr2 TYPE scx_attrname VALUE 'TEXT2',
        attr3 TYPE scx_attrname VALUE 'TEXT3',
        attr4 TYPE scx_attrname VALUE 'TEXT4',
      END OF value_not_valid.

    INTERFACES:
      if_t100_dyn_msg,
      if_t100_message .

    DATA:
      text1 TYPE sstring READ-ONLY,
      text2 TYPE sstring READ-ONLY,
      text3 TYPE sstring READ-ONLY,
      text4 TYPE sstring READ-ONLY.

    "! <p class="shorttext synchronized" lang="en">Triggers a Static Exception from a System Message</p>
    "!
    "! @raising   zcx_params | <p class="shorttext synchronized" lang="en">Resulto: Static Exception</p>
    CLASS-METHODS raise_by_syst
      RAISING
        zcx_params .

    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    "!
    "! @parameter textid | <p class="shorttext synchronized" lang="en">Text ID</p>
    "! @parameter text1 | <p class="shorttext synchronized" lang="en">Message Text 1</p>
    "! @parameter text2 | <p class="shorttext synchronized" lang="en">Message Text 2</p>
    "! @parameter text3 | <p class="shorttext synchronized" lang="en">Message Text 3</p>
    "! @parameter text4 | <p class="shorttext synchronized" lang="en">Message Text 4</p>
    "! @parameter previous | <p class="shorttext synchronized" lang="en">Previous exception</p>
    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !text1    TYPE sstring OPTIONAL
        !text2    TYPE sstring OPTIONAL
        !text3    TYPE sstring OPTIONAL
        !text4    TYPE sstring OPTIONAL
        !previous LIKE previous OPTIONAL .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcx_params IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    me->text1 = text1.
    me->text2 = text2.
    me->text3 = text3.
    me->text4 = text4.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

  ENDMETHOD.


  METHOD raise_by_syst.

    DATA:
      ls_textid TYPE scx_t100key,
      lv_text1 TYPE sstring,
      lv_text2 TYPE sstring,
      lv_text3 TYPE sstring,
      lv_text4 TYPE sstring.

    ls_textid-msgid = sy-msgid.
    ls_textid-msgno = sy-msgno.
    ls_textid-attr1 = 'TEXT1'.
    ls_textid-attr2 = 'TEXT2'.
    ls_textid-attr3 = 'TEXT3'.
    ls_textid-attr4 = 'TEXT4'.

    lv_text1 = sy-msgv1.
    lv_text2 = sy-msgv2.
    lv_text3 = sy-msgv3.
    lv_text4 = sy-msgv4.

    RAISE EXCEPTION TYPE zcx_params
      EXPORTING
        textid = ls_textid
        text1  = lv_text1
        text2  = lv_text2
        text3  = lv_text3
        text4  = lv_text4.

  ENDMETHOD.


ENDCLASS.