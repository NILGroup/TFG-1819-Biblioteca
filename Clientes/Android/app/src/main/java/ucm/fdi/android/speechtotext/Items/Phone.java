package ucm.fdi.android.speechtotext.Items;

public class Phone {
    private String phone;
    private String library;

    public Phone(String phone, String library) {
        this.phone = phone;
        this.library = library;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLibrary() {
        return library;
    }

    public void setLibrary(String library) {
        this.library = library;
    }
}
