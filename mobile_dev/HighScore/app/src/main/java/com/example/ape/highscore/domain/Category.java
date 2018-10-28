package com.example.ape.highscore.domain;

import java.io.Serializable;

/**
 * Created by ape on 30.10.2017.
 */

public class Category implements Serializable {
    private String name;
    private Integer flow;

    public Category (String n, Integer f) {
         this.name = n;
         this.flow = f;
    }

    @Override
    public String toString() {
        return this.name; //+ " " + Integer.toString(this.flow);
    }

    public String getName() {
        return name;
    }
    public Integer getFlow() {
        return flow;
    }


    @Override
    public boolean equals(Object o)
    {
        if (o instanceof Category)
        {
            Category c = (Category) o;
            if ( this.name.equals(c.name) )
                return true;
        }
        return false;
    }
}
