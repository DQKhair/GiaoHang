package com.delivery.ghk2p;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.TextView;
import android.widget.Toast;
import com.android.volley.VolleyError;

import java.util.Objects;

public class MainActivity extends AppCompatActivity {
    FrameLayout frameLayout;

    Button btnLogin;
    EditText edituser,editPassword;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Objects.requireNonNull(getSupportActionBar()).hide();
        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_main);
        Fragment Login = new Login();

        FragmentManager fragmentManager = getSupportFragmentManager();
        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        fragmentTransaction.add(R.id.frame, Login );
        fragmentTransaction.commit();



        //Cách dùng ApiHelper
//        textView = findViewById(R.id.textView);


//        String action = "alo";
//        ApiHelper api = new ApiHelper(MainActivity.this,action);
//
//        api.getResult(new ApiHelper.GoiHam() {
//            @Override
//            public void LayDuLieu(String ketqua) {
//                textView.setText(ketqua);
//            }
//
//            @Override
//            public void LayLoi(VolleyError loi) {
//                textView.setText(loi.toString());
//            }
//        });
    }
    public void insertIntoDb(View v) {
    }
}