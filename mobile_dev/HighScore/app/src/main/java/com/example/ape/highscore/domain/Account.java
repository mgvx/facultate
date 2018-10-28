package com.example.ape.highscore.domain;


import java.io.Serializable;

/**
 * Created by ape on 30.10.2017.
 */

public class Account implements Serializable {
    private String name;
    private Integer sum;

    public Account (String n, Integer s) {
        this.name = n;
        this.sum = s;
    }

    @Override
    public String toString() {
        return this.name;// + " " + Integer.toString(this.sum);
    }

    public String getName() {
        return name;
    }

    @Override
    public boolean equals(Object o)
    {
        if (o instanceof Account)
        {
            Account c = (Account) o;
            if ( this.name.equals(c.name) )
                return true;
        }
        return false;
    }
}
