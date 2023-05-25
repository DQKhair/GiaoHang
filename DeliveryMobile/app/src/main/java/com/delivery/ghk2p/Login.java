package com.delivery.ghk2p;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.VolleyError;


public class Login extends Fragment {

    EditText edituser,editPassword;
    Button btnLogin;
    ApiHelper apiHelper;


    public Login(){

    }



    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_login, container, false);
        btnLogin = view.findViewById(R.id.BtnLogin);
        edituser = view.findViewById(R.id.editUser);
        editPassword = view.findViewById(R.id.editPassword);
        btnLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                apiHelper = new ApiHelper(getActivity().getApplicationContext(), "dangnhap/?user="+edituser.getText().toString()+"&pass="+editPassword.getText().toString());

                apiHelper.getResult(new ApiHelper.GoiHam()
                {

                    @Override
                    public void LayDuLieu(String ketqua) {
                        Toast.makeText(getActivity().getApplicationContext(),ketqua,Toast.LENGTH_LONG).show();
                    }

                    @Override
                    public void LayLoi(VolleyError loi) {

                    }
                });
            }
        });
        //Return view :)))) chứ k phải inflater.inflate(R.layout.fragment_login, container, false
        //Ảo chưa
        return view;


    }
}