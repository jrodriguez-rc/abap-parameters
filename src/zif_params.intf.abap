"! <p class="shorttext synchronized" lang="en">Parameters</p>
INTERFACE zif_params
  PUBLIC.

  "! <p class="shorttext synchronized" lang="en">Get IMG Subobject</p>
  "! Filter class by an assigned object in IMG Activity Maintenance Object
  "!
  "! @parameter rv_subobject | <p class="shorttext synchronized" lang="en">IMG Subobject</p>
  METHODS get_img_subobject
    RETURNING
      VALUE(rv_subobject) TYPE ob_subobj.

  "! <p class="shorttext synchronized" lang="en">Get description</p>
  "! This description is shown in Parameters Maintenance Tool to define a class name
  "!
  "! @parameter rv_description | <p class="shorttext synchronized" lang="en">Description</p>
  METHODS get_description
    RETURNING
      VALUE(rv_description) TYPE string.

ENDINTERFACE.
