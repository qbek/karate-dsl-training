Feature: Task creation

  Background:
    Given url todoisturl

  Scenario: User can add task to the existing project

    Given def preconditionProjectData = { name: "#(randomProjectName())" }
    * def taskData = { content: "#(randomTaskName())" }
    * call read("classpath:todoist/steps/create_new_project.feature") preconditionProjectData
    * set taskData.project_id = response.id

    Given header Authorization = "Bearer " +  token
    * def payload = read("classpath:todoist/model/new_task.json")
    * request payload
    * path "/tasks"
    When method post
    Then status 200
    * match response contains taskData
    * set taskData.id = response.id

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


