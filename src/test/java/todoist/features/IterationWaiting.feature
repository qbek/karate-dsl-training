Feature: Iteration  waiting

  Background:
    Given url "https://api.todoist.com/rest/v2"
    * def token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"
    * def create_new_project = read("classpath:todoist/steps/create_new_project.feature")


    * def project_exists = read("classpath:todoist/steps/create_new_project.feature")
    * def get_project_details = read("classpath:todoist/steps/get_project_details.feature")
    * def get_all_projects = read("classpath:todoist/steps/get_all_projects.feature")

  Scenario: Wait until user marks project as favoirte
    Given call project_exists  { name: "Czekam az bede ulubiony" }
    * def projectData = response

    * configure retry = { count: 20, interval: 2000 }
    * retry until response.is_favorite == true
    When def detailsResponse = call get_project_details projectData
    * print detailsResponse

  Scenario: Wait until STOP project exists

    Given header Authorization = "Bearer " + token
    * path "/projects/"

    # czekaj za user doda projekt STOP
    When method get
    Then status 200


