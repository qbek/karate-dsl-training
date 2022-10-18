Feature: Project creation

  Background:
    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"


  Scenario: User can create a project

    Given header Authorization = "Bearer " +  token
    * def projectData = { name: "Jeszcze lepsze szkolenie Karate" }
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

    Given header Authorization = "Bearer " + token
    * path "/projects"
    When method get
    Then status 200
    * match response[*] contains deep projectData

  Scenario: User can create favorite project

    Given header Authorization = "Bearer " +  token
    * def projectData = { name: "Ulubione szkolenie Karate", is_favorite: true }
    * def payload = read("classpath:todoist/model/new_project.json")
    * set payload.is_favorite = projectData.is_favorite
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
