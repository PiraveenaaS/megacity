package com.megacity.service;

import com.mailgun.api.v3.MailgunMessagesApi;
import com.mailgun.client.MailgunClient;
import com.mailgun.model.message.Message;
import com.mailgun.model.message.MessageResponse;

public class Email{

    private final static String API_KEY = "fa3e86cf9d0f1ff88892e0b2dde20a2a-3af52e3b-3478ce70";
    private static final String DOMAIN = "sandbox189b058b22ef424ab979f210808aed7a.mailgun.org";

    public static boolean sendEmail(String to, String subject, String message) {
        try{
            MailgunMessagesApi mailgunMessagesApi = MailgunClient.config(API_KEY).createApi(MailgunMessagesApi.class);
            Message bundle = Message.builder()
                    .from("MegaCityCab <no-reply-megacitycab@" + DOMAIN + ">")
                    .to(to)
                    .subject(subject)
                    .text(message)
                    .build();

            MessageResponse messageResponse = mailgunMessagesApi.sendMessage(DOMAIN, bundle);
            return messageResponse.getMessage().equals("Queued. Thank you.");
        }
        catch (Exception e) {
            System.err.println("Class: Email sender, Issue: Mail is not sent Properly because of " + e);
            return false;
        }
    }
}
