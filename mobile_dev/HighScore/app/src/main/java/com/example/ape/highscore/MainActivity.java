package com.example.ape.highscore;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.content.LocalBroadcastManager;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.support.design.widget.NavigationView;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.example.ape.highscore.domain.Manager;
import com.example.ape.highscore.domain.ManagerSaver;
import com.example.ape.highscore.domain.Transaction;
import com.example.ape.highscore.fragments.ProgressFragment;
import com.example.ape.highscore.fragments.StatisticsFragment;
import com.example.ape.highscore.fragments.TransactionsFragment;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.auth.api.signin.GoogleSignInResult;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.common.SignInButton;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.ResultCallback;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.gcm.GoogleCloudMessaging;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.messaging.FirebaseMessaging;

public class MainActivity extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener {

    private static final String TAG = MainActivity.class.getSimpleName();
    public final static int REQ_CODE_CHILD = 1;
    Manager man;

    GoogleApiClient mGoogleApiClient;
    static int RC_SIGN_IN = 9001;
    SignInButton sing_in;
    Button sing_out;
    TextView status_text;
    TextView token_text;


    //    private static final String TAG = MainActivity.class.getSimpleName();
    private BroadcastReceiver mRegistrationBroadcastReceiver;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ManagerSaver saver = new ManagerSaver();
        this.man = saver.readFromInternalMemory(getApplicationContext());
        getIntent().putExtra("managerObj", this.man);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                addTransaction();

            }
        });

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.setDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.bringToFront();
        navigationView.setNavigationItemSelectedListener(this);
        navigationView.setCheckedItem(R.id.nav_progress);
        navigationView.getMenu().performIdentifierAction(R.id.nav_progress, 0);


        status_text = (TextView) this.findViewById(R.id.status);
        token_text = (TextView) this.findViewById(R.id.token);
        sing_in = (SignInButton) this.findViewById(R.id.sign_in_button);
        sing_out = (Button) this.findViewById(R.id.sign_out_button);


        GoogleSignInOptions gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
