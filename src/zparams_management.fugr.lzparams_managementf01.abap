*----------------------------------------------------------------------*
***INCLUDE LZPARAMS_MANAGEMENTF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  BEFORE_PBO_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM before_pbo_0100.

  go_prc->before_pbo( ).

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PBO_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM pbo_0100.

  go_prc->pbo( ).

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  AFTER_PBO_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM after_pbo_0100.

  go_prc->after_pbo( ).

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PAI_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM pai_0100.

  IF go_prc->pai( gv_ucomm_0100 ) = abap_true.
    go_prc->destroy( ).
    SET SCREEN 0.
    LEAVE SCREEN.
  ENDIF.

ENDFORM.
