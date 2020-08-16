/*
* This class makes callout to random number
*/
public class BasicAuth{
    public void getRequest(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // Use Named Credentials for clean call out implementation
        request.setEndpoint('callout:Mission');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        System.debug('Status Code --' + response.getStatusCode() + '-- Body --' + response.getBody());
        if(response.getStatusCode() == 200) {
        //Deserialize JSON response 
            JsonToApex result = (JsonToApex) JSON.deserializeStrict(response.getBody(),JsonToApex.class);
            System.debug(result.max + ' -- ' + result.min);
            Integer maxValue = result.max;
            Integer minValue = result.min;
            
            postRequest(maxValue,minValue);
        }
    }
    
    public void postRequest(Integer maxValue,Integer minValue) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Mission/post');
        request.setMethod('POST');
        
        String body =  '{' + '\"max\":'+maxValue+ ',\"min\":'+minValue + ',\"results":[{\"max\":'+maxValue+ '},'+'{\"min\":'+minValue+'}]}';
        System.debug(body);
        request.setBody(body);
        request.setHeader('Content-Type','application/json');
        HttpResponse response = http.send(request);
        System.debug('Response Code for Post callout -' + response.getStatusCode());
        System.debug('Response Message for Post callout -' + response.getBody());
    }
    
    public class JsonToApex{
        public Integer max;
        public Integer min;
    }
}