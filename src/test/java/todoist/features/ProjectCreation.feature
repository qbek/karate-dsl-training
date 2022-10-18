Feature: Project creation

  Scenario: User can create a project

    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"
    * header Authorization = "Bearer " +  token
    * def projectName = "Jeszcze lepsze szkolenie Karate"
    * request { name: "#(projectName)" }
    * path "/projects"
    When method post
    Then status 200
    * match response.name == projectName
    * def projectId = response.id

    Given header Authorization = "Bearer " + token
    * path "/projects/", projectId
    When method get
    Then status 200
    * match response.id == projectId
    * match response.name == projectName

    Given header Authorization = "Bearer " + token
    * path "/projects"
    When method get
    Then status 200
    * match response[*] contains deep { id: "#(projectId)", name: "#(projectName)" }
