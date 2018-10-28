package com.example.ape.highscore.domain;

import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;

import java.io.FileOutputStream;
import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ape on 30.10.2017.
 */

public class Manager implements Serializable {
    public List<Category> categories;
    public List<Account> accounts;
    public List<Transaction> transactions;
//    public AsyncTaskRunner runner;

    public Manager () {
        this.categories = new ArrayList<>();
        this.accounts = new ArrayList<>();
        this.transactions = new ArrayList<>();

        this.categories.add(new Category ("salary",0));
        this.categories.add(new Category ("allowance",0));
        this.categories.add(new Category ("food",1));
        this.categories.add(new Category ("tickets",1));
        this.categories.add(new Category ("transportation",1));
        this.categories.add(new Category ("clothes",1));

        this.accounts.add(new Account("-",0));
        this.accounts.add(new Account("BRD",100));
        this.accounts.add(new Account("Transilvania",200));
        this.accounts.add(new Account("PiggyBank",200));

        DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

        try{
            this.transactions.add(new Transaction(7, this.categories.get(1), this.accounts.get(0), this.accounts.get(1),dateFormat.parse("11-01-2015")));
            this.transactions.add(new Transaction(3, this.categories.get(4), this.accounts.get(0), this.accounts.get(1),dateFormat.parse("11-01-2015")));
            this.transactions.add(new Transaction(14, this.categories.get(0), this.accounts.get(2), this.accounts.get(0),dateFormat.parse("11-05-2015")));
            this.transactions.add(new Transaction(8, this.categories.get(5), this.accounts.get(2), this.accounts.get(0),dateFormat.parse("07-04-2016")));
            this.transactions.add(new Transaction(5, this.categories.get(3), this.accounts.get(2), this.accounts.get(0),dateFormat.parse("07-05-2016")));
            this.transactions.add(new Transaction(10, this.categories.get(1), this.accounts.get(2), this.accounts.get(3),dateFormat.parse("10-11-2016")));
            this.transactions.add(new Transaction(16, this.categories.get(2), this.accounts.get(2), this.accounts.get(3),dateFormat.parse("01-02-2017")));
            this.transactions.add(new Transaction(6, this.categories.get(3), this.accounts.get(2), this.accounts.get(0),dateFormat.parse("01-04-2017")));
            this.transactions.add(new Transaction(12, this.categories.get(1), this.accounts.get(2), this.accounts.get(0),dateFormat.parse("21-07-2017")));
        }catch(Exception e){
            System.out.println("Error::"+e);
            e.printStackTrace();
        }


    }


    public void addTransaction(Transaction t) {
        this.transactions.add(t);
    }

    public void updateTransaction(Transaction prev_tran, Transaction new_tran) {
        int id = this.transactions.indexOf(prev_tran);
        this.transactions.set(id, new_tran);
    }

    public void removeTransaction(Transaction t) {
        int id = this.transactions.indexOf(t);
        this.transactions.remove(id);
    }


    public List<Transaction> get_out_trans() {

        List<Transaction> trans = new ArrayList<Transaction>();
        for (Transaction t : this.transactions) {
            if (t.getCategory().getFlow() == 1) {
                trans.add(t);
            }
        }

        return trans;
    }

    public List<Transaction> get_in_trans() {

        List<Transaction> trans = new ArrayList<Transaction>();
        for (Transaction t : this.transactions) {
            if (t.getCategory().getFlow() == 0) {
                trans.add(t);
            }
        }
        return trans;
    }

    public Category findCategory (String x){
        for (Category c: this.categories){
            if(c.getName() == x) {
                return c;
            }
        }
        return null;
    }

    public Account findAccount (String x){
        for (Account a: this.accounts){
            if(a.getName() == x) {
                return a;
            }
        }
        return null;
    }

    public String toString() {
        String s = "TRANSACTIONS:\n";
        for (Transaction t: this.transactions){
            s += (t.toString()+'\n');
        }
        return s;
    }

}
