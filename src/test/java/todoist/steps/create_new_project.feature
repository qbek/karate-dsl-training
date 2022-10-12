Feature: create new project

  Scenario:
    Given def projectData = { name: "#(name)" }
    * def payload = read("classpath:todoist/model/new_project.json")
    * header Authorization = "Bearer " + token
    * request payload
    * path "/projects"
    When method post
    Then status 200