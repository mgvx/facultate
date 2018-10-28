package com.example.ape.highscore.domain;

import android.content.Context;
import android.util.Log;

import com.example.ape.highscore.domain.Manager;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInput;
import java.io.ObjectInputStream;
import java.io.ObjectOutput;
import java.io.ObjectOutputStream;

/**
 * Created by ape on 27.11.2017.
 */

public class ManagerSaver {
    String filename = "myfile";

    public void saveToInternalMemory(Context context, Manager man) {
        FileOutputStream outputStream;
        ObjectOutput out;
        try {
            Log.d("SAVER","saved");
            Log.d("SAVER", man.toString());
            outputStream = context.openFileOutput(this.filename, Context.MODE_PRIVATE);
            out = new ObjectOutputStream(outputStream);
            out.writeObject(man);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public Manager readFromInternalMemory(Context context){
        FileInputStream inputStream;
        ObjectInput in;
        Manager man = new Manager();
        try {
            Log.d("SAVER","readed");
            Log.d("SAVER", man.toString());
            inputStream = context.openFileInput(this.filename);
            in = new ObjectInputStream(inputStream);
            man = (Manager) in.readObject();
            in.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return man;
    }

}
