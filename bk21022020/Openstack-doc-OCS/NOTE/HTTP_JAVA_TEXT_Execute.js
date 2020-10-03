package execution;

import com.mongodb.ConnectionString;
import com.mongodb.reactivestreams.client.MongoClient;
import com.mongodb.reactivestreams.client.MongoClients;
import com.mongodb.reactivestreams.client.MongoCollection;
import com.mongodb.reactivestreams.client.MongoDatabase;
import common.Initialization;
import database.SubscriberHelpers;
import database.Test;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import report.ExcelReport;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.InvocationTargetException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import static com.mongodb.client.model.Filters.eq;

/**
 * Created by linhnt115 on 7/19/2019.
 */
public class TestExecute extends Initialization {
    protected Logger logger = Logger.getLogger(String.valueOf(getClass()));
    int cellToSetResult = 9;
    String TC_Result = null;
    List<String> result = new ArrayList<>();
    HttpGet get;
    HttpClient httpClient;
    int actualStatusCode;
    StringBuffer responseBody;
    HttpResponse res;
    String newUri = null;
    URL serverUrl;
    String actualResponse;
    CloseableHttpClient httpclient;
    String valueID;
    String authen;
    String expResponse;

    public void TCController() throws NoSuchMethodException, InvocationTargetException, IllegalAccessException, InterruptedException, IOException, JSONException, JSONException {
        logger.info("Start testing");

        List<Integer> sheet = data_file.getAllTCSheet();
        List<Map<String, String>> DB_info = data_file.getDataSource("DB_Info");
        List<Map<String, String>> get_Authen = data_file.getDataSource("GetAuthen");
        int TC = 0;
        int TCPass = 0;
        int TCFail = 0;


        for (Integer index : sheet) {
            int rowIndex = 9;
            List<Map<String, String>> dataSource = data_file.getDataSourceTestCase(index);
            for (Map<String, String> db : DB_info) {

                String dbConnection = db.get("DB Connection");
                String dbName = db.get("DB Name");

                for (Map<String, String> data : dataSource) {
//                TC++;
                    rowIndex++;
                    String tcID = data.get("TestCaseID");
                    String url = data.get("Url");
                    String uri = data.get("Uri");
                    String method = data.get("Method");
                    String body = data.get("Body");
                    String pathParam = data.get("Path parameter");
                    String expStatusCode = data.get("Expected status code");
                    expResponse = data.get("Expected response body");

                    if (tcID.contains("API_")) {
                        TC++;

                        JSONObject path_param = new JSONObject(pathParam);
                        JSONArray keys = path_param.names();
                        for (int i = 0; i < keys.length(); i++) {
                            String key_path_param = keys.getString(i);
                            if (uri.contains("{" + key_path_param + "}")) {
                                newUri = uri.replace("{" + key_path_param + "}", (CharSequence) path_param.get(key_path_param));
                                uri = newUri;
                                serverUrl = new URL(url + newUri);
                            } else {
                                serverUrl = new URL(url + uri);
                            }
                        }

//                        String[] paramObject = pathParam.split(":");
//                        String valueParam = paramObject[0];
//                        result.removeAll(result);
//                        if (uri.contains("{" + valueParam + "}")) {
//                            newUri = uri.replace("{" + valueParam + "}", paramObject[1]);
//                            System.out.println("new uri: " + newUri);
//                            serverUrl = new URL(url + newUri);
//                        } else {
//                            serverUrl = new URL(url + uri);
//                        }
                        // Connect to the web server endpoint
                        httpclient = HttpClients.createDefault();

                        for (Map<String, String> getauthen : get_Authen) {
                            String body_Authen = getauthen.get("Body");
                            String serverUrlAuthen = getauthen.get("Url");
                            String uriAuthen = getauthen.get("Uri");
                            HttpPost httpPost = new HttpPost(serverUrlAuthen + uriAuthen);
                            StringEntity entity = new StringEntity(body_Authen);
                            httpPost.setEntity(entity);
                            httpPost.setHeader("Accept", "application/json");
                            httpPost.setHeader("Content-type", "application/json");
                            res = httpclient.execute(httpPost);

                            //Get response body
                            BufferedReader rd = new BufferedReader(
                                    new InputStreamReader(res.getEntity().getContent()));
                            responseBody = new StringBuffer();
                            String line = "";
                            while ((line = rd.readLine()) != null) {
                                responseBody.append(line);
                            }

                            String result_authen = responseBody.toString();
                            JSONObject json = new JSONObject(result_authen);
                            authen = "Bearer " + (String) json.get("access_token");
                            System.out.println("authen is: " + authen);
                            logger.info("Set value of Authen");
                            ExcelReport.setAuthen("GetAuthen", authen, 1, 5);
                        }

                        if (method.equals("GET")) {
                            logger.info("Execute GET request");
                            HttpGet httpGet = new HttpGet(serverUrl.toString());
                            httpGet.setHeader("Authorization", authen);
                            res = httpclient.execute(httpGet);
                            this.check(expStatusCode, res);
                            this.checkDatabase(dbConnection, dbName, dbConnection, getValueID());
                        } else if (method.equals("POST")) {
                            logger.info("Execute POST request");

                            HttpPost httpPost = new HttpPost(serverUrl.toString());

                            StringEntity entity = new StringEntity(body);
                            httpPost.setEntity(entity);
                            httpPost.setHeader("Accept", "application/json");
                            httpPost.setHeader("Content-type", "application/json");
                            httpPost.setHeader("Authorization", authen);
                            res = httpclient.execute(httpPost);
                            this.check(expStatusCode, res);
                            this.checkDatabase(dbConnection, dbName, dbConnection, getValueID());

                        } else if (method.equals("DELETE")) {
                            logger.info("Execute DELETE request");
                            HttpDelete httpDelete = new HttpDelete(serverUrl.toString());
                            httpDelete.setHeader("Accept", "application/json");
                            httpDelete.setHeader("Content-type", "application/json");
                            httpDelete.setHeader("Authorization", authen);
                            res = httpclient.execute(httpDelete);
                            actualStatusCode = res.getStatusLine().getStatusCode();
                            System.out.println("actual status code is:" + actualStatusCode);
                            System.out.println("expected status code is:" + expStatusCode);
                            this.check(expStatusCode, res);
                            this.checkDatabase(dbConnection, dbName, dbConnection, getValueID());

                        } else if (method.equals("PUT")) {
                            logger.info("Execute PUT request");
                            HttpPut httpPut = new HttpPut(serverUrl.toString());

                            StringEntity entity = new StringEntity(body);
                            httpPut.setEntity(entity);
                            httpPut.setHeader("Accept", "application/json");
                            httpPut.setHeader("Content-type", "application/json");
                            httpPut.setHeader("Authorization", authen);

                            res = httpclient.execute(httpPut);
                            this.check(expStatusCode, res);
                            this.checkDatabase(dbConnection, dbName, dbConnection, getValueID());
                        }

                        logger.info("Set result test to testcase: " + TC);

                        System.out.println("check: " + result.contains("Fail: Actual response body is: "));
                        if (result.contains("F: Status code is: " + actualStatusCode)) {
                            TC_Result = "F: Status code is: " + actualStatusCode;
                            TCFail++;
                            ExcelReport.setResult(index, "TongHop", TC_Result, rowIndex, cellToSetResult, TCPass, TCFail, TC);
                            logger.info("Write result Fail status code in excel file");
                        } else if (result.contains("F: Response body is: " + responseBody.toString())) {
                            //TC_Result = "F: Response body is: " + responseBody.toString();
                            TC_Result = "F: Response body is: " + responseBody.toString();
                            TCFail++;
                            ExcelReport.setResult(index, "TongHop", TC_Result, rowIndex, cellToSetResult, TCPass, TCFail, TC);
                            logger.info("Write result Fail actual response in excel file");
                        } else if (result.contains("F: Result in DB is not equal to response API: ")) {
                            TC_Result = "F: Result in DB is not equal to response API: ";
                            TCFail++;
                            ExcelReport.setResult(index, "TongHop", TC_Result, rowIndex, cellToSetResult, TCPass, TCFail, TC);
                            logger.info("Write result Fail check db in excel file");
                        } else {
                            TCPass++;
                            TC_Result = "P";
                            ExcelReport.setResult(index, "TongHop", TC_Result, rowIndex, cellToSetResult, TCPass, TCFail, TC);
                            logger.info("Write result Pass");
                        }
                        System.out.println("result is: " + result);
                    }
                }

            }
        }
    }


