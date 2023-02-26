package is.yarr.hot_foods_backend.enums;

public enum DiningLocations {
    COLLEGE_GRIND("The College Grind"),
    ARTESANO("Artesano Bakery & Caf"),
    GRACIES("Gracie's"),
    BEANZ("Beanz"),
    SOLZ("Sol's Underground"),
    BRICK_CITY("Brick City Caf"),
    CROSSROADS_MARKET("Caf & Market at Crossroads"),
    COMMONS("The Commons"),
    CTRL_ALT_DELI("Ctrl Alt Deli"),
    GV_GRILL("Global Grille at Global Village"),
    MIDNIGHT_OIL("Midnight Oil"),
    RITZ("RITz Sport Zone"),
    SALSARITAS("Salsarita's at Global Village");

    private String name;

    DiningLocations(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
