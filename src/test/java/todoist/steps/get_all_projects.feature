Feature: get_all_projects

  Scenario:
    Given header Authorization = "Bearer " + token
    * path "/projects"
    When method get
    Then status 200