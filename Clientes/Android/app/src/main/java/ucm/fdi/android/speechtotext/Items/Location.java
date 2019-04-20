package ucm.fdi.android.speechtotext.Items;

public class Location {

    private String library;
    private String location;
    private String latitud;
    private String longitud;

    public Location(String library, String location, String latitud, String longitud) {
        this.library = library;
        this.location = location;
        this.latitud = latitud;
        this.longitud = longitud;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getLibrary() {
        return library;
    }

    public void setLibrary(String library) {
        this.library = library;
    }

    public String getLatitud() {
        return latitud;
    }

    public void setLatitud(String latitud) {
        this.latitud = latitud;
    }

    public String getLongitud() {
        return longitud;
    }

    public void setLongitud(String longitud) {
        this.longitud = longitud;
    }
}
