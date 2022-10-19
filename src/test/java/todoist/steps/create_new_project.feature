Feature: Create new project

  Scenario:
    Given header Authorization = "Bearer " +  token
    * def projectData = { name: "#(name)" }
    * def payload = read("classpath:todoist/model/new_project.json")
    * request payload
    * path "/projects"
    When method post
    Then status 200
