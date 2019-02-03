package ucm.fdi.android.speechtotext;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.speech.RecognizerIntent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;

import java.io.InputStream;
import java.util.Locale;

import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.speech.tts.TextToSpeech;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.concurrent.ExecutionException;

public class MainActivity extends AppCompatActivity {

    private static final int REQ_CODE_SPEECH_INPUT = 100;
    private static TextToSpeech t;
    private ImageButton mSpeakBtn;
    private Locale locSpanish = new Locale("es", "ES");
    private SendAndReceiveTask mTask = null;

    private static JSONObject resultado;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mSpeakBtn = (ImageButton) findViewById(R.id.btnSpeak);
        t = new TextToSpeech(getApplicationContext(), new TextToSpeech.OnInitListener() {
            @Override
            public void onInit(int status) {
                if(status != TextToSpeech.ERROR){
                    t.setLanguage(locSpanish);
                }
            }
        });
        mSpeakBtn.setOnClickListener(new View.OnClickListener(){
            public void onClick (View v){
                //startVoiceInput();

                //NOTE: Only for debugging
                start();
            }
        });
    }

    private void start(){
        String result = "Busca libros de Harry Potter";
        newSimpleEntryText(result, true);
        mTask = new SendAndReceiveTask(result, this);
        mTask.execute();
    }

    private void startVoiceInput() {
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, Locale.getDefault());
        try {
            startActivityForResult(intent, REQ_CODE_SPEECH_INPUT);
        } catch (ActivityNotFoundException a) {

        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        switch (requestCode) {
            case REQ_CODE_SPEECH_INPUT: {
                if (resultCode == RESULT_OK && null != data) {
                    ArrayList<String> result = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);
                    newSimpleEntryText(result.get(0), true);
                    mTask = new SendAndReceiveTask(result.get(0), this);
                    mTask.execute();
                }
                break;
            }

        }
    }

    private void formatResponse(JSONObject resultado) throws JSONException {
        if(resultado.get("errorno").toString().equals("0")){
            String aux = resultado.get("content-type").toString();
            if(resultado.get("content-type").toString().equals("text")){
                newSimpleEntryText(resultado.get("response").toString(), false);
            }else if (resultado.get("content-type").toString().equals("single-book")||resultado.get("content-type").toString().equals("list-books")){
                newSimpleEntryText(resultado.get("response").toString(),false);
                newObjectEntry(resultado);
            }
        }
    }

    private void newObjectEntry(JSONObject resultado) {
        LinearLayout linearLayout = (LinearLayout) findViewById(R.id.conversationContainer);
        //ListView listView = new ListView(this);
        //LinearLayout objectContainer = new LinearLayout(this);
        TextView mResponse = new TextView(this);
        TextView mInfo = new TextView(this);
        ImageView mCover = new ImageView(this);

        //listView.setBackgroundResource(R.drawable.bocadillo_janet_patch);

        LayoutParams layoutParams = new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
        layoutParams.gravity = Gravity.LEFT;

        mCover.setLayoutParams(layoutParams);
        mResponse.setLayoutParams(layoutParams);
        mInfo.setLayoutParams(layoutParams);

        try {
            ArrayList<Bitmap> arrayBMP = new ArrayList<Bitmap>();
            ArrayList<InfoObject> allObject = new ArrayList<InfoObject>();
            JSONArray books = resultado.getJSONArray("books");
            for(int i = 0; i < books.length(); ++i) {
                String url = books.getJSONObject(i).get("cover-art").toString();
                Bitmap bmp = new DownloadImageTask(mCover).execute(url).get();

                String title = books.getJSONObject(i).get("title").toString();
                String author = books.getJSONObject(i).get("author").toString();
                String oclcCode = books.getJSONObject(i).get("oclc").toString();
                InfoObject infoObject = new InfoObject(title, author, oclcCode,bmp);
                allObject.add(infoObject);
                arrayBMP.add(bmp);

                linearLayout.addView(fillObjectContainer(infoObject));
            }
            //objectContainer.setLayoutParams(layoutParams);
            //objectContainer.setBackgroundResource(R.drawable.bocadillo_janet_patch);
            //linearLayout.addView(objectContainer);
            //CustomAdapter customAdapter = new CustomAdapter(this, allObject, arrayBMP);

            //ViewGroup.LayoutParams par = new LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            //listView.setLayoutParams(layoutParams);
            //listView.setScrollContainer(false);
            //listView.setAdapter(customAdapter);

            //listView.setLayoutParams(layoutParams);
            //linearLayout.addView(listView);

            //linearLayout.setScrollContainer(false);
            //linearLayout.setBackgroundResource(R.drawable.bocadillo_janet_patch);
        } catch (JSONException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }

    }

    private LinearLayout fillObjectContainer(InfoObject info){
        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.HORIZONTAL);
        LayoutParams params = new LayoutParams(LayoutParams.WRAP_CONTENT,LayoutParams.WRAP_CONTENT);

        TextView text = new TextView(this);
        ImageView image = new ImageView(this);

        image.setImageBitmap(info.cover);
        text.setText(info.title + "\n"+info.author);

        text.setLayoutParams(params);
        image.setLayoutParams(params);

        layout.addView(image);
        layout.addView(text);

        layout.setLayoutParams(params);
        layout.setBackgroundResource(R.drawable.bocadillo_janet_patch);

        return layout;

    }

    private void newSimpleEntryText(String message, boolean isUser) {

        LinearLayout linearLayout = (LinearLayout) findViewById(R.id.conversationContainer);
        TextView mTextViewMessage = new TextView(this);
        LayoutParams layoutParams = new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
        if (!isUser){
            layoutParams.gravity = Gravity.LEFT;
            mTextViewMessage.setBackgroundResource(R.drawable.bocadillo_janet_patch);
            t.speak(message, TextToSpeech.QUEUE_FLUSH, null, null);
        }else{
            layoutParams.gravity = Gravity.RIGHT;
            mTextViewMessage.setBackgroundResource(R.drawable.bocadillo_user_patch);
        }
        mTextViewMessage.setLayoutParams(layoutParams);
        mTextViewMessage.setText(message);
        linearLayout.addView(mTextViewMessage);

    }

    public static void justifyListViewHeightBasedOnChildren (ListView listView) {

        ListAdapter adapter = listView.getAdapter();

        if (adapter == null) {
            return;
        }
        ViewGroup vg = listView;
        int totalHeight = 0;
        for (int i = 2; i < adapter.getCount(); i++) {
            View listItem = adapter.getView(i, null, vg);
            listItem.measure(0, 0);
            int aux2 = listItem.getHeight();
            totalHeight += listItem.getMeasuredHeight();
        }

        ViewGroup.LayoutParams par = listView.getLayoutParams();
        par.height = 0;//totalHeight + (listView.getDividerHeight() * (adapter.getCount() - 1));
        listView.setLayoutParams(par);
        listView.requestLayout();
    }

    private class SendAndReceiveTask extends AsyncTask<Void, Void, Boolean>{

        private final String message;
        private final Context ctx;

        SendAndReceiveTask(String _message, Context _ctx){
            message = _message;
            ctx = _ctx;
        }

        @Override
        protected Boolean doInBackground(Void... voids) {
            //En esta funcion se envian los datos al servidor y se deshabilita el boton
            Connection conn = new Connection();
            String type = "query";
            resultado = conn.ejecutar("type="+type,"content=" + message);
            //TODO: mostrar errores en toast
            try {
                String aux = resultado.get("errorno").toString();
                if(!resultado.get("errorno").toString().equals("0")){
                    return false;
                }
            } catch (JSONException e) {
                e.printStackTrace();
                return false;
            }

            return true;
        }

        @Override
        protected void onPostExecute(final Boolean success) {
            if(!success){
                try {
                    Toast.makeText(ctx,resultado.get("errorMessage").toString() ,Toast.LENGTH_LONG).show();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }else{
                try {
                    formatResponse(resultado);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }

    }

    private class DownloadImageTask extends AsyncTask<String, Void, Bitmap> {
        ImageView bmImage;

        public DownloadImageTask(ImageView bmImage) {
            this.bmImage = bmImage;
        }

        protected Bitmap doInBackground(String... urls) {
            String urldisplay = urls[0];
            Bitmap mIcon11 = null;
            try {
                InputStream in = new java.net.URL(urldisplay).openStream();
                mIcon11 = BitmapFactory.decodeStream(in);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return mIcon11;
        }

        protected void onPostExecute(Bitmap result) {
            bmImage.setImageBitmap(result);
        }
    }

    public class InfoObject{
        private String title;
        private String author;
        private String oclcCode;
        private Bitmap cover;

        public InfoObject(String _title, String _author, String _oclcCode, Bitmap _cover){
            title = _title;
            author = _author;
            oclcCode = _oclcCode;
            cover = _cover;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getAuthor() {
            return author;
        }

        public void setAuthor(String author) {
            this.author = author;
        }

        public String getOclcCode() {
            return oclcCode;
        }

        public void setOclcCode(String oclcCode) {
            this.oclcCode = oclcCode;
        }

        public Bitmap getCover() {
            return cover;
        }

        public void setCover(Bitmap cover) {
            this.cover = cover;
        }
    }
}
