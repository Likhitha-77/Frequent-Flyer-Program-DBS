package com.example.freqflier;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ProgressBar;
import android.widget.Spinner;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.RetryPolicy;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import java.util.ArrayList;

public class MainActivity5 extends AppCompatActivity implements Spinner.OnItemSelectedListener {

    String aid = "";
    Spinner spinner;
    ArrayList<String> AWARDIds;
    RequestQueue queue;
    TextView textView12;
    TextView textView14;
    String[] result;
    TableLayout stk;
    ProgressBar progressBar;
    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main5);
        Intent intent=getIntent();
        aid=intent.getStringExtra("aid");
        texrrView12=findViewById(R.id.textView12);
        textView14=findViewById(R.id.textView14);

        stk = findViewById(R.id.tableLayout);
        textView12.setText("");
        textView14.setText("");
        progressBar=findViewById(R.id.progressBar4);
        queue= Volley.newRequestQueue(this);
        progressBar.setVisibility(View.VISIBLE);
        String url="http://127.0.0.1:8r080/frequentflier/AwardIds.jsp?pid="+aid;
        StringRequest request=new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String s) {
                progressBar.setVisibility(View.GONE);
                result=s.trim().split("#");

                initSpinner(result);
            }
        }, null);
        setRequestPolicy(request);
        queue.add(request);
    }

    public void initSpinner(String[] result) {
        spinner = findViewById(R.id.spinner);
        spinner.setOnItemSelectedListener(this);
        AWARDIds = new ArrayList<String>();
        AWARDIds.add("Select");
        for(int itr=0; itr< result.length; itr++) {
            AWARDIds.add(result[itr]);
        }
        spinner.setAdapter(new ArrayAdapter<String>(MainActivity5.this, android.R.layout.simple_spinner_dropdown_item, AWARDIds));
    }

    public void initTable(String[] result) {


        TableRow tableRow1 = new TableRow(this);
        TextView textView1 = new TextView(this);
        textView1.setText(" Redemption Date              ");
        tableRow1.addView(textView1);

        TextView textView2 = new TextView(this);
        textView2.setText(" Exchange Center                 ");
        tableRow1.addView(textView2);

        stk.addView(tableRow1);
        int totalPoints = 0;
        for (int itr =0; itr< result.length; itr++){
            String[] row = result[itr].split(",");
            String redemptionDate = row[2];
            String exchgCenter = row[3];
            totalPoints = totalPoints + Integer.parseInt(row[1]);
            TableRow tableRow = new TableRow(this);
            TextView redemptionDateView = new TextView(this);
            redemptionDateView.setText(" " + redemptionDate);
            tableRow.addView(redemptionDateView);

            TextView exchgCenterView = new TextView(this);
            exchgCenterView.setText(" " + exchgCenter);
            tableRow.addView(exchgCenterView);

            stk.addView(tableRow);
        }
        textView14.setText("Points Needed \n" + totalPoints + " Points");
        View endline = new View(this);
        endline.setLayoutParams(new TableLayout.LayoutParams(TableLayout.LayoutParams.FILL_PARENT, 3));
        endline.setBackgroundColor(Color.rgb(0, 188, 212));
        stk.addView(endline);
    }

    private void setRequestPolicy(StringRequest request) {


        request.setRetryPolicy(new RetryPolicy() {
            @Override
            public int getCurrentTimeout() {
                return 50000;
            }

            @Override
            public int getCurrentRetryCount() {
                return 50000;
            }

            @Override
            public void retry(VolleyError error) throws VolleyError {

            }
        });
    }

    @Override
    public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {

        textView12.setText("");
        textView14.setText("");
        stk.removeAllViewsInLayout();
        if (!"Select".equals(AWARDIds.get(i))) {
            progressBar.setVisibility(View.VISIBLE);
            String DetailsUrl = "http://10.0.2.2:8080/frequentflier/RedemptionDetails.jsp?awardidid=" + AWARDIds.get(i) +"&pid=" + aid;
            StringRequest request1 = new StringRequest(Request.Method.GET, DetailsUrl, new Response.Listener<String>() {
                @Override
                public void onResponse(String s) {
                    progressBar.setVisibility(View.GONE);
                    String[] result = s.trim().split("#");
                    String[] row = result[0].split(",");
                    String AWARDDesc = row[0];
                    String AWARDPointsNeeded = row[1];
                    textView12.setText("AWARD Desc. \n" + AWARDDesc);
                    initTable(result);
                }
            }, null);
            setRequestPolicy(request1);
            queue.add(request1);
        }
    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {

    }
}
