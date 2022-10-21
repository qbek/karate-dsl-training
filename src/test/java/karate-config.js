function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    javaRandomUUID: function () {
      var UUID = Java.type("java.util.UUID")
      return UUID.randomUUID()
    },
    step: {
        create_new_project: read("classpath:todoist/steps/create_new_project.feature")
    }
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}