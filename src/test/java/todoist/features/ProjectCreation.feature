Feature: Project creation



  Scenario: User can create a project

    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"
    * def projectName = "Lepsze szkolenie Karate"
    * header Authorization = "Bearer " + token
    * request { name: "#(projectName)" }
    * path "/projects"
    When method post
    Then status 200
    * match response.name == projectName
    * def projectId = response.id

    * header Authorization = "Bearer " + token
    * path "/projects", projectId
    When method get
    Then status 200
    * match response.name == projectName

    * header Authorization = "Bearer " + token
    * path "/projects"
    When method get
    Then status 200
    * match response[*] contains deep { id: "#(projectId)", name: "#(projectName)" }

  Scenario: User can create favorite project

    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"
    * def projectName = "Moj ulubiony projekt"
    * def projectIsFavorite = true
    * header Authorization = "Bearer " + token
    * request { name: "#(projectName)", is_favorite: "#(projectIsFavorite)" }
    * path "/projects"
    When method post
    Then status 200
    * match response.name == projectName
    * match response.is_favorite == projectIsFavorite
    * def projectId = response.id

    * header Authorization = "Bearer " + token
    * path "/projects", projectId
    When method get
    Then status 200
    * match response.name == projectName
    * match response.is_favorite == projectIsFavorite
