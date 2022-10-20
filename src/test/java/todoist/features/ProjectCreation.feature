Feature: Project creation

  Background:
    Given url todoisturl
#    * def create_new_project = read("classpath:todoist/steps/create_new_project.feature")
    * def project_exists = read("classpath:todoist/steps/create_new_project.feature")
    * def get_project_details = read("classpath:todoist/steps/get_project_details.feature")
    * def get_all_projects = read("classpath:todoist/steps/get_all_projects.feature")

  Scenario: User can create a project
    Given def projectData = { name: "Jeszcze lepsze szkolenie Karate" }
    When call step.project.create_new_project projectData
    Then match response contains projectData
@ignore
  Scenario: User can get project details
    Given call project_exists { name: "projekt na pobranie detali" }
    * def projectData = response
    When call get_project_details projectData
    Then match response contains projectData

  Scenario: User can get all projects
    Given call project_exists { name: "projekt na pobranie wszystkich projektów" }
    * def projectData = response
    When call get_all_projects
    Then match response[*] contains deep projectData

    @ignore
  Scenario Outline: User can create custom project

    Given header Authorization = "Bearer " +  token
    * def projectData = { name: "<name>", is_favorite: <favorite>, "view_style": "<view>" }
    * def payload = read("classpath:todoist/model/new_project.json")
    * request payload
    * path "/projects"
    When method post
    Then status 200
    * match response contains projectData
    * set projectData.id = response.id

    Given header Authorization = "Bearer " + token
    * path "/projects/", projectData.id
    When method get
    Then status 200
    * match response contains projectData

    Examples:
      | name                 | favorite | view  | description                                |
      | Ulubiony projekt     | true     | board | this scenario creats favorite project      |
      | Nie ulubiony projekt | false    | list  | this scenario creates not favorite project |