    public boolean testJson(JSONObject objectExcel, JSONObject objectResponse) throws JSONException {
        JSONArray keys = objectExcel.names();
        for (int i = 0; i < keys.length(); ++i) {
            String key = keys.getString(i); // Here's your key
            if (!objectResponse.has(key)) {
                logger.info("Reponse boby has no " + key);
                return false;
            } else {
                Object value = objectExcel.get(key); // Here's your value
                if (!objectResponse.get(key).equals(value)) {
                    logger.info("Response body value of " + key + " is not equal to expected");
                    return false;
                }
            }
        }
        return true;
    }



    public void checkStatusCode(String actualStatusCode, String expStatusCode) {
        logger.info("Check status code");
        if (actualStatusCode.equals(expStatusCode)) {
            result.add("P");
        } else {
            result.add("F: Status code is: " + actualStatusCode);
        }
    }


    public void checkResponse(String actualResponse, String expResponse) {
        //check response boby
        logger.info("Check response body");
        try {
            JSONObject objectResponse = new JSONObject(actualResponse);
            JSONObject objectExcel = new JSONObject(expResponse);
            logger.info("Object Response equal object Excel: " + testJson(objectExcel, objectResponse));
            if (testJson(objectExcel, objectResponse)) {
                logger.info("Add result pass");
                result.add("P");
            } else {
                logger.info("Add result fail");
                result.add("F: Response body is: " + actualResponse);
            }
        } catch (Throwable t) {
            if (actualResponse == null || actualResponse.equals("")) {
                if (expResponse == null || expResponse.equals("")) {
                    result.add("P");
                    logger.info("Add result pass when null response body expected");
                } else {
                    result.add("F: Response body is: " + actualResponse);
                    logger.info("Add result fail");
                }
            } else {
                result.add("F: Response body is: " + actualResponse);
                logger.info("Add result fail actual response body is: " + responseBody.toString());
            }
        }
    }

//    public void checkResponse(String actualResponse, String expResponse) {
//        //check response boby
//        logger.info("Check response body");
//        try {
//            JSONObject objectResponse = new JSONObject(actualResponse);
//            JSONObject objectExcel = new JSONObject(expResponse);
//            if (compairJsonList(actualResponse, expResponse)) {
//                logger.info("Add result pass");
//                result.add("P");
//            } else {
//                logger.info("Add result fail");
//                result.add("F: Response body is: " + actualResponse);
//            }
//        } catch (Throwable t) {
//            if (actualResponse == null || actualResponse.equals("")) {
//                if (expResponse == null || expResponse.equals("")) {
//                    logger.info("Add result pass when null response body expected");
//                    result.add("P");
//                } else {
//                    logger.info("Add result fail");
//                    result.add("F: Response body is: " + actualResponse);
//                }
//            } else {
//                result.add("F: Response body is: " + actualResponse);
//                logger.info("Add result fail actual response body is: " + responseBody.toString());
//            }
//        }
//    }

