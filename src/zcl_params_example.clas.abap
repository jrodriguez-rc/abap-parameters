CLASS zcl_params_example DEFINITION
  PUBLIC
  INHERITING FROM zcl_params
  FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_params.

  PUBLIC SECTION.
    CLASS-DATA:
      example_class_active TYPE abap_bool VALUE abap_true READ-ONLY.

    CLASS-METHODS class_constructor.

    METHODS constructor
      IMPORTING
        iv_refresh TYPE abap_bool DEFAULT abap_true.

    METHODS zif_params~get_description
        REDEFINITION.

    METHODS zif_params~get_img_subobject
        REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_params_example IMPLEMENTATION.


  METHOD constructor.

    super->constructor( iv_clsname = `ZCL_PARAMS_EXAMPLE` iv_refresh = iv_refresh ).

  ENDMETHOD.


  METHOD class_constructor.

    DATA:
      lo_example TYPE REF TO zcl_params_example.

    CREATE OBJECT lo_example.

  ENDMETHOD.


  METHOD zif_params~get_description.

    rv_description = 'Example class'(001).

  ENDMETHOD.


  METHOD zif_params~get_img_subobject.

    rv_subobject = 'ZTSTPARAMS'.

  ENDMETHOD.


ENDCLASS.
