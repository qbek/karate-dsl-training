Feature: get_project_details

  Scenario:
    Given path "/projects", id
    When method get
    Then status 200