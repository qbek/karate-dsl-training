Feature: Project creation

  Background:
    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"


  Scenario: User can create a project

    Given header Authorization = "Bearer " + token
    * def projectName = "Moj projekt"
    * def payload = read("classpath:todoist/model/new_project.json")
    * request payload
    * path "/projects"
    When method post
    Then status 200
    * match response.name == projectName
    * def projectId = response.id

    Given header Authorization = "Bearer " + token
    * path "/projects", projectId
    When method get
    Then status 200
    * match response.name == projectName

    Given header Authorization = "Bearer " + token
    * path "/projects"
    When method get
    Then status 200
    * match response[*] contains deep { id: "#(projectId)", name: "#(projectName)" }

  Scenario: User can create favorite project

    Given def projectIsFavorite = true
    * def projectName = "Moj ulubiony projekt"
    * def payload = read("classpath:todoist/model/new_project.json")
    * set payload.is_favorite = projectIsFavorite
    * header Authorization = "Bearer " + token
    * request payload
    * path "/projects"
    When method post
    Then status 200
    * match response.name == projectName
    * match response.is_favorite == projectIsFavorite
    * def projectId = response.id

    Given header Authorization = "Bearer " + token
    * path "/projects", projectId
    When method get
    Then status 200
    * match response.name == projectName
    * match response.is_favorite == projectIsFavorite


