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

import ucm.fdi.android.speechtotext.Items.Book;

public class CustomAdapter extends ArrayAdapter<Book>{

    private Context _ctx;
    private ArrayList<Book> _book;
    private ArrayList<Bitmap> _image;
    public CustomAdapter(Context _ctx, ArrayList<Book> _info, ArrayList<Bitmap> _image) {
        super(_ctx, R.layout.customadapter, _info);

        _ctx = _ctx;
        _info = _info;
        _image = _image;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        LayoutInflater layoutInflater = (LayoutInflater) _ctx.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        convertView = layoutInflater.inflate(R.layout.customadapter, null);

        LayoutParams layoutParams= new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);

        TextView mTextViewInfo = (TextView) convertView.findViewById(R.id.textViewInfo);
        ImageView mCover = (ImageView)convertView.findViewById(R.id.imageViewCover);

        mCover.setImageBitmap(_image.get(position));
        mCover.getLayoutParams().height = _image.get(position).getHeight();
        mCover.getLayoutParams().width = _image.get(position).getWidth();
        String infoString = getFormatedInfo(_book.get(position));
        mTextViewInfo.setText(infoString);
        mTextViewInfo.setLayoutParams(layoutParams);
        return convertView;
    }

    private String getFormatedInfo(Book book){
        return book.getTitle() + "\n" + book.getAuthor();
    }
}
