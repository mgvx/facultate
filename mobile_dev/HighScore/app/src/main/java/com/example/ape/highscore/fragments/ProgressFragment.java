package com.example.ape.highscore.fragments;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.example.ape.highscore.MainActivity;
import com.example.ape.highscore.R;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.auth.api.signin.GoogleSignInResult;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.SignInButton;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.ResultCallback;
import com.google.android.gms.common.api.Status;


public class ProgressFragment extends Fragment {

    Button send;
    EditText name_text;
    EditText email_text;
    EditText password_text;
//    TextView status_text;
//    GoogleApiClient mGoogleApiClient;
//    static int RC_SIGN_IN = 9001;
//    SignInButton sing_in;


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        getActivity().setTitle("Progress");

        View rootView = inflater.inflate(R.layout.fragment_progress, container, false);

        send = (Button) rootView.findViewById(R.id.button_send);
        send.setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        send_mail();
                                    }
                                }
        );

        name_text = (EditText) rootView.findViewById(R.id.name_text);
        email_text = (EditText) rootView.findViewById(R.id.email_text);
        password_text = (EditText) rootView.findViewById(R.id.password_text);
//        status_text = (TextView) rootView.findViewById(R.id.status);
//
//        GoogleSignInOptions gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
////                .requestIdToken(getString(R.string.default_web_client_id))
//                .requestEmail()
//                .build();
//        mGoogleApiClient = new GoogleApiClient.Builder(getActivity())
//                .enableAutoManage(getActivity(), new GoogleApiClient.OnConnectionFailedListener() {
//                    @Override
//                    public void onConnectionFailed(ConnectionResult result) {
//                        Log.d("haha","nooooooooooooooooooo");
////                        Timber.e("failed: Has resolution? ");
//                    }
//                })
//                .addApi(Auth.GOOGLE_SIGN_IN_API,gso)
//                .build();
//
//
//        sing_in = (SignInButton) rootView.findViewById(R.id.sign_in_button);
//        sing_in.setOnClickListener(new View.OnClickListener() {
//                                       @Override
//                                       public void onClick(View view) {
//                                           signIn();
//                                       }
//                                   }
//        );
        return rootView;
    }
//    private void signIn() {
//        Log.d("haha","AHHHHHHHHHHHHHHHHHH");
//        Intent signInIntent = Auth.GoogleSignInApi.getSignInIntent(mGoogleApiClient);
//        Log.d("haha","AHHHHHHHHHHHHHHHHHH");
//        startActivityForResult(signInIntent, RC_SIGN_IN);
//        Log.d("haha","AHHHHHHHHHHHHHHHHHH");
//    }
//    @Override
//    public void onActivityResult(int requestCode, int resultCode, Intent data) {
//        Log.d("haha","YEYEYE");
//        super.onActivityResult(requestCode, resultCode, data);
//
//        // Result returned from launching the Intent from GoogleSignInApi.getSignInIntent(...);
//        if (requestCode == RC_SIGN_IN) {
//            Log.d("haha","YEYEYE");
//            GoogleSignInResult result = Auth.GoogleSignInApi.getSignInResultFromIntent(data);
//            handleSingInResult(result);
//        }
//    }
//
//    private void singOut() {
//        Auth.GoogleSignInApi.signOut(mGoogleApiClient).setResultCallback(new ResultCallback<Status>() {
//            @Override
//            public void onResult(@NonNull Status status) {
//                status_text.setText("signed out");
//            }
//        });
//    }
//    private void handleSingInResult(GoogleSignInResult result) {
//        Log.d("haha","AHHHHHHHHHHHHHHHHHH");
//        if (result.isSuccess()) {
//            GoogleSignInAccount acc = result.getSignInAccount();
//            Log.d("haha","AHHHHHHHHHHHHHHHHHH");
//            status_text.setText(acc.getDisplayName());
//        }
//    }

    public void send_mail () {
        String name = name_text.getText().toString();
        String email = email_text.getText().toString();
        String password = password_text.getText().toString();

        Intent intent = new Intent(Intent.ACTION_SEND);
        intent.setType("text/html");
        intent.putExtra(Intent.EXTRA_EMAIL, "emailaddress@emailaddress.com");
        intent.putExtra(Intent.EXTRA_SUBJECT, "Your Acoount Details");
//        intent.setData(Uri.parse("mailto:"+email));
        intent.putExtra(Intent.EXTRA_TEXT, "I'm email body. DATA:\n"+ name + "\n" + email + "\n" + password);
        startActivity(Intent.createChooser(intent, "Send Email"));

    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        // Setup any handles to view objects here
        // EditText etFoo = (EditText) view.findViewById(R.id.etFoo);
    }


}
