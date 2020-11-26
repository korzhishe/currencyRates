public with sharing class RatesApi {
    @AuraEnabled(cacheable=true)
    public static List <Rate> getRates() {
        List <Rate> result = new List<Rate>();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.ratesapi.io/api/latest');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON.
            Map<String,Object> resData = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            String baseCur = (String) resData.get('base');
            Map<String,Object> rateCur = (Map<String,Object>) resData.get('rates');

            for (String key : rateCur.keySet()) {
                Rate rateInto = new Rate();
                rateInto.id = baseCur + key;
                rateInto.baseCurrency = baseCur;
                rateInto.rateCurrency = key;
                rateInto.rate = (Decimal) rateCur.get(key);
                result.add(rateInto);
            }
        }

        return result;
    }

    public class Rate {

        @AuraEnabled
        public String id{get;set;}

        @AuraEnabled
        public String baseCurrency{get;set;}

        @AuraEnabled
        public String rateCurrency{get;set;}

        @AuraEnabled
        public Decimal rate{get;set;}
    }
}
