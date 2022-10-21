package todoist.features;

import com.intuit.karate.junit5.Karate;

class TodoistRunner {

    @Karate.Test
    Karate allTests() {
        return Karate.run().relativeTo(getClass());
    }

    @Karate.Test
    Karate testByFeatureName() {
        return Karate.run("TaskCreation").relativeTo(getClass());
    }    

    @Karate.Test
    Karate testByTag() {
        return Karate.run().tags("@run").relativeTo(getClass());
    }

    @Karate.Test
    Karate testNotByTag() {
        return Karate.run().tags("~@dontrun").relativeTo(getClass());
    }

}

