Feature: get_project_details

  Scenario:
    Given header Authorization = "Bearer " + token
    * path "/projects", id
    When method get
    Then status 200