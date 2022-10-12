Feature: Project creation

  Background:
    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"


  Scenario: User can create a project

    Given def testData = { name: "Moj projekt" }
    * def payload = read("classpath:todoist/model/new_project.json")
    * header Authorization = "Bearer " + token
    * request payload
    * path "/projects"
    When method post
    Then status 200
    * match response contains testData
    * def testData = response

    Given header Authorization = "Bearer " + token
    * path "/projects", testData.id
    When method get
    Then status 200
    * match response contains testData

    Given header Authorization = "Bearer " + token
    * path "/projects"
    When method get
    Then status 200
    * match response[*] contains deep testData

  Scenario Outline: User can create custom project
    
    Given def testData = { name: "<name>", is_favorite: <favorite>, "view_style": "<style>" }
    * def payload = read("classpath:todoist/model/new_project.json")
    * header Authorization = "Bearer " + token
    * request payload
    * path "/projects"
    When method post
    Then status 200
    * match response contains testData
    * def testData = response

    Given header Authorization = "Bearer " + token
    * path "/projects", testData.id
    When method get
    Then status 200
    * match response contains testData

    Examples:
      | name                         | favorite | style | description                              |
      | Moj ulubiony projekt         | true     | list  | User creates custom favorite project     |
      | To nie jest ulubiony projekt | null    | board | User creates custom not favorite project |
