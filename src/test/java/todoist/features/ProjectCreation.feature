Feature: Project creation

  Background:
    Given url todoisturl
    * def project_exists = read("classpath:todoist/steps/create_new_project.feature")
    * def get_project_details = read("classpath:todoist/steps/get_project_details.feature")
    * def get_all_projects = read("classpath:todoist/steps/get_all_projects.feature")


  Scenario: User can create a project

    Given def projectData = { name: "Moj projekt" }
    When call step.create_new_project projectData
    Then match response contains projectData


  Scenario: User can get project details

    Given call project_exists { name: "Projekt na sprawdzenie detali" }
    * def projectData = response
    When call get_project_details projectData
    Then match response contains projectData


  Scenario: User can get all projects

    Given call project_exists { name: "Projekt na sprawdzenie detali" }
    * def projectData = response
    When call get_all_projects
    Then match response[*] contains deep projectData


  Scenario Outline: User can create custom project
    
    Given def projectData = { name: "<name>", is_favorite: <favorite>, "view_style": "<style>" }
    * def payload = read("classpath:todoist/model/new_project.json")
    * header Authorization = "Bearer " + token
    * request payload
    * path "/projects"
    When method post
    Then status 200
    * match response contains projectData
    * def projectData = response

    Given header Authorization = "Bearer " + token
    * path "/projects", projectData.id
    When method get
    Then status 200
    * match response contains projectData

    Examples:
      | name                         | favorite | style | description                              |
      | Moj ulubiony projekt         | true     | list  | User creates custom favorite project     |
      | To nie jest ulubiony projekt | null    | board | User creates custom not favorite project |
