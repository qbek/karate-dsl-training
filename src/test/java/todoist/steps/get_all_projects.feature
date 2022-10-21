Feature: get_all_projects

  Scenario:
    Given header Authorization = "Bearer " + token
    * header X-Request-Id = javaRandomUUID()
    * path "/projects"
    When method get
    Then status 200