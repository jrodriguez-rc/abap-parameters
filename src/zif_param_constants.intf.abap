"! <p class="shorttext synchronized" lang="en">Parameter Constants</p>
INTERFACE zif_param_constants
  PUBLIC.

  CONSTANTS:
    "! <p class="shorttext synchronized" lang="en">C (Create) - R (Read) - U (Update) - D (Delete)</p>
    BEGIN OF crud,
      create TYPE lrm_crud_mode VALUE 'C' ##NO_TEXT,
      read   TYPE lrm_crud_mode VALUE 'R' ##NO_TEXT,
      update TYPE lrm_crud_mode VALUE 'U' ##NO_TEXT,
      delete TYPE lrm_crud_mode VALUE 'D' ##NO_TEXT,
    END OF crud.

ENDINTERFACE.