    public void checkDatabase(String dbConnection, String dbName, String dbCollection, String id) throws InterruptedException {
        logger.info("Check database");
        MongoClient mongoClient = MongoClients.create(new ConnectionString(dbConnection));
        MongoDatabase database = mongoClient.getDatabase(dbName);
        MongoCollection<Document> collection = database.getCollection(dbCollection);
        collection.find(eq("_id", id)).subscribe(new Test.PrintDocumentSubscriber());
        System.out.println("Check database");

        Thread.sleep(3000);
    }

    public class PrintDocumentSubscriber extends SubscriberHelpers.OperationSubscriber<Document> {

        @Override
        public void onNext(final Document document) {
            super.onNext(document);
            System.out.println(document.toJson());
            //Em lam so sanh hay gi do o day
            try {
                JSONObject objectDB = new JSONObject(document.toJson());
                JSONObject objectResponseAPI = new JSONObject(responseBody.toString());
                if (testJson(objectDB, objectResponseAPI)) {
                    result.add("P");
                    logger.info("Add result Pass check database");
                } else {
                    result.add("F: Result in DB is not equal to response API: " + document.toString());
                    logger.info("Add result Fail check database");
                }
            } catch (Throwable t) {

                if (responseBody.toString() == null) {
                    if (document.toJson() == null) {
                        result.add("P");
                    } else {
                        result.add("F: result in DB is: ");
                        logger.info("Add result Fail check db null");
                    }
                } else {
                    result.add("F: result in DB is not equal to response API");
                    logger.info("Add fail result in DB is not equal to reponse API");
                }
            }
        }
    }

