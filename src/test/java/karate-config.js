function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    step: {
        project: {
            create_new_project: read("classpath:todoist/steps/create_new_project.feature")
        },
        task: {
        }
    }
  }
  if (env == 'dev') {
    config.todoisturl = "https://api.todoist.com/rest/v2"
    config.token = "d469ce54eca3a7ca5b6b5e7d4c8d51ced8d4c7b1"
  } else if (env == 'e2e') {
    config.todoisturl = "https://todoist.pl"
    config.token = "INVALID"
  } else if (env == 'qa') {

  }
  return config;
}