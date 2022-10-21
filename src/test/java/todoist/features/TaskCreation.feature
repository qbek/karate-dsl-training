Feature: Task creation

  Background:
    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"

  Scenario: User can add task to the project

    Given call step.create_new_project { name: "To jest lepszy projekt na zadanie" }

    Given def taskData  = { content: "Moje zadanie", project_id: "#(response.id)" }
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