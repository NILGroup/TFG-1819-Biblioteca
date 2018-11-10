package ucm.fdi.android.speechtotext;

import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.speech.RecognizerIntent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import java.util.Locale;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.speech.tts.TextToSpeech;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    private static final int REQ_CODE_SPEECH_INPUT = 100;
    private static TextToSpeech t;
    private ImageButton mSpeakBtn;
    private Locale locSpanish = new Locale("es", "ES");

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
                startVoiceInput();
            }
        });
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
                    newEntry(result.get(0), true);
                    newResponse(result.get(0));
                }
                break;
            }

        }
    }

    private void newEntry(String message, boolean isUser) {
        LinearLayout linearLayout = (LinearLayout) findViewById(R.id.conversationContainer);
        TextView mTextViewMessage = new TextView(this);
        mTextViewMessage.setTypeface(null, Typeface.BOLD);
        mTextViewMessage.setTextSize(15);
        LayoutParams layoutParams = new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);

        if(!isUser) {
            mTextViewMessage.setBackgroundResource(R.drawable.bocadillo_janet_patch);;
            t.speak(message, TextToSpeech.QUEUE_FLUSH, null, null);
        }else {
            mTextViewMessage.setBackgroundResource(R.drawable.bocadillo_user_patch);
            layoutParams.gravity = Gravity.RIGHT;
        }
        mTextViewMessage.setLayoutParams(layoutParams);
        mTextViewMessage.setText(message);
        linearLayout.addView(mTextViewMessage);

    }

    private void newResponse(String message){

        switch (message.toUpperCase()){
            case "HOLA":
                newEntry("Hola, soy Janet. ¿En qué te puedo ayudar?kñhgdsfhgsaflhjgsjfkhgsdakjgfksjafgkjdsahgfkasjhgfkasgfjkadsgfsajg", false);
                break;
            case "ADIÓS":
                newEntry("Adiós, que tenga un buen día.", false);
                break;
        }
    }
}
