Feature: Project creation


  Scenario: User can create a project

    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"
    * header Authorization = "Bearer " +  token
    * request { name: "Szkolenie Karate" }
    * path "/projects"
    When method post
    Then status 200
    * match response.name == "Szkolenie Karate"

    * header Authorization = "Bearer " + token
    * path "/projects/", "2300721998"
    When method get
    Then status 200
    * match response.id == "2300721998"
    * match response.name == "Szkolenie Karate"

    * header Authorization = "Bearer " + token
    * path "/projects"
    When method get
    Then status 200
    * match response[*] contains deep { id: "2300721998", name: "Szkolenie Karate" }
