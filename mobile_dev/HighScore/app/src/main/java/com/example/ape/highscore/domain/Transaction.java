package com.example.ape.highscore.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by ape on 30.10.2017.
 */

public class Transaction implements Serializable {
    private Integer sum;
    private Date date;
    private Category cat;
    private Account from;
    private Account to;

    public Transaction (Integer s, Category c, Account to, Account from, Date d) {
        this.sum = s;
        this.date = d;
        this.cat = c;
        this.to = to;
        this.from = from;
    }

    @Override
    public String toString() {
        String s = "";
        if (cat.getFlow() == 0) {
            s = "- " + Integer.toString(this.sum) + "  on " + this.cat;
        } else{
            s = "+ " + Integer.toString(this.sum) + "  from " + this.cat;
        }
        return s;
    }

    public Integer getSum() {
        return sum;
    }
    public Category getCategory() {
        return cat;
    }
    public Account getToAccount() {
        return to;
    }
    public Account getFromAccount() {
        return from;
    }

    @Override
    public boolean equals(Object o)
    {
        if (o instanceof Transaction)
        {
            Transaction c = (Transaction) o;
            if ( this.sum.equals(c.sum) && this.date.equals(c.date) && this.cat.equals(c.cat))
                return true;
        }
        return false;
    }

    public Date getDate() {
        return date;
    }
}