//                .requestIdToken(getString(R.string.default_web_client_id))
                .requestEmail()
                .build();
        mGoogleApiClient = new GoogleApiClient.Builder(this)
                .enableAutoManage(this, new GoogleApiClient.OnConnectionFailedListener() {
                    @Override
                    public void onConnectionFailed(ConnectionResult result) {
                        Log.d("err", "couldn't sing in");
                    }
                })
                .addApi(Auth.GOOGLE_SIGN_IN_API, gso)
                .build();


        sing_in.setOnClickListener(new View.OnClickListener() {
                                       @Override
                                       public void onClick(View view) { signIn();}} );
        sing_out.setOnClickListener(new View.OnClickListener() {
                                        @Override
                                        public void onClick(View view) { singOut();}});


        mRegistrationBroadcastReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                if (intent.getAction().equals(Config.REGISTRATION_COMPLETE)) {
                    FirebaseMessaging.getInstance().subscribeToTopic(Config.TOPIC_GLOBAL);
                    displayFirebaseRegId();

                } else if (intent.getAction().equals(Config.PUSH_NOTIFICATION)) {
                    String message = intent.getStringExtra("message");
                    Toast.makeText(getApplicationContext(), "Received new Push notification! " + message, Toast.LENGTH_LONG).show();
                    token_text.setText("Message: " + message);
                }
            }
        };
        displayFirebaseRegId();

    }

    private void displayFirebaseRegId() {
        SharedPreferences pref = getApplicationContext().getSharedPreferences(Config.SHARED_PREF, 0);
        String regId = pref.getString("regId", null);
        Log.e(TAG, "Firebase reg id: " + regId);
        if (!TextUtils.isEmpty(regId))
            token_text.setText("Firebase Reg Id: " + regId);
        else
            token_text.setText("Firebase Reg Id is not received yet!");
    }


    @Override
    protected void onResume() {
        super.onResume();
        LocalBroadcastManager.getInstance(this).registerReceiver(mRegistrationBroadcastReceiver,
                new IntentFilter(Config.REGISTRATION_COMPLETE));
        LocalBroadcastManager.getInstance(this).registerReceiver(mRegistrationBroadcastReceiver,
                new IntentFilter(Config.PUSH_NOTIFICATION));
        NotificationUtils.clearNotifications(getApplicationContext());
    }

    @Override
    protected void onPause() {
        LocalBroadcastManager.getInstance(this).unregisterReceiver(mRegistrationBroadcastReceiver);
        super.onPause();
    }


    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();
        if (id == R.id.nav_progress) {
            show_all();
            Log.d("myTag", "PROGRESS");
            FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
            ft.replace(R.id.my_placeholder, new ProgressFragment());
            ft.commit();

        } else if (id == R.id.nav_transactions) {
            hide_all();
            Log.d("myTag", "TRANSACTION");
            FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
            ft.replace(R.id.my_placeholder, new TransactionsFragment());
            ft.commit();

        } else if (id == R.id.nav_statistics) {
            hide_all();
            Log.d("myTag", "STATISTICS");
            FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
            ft.replace(R.id.my_placeholder, new StatisticsFragment());
            ft.commit();
        }

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }


    private void addTransaction(){
        Intent intent = new Intent(MainActivity.this, AddTransaction.class);
        intent.putExtra("managerObj", man);
        EditText editText = (EditText) findViewById(R.id.add_transaction_layout);
        startActivityForResult(intent, REQ_CODE_CHILD);

    }
    private void signIn() {
        Intent signInIntent = Auth.GoogleSignInApi.getSignInIntent(mGoogleApiClient);
        startActivityForResult(signInIntent, RC_SIGN_IN);
    }

    private void singOut() {
        Auth.GoogleSignInApi.signOut(mGoogleApiClient).setResultCallback(new ResultCallback<Status>() {
            @Override
            public void onResult(@NonNull Status status) {
                status_text.setText("Hello?");
            }
        });
    }
    private void handleSingInResult(GoogleSignInResult result) {
        if (result.isSuccess()) {
            GoogleSignInAccount acc = result.getSignInAccount();
            status_text.setText("Hi, " + acc.getDisplayName() +"!");
        }
    }

    protected void onActivityResult (int requestCode, int resultCode, Intent intent) {
//        if(requestCode == REQ_CODE_CHILD && resultCode == 1) {
        if(resultCode == 1) {
            Transaction t = (Transaction) intent.getSerializableExtra("newTransaction");
            this.man.addTransaction(t);
//            this.saver.saveToInternalMemory(getApplicationContext(),this.man);
        }
        if(resultCode == 2) {
            Transaction prev_tran = (Transaction) intent.getSerializableExtra("prevTransaction");
            Transaction new_tran = (Transaction) intent.getSerializableExtra("newTransaction");
            this.man.updateTransaction(prev_tran, new_tran);
//            this.saver.saveToInternalMemory(getApplicationContext(),this.man);

        }
        if(resultCode == 3) {
            Transaction t = (Transaction) intent.getSerializableExtra("delTransaction");
            this.man.removeTransaction(t);
//            this.saver.saveToInternalMemory(getApplicationContext(),this.man);
        }
        if (requestCode == RC_SIGN_IN) {
            GoogleSignInResult result = Auth.GoogleSignInApi.getSignInResultFromIntent(intent);
            handleSingInResult(result);
        }
        else {
            Log.d("error","X\n");
        }
        new SavingTask().execute(this.man);
    }

    private class SavingTask extends AsyncTask<Manager, Void, Void> {

        @Override
        protected Void doInBackground(Manager... man) {
            ManagerSaver saver = new ManagerSaver();
            saver.saveToInternalMemory(getApplicationContext(), man[0]);
            return null;
        }
        @Override
        protected void onProgressUpdate(Void... voids) {
        }
        @Override
        protected void onPostExecute(Void v) {
//            super.onPostExecute(voids);
//            Toast.makeText(getApplicationContext(), "Database Updated Asynchronously", Toast.LENGTH_SHORT).show();
        }
    }

    public void hide_all() {
        status_text.setVisibility(View.INVISIBLE);
        token_text.setVisibility(View.INVISIBLE);
        sing_in.setVisibility(View.INVISIBLE);
        sing_out.setVisibility(View.INVISIBLE);
    }
    public void show_all() {
        status_text = (TextView) this.findViewById(R.id.status);
        token_text = (TextView) this.findViewById(R.id.token);
        sing_in = (SignInButton) this.findViewById(R.id.sign_in_button);
        sing_out = (Button) this.findViewById(R.id.sign_out_button);
        status_text.setVisibility(View.VISIBLE);
        token_text.setVisibility(View.VISIBLE);
        sing_in.setVisibility(View.VISIBLE);
        sing_out.setVisibility(View.VISIBLE);
    }
}
