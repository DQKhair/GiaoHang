package com.delivery.ghk2p;

import android.content.Context;
import android.widget.Toast;

import com.android.volley.Cache;
import com.android.volley.Network;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.BasicNetwork;
import com.android.volley.toolbox.DiskBasedCache;
import com.android.volley.toolbox.HurlStack;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

public class ApiHelper {
    String ApiUrl = "http://171.248.149.70:2302/";
    private String action;

    private Context context;

    public ApiHelper(Context context,String action) {
        this.ApiUrl = ApiUrl+action;
        this.context = context;
    }

    public void getResult(final GoiHam callback) {
        RequestQueue requestQueue;

// Instantiate the cache
        Cache cache = new DiskBasedCache(context.getCacheDir(), 1024 * 1024); // 1MB cap

// Set up the network to use HttpURLConnection as the HTTP client.
        Network network = new BasicNetwork(new HurlStack());

// Instantiate the RequestQueue with the cache and network.
        requestQueue = new RequestQueue(cache, network);

        requestQueue.start();

        StringRequest stringRequest = new StringRequest(Request.Method.GET, ApiUrl,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        callback.LayDuLieu(response);
                    }
                }, new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        callback.LayLoi(error);
                    }
                }
        );
        requestQueue.add(stringRequest);
    }

    public interface GoiHam{
        void LayDuLieu(String ketqua);
        void LayLoi(VolleyError loi);
    }

}
