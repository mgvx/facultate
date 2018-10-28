package com.example.ape.highscore.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;

import com.example.ape.highscore.EditTransaction;
import com.example.ape.highscore.domain.ManagerSaver;
import com.example.ape.highscore.R;
import com.example.ape.highscore.domain.Manager;
import com.example.ape.highscore.domain.Transaction;

import android.widget.AdapterView.OnItemClickListener;
import android.widget.Toast;

public class TransactionsFragment extends ListFragment implements OnItemClickListener {
    Manager man;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        getActivity().setTitle("Transactions");
        View rootView = inflater.inflate(R.layout.fragment_transactions, container, false);
        Intent intent = getActivity().getIntent();
//        this.man = (Manager) intent.getSerializableExtra("managerObj");
        ManagerSaver saver = new ManagerSaver();
        this.man = saver.readFromInternalMemory(getContext());
        return rootView;
    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        // Setup any handles to view objects here
        // EditText etFoo = (EditText) view.findViewById(R.id.etFoo);
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        ArrayAdapter<Transaction> adapter = new ArrayAdapter<Transaction>(getActivity(), android.R.layout.simple_list_item_1, this.man.transactions);
        setListAdapter(adapter);
        getListView().setOnItemClickListener(this);
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position,long id) {
        Toast.makeText(getActivity(), "Item: " + position, Toast.LENGTH_SHORT).show();
        Intent intent = new Intent(getActivity(), EditTransaction.class);
//        intent.putExtra("managerObj", man);
        intent.putExtra("editObj", (Transaction) parent.getItemAtPosition(position));
        startActivityForResult(intent, 1);
    }

}
