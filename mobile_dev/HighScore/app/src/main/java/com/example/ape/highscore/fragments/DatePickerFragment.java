package com.example.ape.highscore.fragments;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.icu.util.Calendar;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.DatePicker;
import android.widget.Toast;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

/**
 * Created by ape on 05.11.2017.
 */

public class DatePickerFragment extends DialogFragment {
    public interface DateListener {
        void onFinish(String s);
    }

    private DateListener listener;
    String s;

    public void onAttach(Context context) {
        super.onAttach(context);
        // Verify that the host activity implements the callback interface
        try {
            // Instantiate the DateListener so we can send events to the host
            listener = (DateListener) context;
        } catch (ClassCastException e) {
            // The activity doesn't implement the interface, throw exception
            throw new ClassCastException(context.toString()
                    + " must implement DateListener");
        }

    }

    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {

        final Calendar c = Calendar.getInstance();
        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH);
        int day = c.get(Calendar.DAY_OF_MONTH);

        return new DatePickerDialog(getActivity(), dateSetListener, year, month, day);
    }

    private DatePickerDialog.OnDateSetListener dateSetListener =
            new DatePickerDialog.OnDateSetListener() {
                public void onDateSet(DatePicker view, int year, int month, int day) {
                    String s = String.valueOf(day) + "-" + String.valueOf(month+1) + "-" + String.valueOf(year);
//                    Date date = new Date(year, month, day);
//                    Toast.makeText(getActivity(), "selected date is " + view.getYear() +
//                            " / " + (view.getMonth() + 1) +
//                            " / " + view.getDayOfMonth(), Toast.LENGTH_SHORT).show();
                    onFinishEditDialog(s);

                }
            };

    public void onFinishEditDialog(String s) {
        dismiss();
        this.listener.onFinish(s);
    }
}
