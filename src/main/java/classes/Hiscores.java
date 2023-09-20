package classes;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Hiscores {

    public ArrayList<String> stats = new ArrayList<String>();

    public Hiscores(String playerName) {
        getPlayerStats(playerName);
    }


    public int getLevel(MySkills skill) {
        try {
            int index = skill.getLevelIndex();
            String[] array = stats.get(index).split(",");

            return Integer.parseInt(array[1]);
        } catch (Exception e) {
            return 1;
        }

    }

    public int getExperience(MySkills skill) {
        int index = skill.getLevelIndex();
        String[] array = stats.get(index).split(",");
        return Integer.parseInt(array[2]);
    }


    public int getExperience() {
        String[] array = new String[7];
        for (int i = 1; i <= 7; i++) {
            array = stats.get(i).split(",");
        }
        return Integer.parseInt(array[2]);
    }


    private void getPlayerStats(final String playerName) {
        try {
            URL url = new URL("https://secure.runescape.com/m=hiscore_oldschool/index_lite.ws?player=" + playerName);
            URLConnection connection = url.openConnection();
            BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));

            String inputLine;
            while ((inputLine = br.readLine()) != null) {
                stats.add(inputLine);
            }
            br.close();
        } catch (IOException e) {
            e.printStackTrace();

        }
    }

    private void getPlayerStats(List<String> playerNames) {
        for (int i = 0; i < playerNames.size(); i++) {
            System.out.println("Adicionando stats de: "+playerNames.get(i));
            try {
                URL url = new URL("https://secure.runescape.com/m=hiscore_oldschool/index_lite.ws?player=" + playerNames.get(i));
                URLConnection connection = url.openConnection();
                BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));

                String inputLine;
                while ((inputLine = br.readLine()) != null) {
                    System.out.println("\nStats: "+inputLine);
                    stats.add(inputLine);
                    System.out.println("\nInput line: "+inputLine);
                }
                br.close();
            } catch (IOException e) {
                e.printStackTrace();

            }
        }
        System.out.println("Stats finais: "+stats);
    }
}