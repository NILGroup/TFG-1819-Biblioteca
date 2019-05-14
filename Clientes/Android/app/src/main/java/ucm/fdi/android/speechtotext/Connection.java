
/*
 * Connection.java
 * Created by Jose Luis Moreno on 5/11/19 9:49 PM
 * MIT License
 * Copyright (c) 2019 . Mauricio Abbati Loureiro - Jose Luis Moreno Varillas
 * Last modified 5/5/19 1:16 PM
 */

package ucm.fdi.android.speechtotext;

import org.json.JSONException;
import org.json.JSONObject;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

public class Connection {
    private final String url = "https://holstein.fdi.ucm.es/tfg-biblio/api";

    public JSONObject ejecutar(String type, String peticion) {

        JSONObject result = new JSONObject();

        if(url.contains("https"))
            result = connectWithHTTPS(result, type, peticion);
        else
            result = connect(result, type, peticion);
        return result;

    }

    private JSONObject connect(JSONObject result, String type, String peticion)
    {
        HttpURLConnection client = null;
        try {
            URL urlConnection = new URL(this.url);
            client = (HttpURLConnection) urlConnection.openConnection();
            client.setRequestProperty("Content-Type", "application/json;  charset=utf-8");
            client.setReadTimeout(20000);
            client.setConnectTimeout(20000);
            client.setRequestMethod("POST");
            client.setDoOutput(true);
            client.setDoInput(true);
            StringBuilder response = new StringBuilder();


            String query = type+"&"+peticion;
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(client.getOutputStream(), "UTF-8"));
            bw.write(query);
            bw.flush();
            bw.close();

            InputStream in = new BufferedInputStream(client.getInputStream());

            BufferedReader reader = new BufferedReader(new InputStreamReader(in));

            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();
            result = new JSONObject(response.toString());
        } catch (IOException e) {
            try {
                result.put("errorno", 404);
                result.put("errorMessage", "Existe un problema de conexion con el servidor");
            } catch (JSONException e1) {
                e1.printStackTrace();
            }

        } catch (JSONException e) {
            e.printStackTrace();
        } finally {
            if (client != null )
                client.disconnect();
            return result;
        }
    }

    private JSONObject connectWithHTTPS(JSONObject result, String type, String peticion)
    {
        HttpsURLConnection client = null;
        try {
            URL urlConnection = new URL(this.url);
            trustAllHosts();
            client = (HttpsURLConnection) urlConnection.openConnection();
            client.setReadTimeout(10000);
            client.setConnectTimeout(10000);
            client.setRequestMethod("POST");
            client.setDoOutput(true);
            client.setDoInput(true);
            StringBuilder response = new StringBuilder();

            String query = type+"&"+peticion;
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(client.getOutputStream(), "UTF-8"));
            bw.write(query);
            bw.flush();
            bw.close();

            InputStream in = new BufferedInputStream(client.getInputStream());

            BufferedReader reader = new BufferedReader(new InputStreamReader(in));

            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();
            result = new JSONObject(response.toString());
        } catch (IOException e) {
            try {
                result.put("errorno", 404);
                result.put("errorMessage", "Existe un problema de conexion con el servidor");
            } catch (JSONException e1) {
                e1.printStackTrace();
            }

        } catch (JSONException e) {
            e.printStackTrace();
        } finally {
            if (client != null )
                client.disconnect();
            return result;
        }
    }


    private static void trustAllHosts() {

        X509TrustManager easyTrustManager = new X509TrustManager() {

            public void checkClientTrusted(
                    X509Certificate[] chain,
                    String authType) throws CertificateException {
                // Oh, I am easy!
            }

            public void checkServerTrusted(
                    X509Certificate[] chain,
                    String authType) throws CertificateException {
                // Oh, I am easy!
            }

            public X509Certificate[] getAcceptedIssuers() {
                return null;
            }

        };

        // Create a trust manager that does not validate certificate chains
        TrustManager[] trustAllCerts = new TrustManager[] {easyTrustManager};

        // Install the all-trusting trust manager
        try {
            SSLContext sc = SSLContext.getInstance("TLS");

            sc.init(null, trustAllCerts, new java.security.SecureRandom());

            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
