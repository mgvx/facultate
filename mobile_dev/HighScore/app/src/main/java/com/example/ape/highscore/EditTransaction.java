package com.example.ape.highscore;

import android.app.DialogFragment;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.example.ape.highscore.domain.Account;
import com.example.ape.highscore.domain.Category;
import com.example.ape.highscore.domain.Manager;
import com.example.ape.highscore.domain.ManagerSaver;
import com.example.ape.highscore.domain.Transaction;
import com.example.ape.highscore.fragments.DatePickerFragment;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class EditTransaction extends AppCompatActivity implements DatePickerFragment.DateListener {
    Manager man;
    Transaction tran;
    EditText sum_text;
    Spinner cat_spinner;
    Spinner to_spinner;
    Spinner from_spinner;
    Button button_delete;
    Date d;
    Button date_button;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_transaction);
        setTitle("Edit Transaction");

        Intent intent = getIntent();
//        this.man = (Manager) intent.getSerializableExtra("managerObj");
        ManagerSaver saver = new ManagerSaver();
        this.man = saver.readFromInternalMemory(getApplicationContext());

        this.tran = (Transaction) intent.getSerializableExtra("editObj");
        this.button_delete = (Button) findViewById(R.id.button_delete);
        button_delete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                int resultCode = 3;
                Intent resultIntent = new Intent();
                resultIntent.putExtra("delTransaction", tran);
                setResult(resultCode, resultIntent);

                finish();

            }
        });

        sum_text = (EditText) findViewById(R.id.sum_text);
        sum_text.setText(Integer.toString(this.tran.getSum()));
        d = new Date(System.currentTimeMillis());
        sum_text.requestFocus();

        sum_text.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if(actionId== EditorInfo.IME_ACTION_DONE){
                    if(sum_text.getText().toString().matches(""))
                    {
//                        Toast.makeText(v.getContext(), "Empty Field!",Toast.LENGTH_SHORT).show();
                    } else {
                        Integer sum = Integer.parseInt(sum_text.getText().toString());
                        Category cat = (Category) cat_spinner.getSelectedItem();
                        Account to = (Account) to_spinner.getSelectedItem();
                        Account from = (Account) from_spinner.getSelectedItem();


                        doMyAction(sum, cat, to, from);


                    }
                }
                return false;
            }
        });

        ArrayAdapter<Category> cat_adapter = new ArrayAdapter<Category>(this, android.R.layout.simple_spinner_item, this.man.categories);
        cat_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        cat_spinner = (Spinner) findViewById(R.id.cat_spinner);
        cat_spinner.setAdapter(cat_adapter);
        cat_spinner.setSelection(cat_adapter.getPosition(this.tran.getCategory()));

        ArrayAdapter<Account> to_adapter = new ArrayAdapter<Account>(this, android.R.layout.simple_spinner_item, this.man.accounts);
        to_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        to_spinner = (Spinner) findViewById(R.id.to_spinner);
        to_spinner.setAdapter(to_adapter);
        to_spinner.setSelection(to_adapter.getPosition(this.tran.getToAccount()));
        Log.d("fff",Integer.toString(to_adapter.getPosition(this.tran.getToAccount())));

        ArrayAdapter<Account> from_adapter = new ArrayAdapter<Account>(this, android.R.layout.simple_spinner_item, this.man.accounts);
        from_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        from_spinner = (Spinner) findViewById(R.id.from_spinner);
        from_spinner.setAdapter(from_adapter);
        from_spinner.setSelection(from_adapter.getPosition(this.tran.getFromAccount()));
        Log.d("fff",Integer.toString(from_adapter.getPosition(this.tran.getFromAccount())));


        date_button = (Button) findViewById(R.id.dateText);
        date_button.setText(String.valueOf(this.tran.getDate()));
        date_button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showDatePicker();
            }
        });

    }

    public void showDatePicker() {
        DialogFragment newFragment = new DatePickerFragment();
        newFragment.show(getFragmentManager(), "datepicker");
    }

    @Override
    public void onFinish(String s){
        try{
            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            this.d = dateFormat.parse(s);
            date_button.setText(String.valueOf(this.d));
        }catch(Exception e){
            System.out.println("Error::"+e);
            e.printStackTrace();
        }
    }

    private void doMyAction(Integer sum, Category cat, Account to, Account from){
        Transaction upd_tran = new Transaction(sum, cat, to, from, this.d);

        int resultCode = 2;
        Intent resultIntent = new Intent();
        resultIntent.putExtra("prevTransaction", tran);
        resultIntent.putExtra("newTransaction", upd_tran);
        setResult(resultCode, resultIntent);

        finish();
    }
}
