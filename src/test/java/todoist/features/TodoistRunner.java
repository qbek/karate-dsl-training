package todoist.features;

import com.intuit.karate.junit5.Karate;

class TodoistRunner {
    
    @Karate.Test
    Karate testByFeatureName() {
        return Karate.run("ProjectCreation", "TaskCreation").relativeTo(getClass());
    }

    @Karate.Test
    Karate testByTag() {
        return Karate.run().tags("@toExecute").relativeTo(getClass());
    }

    @Karate.Test
    Karate testNotByTag() {
        return Karate.run().tags("~@ignore").relativeTo(getClass());
    }

}
