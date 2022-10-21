Feature: Iteration retry

  Background:
    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"
    * def create_new_project = read("classpath:todoist/steps/create_new_project.feature")
    * def get_project_details = read("classpath:todoist/steps/get_project_details.feature")
    * def get_all_projects = read("classpath:todoist/steps/get_all_projects.feature")

  Scenario: Wait until project set to favorite

    Given call create_new_project { name: "Dodaj mnie do ulubionych" }
    * def projectData = response

    * configure retry = { count: 10, interval: 2000 }
    * retry until response.is_favorite == true
    When call get_project_details projectData

  Scenario: Wait until project STOP exists

    * configure retry = { count: 10, interval: 2000 }
    * retry until response.filter( project => project.name == "STOP").length == 1
    When call get_all_projects

  Scenario: test

    * print myVarName