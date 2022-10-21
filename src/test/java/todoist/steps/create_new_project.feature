Feature: create new project

  Scenario:
    * def randomUUID =
    """
    function () {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    }
    """

    * def javaRandomUUID =
    """
    function () {
      var UUID = Java.type("java.util.UUID")
      return UUID.randomUUID()
    }
    """

    Given def projectData = { name: "#(name)" }
    * def payload = read("classpath:todoist/model/new_project.json")
    * header Authorization = "Bearer " + token
    * header X-Request-Id = javaRandomUUID()
    * request payload
    * path "/projects"
    When method post
    Then status 200

