package com.megacity.service;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.google.maps.DistanceMatrixApi;
import com.google.maps.GeoApiContext;
import com.google.maps.PlaceAutocompleteRequest;
import com.google.maps.PlacesApi;
import com.google.maps.model.AutocompletePrediction;
import com.google.maps.model.ComponentFilter;
import com.google.maps.model.DistanceMatrix;
import org.json.JSONObject;
import org.json.JSONArray;

@WebServlet("/booking")
public class Booking extends HttpServlet {
    private static final String API_KEY = "AIzaSyBkrtJWMGqV1v4siBiwE_JDYbGXilEHVy0";
    private static final GeoApiContext context = new GeoApiContext.Builder()
            .apiKey(API_KEY)
            .build();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");

        PlaceAutocompleteRequest.SessionToken sessionToken = new PlaceAutocompleteRequest.SessionToken();
        try {
            AutocompletePrediction[] predictions = PlacesApi.placeAutocomplete(context, query, sessionToken)
                    .language("en")
                    .components(ComponentFilter.country("LK"))
                    .await();

            List<String> suggestions = Stream.of(predictions)
                    .map(prediction -> prediction.description)
                    .collect(Collectors.toList());

            JSONArray jsonResponse = new JSONArray(suggestions);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse.toString());
        }
        catch (Exception e) {
            System.err.println("Error fetching place suggestions: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StringBuilder sb = new StringBuilder();
        String line;
        try(BufferedReader reader = req.getReader()){
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        catch (Exception e){
            System.err.println("Booking Page ERROR in json request gathering: " + e.getMessage());
        }

        JSONObject requestJson = new JSONObject(sb.toString());
        JSONObject fareResponse = calculateFare(requestJson);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(fareResponse.toString());
    }

    private JSONObject calculateFare(JSONObject req) {
        String source = req.getString("source");
        String destination = req.getString("destination");
        String vehicle = req.getString("vehicle");
        boolean needAC = req.optBoolean("needAC", false);
        String travelDate = req.optString("travelDate");
        String travelTime = req.optString("travelTime");


        double distanceKm = getDistance(source, destination);
        double baseFare, perKm, acCharge = 0, waitingCharge = 0;

        switch (vehicle) {
            case "threewheeler":
                baseFare = 100;
                perKm = 15;
                break;
            case "car":
                baseFare = 200;
                perKm = 20;
                acCharge = needAC ? 120 : 0;
                break;
            case "van":
                baseFare = 300;
                perKm = 30;
                acCharge = needAC ? 180 : 0;
                break;
            default:
                baseFare = 0;
                perKm = 0;
        }

        double distanceCharge = distanceKm * perKm;
        double totalFare = baseFare + distanceCharge + acCharge;
        JSONObject responseJson = new JSONObject();
        responseJson.put("base", baseFare);
        responseJson.put("distanceCharge", distanceCharge);
        responseJson.put("acCharge", acCharge);
        responseJson.put("total", totalFare);

        return responseJson;
    }

    private double getDistance(String source, String destination) {
        try {
            String encodedSource = URLEncoder.encode(source, StandardCharsets.UTF_8.toString());
            String encodedDestination = URLEncoder.encode(destination, StandardCharsets.UTF_8.toString());
            DistanceMatrix matrix = DistanceMatrixApi.newRequest(context)
                    .origins(encodedSource)
                    .destinations(encodedDestination)
                    .mode(com.google.maps.model.TravelMode.DRIVING)
                    .await();

            long distanceMeters = matrix.rows[0].elements[0].distance.inMeters;
            return distanceMeters / 1000.0;
        }
        catch (Exception e) {
            System.err.println("Error in fetching distance: " + e.getMessage());
            return 0.00;
        }
    }
}