package com.example.ape.highscore.fragments;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.example.ape.highscore.domain.Category;
import com.example.ape.highscore.domain.ManagerSaver;
import com.example.ape.highscore.R;
import com.example.ape.highscore.domain.Manager;
import com.example.ape.highscore.domain.Transaction;
import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.series.BarGraphSeries;
import com.jjoe64.graphview.series.LineGraphSeries;

import com.jjoe64.graphview.series.DataPoint;

import org.junit.experimental.categories.Categories;

import java.util.ArrayList;
import java.util.List;
//import org.junit.experimental.theories.DataPoint;


public class StatisticsFragment extends Fragment {
    Manager man;
    List<Transaction> in_trans = new ArrayList<Transaction>();
    List<Transaction> out_trans = new ArrayList<Transaction>();


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        getActivity().setTitle("Statistics");
        View rootView = inflater.inflate(R.layout.fragment_statistics, container, false);
        ManagerSaver saver = new ManagerSaver();
        this.man = saver.readFromInternalMemory(getContext());

        this.in_trans = this.man.get_in_trans();
        this.out_trans = this.man.get_out_trans();
//        Log.d("OKKK",String.valueOf(this.in_trans));
//        Log.d("OKKK",String.valueOf(this.out_trans));

        GraphView graph = (GraphView) rootView.findViewById(R.id.graph);
        DataPoint[] in_points = new DataPoint[this.in_trans.size()];
        DataPoint[] out_points = new DataPoint[this.out_trans.size()];

        int k = 0;
        for (Transaction t : this.in_trans) {
            int tsec = Integer.parseInt(String.valueOf( t.getDate().getTime()).substring(0, 6));
            in_points[k] = new DataPoint(tsec, t.getSum());
            k+=1;
        }
        k = 0;
        for (Transaction t : this.out_trans) {
            int tsec = Integer.parseInt(String.valueOf( t.getDate().getTime()).substring(0, 6));
            out_points[k] = new DataPoint(tsec, t.getSum());
            k+=1;
        }

        LineGraphSeries<DataPoint> in_series = new LineGraphSeries<>(in_points);
        LineGraphSeries<DataPoint> out_series = new LineGraphSeries<>(out_points);
        in_series.setColor(Color.GREEN);
        out_series.setColor(Color.RED);

        graph.addSeries(in_series);
        graph.addSeries(out_series);
        graph.getGridLabelRenderer().setHorizontalLabelsVisible(false);


        GraphView bar_graph = (GraphView) rootView.findViewById(R.id.bar_graph);
        List<Integer> cats = new ArrayList<>();
        k = 0;
        for(Category c : this.man.categories){
            cats.add(0);
            for (Transaction t : this.man.transactions) {
                if (c.equals(t.getCategory())) {
                    cats.set(k, ((int)cats.get(k)+1));
                }
            }
            k += 1;
        }

        DataPoint[] cat_points = new DataPoint[cats.size()+1];
        k = 0;
        cat_points[0] = new DataPoint(0,0);
        for(Category c : this.man.categories){
            cat_points[k+1] = new DataPoint(k+1, cats.get(k));
            k += 1;
        }

        BarGraphSeries<DataPoint> bar_series = new BarGraphSeries<>(cat_points);
        bar_series.setSpacing(50);
        bar_series.setDrawValuesOnTop(true);
        bar_series.setValuesOnTopColor(Color.RED);

        bar_graph.addSeries(bar_series);
        bar_graph.getGridLabelRenderer().setHorizontalLabelsVisible(false);
        return rootView;
    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        // Setup any handles to view objects here
        // EditText etFoo = (EditText) view.findViewById(R.id.etFoo);
    }

}
