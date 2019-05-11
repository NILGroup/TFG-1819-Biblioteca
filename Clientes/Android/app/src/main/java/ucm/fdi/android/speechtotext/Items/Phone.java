/*
 * Phone.java
 * Created by Jose Luis Moreno on 5/11/19 9:49 PM
 * MIT License
 * Copyright (c) 2019 . Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
 * Last modified 5/5/19 1:15 PM
 */

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
