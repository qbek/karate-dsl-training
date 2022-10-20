package todoist.aux;

import com.github.javafaker.Faker;

public class DataGenerator {

    private static Faker generator = new Faker();

    public static String randomProjectName() {
        return generator.leagueOfLegends().champion();
    }

    public static String randomTaskName() {
        return generator.chuckNorris().fact();
    }
}
