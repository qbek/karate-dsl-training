Feature: Project creation

  Background:
    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"

  Scenario: User can create a project


    Given def projectData = { name: "Jeszcze lepsze szkolenie Karate" }
    * call read("classpath:todoist/steps/create_new_project.feature") projectData
    * match response contains projectData
    * def projectData = response

    Given call read("classpath:todoist/steps/get_project_details.feature") projectData
    * match response contains projectData

    Given call read("classpath:todoist/steps/get_all_projects.feature")
    * match response[*] contains deep projectData

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