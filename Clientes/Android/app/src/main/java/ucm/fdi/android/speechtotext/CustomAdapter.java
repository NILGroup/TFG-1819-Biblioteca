package ucm.fdi.android.speechtotext;

import android.content.Context;
import android.graphics.Bitmap;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.LinearLayout.LayoutParams;

import java.util.ArrayList;

public class CustomAdapter extends ArrayAdapter<MainActivity.InfoObject>{

    private Context ctx;
    private ArrayList<MainActivity.InfoObject> info;
    private ArrayList<Bitmap> image;
    public CustomAdapter(Context _ctx, ArrayList<MainActivity.InfoObject> _info, ArrayList<Bitmap> _image) {
        super(_ctx, R.layout.customadapter, _info);

        ctx = _ctx;
        info = _info;
        image = _image;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        LayoutInflater layoutInflater = (LayoutInflater) ctx.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        convertView = layoutInflater.inflate(R.layout.customadapter, null);

        LayoutParams layoutParams= new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);

        TextView mTextViewInfo = (TextView) convertView.findViewById(R.id.textViewInfo);
        ImageView mCover = (ImageView)convertView.findViewById(R.id.imageViewCover);

        mCover.setImageBitmap(image.get(position));
        mCover.getLayoutParams().height = image.get(position).getHeight();
        mCover.getLayoutParams().width = image.get(position).getWidth();
        String infoString = getFormatedInfo(info.get(position));
        mTextViewInfo.setText(infoString);
        mTextViewInfo.setLayoutParams(layoutParams);
        return convertView;
    }

    private String getFormatedInfo(MainActivity.InfoObject infoObject){
        return infoObject.getTitle() + "\n" + infoObject.getAuthor();
    }
}
