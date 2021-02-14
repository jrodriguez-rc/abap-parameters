INTERFACE zif_params_constants
  PUBLIC.

  CONSTANTS:
    BEGIN OF crud,
      create TYPE lrm_crud_mode VALUE 'C' ##NO_TEXT,
      read   TYPE lrm_crud_mode VALUE 'R' ##NO_TEXT,
      update TYPE lrm_crud_mode VALUE 'U' ##NO_TEXT,
      delete TYPE lrm_crud_mode VALUE 'D' ##NO_TEXT,
    END OF crud.

ENDINTERFACE.