    public String getBodyRes(HttpResponse res) {
        BufferedReader rd = null;
        try {
            rd = new BufferedReader(
                    new InputStreamReader(res.getEntity().getContent()));
            responseBody = new StringBuffer();
            String line = "";
            while ((line = rd.readLine()) != null) {
                responseBody.append(line);
            }
            return responseBody.toString();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return responseBody.toString();

    }

    public void check(String expStatusCode, HttpResponse res) throws IOException {
        //Check status code
        actualStatusCode = res.getStatusLine().getStatusCode();
        System.out.println("actual status code is:" + actualStatusCode);
        System.out.println("expected status code is:" + expStatusCode);
        this.checkStatusCode(Integer.toString(actualStatusCode), expStatusCode);

        //Get response body
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(res.getEntity().getContent()));
        responseBody = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            responseBody.append(line);
        }
        System.out.println("Actual ressponse body is: " + responseBody.toString());
        //actualResponse = responseBody.toString();
        this.checkResponse(responseBody.toString(), expResponse);
    }

    public void initInfo(String dataFilePath, String resultFilePath) throws IOException {
        logger.info("init data");
        initialize(dataFilePath, resultFilePath);
    }

    public void executeTest(String dataFilePath, String resultFilePath) throws IOException, InterruptedException, NoSuchMethodException, IllegalAccessException, InvocationTargetException, JSONException {
        this.initInfo(dataFilePath, resultFilePath);
        this.TCController();
    }

    public String getValueID() throws JSONException {
        JSONObject objectResponse = new JSONObject(responseBody.toString());
        JSONArray keys = objectResponse.names();
        for (int i = 0; i < keys.length(); ++i) {
            String key = keys.getString(i); // Here's your key
            if (key.equals("id")) {
                valueID = (String) objectResponse.get(key);
            }
        }
        return valueID;
    }

    public static void main(String args[]) throws IOException, InterruptedException, NoSuchMethodException, IllegalAccessException, InvocationTargetException, JSONException {
//        String dataFilePath = "C:\\Users\\linhnt115\\Desktop\\APITEST\\DataTest\\CreateAPI.xlsx";
//        String resultFilePath = "C:\\Users\\linhnt115\\Desktop\\APITEST\\ResultTest";
//        TestExecute mainCore = new TestExecute();
//        mainCore.initInfo(dataFilePath, resultFilePath);
//        mainCore.TCController();

        String sjon = "[{ \"id\": \"03d19b8f-2301-4124-8c28-4f9ec33fac245\",\n" +
                "                \"vnfInstanceName\": \"name1\"}, { \"id\": \"03d19b8f-2301-4124-8c28-4f9ec33fac25\",\n" +
                "                \"vnfInstanceName\": \"name2\"}]";
        String sjonexp = "[{ \"id\": \"03d19b8f-2301-4124-8c28-4f9ec33fac24\",\n" +
                "                \"vnfInstanceName\": \"name1\"}, { \"id\": \"03d19b8f-2301-4124-8c28-4f9ec33fac2588\",\n" +
                "                \"vnfInstanceName\": \"name2\"}]";
        JSONArray actual = new JSONArray(sjon);
        JSONArray exp = new JSONArray(sjonexp);

        List<JSONObject> object_list = new ArrayList<>();
        List<JSONObject> object_list_exp = new ArrayList<>();

        for (int i = 0; i < actual.length(); i++) {
            JSONObject json_object = actual.getJSONObject(i);
            object_list.add(json_object);
            System.out.println("object json : " + i + "is: " + json_object.toString());
        }

        for (int i = 0; i < exp.length(); i++) {
            JSONObject json_object_exp = exp.getJSONObject(i);
            object_list_exp.add(json_object_exp);
            System.out.println("object json : " + i + "is: " + json_object_exp.toString());
        }

        List<String> result_compair = new ArrayList<>();

        for (JSONObject json : object_list) {
            for (JSONObject jsonexp : object_list_exp) {
                TestExecute t = new TestExecute();
                if (t.testJson(jsonexp, json)) {
                    result_compair.add("true");
                } else result_compair.add("false");
            }
        }
        if (!result_compair.contains("false")) {
            System.out.println("TRUE");
        }
    }
}


