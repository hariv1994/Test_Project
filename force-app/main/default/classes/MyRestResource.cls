/*
* This class exposes service for min, max values
*/
@RestResource(urlMapping='/MinMax/*')
global with sharing class MyRestResource {
    @HttpGet
    global static GetResponseWrapper getRecord() {
        // Add your code
        GetResponseWrapper rw = new GetResponseWrapper();
        Double rand = Math.random() *10;
        Integer minValue = rand.intValue();
        rw.min = minValue;
        rw.max = minValue + 3;
        return rw;
    }
    
    @HttpPost
    global static PostResponseWrapper doPost(Integer max, Integer min,List<GetResponseWrapper> results) {
       
       PostResponseWrapper rw = new PostResponseWrapper();
       if(max == null) {
           rw.error = true;
           rw.message = 'body should have required property "max" ' ;
           return rw;
       }
       else if(min == null) {
           rw.error = true;
           rw.message = 'body should have required property "min" ' ;
           return rw;          
       }
       else if(results == null){
           rw.error = true;
           rw.message = 'body should have required property "results" ' ;
           return rw;           
       }
       else if(results.size() < 2) {
           rw.error = true;
           rw.message = 'minimum two objects are required in "results" ' ;
           return rw;
       }
       
        for(GetResponseWrapper result : results){
            //System.debug('Max --' + result.max + ' -- Min --' + result.min);
            if(result.min > result.max) {
                rw.error = true;
                rw.success = false;
                rw.message = 'Max item should be greater than Min Item in results';
                
                return rw;
            }
            
        }
        
        rw.results = results;       
        rw.message = 'Your input has been successfully processed!';
        rw.success = true;   
        rw.error = false;      
        
        return rw;
    } 
    
    
    global class GetResponseWrapper {        
        public Integer max {get;set;}
        public Integer min {get;set;}
        public getResponseWrapper() {            
            this.max = 0;
            this.min = 0;
        }
    }
    
    global class PostResponseWrapper {        
        
        public String message {get;set;}
        public boolean error {get;set;}
        public boolean success {get;set;}
        public List<GetResponseWrapper> results {get;set;}
        public postResponseWrapper() {                       
            this.message = '';                                    
        }
    }

}