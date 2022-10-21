@run
Feature: Task creation

  Background:
    Given url todoisturl

  Scenario: User can add task to the project

    Given call step.create_new_project { name: "#(generator.randomProjectName())" }

    Given def taskData  = { content: "#(generator.randomTaskName())", project_id: "#(response.id)" }
    * def payload = read("classpath:todoist/model/new_task.json")
    * header Authorization = "Bearer " + token
    * request payload
    * path "/tasks"
    When method post
    Then status 200
    * match response contains taskData
    * def taskData = response

    Given header Authorization = "Bearer " + token
    * path "/tasks", taskData.id
    When method get
    Then status 200
    * match response contains taskData

    Given header Authorization = "Bearer " + token
    * path "/tasks"
    When method get
    Then status 200
    * match response[*] contains deep taskData