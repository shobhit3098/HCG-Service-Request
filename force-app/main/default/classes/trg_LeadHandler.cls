public class trg_LeadHandler {
    
    public static void leadsharing(list<Lead> leadupdate)
    {
        list<LeadShare> leadsharelist = new list<Leadshare>();
        if(leadupdate != null && leadupdate.size() > 0)
        {
            List<Sharing_Metadata__mdt> sharingMdt = new List<Sharing_Metadata__mdt>([
                Select id, Public_Group_Share__c, Record_Type_Name__c, Unit_Location_Name__c, Share_With__c from Sharing_Metadata__mdt
            ]);
            
            Map<String, Sharing_Metadata__mdt> sharingMdtMap = new Map<String, Sharing_Metadata__mdt>();
            if(sharingMdt != null && sharingMdt.size() > 0) {
                for(Sharing_Metadata__mdt mdt : sharingMdt) {
                    sharingMdtMap.put(mdt.Record_Type_Name__c + mdt.Unit_Location_Name__c + mdt.Share_With__c, mdt);
                }
            }
            
            List<Group> pGroup = new List<Group>([Select Id, DeveloperName from Group]); 
            Map<String, Group> pGroupMap = new Map<String, Group>();
            
            if(pGroup != null && pGroup.size() > 0) {
                for(Group grp : pGroup) {
                    pGroupMap.put(grp.DeveloperName, grp);
                }
            }
            
            for(lead ld : leadupdate) {
                
                if(ld.Record_Type_F__c != null && ld.Record_Type_F__c != '' && ld.Unit_Of_Location_F__c != null && ld.Unit_Of_Location_F__c != '') {
                    System.debug('ld.Record_Type_F__c'+ld.Record_Type_F__c);
                    System.debug('ld.Unit_Of_Location_F__c'+ld.Unit_Of_Location_F__c);
                    System.debug('l=containskey'+sharingMdtMap.containskey(ld.Record_Type_F__c + ld.Unit_Of_Location_F__c + 'Corporate'));
                    System.debug('l=sharingMdtMap'+sharingMdtMap);
                    if(ld.Record_Type_F__c == 'Corporate Partner' && !sharingMdtMap.isEmpty() && !pGroupMap.isEmpty()) {
                        if(sharingMdtMap.containskey(ld.Record_Type_F__c + ld.Unit_Of_Location_F__c + 'Corporate')) {
                            Leadshare leadsharerecord = new Leadshare();
                            leadsharerecord.Leadid = ld.id;
                            leadsharerecord.UserOrGroupId = pGroupMap.get(sharingMdtMap.get(ld.Record_Type_F__c + ld.Unit_Of_Location_F__c + 'Corporate').Public_Group_Share__c).Id;
                            leadsharerecord.LeadAccessLevel = 'Read';
                            leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                            leadsharelist.add(leadsharerecord);
                        }
                        
                        if(sharingMdtMap.containskey(ld.Record_Type_F__c + ld.Unit_Of_Location_F__c + 'Unit Sales Head')) {
                            Leadshare leadsharerecord = new Leadshare();
                            leadsharerecord.Leadid = ld.id;
                            leadsharerecord.UserOrGroupId = pGroupMap.get(sharingMdtMap.get(ld.Record_Type_F__c + ld.Unit_Of_Location_F__c + 'Unit Sales Head').Public_Group_Share__c).Id;
                            leadsharerecord.LeadAccessLevel = 'Edit';
                            leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                            leadsharelist.add(leadsharerecord);
                        }
                    }
                    
                    if(ld.Record_Type_F__c == 'International Partner' && !sharingMdtMap.isEmpty() && !pGroupMap.isEmpty()) {
                        if(sharingMdtMap.containskey(ld.Record_Type_F__c + ld.Unit_Of_Location_F__c + 'Unit Sales Head')) {
                            Leadshare leadsharerecord = new Leadshare();
                            leadsharerecord.Leadid = ld.id;
                            leadsharerecord.UserOrGroupId = pGroupMap.get(sharingMdtMap.get(ld.Record_Type_F__c + ld.Unit_Of_Location_F__c + 'Unit Sales Head').Public_Group_Share__c).Id;
                            leadsharerecord.LeadAccessLevel = 'Read';
                            leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                            leadsharelist.add(leadsharerecord);
                        }
                    }
                }
                
                if(ld.CSO__c != null){
                    Leadshare leadsharerecord = new Leadshare();
                    leadsharerecord.Leadid = ld.id;
                    leadsharerecord.UserOrGroupId = ld.CSO__c;
                    leadsharerecord.LeadAccessLevel = 'Read';
                    leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                    leadsharelist.add(leadsharerecord);
                }
                
                if(ld.Regional_Sales_Head_Cluster_Sales_Head__c != null){
                    Leadshare leadsharerecord = new Leadshare();
                    leadsharerecord.Leadid = ld.id;
                    leadsharerecord.UserOrGroupId = ld.Regional_Sales_Head_Cluster_Sales_Head__c;
                    leadsharerecord.LeadAccessLevel = 'Read';
                    leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                    leadsharelist.add(leadsharerecord);
                }
                
                if(ld.Unit_Sales_Head__c != null){
                    Leadshare leadsharerecord = new Leadshare();
                    leadsharerecord.Leadid = ld.id;
                    leadsharerecord.UserOrGroupId = ld.Unit_Sales_Head__c;
                    leadsharerecord.LeadAccessLevel = 'Read';
                    leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                    leadsharelist.add(leadsharerecord);
                }
                
                if(ld.Sales_Head_Corporate__c != null && ld.RecordTypeName__c == 'Corporate Partner'){
                    Leadshare leadsharerecord = new Leadshare();
                    leadsharerecord.Leadid = ld.id;
                    leadsharerecord.UserOrGroupId = ld.Sales_Head_Corporate__c;
                    leadsharerecord.LeadAccessLevel = 'Read';
                    leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                    leadsharelist.add(leadsharerecord);
                }
                
                if(ld.Sales_Head_International__c != null && ld.RecordTypeName__c == 'International Partner'){
                    Leadshare leadsharerecord = new Leadshare();
                    leadsharerecord.Leadid = ld.id;
                    leadsharerecord.UserOrGroupId = ld.Sales_Head_International__c;
                    leadsharerecord.LeadAccessLevel = 'Read';
                    leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                    leadsharelist.add(leadsharerecord);
                }
                if(ld.Sales_Head_Retail__c != null && ld.RecordTypeName__c == 'Retail Partner'){
                    Leadshare leadsharerecord = new Leadshare();
                    leadsharerecord.Leadid = ld.id;
                    leadsharerecord.UserOrGroupId = ld.Sales_Head_Retail__c;
                    leadsharerecord.LeadAccessLevel = 'Read';
                    leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                    leadsharelist.add(leadsharerecord);
                }
            }
        }
        
        if(leadsharelist != null && leadsharelist.size()>0){
            try {
                insert leadsharelist ;
            }
            catch(Exception e) {
                
            }
        }
    }
    
    public static void leadsharingAsfterUpdate(list<Lead> leadupdate,map<id,lead> oldLeadMap)
    {
        list<LeadShare> leadsharelist = new list<Leadshare>();
        if(leadupdate != null && leadupdate.size() > 0)
        {
            for(lead ld : leadupdate) {
                if(oldLeadMap.get(ld.id).OwnerId != ld.OwnerId) {
                    if(ld.CSO__c != null){
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.CSO__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                    
                    if(ld.Regional_Sales_Head_Cluster_Sales_Head__c != null) {
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.Regional_Sales_Head_Cluster_Sales_Head__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                    
                    if(ld.Unit_Sales_Head__c != null){
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.Unit_Sales_Head__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                    
                    if(ld.Sales_Head_Corporate__c != null && ld.RecordTypeName__c == 'Corporate Partner'){
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.Sales_Head_Corporate__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                    
                    if(ld.Sales_Head_International__c != null && ld.RecordTypeName__c == 'International Partner'){
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.Sales_Head_International__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                    if(ld.Sales_Head_Retail__c != null && ld.RecordTypeName__c == 'Retail Partner'){
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.Sales_Head_Retail__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                }
            }
        }
        
        if(leadsharelist != null && leadsharelist.size()>0){
            try{
            insert leadsharelist ;
            }
            catch(Exception e) {
                
            }
        }
    }

public static void leadsharingAsfterInsert(list<Lead> leadupdate)
    {
        list<LeadShare> leadsharelist = new list<Leadshare>();
        if(leadupdate != null && leadupdate.size() > 0)
        {
            for(lead ld : leadupdate) {
                    if(ld.CSO__c != null){
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.CSO__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                    
                    if(ld.Regional_Sales_Head_Cluster_Sales_Head__c != null) {
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.Regional_Sales_Head_Cluster_Sales_Head__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                    
                    if(ld.Unit_Sales_Head__c != null){
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.Unit_Sales_Head__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                if(ld.Sales_Head_Retail__c != null && ld.RecordTypeName__c == 'Retail Partner'){
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.Sales_Head_Retail__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                if(ld.Sales_Manager__c != null && ld.RecordTypeName__c == 'Retail Partner'){
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.Sales_Manager__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
                if(ld.Sales_Head_Corporate__c != null && ld.RecordTypeName__c == 'Corporate Partner'){
                        Leadshare leadsharerecord = new Leadshare();
                        leadsharerecord.Leadid = ld.id;
                        leadsharerecord.UserOrGroupId = ld.Sales_Head_Corporate__c;
                        leadsharerecord.LeadAccessLevel = 'edit';
                        leadsharerecord.RowCause = Schema.leadshare.RowCause.Manual;
                        leadsharelist.add(leadsharerecord);
                    }
            }
        }
        
        if(leadsharelist != null && leadsharelist.size()>0){
            try{
            insert leadsharelist ;
            }
            catch(Exception e) {
                
            }
        }
    }
    
    public static void updateAddressId(list<lead> accountupdate) {
        set<String> city = new set<String>();
        set<String> district = new set<String>();
        set<String> state = new set<String>();
        set<String> country = new set<String>();
        set<string> countryIds = new set<string>();
       
        if(accountupdate != null && accountupdate.size() > 0) {
            for(lead ld : accountupdate) {
                
                if(ld.Title != null) {
                    try{
                        ld.Salutation = ld.Title;
                    }catch(exception e){}
                }
                ld.Title__c = ld.Salutation;
                
                if(ld.MobilePhone != null && ld.MobilePhone.length() >= 10) {
                    ld.MobilePhone = ld.MobilePhone.substring(ld.MobilePhone.length()-10,ld.MobilePhone.length());
                }
                if(ld.MobilePhone != null) {
                    ld.Phone = ld.MobilePhone;
                }
                
                countryIds.add(ld.Country__c);
                country.add(ld.HIS_Country_Code__c);
                state.add(ld.HIS_State_Code__c);
                district.add(ld.HIS_District_Code__c);
                city.add(ld.HIS_City_Code__c);
            }
        }
        Map<String,String> countries = new Map<String,String>();
        Map<String,String> states = new Map<String,String>();
        Map<String,String> districts = new Map<String,String>();
        Map<String,String> cities = new Map<String,String>();
        list<Country__c> Countrylist = new list<Country__c>();
        map<id,Country__c> countryMap = new map<id,Country__c>();
        
        list<state__c> statelist = new list<state__c>();
        list<district__c> districtlist = new list<district__c>();
        list<city__c> citylist = new list<city__c>();
        if(country != null && country.size() > 0) {
            Countrylist = [select id,CountryId__c,Telephone_Code__c from Country__c where CountryId__c IN: country OR id IN : countryIds];
        }
        if(state != null && state.size() > 0) {
            statelist = [select id,stateId__c from state__c where stateId__c IN: state];
        }
        if(district != null && district.size() > 0) {
            districtlist = [select id,districtId__c from district__c where districtId__c IN: district];
        }
        if(city != null && city.size() > 0) {
            citylist = [select id,cityId__c from city__c where cityId__c IN: city];
        }
        if(Countrylist != null && Countrylist.size() > 0) {
            for(Country__c co : Countrylist) {
                countries.put(co.CountryId__c,co.id);
                countryMap.put(co.id,co);
            }
        }
        if(statelist != null && statelist.size() > 0) {
            for(state__c co : statelist) {
                states.put(co.stateId__c,co.id);
            }
        }
        if(districtlist != null && districtlist.size() > 0) {
            for(district__c co : districtlist) {
                districts.put(co.districtId__c,co.id);
            }
        }
        if(citylist != null && citylist.size() > 0) {
            for(city__c co : citylist) {
                cities.put(co.cityId__c,co.id);
            }
        }
        
        for(lead acc : accountupdate) {
            if(countries.containskey(acc.HIS_Country_Code__c) && acc.HIS_Country_Code__c != null && acc.HIS_Country_Code__c != '') {
                acc.Country__c = countries.get(acc.HIS_Country_Code__c);
            }
            else if(acc.HIS_Country_Code__c != null && acc.HIS_Country_Code__c != '') {
                acc.adderror('Country Code not found!');
            }
            if(states.containskey(acc.HIS_State_Code__c) && acc.HIS_State_Code__c != null && acc.HIS_State_Code__c != '') {
                acc.State__c = states.get(acc.HIS_State_Code__c);
            }
            else if(acc.HIS_State_Code__c != null && acc.HIS_State_Code__c != ''){
                acc.adderror('State Code not found!');
            }
            if(districts.containskey(acc.HIS_District_Code__c) && acc.HIS_District_Code__c != null && acc.HIS_District_Code__c != '') 
            {
                acc.District__c = districts.get(acc.HIS_District_Code__c);
            }
            else if(acc.HIS_District_Code__c != null && acc.HIS_District_Code__c != '') {
                acc.adderror('District Code not found!');
            }
            if(cities.containskey(acc.HIS_City_Code__c) && acc.HIS_City_Code__c != null && acc.HIS_City_Code__c != '')
            {
                acc.City__c = cities.get(acc.HIS_City_Code__c);
            }
            else if(acc.HIS_City_Code__c != null && acc.HIS_City_Code__c != ''){
                acc.adderror('City Code not found!');
            }
        }        
    }
    public static void updateunit(list<Lead> leadupdate,map<id,lead> oldMap) {
        set<String> owner = new set<String>();
        set<String> treatunit = new set<String>();
        set<String> locationunit = new set<String>();
        if(leadupdate != null && leadupdate.size() > 0) {
            for(lead ld : leadupdate) {
                owner.add(ld.OwnerId);
                treatunit.add(ld.Treating_Unit__c);
                locationunit.add(ld.Location_Id__c);    
            }
        }
        
        list<String> unit = new list<String>();
        list<user> userunit = new list<user>();
        list<Unit_Location__c> treatunitlist = new list<Unit_Location__c>();
        list<Unit_Location__c> locationunitlist = new list<Unit_Location__c>();
        if(treatunit != null && treatunit.size() > 0){
            treatunitlist = [select id,Location_Id__c from Unit_Location__c limit 1000];
        }
        if(locationunit != null && locationunit.size() > 0) {
            locationunitlist = [select id,Location_Id__c,name from Unit_Location__c where Location_Id__c IN: locationunit];
        }
        if(owner != null && owner.size() > 0) {
            userunit = [select unit__c from user where id IN: owner];
        }
        if(userunit != null && userunit.size() > 0) {
            for(user us : userunit) {
                unit.add(us.unit__c);
            }
        }
        map<String,Unit_Location__c> treatingmap = new map<String,Unit_Location__c>();
        map<String,Unit_Location__c> unitlocationmap = new map<String,Unit_Location__c>();
        if(treatunitlist != null && treatunitlist.size() > 0) {
            for(Unit_Location__c us : treatunitlist) {
                treatingmap.put(us.id,us);
            }
        }
        if(locationunitlist != null && locationunitlist.size() > 0) {
            for(Unit_Location__c us : locationunitlist) {
                unitlocationmap.put(us.Location_Id__c,us);
            }
        }
        
        map<String,Unit_Location__c> locationmap = new map<String,Unit_Location__c>();
        map<id,Unit_Location__c> usermap = new map<id,Unit_Location__c>();
        
        if(unit != null && unit.size() > 0) {
            list<Unit_Location__c> unitlist = [select id,name,Location_Id__c from Unit_Location__c where name IN: unit]; 
            if(unitlist != null && unitlist.size() > 0) {  
                for(Unit_Location__c us : unitlist) {
                    locationmap.put(us.name,us);
                }
            }
            if(locationmap != null && locationmap.size() > 0) { 
                for(user us : userunit) {
                    if(us.unit__c != null && us.unit__c != '') {
                        usermap.put(us.id,locationmap.get(us.unit__c));
                    }
                }
            }       
        }
        
        system.debug('yes1');
        
        for(lead ld : leadupdate) {
            system.debug(ld.Unit_Location__c);
            try{
                if(ld.Location_Id__c != null && ld.Location_Id__c != '' && ld.UHID__c != null && unitlocationmap.get(ld.Location_Id__c) != null) {
                    System.debug('First1');
                    ld.Treating_Unit__c = unitlocationmap.get(ld.Location_Id__c).Id;
                }
                else if(trigger.isInsert && ld.Location_Id__c != null && ld.Location_Id__c != '' && (ld.PRN__c != null || ld.QRN__c != null) && unitlocationmap.get(ld.Location_Id__c) != null) {
                    System.debug('Second2');
                    ld.Treating_Unit__c = unitlocationmap.get(ld.Location_Id__c).Id;
                    ld.Unit_Location__c = unitlocationmap.get(ld.Location_Id__c).Id;
                }
                else if(trigger.isUpdate && oldMap.get(ld.Id).Location_Id__c != ld.Location_Id__c && ld.Location_Id__c != null && ld.Location_Id__c != '' && (ld.PRN__c != null || ld.QRN__c != null) && unitlocationmap.get(ld.Location_Id__c) != null) {
                    System.debug('Third3');
                    ld.Treating_Unit__c = unitlocationmap.get(ld.Location_Id__c).Id;
                }
                else {
                    if(ld.Unit_Location__c == null && usermap.containsKey(ld.OwnerId) && usermap.get(ld.OwnerId).Id != null){
                         System.debug('Fourth4');
                        ld.Unit_Location__c = usermap.get(ld.OwnerId).Id;
                    }
                    if(ld.Unit_Location__c != null && ld.Treating_Unit__c == null ){
                        System.debug('Five5');
                        ld.Treating_Unit__c = ld.Unit_Location__c;
                    }
                    if(ld.Treating_Unit__c != null && treatingmap.containskey(ld.Treating_Unit__c)) {
                        System.debug('Six6');
                        ld.Location_Id__c = treatingmap.get(ld.Treating_Unit__c).Location_Id__c;
                    }
                }  
            }
            catch(exception e){
                system.debug(e.getMessage());
            } 
        }
    }
    //This method for update location on lead According to zipcode
    public static void updatezipcode(list<Lead> leadlist) {
        set<String> zipset = new set<String>();
        for(Lead ld : leadlist) {
            if(ld.RecordTypeId != Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Patients').getRecordTypeId() )
                zipset.add(ld.Postal_Code__c);
        }
        map<String,Pincode_Location_Master__c> zipmap = new map<String,Pincode_Location_Master__c>();
        list<Pincode_Location_Master__c> ziplist = new list<Pincode_Location_Master__c>();
        if(zipset != null && zipset.size() > 0) {
            ziplist = [select id,name,Postal_Code__c,Street_Area__c,Beat_No__c,Beat_Group__c from Pincode_Location_Master__c where Postal_Code__c IN:zipset];
        }
        if(ziplist != null && ziplist.size() > 0) {
            for(Pincode_Location_Master__c zip : ziplist){
                zipmap.put(zip.Postal_Code__c,zip);
            }
        }
        if(!zipmap.isempty()){
            for(Lead ld : leadlist) {
                try{
                    ld.Location_Name__c = zipmap.get(ld.Postal_Code__c).Beat_No__c;
                    ld.Location_Name__c = zipmap.get(ld.Postal_Code__c).Beat_Group__c;
                    ld.Location_Name__c = zipmap.get(ld.Postal_Code__c).Street_Area__c;
                }
                catch(exception e){}
            }
        }
    }
    
    //Method for auto lead conversion for International patient lead
    public static void InternationalpatientLeadAutoConvert(list<lead> InternationalpatientLeadList){
        system.debug('Inside International patient Lead');
        try{
            if(InternationalpatientLeadList != null && InternationalpatientLeadList.size() > 0){
                system.debug('InternationalpatientLeadList 438 ===> ' + InternationalpatientLeadList);
                list<Database.LeadConvert> leadConverts = new list<Database.LeadConvert>();
                for(Lead leadPatient : InternationalpatientLeadList){
                    system.debug('leadPatient 441 ===> ' + leadPatient);
                    if(!leadPatient.isConverted){
                        system.debug('leadPatient 443 ===> ' + leadPatient);
                        Database.LeadConvert lc = new database.LeadConvert();
                        lc.setLeadId(leadPatient.Id);
                        lc.setConvertedStatus('Closed');
                        lc.setDoNotCreateOpportunity(true);
                        leadConverts.add(lc);
                    }
                }
                if(!leadConverts.isEmpty()){
                    List<Database.LeadConvertResult> lcrList = Database.convertLead(leadConverts);
                    system.debug('lcrList ===> ' + lcrList);
                }
            }
        }
        catch(Exception e) {
            system.debug('Got Caught in :: ' + e.getMessage() + e.getStackTraceString() + e.getLineNumber());
        }
    }
    
    //Method for auto lead conversion for patient lead
    public static void patientLeadAutoConvert(list<lead> patientLeadList){
        system.debug('Inside patient Lead');
        try{
            list<id> patientLeadIds = new list<id>();
            if(patientLeadList != null && patientLeadList.size() > 0){
                list<Database.LeadConvert> leadConverts = new list<Database.LeadConvert>();
                for(Lead leadPatient : patientLeadList){
                    patientLeadIds.add(leadPatient.id);
                    if(!leadPatient.isConverted){
                        Database.LeadConvert lc = new database.LeadConvert();
                        lc.setLeadId(leadPatient.Id);
                        lc.setConvertedStatus('Closed');
                        lc.setDoNotCreateOpportunity(true);
                        leadConverts.add(lc);
                    }
                }
                if(!leadConverts.isEmpty()){
                    List<Database.LeadConvertResult> lcrList = Database.convertLead(leadConverts);
                }
                list<case> CaseList = new list<case>();
                if(patientLeadIds != null && patientLeadIds.size()>0) {
                    CaseList = [select id,Lead__r.Name,Lead__r.Email,Lead__r.Gender__c,Department__c,Sub_Department__c,Service_List__c,Department_Master__c,Lead__r.ConvertedAccountId,isLagacy__c
                                ,Appointment_Time__c,Treating_Unit__c,Unit_Location__c,Appointment_Detail_Id__c,Appointment_Date__c,Appointment_No__c,Equipment_Master__c,Modality_Master__c,Unit__c,Follow_Up_Date__c
                                ,Test_Master__c,Specialty_Master__c,Service__c,Type_of_Service__c,Request_Id__c,Request_Type__c,Requested_Appointment_Time__c,Requested_Appointment_Date__c,Reason_For_Disposition__c,Reason_For_Others__c,Disposition__c,Doctor_Location_Wise_Master__c, RecordTypeId,Type, Next_Best_Action__c,Status__c,Initial_Disposition__c,Treating_unit_F__c,Treating_Location_Id__c from Case where lead__c IN :patientLeadIds];
                }
                system.debug('Case size ====> ' + CaseList.size());
                system.debug('Case Detaails ====> ' + CaseList);
                list<opportunity> oppList = new list<opportunity>();
                if(CaseList != null && CaseList.size()>0) {
                    for(Case appoint : CaseList) {
                        opportunity opp = new opportunity(); 
                        opp.name = appoint.Lead__r.Name;
                        opp.AccountId = appoint.Lead__r.ConvertedAccountId;
                        opp.Category_1__c = appoint.Department__c;
                        opp.Category_2__c = appoint.Sub_Department__c;
                        opp.Category_3__c = appoint.Service_List__c;
                        opp.Gender__c = appoint.Lead__r.Gender__c;
                        opp.Email__c = appoint.Lead__r.Email;
                        opp.Treating_Unit__c = appoint.Treating_Unit__c;
                        opp.Unit_Location__c = appoint.Unit_Location__c;
                        opp.Department_Master__c = appoint.Department_Master__c;
                        opp.Type_of_Query_Service__c = appoint.Type_of_Service__c;
                        opp.Specialty_Master__c = appoint.Specialty_Master__c;
                        opp.ServiceLookup__c = appoint.Service__c;
                        opp.Test_Master__c = appoint.Test_Master__c;
                        opp.Modality_Master__c = appoint.Modality_Master__c;
                        opp.Equipment_Master__c = appoint.Equipment_Master__c;
                        opp.Unit__c = appoint.Unit__c;
                        opp.Treating_unit_F__c = appoint.Treating_unit_F__c;
                        opp.Treating_Location_Id__c = appoint.Treating_Location_Id__c;
                        opp.Reason_For_Disposition__c = appoint.Reason_For_Disposition__c;
                        opp.Appointment_No__c = appoint.Appointment_No__c;
                        opp.Appointment_Date__c = appoint.Appointment_Date__c;
                        opp.Appointment_Detail_Id__c = appoint.Appointment_Detail_Id__c;
                        opp.Appointment_Time__c = appoint.Appointment_Time__c;
                        opp.Appointment_Status__c = appoint.Status__c;
                        opp.Doctor_Location_Wise_Master__c = appoint.Doctor_Location_Wise_Master__c; 
                        opp.Reason_For_Others__c = appoint.Reason_For_Others__c;
                        opp.stageName = 'Open';
                        opp.Initial_Disposition__c = appoint.Initial_Disposition__c;
                        opp.Reason_For_Disposition__c = appoint.Reason_For_Disposition__c;
                        opp.Follow_Up_Date__c = appoint.Follow_Up_Date__c;
                        opp.isLagacy__c = appoint.isLagacy__c;
                        opp.CloseDate = system.today().addDays(65);
                        opp.Disposition__c = appoint.Disposition__c;
                        opp.Next_Best_Action__c = appoint.Next_Best_Action__c;
                        opp.Reason_Id__c = appoint.Request_Id__c;
                        opp.Request_Type__c = appoint.Request_Type__c;
                        opp.Requested_Appointment_Date__c = appoint.Requested_Appointment_Date__c;
                        opp.Requested_Appointment_Time__c = appoint.Requested_Appointment_Time__c;
                        opp.Type = appoint.Type;
                        system.debug('appoint.RecordTypeId ====> ' + appoint.RecordTypeId);
                        if(Schema.SObjectType.Case.getRecordTypeInfosByName().get('Consultation').getRecordTypeId() == appoint.RecordTypeId){
                            opp.RecordTypeId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Consultation').getRecordTypeId();
                        }
                        if(Schema.SObjectType.Case.getRecordTypeInfosByName().get('Diagnostic').getRecordTypeId() == appoint.RecordTypeId){
                            opp.RecordTypeId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Diagnostic').getRecordTypeId();
                        }
                        if(Schema.SObjectType.Case.getRecordTypeInfosByName().get('Others').getRecordTypeId() == appoint.RecordTypeId) {
                            opp.RecordTypeId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Others').getRecordTypeId();
                        }
                        if(Schema.SObjectType.Case.getRecordTypeInfosByName().get('Admission').getRecordTypeId() == appoint.RecordTypeId) {
                            opp.RecordTypeId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Admission').getRecordTypeId();
                        }
                        if(Schema.SObjectType.Case.getRecordTypeInfosByName().get('Pharmacy').getRecordTypeId() == appoint.RecordTypeId) {
                            opp.RecordTypeId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Pharmacy').getRecordTypeId();
                        }
                        //if(Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Patients').getRecordTypeId() != null)
                        //opp.RecordTypeId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Patients').getRecordTypeId();
                        
                        oppList.add(opp);
                    }
                }
                system.debug('oppList size ====> ' + oppList.size());
                system.debug('Before Insert oppList Details ====> ' + oppList);
                if(oppList != null && oppList.size()>0) {
                    insert oppList;
                    system.debug('After Insert oppList Details ====> ' + oppList);
                }
            }
        }
        catch(Exception e) {
            system.debug('Got Caught in :: ' + e.getMessage() + e.getStackTraceString() + e.getLineNumber());
        }
    }
    
    //This method used to send contract details from lead to account
    public static void sendContractDataToAccount(list<lead> leadList) {
        
        if(leadList != null && leadList.size()>0) {
            
            list<Contract> contractList = new list<Contract>();
            map<string,lead> IdToRecordTypeMap = new map<string,lead>();
            list<string> documnetIds = new list<string>();
            
            for(Lead leadRecord : leadList) {
                if(leadRecord.isContracted__c == true) {
                    Contract contrt = new Contract();
                    contrt.AccountId = leadRecord.ConvertedAccountId;
                    contrt.Contract_Type__c = leadRecord.Contract_Type__c;
                    contrt.Status = 'Active';
                    contrt.Legal_Approval__c = leadRecord.Legal_Approval__c;
                    contrt.Credit_Control_Team_Approval__c = leadRecord.Credit_Control_Team_Approval__c;
                    contrt.Approval_Status__c = 'Draft';
                    contrt.StartDate = leadRecord.Contract_Start_Date__c;
                    contrt.Vendor_Code_Activation__c = leadRecord.Vendor_Code_Activation__c;
                    if(leadRecord.Contract_Term_Month__c != null)
                        contrt.ContractTerm = Integer.ValueOf(leadRecord.Contract_Term_Month__c);
                    contrt.Signing_Authority_From_HCG__c = leadRecord.Signing_Authority_From_HCG__c;
                    contrt.Signing_Authority_From_Account__c = leadRecord.Signing_Authority_From_Account__c;
                    contrt.Scope_Of_Contract__c = leadRecord.Scope_Of_Contract__c;
                    contrt.Scope_Of_Services__c = leadRecord.Scope_Of_Services__c;
                    contrt.Tariff_Applied__c = leadRecord.Tariff_Applied__c;
                    contrt.Lead__c = leadRecord.id;
                    
                    system.debug('Lead record type==>'+leadRecord.RecordTypeName__c);
                    if(leadRecord.RecordTypeName__c != null && Schema.SObjectType.Contract.getRecordTypeInfosByName().get(leadRecord.RecordTypeName__c) != null)
                        contrt.RecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get(leadRecord.RecordTypeName__c).getRecordTypeId();
                    
                    contractList.add(contrt);
                }
                documnetIds.add(leadRecord.Id);
                IdToRecordTypeMap.put(leadRecord.ConvertedAccountId,leadRecord);
            }
            //update Account RecordType and opportunityRecordType as Lead RecordType
            if(IdToRecordTypeMap != null && IdToRecordTypeMap.size()>0) {
                //Update Record Type of Account
                map<id,account> accountMap = new map<id,account>();
                list<Account> AccountList = new list<Account>([select id,RecordTypeId,Type,RecordType.Name from Account where id IN : IdToRecordTypeMap.keyset()]);
                if(AccountList != null && AccountList.size()>0) {
                    for(Account accrecord : AccountList) {
                        if(IdToRecordTypeMap.get(accrecord.id) != null) {
                            if(IdToRecordTypeMap.get(accrecord.id).RecordTypeName__c != 'International Patient' && Schema.SObjectType.Account.getRecordTypeInfosByName().get(IdToRecordTypeMap.get(accrecord.id).RecordTypeName__c).getRecordTypeId() != null) {
                                 accrecord.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(IdToRecordTypeMap.get(accrecord.id).RecordTypeName__c).getRecordTypeId();
                            }
                            else {
                                 accrecord.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Patients').getRecordTypeId();
                            }
                               
                            accrecord.Email__c = IdToRecordTypeMap.get(accrecord.id).Email;
                            accrecord.Phone = IdToRecordTypeMap.get(accrecord.id).MobilePhone;
                            if(IdToRecordTypeMap.get(accrecord.id).Age__c != null) {
                                accrecord.Age__c = Integer.valueOf(IdToRecordTypeMap.get(accrecord.id).Age__c);
                            }
                            if(IdToRecordTypeMap.get(accrecord.id).RecordTypeName__c == 'Patients') {
                                accrecord.Phone = IdToRecordTypeMap.get(accrecord.id).Phone;
                            }
                            if(IdToRecordTypeMap.get(accrecord.id).Master_Account__c != null)
                                accrecord.ParentId = IdToRecordTypeMap.get(accrecord.id).Master_Account__c;
                            
                            if(IdToRecordTypeMap.get(accrecord.id).RecordTypeName__c == 'Retail Partner' || IdToRecordTypeMap.get(accrecord.id).RecordTypeName__c == 'International Partner' || IdToRecordTypeMap.get(accrecord.id).RecordTypeName__c == 'Patients' || IdToRecordTypeMap.get(accrecord.id).RecordTypeName__c == 'International Patient') {
                                if(IdToRecordTypeMap.get(accrecord.id).FirstName != '' && IdToRecordTypeMap.get(accrecord.id).FirstName != null) {
                                    accrecord.name = IdToRecordTypeMap.get(accrecord.id).FirstName + ' ' + IdToRecordTypeMap.get(accrecord.id).LastName;
                                } else {
                                    accrecord.name = IdToRecordTypeMap.get(accrecord.id).LastName;
                                }
                                
                            }
                            
                            accountMap.put(accrecord.id,accrecord);
                        }
                    }
                    update AccountList;
                }
                
                //Update Record Type of Opportunity
                if(accountMap != null && accountMap.size()>0) {
                    list<opportunity> oppList = new list<opportunity>([select id,type,RecordTypeId,AccountId,Account.Name,Account.RecordTypeId,Account.RecordType.Name from opportunity where AccountId IN :accountMap.keyset()]);
                    if(oppList != null && oppList.size()>0) {
                        for(Opportunity oppRecord : oppList) {
                            if(accountMap.get(oppRecord.AccountId) != null) {
                                if(oppRecord.Account.RecordType.Name != 'Patients') {
                                    if(Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(oppRecord.Account.RecordType.Name).getRecordTypeId() != null)
                                        oppRecord.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(oppRecord.Account.RecordType.Name).getRecordTypeId();
                                    oppRecord.Type = accountMap.get(oppRecord.AccountId).Type; 
                                    oppRecord.Name = oppRecord.Account.Name+' All Category';  
                                    
                                }
                                else {
                                    oppRecord.Name = oppRecord.Account.Name;
                                }
                            }
                        }
                        update oppList;
                    }  
                }
            }
            
            // create contract and send all attachment to contractS
            map<string,string> contractMap = new map<string,string>();
            if(contractList != null && contractList.size()>0) {
                try {
                    insert contractList;
                }
                catch(Exception e) {
                    
                }
                for(Contract cotrtRecord :contractList) {
                    contractMap.put(cotrtRecord.Lead__c,cotrtRecord.id);
                }
            }
            
            list<ContentDocumentLink> allCdLinks = new list<ContentDocumentLink>();
            allCdLinks = [select Id, LinkedEntityId, ContentDocumentId, ShareType, Visibility from ContentDocumentLink where LinkedEntityId IN :documnetIds];
            
            list<ContentDocumentLink> allCdLinksToInsert = new list<ContentDocumentLink> ();
            if(contractMap != null && contractMap.size() > 0) {
                for(ContentDocumentLink cdl : allCdLinks) {
                    if(contractMap.get(cdl.LinkedEntityId) != null) {
                        cdl.id = null;
                        cdl.LinkedEntityId = contractMap.get(cdl.LinkedEntityId);
                        allCdLinksToInsert.add(cdl);
                    }  
                }
            }
            if(allCdLinksToInsert != null && allCdLinksToInsert.size()>0) {
                insert allCdLinksToInsert;
            }
        }
    }
    
    //logic to check approved before convert
    public static void checkApproved(list<lead> leadList,map<id,lead> oldLeadMap) {
        if(leadList != null && leadList.size()>0) {
            for(Lead leadRecord : leadList) {
                
               if(leadRecord.Title != null) {
                    try{
                        leadRecord.Salutation = leadRecord.Title;
                    }catch(exception e){}
                }
                leadRecord.Title__c = leadRecord.Salutation;
                
                if(leadRecord.MobilePhone != null && leadRecord.MobilePhone.length() >= 10) {
                    leadRecord.MobilePhone = leadRecord.MobilePhone.substring(leadRecord.MobilePhone.length()-10,leadRecord.MobilePhone.length());
                }
                if(leadRecord.MobilePhone != null) {
                    leadRecord.Phone = leadRecord.MobilePhone;
                }
                
                if(leadRecord.RecordTypeName__c != 'Patients') {
                    if(leadRecord.Status__c != oldLeadMap.get(leadRecord.id).Status__c && leadRecord.Status__c != leadRecord.Status) {
                        try{
                            leadRecord.Status = leadRecord.Status__c;
                        }
                        catch(Exception e) {
                            leadRecord.addError(e.getMessage());
                        }
                    }
                    else if(leadRecord.Status != oldLeadMap.get(leadRecord.id).Status && leadRecord.Status__c != leadRecord.Status) {
                        try{
                            leadRecord.Status__c = leadRecord.Status;
                        }
                        catch(Exception e) {
                            leadRecord.addError(e.getMessage());
                        }
                    }
                    if((leadRecord.Status == 'Converted' && leadRecord.Approved__c != true) || (leadRecord.Status__c == 'Converted' && leadRecord.Approved__c != true)) {
                        leadRecord.addError('Lead should be Approved before conversion !');
                    }
                }
            }
        }
    }
   //logic to bypass duplicate check
    public static void byPassFlowForSales(list<Lead> leadList) {
        if(leadList != null && leadList.size()>0) {
            
            String RecordType = '';
            if(Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Patients').getRecordTypeId() != null) {
                RecordType = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Patients').getRecordTypeId();
            }
            
            String AccRecordType = '';
            if(Schema.SObjectType.Account.getRecordTypeInfosByName().get('Patients').getRecordTypeId() != null) {
                AccRecordType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Patients').getRecordTypeId();
            }
            
            Set<String> onlyPhoneKey = new Set<String>();
            Set<String> onlyFNameKey = new Set<String>();
            Set<String> onlyLNameKey = new Set<String>();
            Set<String> FLPhoneKey = new Set<String>();
            Set<String> DOBPhoneKey = new Set<String>();
            for(Lead ld : leadList) {
                if(!ld.Do_you_want_to_bypass_duplicate_check__c) {
                    
                    if(ld.MobilePhone != null && ld.MobilePhone != '') {
                        onlyPhoneKey.add(String.valueOf(ld.MobilePhone));
                    }
                    
                    if(ld.Phone != null && ld.Phone != '') {
                        onlyPhoneKey.add(String.valueOf(ld.Phone));
                    }
                    
                    System.debug(ld.FirstName);
                    
                    if(ld.FirstName != null && ld.FirstName != '') {
                        onlyLNameKey.add(ld.FirstName.toLowerCase().deleteWhitespace() + ld.LastName.toLowerCase().deleteWhitespace() + String.Valueof(ld.Date_of_Birth__c));
                    } else {
                        onlyLNameKey.add(ld.LastName.toLowerCase().deleteWhitespace() + String.Valueof(ld.Date_of_Birth__c));
                    }
                }
            }
            
            //For Sales
            //Mobile Phone Map
            Map<String, List<String>> phoneDupMap = new Map<String, List<String>>();
            Map<String, List<String>> accPhoneMap = new Map<String, List<String>>();
            
            if(onlyPhoneKey != null && onlyPhoneKey.size() > 0) {
                List<Lead> phoneDupList = new List<Lead>([
                    Select id, Name, MobilePhone, Phone from Lead where ((MobilePhone IN : onlyPhoneKey or Phone IN : onlyPhoneKey) AND RecordTypeId != :RecordType AND isConverted != true)
                ]);                
                
                if(phoneDupList != null && phoneDupList.size() > 0) {
                    for(Lead ld : phoneDupList) {
                        if(ld.MobilePhone != null && ld.MobilePhone != '') {
                            if(!phoneDupMap.isEmpty() && phoneDupMap.containsKey(ld.MobilePhone)) {
                                phoneDupMap.get(ld.MobilePhone).add(ld.Name);
                            } else {
                                phoneDupMap.put(ld.MobilePhone, new List<String>{ld.Name});
                            }
                        }
                        if(ld.Phone != null && ld.Phone != '') {
                            if(!phoneDupMap.isEmpty() && phoneDupMap.containsKey(ld.Phone)) {
                                phoneDupMap.get(ld.Phone).add(ld.Name);
                            } else {
                                phoneDupMap.put(ld.Phone, new List<String>{ld.Name});
                            }
                        }
                    }
                }
                
                List<Account> accList = new List<Account>([
                    Select id, Name, phone from Account where recordTypeID != :AccRecordType AND phone IN : onlyPhoneKey
                ]);
                
                
                if(accList != null && accList.size() > 0) {
                    for(Account acc : accList) {
                        if(!accPhoneMap.isEmpty() && accPhoneMap.containsKey(acc.phone)) {
                            accPhoneMap.get(acc.phone).add(acc.Name);
                        } else {
                            accPhoneMap.put(acc.phone, new List<String>{acc.Name});
                        }
                    }
                }
            }
            
            //Name DOB Map
            Map<String, List<String>> nameDobDupMap = new Map<String, List<String>>();
            Map<String, List<String>> accnameDobMap = new Map<String, List<String>>();
            List<Lead> nameDobDupList;
            List<Account> nameDOBAccDupList;
            
            if(onlyLNameKey != null && onlyLNameKey.size() > 0) {
                nameDobDupList = new List<Lead>([
                    Select id, FirstName, LastName, Name, Date_of_Birth__c from Lead where NameDOBKey__c IN : onlyLNameKey AND Date_of_Birth__c != null AND isConverted != true
                ]);
                
                nameDOBAccDupList = new List<Account>([
                    Select id, Name, Date_of_Birth__c,Name_DOB_External_Key__c from Account where Name_DOB_External_Key__c IN : onlyLNameKey AND Date_of_Birth__c != null
                ]);
            }
            
            if(nameDobDupList != null && nameDobDupList.size() > 0) {
                for(Lead ld : nameDobDupList) {
                    if(ld.FirstName != null && ld.FirstName != '') {
                        if(!nameDobDupMap.isEmpty() && nameDobDupMap.containsKey(ld.FirstName.toLowerCase().deleteWhitespace() + ld.LastName.toLowerCase().deleteWhitespace() + String.Valueof(ld.Date_of_Birth__c))) {
                            nameDobDupMap.get(ld.FirstName.toLowerCase().deleteWhitespace() + ld.LastName.toLowerCase().deleteWhitespace() + String.Valueof(ld.Date_of_Birth__c)).add(ld.Name);
                        } else {
                            nameDobDupMap.put(ld.FirstName.toLowerCase().deleteWhitespace() + ld.LastName.toLowerCase().deleteWhitespace() + String.Valueof(ld.Date_of_Birth__c), new List<String>{ld.Name});
                        }
                    } else {
                        if(!nameDobDupMap.isEmpty() && nameDobDupMap.containsKey(ld.LastName.toLowerCase().deleteWhitespace() + String.Valueof(ld.Date_of_Birth__c))) {
                            nameDobDupMap.get(ld.LastName.toLowerCase().deleteWhitespace() + String.Valueof(ld.Date_of_Birth__c)).add(ld.Name);
                        } else {
                            nameDobDupMap.put(ld.LastName.toLowerCase().deleteWhitespace() + String.Valueof(ld.Date_of_Birth__c), new List<String>{ld.Name});
                        }
                    }
                } 
            }
            
            if(nameDOBAccDupList != null && nameDOBAccDupList.size() > 0) {
                for(Account acc : nameDOBAccDupList) {
                    if(!accnameDobMap.isEmpty() && accnameDobMap.containsKey(acc.Name.toLowerCase().deleteWhitespace() + String.Valueof(acc.Date_of_Birth__c))) {
                        accnameDobMap.get(acc.Name.toLowerCase().deleteWhitespace() + String.Valueof(acc.Date_of_Birth__c)).add(acc.name);
                    } else {
                        accnameDobMap.put(acc.Name.toLowerCase().deleteWhitespace() + String.Valueof(acc.Date_of_Birth__c), new List<String>{acc.name});
                    }
                }
            }
            system.debug('Map==>'+accPhoneMap);
            //Duplication Errors
            for(Lead ld : leadList) {
                Boolean isError = false;
                if(!ld.Do_you_want_to_bypass_duplicate_check__c && ld.Status != 'Converted') {
                    
                    //Mobile or Phone match error for both accounts and leads
                    if(!accPhoneMap.isEmpty()) {
                        //if both account and lead Mobile match
                        if(!phoneDupMap.isEmpty()) {
                            if(accPhoneMap.containsKey(ld.MobilePhone) && (phoneDupMap.containskey(ld.MobilePhone))) {
                                isError = true;
                                ld.MobilePhone.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accPhoneMap.get(ld.MobilePhone) + '. LEAD DETAILS : ' + phoneDupMap.get(ld.MobilePhone));
                                ld.addError('Mobile Phone: There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accPhoneMap.get(ld.MobilePhone) + '. LEAD DETAILS : ' + phoneDupMap.get(ld.MobilePhone));
                            } else if(ld.Phone != null && accPhoneMap.containsKey(ld.Phone) && (phoneDupMap.containskey(ld.Phone))) {
                                isError = true;
                                ld.Phone.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accPhoneMap.get(ld.Phone) + '. LEAD DETAILS : ' + phoneDupMap.get(ld.Phone));
                                ld.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accPhoneMap.get(ld.Phone) + '. LEAD DETAILS : ' + phoneDupMap.get(ld.Phone));
                            }
                        }
                        
                        //if only account mobile match
                        if(accPhoneMap.containsKey(ld.MobilePhone) && !isError) {
                            isError = true;
                            ld.MobilePhone.addError('There are duplicate Accounts. ACCOUNT DETAILS : ' + accPhoneMap.get(ld.MobilePhone) + '.');
                            ld.addError('There are duplicate Accounts. ACCOUNT DETAILS : ' + accPhoneMap.get(ld.MobilePhone) + '.');
                        } else if(ld.Phone != null && accPhoneMap.containsKey(ld.Phone)  && !isError) {
                            isError = true;
                            ld.Phone.addError('There are duplicate Accounts. ACCOUNT DETAILS : ' + accPhoneMap.get(ld.Phone) + '.');
                            ld.addError('There are duplicate Accounts. ACCOUNT DETAILS : ' + accPhoneMap.get(ld.Phone) + '.');
                        }
                    }
                    
                    //Mobile or Phone match error only in leads
                    if(!phoneDupMap.isEmpty() && !isError) {
                        if(ld.MobilePhone != null && ld.Date_of_Birth__c != null && phoneDupMap.containskey(ld.MobilePhone)) {
                            isError = true;
                            ld.MobilePhone.addError('There are duplicate Leads. LEAD DETAILS : ' + phoneDupMap.get(ld.MobilePhone) + '.');
                            ld.addError('There are duplicate Leads. LEAD DETAILS : ' + phoneDupMap.get(ld.MobilePhone) + '.');
                        } else if(ld.Phone != null && ld.Date_of_Birth__c != null && phoneDupMap.containskey(ld.Phone)) {
                            isError = true;
                            ld.Phone.addError('There are duplicate Leads. LEAD DETAILS : ' + phoneDupMap.get(ld.Phone) + '.');
                            ld.addError('There are duplicate Leads. LEAD DETAILS : ' + phoneDupMap.get(ld.Phone) + '.');
                        }
                    }
                    
                    // Name and DOB Match for both account and lead
                    String fNamekey = '';
                    String lNamekey = ld.LastName.toLowerCase().deleteWhitespace() + String.Valueof(ld.Date_of_Birth__c);
                    if(ld.FirstName != null && ld.FirstName != '') {
                        fNamekey = ld.FirstName.toLowerCase().deleteWhitespace() + ld.LastName.toLowerCase().deleteWhitespace() + String.Valueof(ld.Date_of_Birth__c);
                    }
                    if(!accnameDobMap.isEmpty() && !isError) {
                        if(!nameDobDupMap.isEmpty()) {
                            
                            //for both account and lead
                            if(accnameDobMap.containsKey(fNamekey) && nameDobDupMap.containsKey(fNamekey)) {
                                isError = true;
                                ld.LastName.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accnameDobMap.get(fNamekey) + '. LEAD DETAILS : ' + nameDobDupMap.get(fNamekey));
                                ld.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accnameDobMap.get(fNamekey) + '. LEAD DETAILS : ' + nameDobDupMap.get(fNamekey));
                            }
                            
                            if(!isError && accnameDobMap.containsKey(lNamekey) && nameDobDupMap.containsKey(lNamekey)) {
                                isError = true;
                                ld.LastName.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accnameDobMap.get(lNamekey) + '. LEAD DETAILS : ' + nameDobDupMap.get(lNamekey));
                                ld.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accnameDobMap.get(lNamekey) + '. LEAD DETAILS : ' + nameDobDupMap.get(lNamekey));
                            }
                            
                            if(!isError && accnameDobMap.containsKey(lNamekey) && nameDobDupMap.containsKey(fNamekey)) {
                                isError = true;
                                ld.LastName.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accnameDobMap.get(lNamekey) + '. LEAD DETAILS : ' + nameDobDupMap.get(fNamekey));
                                ld.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accnameDobMap.get(lNamekey) + '. LEAD DETAILS : ' + nameDobDupMap.get(fNamekey));
                            }
                            
                            if(!isError && accnameDobMap.containsKey(fNamekey) && nameDobDupMap.containsKey(lNamekey)) {
                                isError = true;
                                ld.LastName.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accnameDobMap.get(fNamekey) + '. LEAD DETAILS : ' + nameDobDupMap.get(lNamekey));
                                ld.addError('There are duplicate Accounts & Leads. ACCOUNT DETAILS : ' + accnameDobMap.get(fNamekey) + '. LEAD DETAILS : ' + nameDobDupMap.get(lNamekey));
                            }
                        }
                        
                        //Only in Account Name DOB Match
                        if(!isError && accnameDobMap.containsKey(fNamekey)) {
                            isError = true;
                            ld.LastName.addError('There are duplicate Accounts. ACCOUNT DETAILS : ' + accnameDobMap.get(fNamekey) + '.');
                            ld.addError('There are duplicate Accounts. ACCOUNT DETAILS : ' + accnameDobMap.get(fNamekey) + '.');
                        } else if(!isError && accnameDobMap.containsKey(lNamekey)) {
                            isError = true;
                            ld.LastName.addError('There are duplicate Accounts. ACCOUNT DETAILS : ' + accnameDobMap.get(lNamekey) + '.');
                            ld.addError('There are duplicate Accounts. ACCOUNT DETAILS : ' + accnameDobMap.get(lNamekey) + '.');
                        }
                    }
                    
                    //Only in leads Name DOB Match
                    if(!isError && !nameDobDupMap.isEmpty()) {
                        if(nameDobDupMap.containsKey(fNamekey)) {
                            isError = true;
                            ld.LastName.addError('There are duplicate Leads. LEAD DETAILS : ' + nameDobDupMap.get(fNamekey) + '.');
                            ld.addError('There are duplicate Leads. LEAD DETAILS : ' + nameDobDupMap.get(fNamekey) + '.');
                        } else if (nameDobDupMap.containsKey(lNamekey)) {
                            isError = true;
                            ld.LastName.addError('There are duplicate Leads. LEAD DETAILS : ' + nameDobDupMap.get(lNamekey) + '.');
                            ld.addError('There are duplicate Leads. LEAD DETAILS : ' + nameDobDupMap.get(lNamekey) + '.');
                        }
                    }  
                }
            }
        }
    }

    public static final Integer SIMILARITY_THRESHOLD = Integer.valueof(System.Label.SIMILARITY_THRESHOLD);
    public static void byPassFlowForService(list<Lead> leadList) {
        Map<Lead, Integer> similarityMap = new Map<Lead, Integer>();
        Map<Lead, Integer> similarityMap1 = new Map<Lead, Integer>();
        Map<Lead, Integer> similarityMap3 = new Map<Lead, Integer>();
        map<string,lead>TagLeadMap = new map<string,lead>();
        map<string,account>tagAccountmap = new map<string,account>();
        List<Lead> duplicateLeads = new List<Lead>();
        list<case>CaseList = new list<case>();
        list<opportunity> OppList = new list<opportunity>();
        list<lead>TobedeletedLead = new list<lead>();
        list<lead>UpdatedList = new list<lead>();
        Set<String> existingNames1 = new Set<String>();
        // Collect existing leads' cleaned first names and last names in sets
        Set<String> existingNames = new Set<String>();
        Set<String> LocationId = new Set<String>();
        set<string> MobilePhoneSet = new set<string>();
        set<string> GenderSet = new set<string>();
        map<string,lead>LeadNewMap = new map<string,lead>();
        Set<String> existingNamesForACc = new Set<String>();   
        map<string,lead>leadMap = new map<string,lead>();
        List<Lead> duplicates = new List<Lead>();
        list<lead>deleledlist = new list<lead>();
        list<lead>ExcelLeadList = new list<lead>();
        set<lead>MapSet = new set<lead>();
        for(lead newLeads : leadList) {
            if(newLeads.Location_Id__c != null) {
                LocationId.add(newLeads.Location_Id__c);
            }
            if(newLeads.Phone != null) {
                MobilePhoneSet.add(newLeads.phone);
                String phoneNumber = newLeads.phone ;
                String fullName = getFullName(newLeads);
                string gen = newLeads.Gender__c;
                String key = phoneNumber + fullName +gen;
                if(newLeads.PRN__c == null && newLeads.QRN__c == null ){
                    system.debug('inside first condition that lead soorce is call center');
                    if (leadMap.containsKey(key)) {
                        duplicates.add(newLeads);
                    } 
                    else {
                        leadMap.put(key, newLeads);
                    }
                }
                
            }
            if(newLeads.Gender__c != null) {
                GenderSet.add(newLeads.Gender__c);
            } 
        }
        if(duplicates != null && duplicates.size()>0) {
            for (Lead duplicate : duplicates) {
                duplicate.addError('Duplicate lead name found');
            }
        }
        
        Id devRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Others').getRecordTypeId();
        Id devRecordTypeOppId = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Others').getRecordTypeId();
         Id devRecordTypeAccId = Schema.SObjectType.account.getRecordTypeInfosByName().get('Patients').getRecordTypeId();
         Id devRecordTypeLeadId = Schema.SObjectType.lead.getRecordTypeInfosByName().get('Patients').getRecordTypeId();
        map<string,Unit_Location__c> unitMap = new map<string,Unit_Location__c>();
        
        if(LocationId != null && LocationId.size()>0) {
            unitMap = getObjectMapUtility.getunit(LocationId);
        }
        
        list<lead>ExitLead = [SELECT FirstName,MiddleName, LastName,Father_Name__c,prn__c,qrn__c FROM Lead where RecordTypeId = :devRecordTypeLeadId and Phone IN : MobilePhoneSet AND Gender__c IN : GenderSet AND isconverted != true];
        if(ExitLead != null && ExitLead.size()>0){
            for (Lead existingLead : ExitLead) {   
                string fullname;
                if(existingLead.FirstName != null && existingLead.MiddleName != null) {
                    fullname = existingLead.FirstName.toLowerCase().deleteWhitespace()+existingLead.MiddleName.toLowerCase().deleteWhitespace()+existingLead.LastName.toLowerCase().deleteWhitespace();
                    existingNames.add(fullname);
                    TagLeadMap.put(fullname,existingLead);
                }
                else if(existingLead.FirstName != null) {
                    fullname = existingLead.FirstName.toLowerCase().deleteWhitespace()+existingLead.LastName.toLowerCase().deleteWhitespace();
                    existingNames.add(fullname);
                    TagLeadMap.put(fullname,existingLead);
                }
                else if(existingLead.MiddleName != null) {
                    fullname = existingLead.MiddleName.toLowerCase().deleteWhitespace()+existingLead.LastName.toLowerCase().deleteWhitespace();
                    existingNames.add(fullname);
                    TagLeadMap.put(fullname,existingLead);
                }
            }
        }
        
        for (Account existingAccount : [SELECT Name FROM account where RecordTypeId = :devRecordTypeAccId and  Phone IN : MobilePhoneSet AND Gender__c IN : GenderSet]  ) {
            if(existingAccount.Name != null && existingAccount.Name != null) {
                existingNamesForACc.add(existingAccount.Name.toLowerCase().deleteWhitespace());
                tagAccountmap.put(existingAccount.Name.toLowerCase().deleteWhitespace(),existingAccount);
            }
            
        }
        
        if(ExitLead != null && ExitLead.size()>0) {
            for (Lead lead : leadList) { 
                Integer similarityScore = calculateSimilarity(lead, existingNames);
                similarityMap.put(lead, similarityScore);
                similarityMap3.put(lead, similarityScore);
            }
        }
        else {
            if(existingNames != null && existingNames.size()>0) {
                for (Lead lead : leadList) {
                    
                    String phoneNumber = lead.phone ;
                    String fullName = getFullName(lead);
                    string gen = lead.Gender__c;
                    String key = phoneNumber + fullName + gen;
                    
                    Integer similarityScore = calculateSimilarity(leadMap.get(key), existingNames);
                    similarityMap.put(lead, similarityScore);
                    similarityMap3.put(lead, similarityScore);
                }
            }
        }
        if(existingNamesForACc != null && existingNamesForACc.size()>0){
            for (Lead lead : leadList) {
                Integer similarityScore = calculateSimilarity(lead, existingNamesForACc);
                similarityMap1.put(lead, similarityScore);
                similarityMap3.put(lead, similarityScore);
            }
        }
        account matchingaccount = new account();
        lead matchingLead = new lead();
        // Iterate through the similarity map and identify the duplicate leads
        for (Lead lead : similarityMap3.keySet()) {
            if (similarityMap.get(lead) <= SIMILARITY_THRESHOLD) {
                string leadfullname = getFullName(lead);
                matchingLead = findMatchingLead(leadfullname,TagLeadMap);
                if((lead.LeadSource != null && lead.LeadSource != ''  && lead.LeadSource != 'Call Center')){
                    if((lead.PRN__c != null ||lead.QRN__c != null) && (matchingLead.PRN__c != null || matchingLead.qrn__c != null)){
                        system.debug('hello');
                    }
                    else {
                        case c = new case();
                        c.RecordTypeId = devRecordTypeId;
                        c.Lead__c = matchingLead.id;
                        c.Referral_Source__c = lead.LeadSource;
                        CaseList.add(c);
                        /*if(lead.PRN__c != null) {
                            matchingLead.PRN__c = lead.PRN__c;
                        } 
                        if(lead.QRN__c != null) {
                            matchingLead.QRN__c = lead.QRN__c;
                        }*/
                        
                        TobedeletedLead.add(lead);
                        //UpdatedList.add(matchingLead);
                    }
                    
                }
                else{
                    lead.adderror('Duplicate lead found  '+matchingLead.FirstName+ ' '+matchingLead.LastName+' ('+(100-(similarityMap.get(lead)))+'%)');
                    duplicateLeads.add(lead);
                } 
            }
            if (similarityMap1.get(lead) <= SIMILARITY_THRESHOLD) {
                system.debug('size '+similarityMap.get(lead));
                string leadfullname = getFullName(lead);
                matchingaccount = findMatchingAccount(leadfullname,tagAccountmap);
                if((lead.LeadSource != null && lead.LeadSource != ''  && lead.LeadSource != 'Call Center')) {
                    opportunity opp = new opportunity();
                    system.debug('account '+matchingaccount);
                    system.debug('map '+tagAccountmap);
                    system.debug('matchingaccount.Name'+matchingaccount.Name);
                    opp.Name = matchingaccount.Name;
                    opp.CloseDate = system.today();
                    opp.StageName = 'open';
                    opp.RecordTypeId = devRecordTypeOppId;
                    opp.AccountId = matchingaccount.id;
                    opp.Referral_Source__c = lead.LeadSource;
                    OppList.add(opp);                        
                }
                else
                    lead.adderror('Duplicate account found with this name and mobilePhone '+matchingaccount.Name+' ('+(100-(similarityMap1.get(lead)))+'%)');
                duplicateLeads.add(lead);
            }
            
            /*if(similarityMap1.get(lead) <= SIMILARITY_THRESHOLD &&  similarityMap.get(lead) <= SIMILARITY_THRESHOLD){
                system.debug('size '+similarityMap.get(lead));
                lead.adderror('Duplicate account  and lead found with this name and mobilePhone '+matchingLead.FirstName+ ' '+matchingLead.LastName+' '+matchingaccount.name+' ('+(100-(similarityMap1.get(lead)))+'%)');
                duplicateLeads.add(lead);
            }*/
        }
        
        try {
            insert CaseList;
            insert OppList;  
            //update UpdatedList;
        }
        catch(exception e) {
            system.debug('Exception==>'+e);
        }
        
    }
    // Calculate similarity between firstName and lastName of a lead
    public static Lead findMatchingLead(String leadfullname, Map<String, Lead> TagLeadMap) {
        for (String fullName : TagLeadMap.keySet()) {
            Integer similarityScore = calculateSimilarity1(leadfullname, fullName);
            if (similarityScore <= SIMILARITY_THRESHOLD) {
                system.debug('findMatchingLead');
                return TagLeadMap.get(fullName);
            }
        }
        return null;
    }
    public static account findMatchingAccount(String leadfullname, Map<String, account> TagAccountMap) {
        system.debug('map '+TagAccountMap);
        for (String fullName : TagAccountMap.keySet()) {
            Integer similarityScore = calculateSimilarity1(leadfullname, fullName);
            if (similarityScore <= SIMILARITY_THRESHOLD) {
                system.debug('findMatchingAccount');
                return TagAccountMap.get(fullName);
            }
        }
        return null;
    }
    
    // Calculate similarity between firstName and lastName of a lead
    public static Integer calculateSimilarity(Lead lead, Set<String> existingNames) {
        String targetFirstName = '';
        String targetMiddleName = '';
        String targetLastName = '';
        if(lead.FirstName != null) {
            targetFirstName = lead.FirstName.toLowerCase().deleteWhitespace();
        }
        if(lead.MiddleName != null) {
            targetMiddleName = lead.MiddleName.toLowerCase().deleteWhitespace();
        }
        if(lead.lastName != null) {
            targetLastName = lead.LastName.toLowerCase().deleteWhitespace();
        }
        string MainTargetName = targetFirstName+targetMiddleName+targetLastName;
        system.debug('MainTargetName  '+MainTargetName);
        
        Integer maxFirstNameSimilarity = 100;
        for (String Names : existingNames) {
            system.debug('names '+Names);
            
            Integer similarity = calculateLevenshteinDistance(MainTargetName, Names);
            system.debug('similerty = '+similarity);
            maxFirstNameSimilarity = Math.min(maxFirstNameSimilarity, similarity);
        }
        system.debug('hello 6  '+maxFirstNameSimilarity);
        return maxFirstNameSimilarity;
    }
    public static Integer calculateSimilarity1(string MainTargetName, string Names) {
        Integer maxFirstNameSimilarity = 100;
        Integer similarity = calculateLevenshteinDistance(MainTargetName, Names);
        maxFirstNameSimilarity = Math.min(maxFirstNameSimilarity, similarity);
        system.debug('calculateSimilarity   1');
        return maxFirstNameSimilarity;
    }
    
    
    // Calculate Levenshtein distance between two strings
    public static integer calculateLevenshteinDistance(String s1, String s2) {
        double  common;
        
        common = (Double)s1.getLevenshteinDistance(s2) / (Double)s1.length();
        system.debug('common '+common);
        integer distance =  Math.round(common * 100);
        system.debug('distance '+distance);
        return distance;
    }
    public static String getFullName(Lead lead) {
        String firstName = lead.FirstName != null ? lead.FirstName.toLowerCase().deleteWhitespace() : '';
        String middleName = lead.MiddleName != null ? lead.MiddleName.toLowerCase().deleteWhitespace() : '';
        String lastName = lead.LastName != null ? lead.LastName.toLowerCase().deleteWhitespace() : '';
        return firstName + middleName + lastName;
    }
    
    
    //duplicate lead which source has HIs,website those are deleted
    public static void DeleteDuplicateLead(list<Lead> leadList) {
        system.debug('inside deletedduploixatelead    .....1');
        Map<Lead, Integer> similarityMap = new Map<Lead, Integer>();
        Map<Lead, Integer> similarityMap1 = new Map<Lead, Integer>();
        Map<Lead, Integer> similarityMap3 = new Map<Lead, Integer>();
        map<string,lead>TagLeadMap = new map<string,lead>();
        List<Lead> duplicateLeads = new List<Lead>();
        list<case>CaseList = new list<case>();
        list<lead>TobedeletedLead = new list<lead>();
        Set<String> existingNames1 = new Set<String>();
        // Collect existing leads' cleaned first names and last names in sets
        Set<String> existingNames = new Set<String>();
        set<string> MobilePhoneSet = new set<string>();
        set<string> GenderSet = new set<string>();
        map<string,lead>LeadNewMap = new map<string,lead>();
        Set<String> existingNamesForACc = new Set<String>();   
        map<string,lead>leadMap = new map<string,lead>();
        List<Lead> duplicates = new List<Lead>();
        list<lead>deleledlist = new list<lead>();
        set<lead>MapSet = new set<lead>();
        for(lead newLeads : leadList) {
            if(newLeads.LeadSource != null && newLeads.LeadSource != ''  && newLeads.LeadSource != 'Call Center'){
                if(newLeads.Phone != null) {
                    MobilePhoneSet.add(newLeads.phone);
                    String phoneNumber = newLeads.phone ;
                    String fullName = getFullName(newLeads);
                    string gen = newLeads.Gender__c;
                    String key = phoneNumber + fullName +gen;
                    
                    if (leadMap.containsKey(key)) {
                        duplicates.add(newLeads);
                    } 
                    else {
                        leadMap.put(key, newLeads);
                    }
                }
                if(newLeads.Gender__c != null) {
                    GenderSet.add(newLeads.Gender__c);
                }
            }
        }
        for (Lead duplicate : duplicates) {
            system.debug('Duplicate lead name found');
            duplicate.addError('Duplicate lead name found');
        }
          Id devRecordTypeLeadId = Schema.SObjectType.lead.getRecordTypeInfosByName().get('Patients').getRecordTypeId();
          Id devRecordTypeAccId = Schema.SObjectType.account.getRecordTypeInfosByName().get('Patients').getRecordTypeId();
        list<lead>ExitLead = [SELECT FirstName,MiddleName, LastName,Father_Name__c,prn__c,qrn__c FROM Lead where  RecordTypeId = :devRecordTypeLeadId and  Phone IN : MobilePhoneSet AND Gender__c IN : GenderSet AND isconverted != true and id NOT IN : leadList];
        system.debug('Exiting Lead=>'+ExitLead);
        if(ExitLead != null && ExitLead.size()>0){
            for (Lead existingLead : ExitLead) { 
                string fullname;
                if(existingLead.FirstName != null && existingLead.MiddleName != null) {
                    fullname = existingLead.FirstName.toLowerCase().deleteWhitespace()+existingLead.MiddleName.toLowerCase().deleteWhitespace()+existingLead.LastName.toLowerCase().deleteWhitespace();
                    existingNames.add(fullname);
                    TagLeadMap.put(fullname,existingLead);
                }
                else if(existingLead.FirstName != null) {
                    fullname = existingLead.FirstName.toLowerCase().deleteWhitespace()+existingLead.LastName.toLowerCase().deleteWhitespace();
                    existingNames.add(fullname);
                    TagLeadMap.put(fullname,existingLead);
                    // existingNames.add(existingLead.FirstName.toLowerCase().deleteWhitespace()+existingLead.LastName.toLowerCase().deleteWhitespace());
                }
                else if(existingLead.MiddleName != null) {
                    fullname = existingLead.MiddleName.toLowerCase().deleteWhitespace()+existingLead.LastName.toLowerCase().deleteWhitespace();
                    existingNames.add(fullname);
                    TagLeadMap.put(fullname,existingLead);
                }
            }
        }
        
        for (Account existingAccount : [SELECT Name FROM account where RecordTypeId = :devRecordTypeAccId and  Phone IN : MobilePhoneSet AND Gender__c IN : GenderSet]) {
            if(existingAccount.Name != null && existingAccount.Name != null) {
                existingNamesForACc.add(existingAccount.Name.toLowerCase().deleteWhitespace());
            }
        }
        
        if(ExitLead != null && ExitLead.size()>0){
            for (Lead lead : leadList) { 
                Integer similarityScore = calculateSimilarity(lead, existingNames);
                similarityMap.put(lead, similarityScore);
                similarityMap3.put(lead, similarityScore);
            }
        }
        else {
            if(existingNames != null && existingNames.size()>0){
                for (Lead lead : leadList) {
                    
                    String phoneNumber = lead.Phone ;
                    String fullName = getFullName(lead);
                    string gen = lead.Gender__c;
                    String key = phoneNumber + fullName + gen;
                    
                    Integer similarityScore = calculateSimilarity(leadMap.get(key), existingNames);
                    similarityMap.put(lead, similarityScore);
                    similarityMap3.put(lead, similarityScore);
                }
            }
        }
        if(existingNamesForACc != null && existingNamesForACc.size()>0){
            for (Lead lead : leadList) {
                Integer similarityScore = calculateSimilarity(lead, existingNamesForACc);
                similarityMap1.put(lead, similarityScore);
                similarityMap3.put(lead, similarityScore);
            }
        }
        Id devRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Others').getRecordTypeId();
        // Iterate through the similarity map and identify the duplicate leads
        for (Lead lead : similarityMap3.keySet()) {
            system.debug('Yes==>'+similarityMap.get(lead));
             system.debug('Yes==>'+SIMILARITY_THRESHOLD);
            if (similarityMap.get(lead) <= SIMILARITY_THRESHOLD) {
                string leadfullname = getFullName(lead);
                Lead matchingLead = findMatchingLead(leadfullname,TagLeadMap);
                if((lead.LeadSource != null && lead.LeadSource != '' && lead.LeadSource != 'Call Center' )) {
                    if((lead.PRN__c != null ||lead.QRN__c != null)&& (matchingLead.PRN__c != null || matchingLead.qrn__c != null)){
                        system.debug('hello');
                    }
                    else if((lead.PRN__c != null ||lead.QRN__c != null)&& (matchingLead.PRN__c == null && matchingLead.qrn__c == null)) {
                        case c = new case();
                        c.RecordTypeId = devRecordTypeId;
                        c.Lead__c = lead.id;
                        c.Referral_Source__c = lead.LeadSource;
                        CaseList.add(c);
                        TobedeletedLead.add(matchingLead);
                    }
                    else{
                        lead l = new lead();
                        l.id = lead.id;
                        TobedeletedLead.add(l);
                    }
                }
            }  
            else if (similarityMap1.get(lead) <= SIMILARITY_THRESHOLD) {
                //string leadfullname = getFullName(lead);
                //Lead matchingLead = findMatchingLead(leadfullname,TagLeadMap);
                if((lead.LeadSource != null && lead.LeadSource != '' && lead.LeadSource != 'Call Center' )) {
                    /*if((lead.PRN__c != null ||lead.QRN__c != null)){
                        system.debug('hello');
                    }
                    else{*/
                        lead l = new lead();
                        l.id = lead.id;
                        TobedeletedLead.add(l);
                    //}
                }
            }  
        }
        if(CaseList != null && CaseList.size()>0) {
            insert CaseList;
        }
        if(TobedeletedLead != null && TobedeletedLead.size()>0) {
            try {
                delete TobedeletedLead;
            }
            catch(exception e) {
                
            }
            
        }
    }
    
    //set heads emails to lead record
    public static void setEmails(list<lead> leadList) {
        if(leadList != null && leadList.size()>0) {
            map<string,Unit_Location__c> unitMap = new map<string,Unit_Location__c>();
            map<string,Unit_Location__c> unitQueueMap = new map<string,Unit_Location__c>();
            list<Unit_Location__c> unitList = new list<Unit_Location__c>([select id,Name,Queue_Name__c,Unit_Center_Head__c,Corporate_Operations_Head__c,Unit_Ops_Head__c,Regional_Business_Head__c from Unit_Location__c limit 10000]);
            
            if(unitList != null && unitList.size()>0) {
                for(Unit_Location__c unitRecord : unitList) {
                    unitMap.put(unitRecord.Name , unitRecord);
                    unitQueueMap.put(unitRecord.Queue_Name__c,unitRecord);
                }
            }
            
            for(lead leadRec : leadList) {
                system.debug('Unit==>'+leadRec.OwnerUnit__c);
                if(unitMap.get(leadRec.OwnerUnit__c) != null) {
                    leadRec.Unit_Center_Head__c = unitMap.get(leadRec.OwnerUnit__c).Unit_Center_Head__c;
                    leadRec.UnitHead__c = unitMap.get(leadRec.OwnerUnit__c).Unit_Ops_Head__c;
                    leadRec.COH__c = unitMap.get(leadRec.OwnerUnit__c).Corporate_Operations_Head__c;
                    leadRec.Regional_BH__c = unitMap.get(leadRec.OwnerUnit__c).Regional_Business_Head__c;
                }
                else if(unitMap.get(leadRec.queueName__c) != null) {
                    leadRec.Unit_Center_Head__c = unitMap.get(leadRec.queueName__c).Unit_Center_Head__c;
                    leadRec.UnitHead__c = unitMap.get(leadRec.queueName__c).Unit_Ops_Head__c;
                    leadRec.COH__c = unitMap.get(leadRec.queueName__c).Corporate_Operations_Head__c;
                    leadRec.Regional_BH__c = unitMap.get(leadRec.queueName__c).Regional_Business_Head__c;
                }
            }   
        }
    }
    
    /***************** Methods Added By Nitish *********************/
    /************************** Start ******************************/
    //Method for adding Leads as a campaign member 
    Public static void addListToCampaign(list<lead> leadListsenWhatsApp){
        system.debug('Inside Campaign Member function');
        try
        {
            if(leadListsenWhatsApp != null && leadListsenWhatsApp.size() > 0){
                list<string> CampaignId = new list<string>();
                List<campaignmember> campaignMemberList = new List<campaignmember>();
                for(Lead leadRecord : leadListsenWhatsApp){
                    if(leadRecord.RecordTypeName__c == 'Patients' && leadRecord.Campaign_Id__c != null){
                        CampaignId.add(leadRecord.Campaign_Id__c);
                    }
                }
                system.debug('CampaignId ====> ' + CampaignId);
                if(CampaignId != null){
                    list<Campaign> campaignList = new list<Campaign>([select id, name from Campaign where Id in :CampaignId]);
                    map<string, Campaign> campaignName = new map<string, campaign>();
                    for(Campaign eachCampaign : campaignList){
                        campaignName.put(eachCampaign.Id, eachCampaign);
                    }
                    system.debug('campaignName ===> ' + campaignName);
                    for(Lead leadRecord : leadListsenWhatsApp){
                        if(leadRecord.Campaign_Id__c != null ){
                            campaignmember campMember = new campaignmember();
                            campMember.LeadId = leadRecord.Id;
                            system.debug('camapign id ====> ' + campaignName.get(leadRecord.Campaign_Id__c).Id);
                            campMember.CampaignId = campaignName.get(leadRecord.Campaign_Id__c).Id;
                            campaignMemberList.add(campMember);
                        }
                    }
                    try{
                        if(campaignMemberList.size() > 0){
                            insert campaignMemberList;
                        }
                    }
                    catch(exception e) {
                        system.debug(e.getMessage());
                    }
                }
                
            }
        }
        catch(exception e) {
            system.debug( 'No Campaign with this Id ===> ' + e.getMessage());
        }
    }
    
    @future(callout = true)
    Public static void sendWhatsappMessage(set<string> leadIds){
        list<Lead> newLeadList = new list<Lead>();
        newLeadList = [Select Id, Name, Phone, Email FROM Lead Where Id IN : leadIds];
        
        if(newLeadList != null && newLeadList.size()>0 ) {
            for(lead newLead : newLeadList) {
                String jsonString = '{"Name": "' + newLead.Name+ '","Email":"' + newLead.Email +'","Phone":"' + newLead.Phone +'","TemplateName":"namasthe","BotId":51589108}';
                system.debug('jsonString ====> ' + jsonString);
                String endPoint = 'https://www.kenyt.ai/dashboardapi/api/crm/send-message?authToken=3a6ef933-d0ee-4855-a1af-a86f8c4ea9c0&organizationId=6493435';
                
                
                Http h2 = new Http();
                HttpRequest newreq = new HttpRequest();
                newreq.setHeader('Content-Type','application/json');
                newreq.setBody(jsonString);
                newreq.setMethod('POST');
                newreq.setEndpoint(endPoint);
                if ( !Test.isRunningTest() ){
                    HttpResponse res2 = h2.send(newreq);
                    System.debug(res2.getBody());
                } 
            }
        }
    }
    
    Public static void matchDoctorUnitLocation(list<lead> leadWebsiteList){
        if(leadWebsiteList != null && leadWebsiteList.size() > 0){
            List<String> strOfWebsiteDoctor = new List<String>();
            List<String> strOfUnitLocation = new List<String>();
            List<String> strOfCountry = new List<String>();
            for(Lead leadRecord : leadWebsiteList){
                if(leadRecord.RecordTypeName__c == 'Patients' && leadRecord.Website_Location__c != null && leadRecord.Website_Doctor__c != null){
                    if(leadRecord.Website_Doctor__c.contains('Dr.')){
                        strOfWebsiteDoctor.add(leadRecord.Website_Doctor__c.replace('Dr. ' , ''));
                    }
                    else if(leadRecord.Website_Doctor__c.contains('Mr.')){
                        strOfWebsiteDoctor.add(leadRecord.Website_Doctor__c.replace('Mr. ' , ''));
                    }
                    else if(leadRecord.Website_Doctor__c.contains('Dr')){
                        strOfWebsiteDoctor.add(leadRecord.Website_Doctor__c.replace('Dr ' , ''));
                    }
                    else if(leadRecord.Website_Doctor__c.contains('Prof. Dr.')){
                        strOfWebsiteDoctor.add(leadRecord.Website_Doctor__c.replace('Prof. Dr. ' , ''));
                    }
                    else if(leadRecord.Website_Doctor__c.contains('Dr. (Maj.)')){
                        strOfWebsiteDoctor.add(leadRecord.Website_Doctor__c.replace('Dr. (Maj.) ' , ''));
                    }
                    else{
                        strOfWebsiteDoctor.add(leadRecord.Website_Doctor__c);
                    }
                    strOfUnitLocation.add(leadRecord.Website_Location__c);
                    strOfCountry.add(leadRecord.Website_Country__c);
                }
            }
            system.debug('strOfWebsiteDoctor ====> ' + strOfWebsiteDoctor);
            system.debug('strOfUnitLocation ====> ' + strOfUnitLocation);
            system.debug('strOfCountry ====> ' + strOfCountry);
            Map<String,String> mapOfDoctorId = new Map<String,String>();
            Map<String,String> mapOfSpecialtyId = new Map<String,String>();
            Map<String,String> mapOfUnitLocationId = new Map<String,String>();
            Map<String,String> mapOfCountry = new Map<String,String>();
            
            List<Unit_Location__c> lstOfUnitLocation = new List<Unit_Location__c>();
            List<Doctors_Location_Wise_Master__c> lstOfDoctor = new List<Doctors_Location_Wise_Master__c>();
            List<Country__c> lstOfCountry = new List<Country__c>();
            if(strOfWebsiteDoctor != null && strOfWebsiteDoctor.size() > 0){
                lstOfDoctor = [Select Id, Name, Specialty_Master__r.Name FROM Doctors_Location_Wise_Master__c Where Name IN: strOfWebsiteDoctor];
            }
            system.debug('lstOfDoctor ===> ' + lstOfDoctor);
            if(strOfUnitLocation != null && strOfUnitLocation.size() > 0){
                lstOfUnitLocation = [Select Id, Name, Unit_Name__c FROM Unit_Location__c Where Unit_Name__c IN: strOfUnitLocation];
            }
            system.debug('lstOfUnitLocation ===> ' + lstOfUnitLocation);
            if(strOfCountry != null && strOfCountry.size() > 0){
                lstOfCountry = [Select Id, Name FROM Country__c Where Name IN: strOfCountry];
            }
            system.debug('lstOfCountry ===> ' + lstOfCountry);
            if(lstOfDoctor != null && lstOfDoctor.size() > 0){
                for(Doctors_Location_Wise_Master__c eachDoc : lstOfDoctor){
                    mapOfDoctorId.put(eachDoc.Name, eachDoc.Id);
                    mapOfSpecialtyId.put(eachDoc.Name,eachDoc.Specialty_Master__c);
                }
            }
            system.debug('mapOfDoctorId ===> ' + mapOfDoctorId);
            if(lstOfUnitLocation != null && lstOfUnitLocation.size() > 0){
                for(Unit_Location__c eachUnitLocation : lstOfUnitLocation){
                    mapOfUnitLocationId.put(eachUnitLocation.Unit_Name__c, eachUnitLocation.Id);
                }
            }
            system.debug('mapOfUnitLocationId ===> ' + mapOfUnitLocationId);
            if(lstOfCountry != null && lstOfCountry.size() > 0){
                for(Country__c eachCountry : lstOfCountry){
                    mapOfCountry.put(eachCountry.Name, eachCountry.Id);
                }
            }
            system.debug('mapOfCountry ===> ' + mapOfCountry);
            try{
                for(Lead eachLead : leadWebsiteList){
                    if(eachLead.Website_Doctor__c.contains('Dr.')){
                        String doctorName = eachLead.Website_Doctor__c.replace('Dr. ' , '');
                        system.debug('doctorName ====> ' + doctorName);
                        if((mapOfDoctorId.containskey(doctorName) || mapOfSpecialtyId.containskey(doctorName)) && eachLead.Website_Doctor__c != null && eachLead.Website_Doctor__c != ''){
                            eachLead.Doctor_Location_Wise_Master__c = mapOfDoctorId.get(doctorName);
                            eachLead.Specialty_Master__c = mapOfSpecialtyId.get(doctorName);
                            system.debug('Inside Doctor populate field ===> ' + eachLead.Doctor_Location_Wise_Master__c);
                        }
                    }
                    else if(eachLead.Website_Doctor__c.contains('Mr.')){
                        String doctorName = eachLead.Website_Doctor__c.replace('Mr. ' , '');
                        system.debug('doctorName ====> ' + doctorName);
                        if((mapOfDoctorId.containskey(doctorName) || mapOfSpecialtyId.containskey(doctorName)) && eachLead.Website_Doctor__c != null && eachLead.Website_Doctor__c != ''){
                            eachLead.Doctor_Location_Wise_Master__c = mapOfDoctorId.get(doctorName);
                            eachLead.Specialty_Master__c = mapOfSpecialtyId.get(doctorName);
                            system.debug('Inside Doctor populate field ===> ' + eachLead.Doctor_Location_Wise_Master__c);
                        }
                    }
                    else if(eachLead.Website_Doctor__c.contains('Prof. Dr.')){
                        String doctorName = eachLead.Website_Doctor__c.replace('Prof. Dr. ' , '');
                        system.debug('doctorName ====> ' + doctorName);
                        if((mapOfDoctorId.containskey(doctorName) || mapOfSpecialtyId.containskey(doctorName)) && eachLead.Website_Doctor__c != null && eachLead.Website_Doctor__c != ''){
                            eachLead.Doctor_Location_Wise_Master__c = mapOfDoctorId.get(doctorName);
                            eachLead.Specialty_Master__c = mapOfSpecialtyId.get(doctorName);
                            system.debug('Inside Doctor populate field ===> ' + eachLead.Doctor_Location_Wise_Master__c);
                        }
                    }
                    else if(eachLead.Website_Doctor__c.contains('Dr. (Maj.)')){
                        String doctorName = eachLead.Website_Doctor__c.replace('Dr. (Maj.) ' , '');
                        system.debug('doctorName ====> ' + doctorName);
                        if((mapOfDoctorId.containskey(doctorName) || mapOfSpecialtyId.containskey(doctorName)) && eachLead.Website_Doctor__c != null && eachLead.Website_Doctor__c != ''){
                            eachLead.Doctor_Location_Wise_Master__c = mapOfDoctorId.get(doctorName);
                            eachLead.Specialty_Master__c = mapOfSpecialtyId.get(doctorName);
                            system.debug('Inside Doctor populate field ===> ' + eachLead.Doctor_Location_Wise_Master__c);
                        }
                    }
                    else {
                        if((mapOfDoctorId.containskey(eachLead.Website_Doctor__c) || mapOfSpecialtyId.containskey(eachLead.Website_Doctor__c)) && eachLead.Website_Doctor__c != null && eachLead.Website_Doctor__c != ''){
                            eachLead.Doctor_Location_Wise_Master__c = mapOfDoctorId.get(eachLead.Website_Doctor__c);
                            eachLead.Specialty_Master__c = mapOfSpecialtyId.get(eachLead.Website_Doctor__c);
                            system.debug('Inside Doctor populate field ===> ' + eachLead.Doctor_Location_Wise_Master__c);
                        }
                    }
                    if(mapOfUnitLocationId.containskey(eachLead.Website_Location__c) && eachLead.Website_Location__c != null && eachLead.Website_Location__c != ''){
                        eachLead.Treating_Unit__c = mapOfUnitLocationId.get(eachLead.Website_Location__c);
                        eachLead.Unit_Location__c = mapOfUnitLocationId.get(eachLead.Website_Location__c);
                        system.debug('Inside Unit Location populate field ===> ' + eachLead.Website_Location__c);
                    }
                    if(mapOfCountry.containskey(eachLead.Website_Country__c) && eachLead.Website_Country__c != null && eachLead.Website_Country__c != ''){
                        eachLead.Country__c = mapOfCountry.get(eachLead.Website_Country__c);
                        system.debug('Inside Country populate field ===> ' + eachLead.Website_Country__c);
                    }
                }
            }
            catch(exception e){
                system.debug('updating Doctor and treating Error =====> ' + e.getMessage());
            }
        }
    }
    
    Public static void createCaseforMarketingLeads(list<lead> leadListForCase){
        List<Case> lstOfCase = new List<Case>();
        try{
            if(leadListForCase != null && leadListForCase.size() > 0){
                for(Lead leadRecord : leadListForCase){
                    if(leadRecord.RecordTypeName__c == 'Patients' && (leadRecord.Website_Location__c != null || leadRecord.Website_Doctor__c != null || leadRecord.LeadSource == 'Website')){
                        Case singlecase = New case();
                        singlecase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Consultation').getRecordTypeId();
                        singlecase.Lead__c = leadRecord.Id;
                        singlecase.Treating_Unit__c = leadRecord.Treating_Unit__c;
                        singlecase.Specialty_Master__c = leadRecord.Specialty_Master__c;
                        singlecase.Doctor_Location_Wise_Master__c = leadRecord.Doctor_Location_Wise_Master__c;
                        singlecase.Department__c = 'OPD';
                        singlecase.Sub_Department__c = 'OP Consultation';
                        //singlecase.Type_of_Service__c = 'Doctor Availability';
                        lstOfCase.add(singlecase);
                    }
                }
            }
            system.debug('lstOfCase ==== > '+ lstOfCase);
            if(lstOfCase != null && lstOfCase.size() > 0){
               insert lstOfCase; 
            }
        }
        catch(exception e) {
            system.debug( 'no Case Created ===> ' + e.getMessage() + '===' + e.getStackTraceString() + '==='+ e.getLineNumber());
        }
    }
    /***************** Methods Added By Nitish *********************/
    /************************** End ******************************/
    
/***************** Methods Added By Akash To Handel Referral Data *********************/
    public static void handleReferralData(list<lead> leadList) {
		
        set<string> uhids = new set<string>();
        set<Decimal> empcodes = new set<Decimal>();
        set<Decimal> relationCodes = new set<Decimal>();
        set<string> relationStringCodes = new set<string>();
        
        for(lead leadData : leadList) {
            if(leadData.Referral__c == '2' && leadData.HIS_Employee_Referral__c != null && leadData.HIS_Employee_Referral__c != '') {
                empcodes.add(Decimal.ValueOf(leadData.HIS_Employee_Referral__c));
            }
            else if(leadData.Referral__c == '3' && leadData.HIS_Patient_Referral__c != null && leadData.HIS_Patient_Referral__c != '') {
                uhids.add(leadData.HIS_Patient_Referral__c);
            }
            else if(leadData.Referral__c == '1' && leadData.HIS_Referral_ReletionType__c != null && leadData.HIS_Referral_ReletionType__c != '') {
                relationCodes.add(Decimal.valueOf(leadData.HIS_Referral_ReletionType__c));
                relationStringCodes.add(leadData.HIS_Referral_ReletionType__c);
            }
        }
        
        //For Patient Referral 
        list<Account> accList = new list<Account>();
        if(uhids != null && uhids.size()>0) {
            accList = [select id,Uhid_Number__c from Account where Uhid_Number__c IN : uhids];
        }
        
        map<string,Account> accMap = new map<string,Account>();
        if(accList != null && accList.size()>0) {
            for(Account accRecord : accList) {
                if(accRecord.UHID_Number__c != null) {
                    accMap.put(accRecord.UHID_Number__c,accRecord);
                }
            }
        }
        
		//For Employee Referral
        list<Employee_Master__c> empList = new list<Employee_Master__c>();
        if(empcodes != null && empcodes.size()>0) {
            empList = [select id,Employee_Code__c,Employee_ID__c from Employee_Master__c where Employee_ID__c IN :empcodes];
        }

        map<Decimal,Employee_Master__c> empMap = new map<Decimal,Employee_Master__c>();
        if(empList != null && empList.size()>0) {
            for(Employee_Master__c empRecord : empList) {
                empMap.put(empRecord.Employee_ID__c,empRecord);
            }
        }
        
        //For NPD Referral (Runs for Customer Referral)==> Query Count 1
        list<Account> NpdList = new list<Account>();
        if(relationCodes != null && relationCodes.size()>0) {
            NpdList = [select id,HIS_Unique_Number__c,Customer_Category__c,Customer_Type__c from Account where HIS_Unique_Number__c IN : relationCodes];
        }
        
        map<Decimal,Account> NPDMap = new map<Decimal,Account>();
        if(NpdList != null && NpdList.size()>0) {
            for(Account npdRecord : NpdList) {
                if(npdRecord.HIS_Unique_Number__c != null) {
                    NPDMap.put(npdRecord.HIS_Unique_Number__c,npdRecord);
                }
            }
        }
        
        //For Internal Doctor Referral (Runs for Customer Referral)==> Query Count 2
        list<HCG_Doctor__c> DocList = new list<HCG_Doctor__c>();
        if(relationStringCodes != null && relationStringCodes.size()>0) {
            DocList = [select id,DOC_ID__c from HCG_Doctor__c where DOC_ID__c IN :relationStringCodes];
        }
        
        map<string,HCG_Doctor__c> DocMap = new map<string,HCG_Doctor__c>();
        if(DocList != null && DocList.size()>0) {
            for(HCG_Doctor__c docRec : DocList) {
                DocMap.put(docRec.DOC_ID__c,docRec);
            }
        }
        
        //All Other Type referral (Runs for Customer Referral)==> Query Count 3 
        list<Referral_Master__c> referralList = new list<Referral_Master__c>();
        if(relationStringCodes != null && relationStringCodes.size()>0) {
            referralList = [select id,ReferralRelTypeId__c,Referral_Type__c,Referral_Category__c,CUSTOMERCATEGORYID__c,CUSTOMERTYPEID__c from Referral_Master__c where ReferralRelTypeId__c IN :relationStringCodes];
        }

        map<string,Referral_Master__c> referralMap = new map<string,Referral_Master__c>();
        if(referralList != null && referralList.size()>0) {
            for(Referral_Master__c refRec : referralList) {
                referralMap.put(refRec.ReferralRelTypeId__c,refRec);
            }
        }
        
         //All Other Type referral (Runs for referal Category)==> Query Count 4 
        list<Referral_Type__c> referralTypeList = new list<Referral_Type__c>([select id,CUSTOMERCATEGORYID__c,CUSTOMERTYPEID__c,Referral_Category__c,Name,CUSTOMERCATEGORYNAME__c from Referral_Type__c]);
		
        //Referral Type Map
        map<string,Referral_Type__c> referralTypeMap = new map<string,Referral_Type__c>();
        if(referralTypeList != null && referralTypeList.size()>0) {
            for(Referral_Type__c refType : referralTypeList) {
                referralTypeMap.put(refType.CUSTOMERCATEGORYID__c+refType.CUSTOMERTYPEID__c,refType);
            }
        }
        
        for(lead leadRec : leadList) {
            if(accMap != null && accMap.size()>0 && accMap.containsKey(leadRec.HIS_Patient_Referral__c)) {
                leadRec.Patient_Referral__c = accMap.get(leadRec.HIS_Patient_Referral__c).Id;
            }
            
            if(empMap != null && empMap.size()>0 && empMap.containsKey(Decimal.valueOf(leadRec.HIS_Employee_Referral__c))) {
                leadRec.Employee_Referral__c = empMap.get(Decimal.valueOf(leadRec.HIS_Employee_Referral__c)).Id;
            }
            
            if(NPDMap != null && NPDMap.size()>0 && NPDMap.containsKey(Decimal.valueOf(leadRec.HIS_Referral_ReletionType__c))) {
                
                if(NPDMap.get(Decimal.valueOf(leadRec.HIS_Referral_ReletionType__c)).Customer_Category__c == '2') {
                    leadRec.NPD_Doctor__c = NPDMap.get(Decimal.valueOf(leadRec.HIS_Referral_ReletionType__c)).Id;
                }
                else {
                    leadRec.Corporate_Account__c = NPDMap.get(Decimal.valueOf(leadRec.HIS_Referral_ReletionType__c)).Id;
                }
                
                string custCategory = NPDMap.get(Decimal.valueOf(leadRec.HIS_Referral_ReletionType__c)).Customer_Category__c;
                string custType = NPDMap.get(Decimal.valueOf(leadRec.HIS_Referral_ReletionType__c)).Customer_Type__c;
                
                system.debug('custCategory'+custCategory);
                system.debug('custType'+custType);
                system.debug('custType'+referralTypeMap);
                
                if(referralTypeMap != null && referralTypeMap.size()>0 && custType != null && custCategory != null && referralTypeMap.containsKey(custCategory+custType)) {
                    leadRec.Referral_Category__c = referralTypeMap.get(custCategory+custType).Referral_Category__c;
                    leadRec.Referral_Type__c = referralTypeMap.get(custCategory+custType).Id;
                    leadRec.Referral_Category1__c = referralTypeMap.get(custCategory+custType).CUSTOMERCATEGORYID__c;
                    leadRec.Referral_Type1__c = referralTypeMap.get(custCategory+custType).CUSTOMERTYPEID__c;
                }
            }
            
            if(DocMap != null && DocMap.size()>0 && DocMap.containsKey(leadRec.HIS_Referral_ReletionType__c)) {
                leadRec.Internal_Doctor__c = DocMap.get(leadRec.HIS_Referral_ReletionType__c).Id;
                leadRec.Referral_Category__c = label.ReferralId;
                leadRec.Referral_Type__c = label.InternalDoctorId;
                leadRec.Referral_Category1__c = '2';
                leadRec.Referral_Type1__c = '122';
            }
            
            if(referralMap != null && referralMap.size()>0 && referralMap.containsKey(leadRec.HIS_Referral_ReletionType__c)) {
                leadRec.Referral_Relation_Type__c = referralMap.get(leadRec.HIS_Referral_ReletionType__c).Id;
                leadRec.Referral_Category__c = referralMap.get(leadRec.HIS_Referral_ReletionType__c).Referral_Category__c;
                leadRec.Referral_Type__c = referralMap.get(leadRec.HIS_Referral_ReletionType__c).Referral_Type__c;
                leadRec.Referral_Category1__c = referralMap.get(leadRec.HIS_Referral_ReletionType__c).CUSTOMERCATEGORYID__c;
                leadRec.Referral_Type1__c = referralMap.get(leadRec.HIS_Referral_ReletionType__c).CUSTOMERTYPEID__c;
            }
        }
    }
    //Method to fetch duplicate PRNs from a new QRN
    @future(callout=true)
    public static void FindDuplicatePRNs(set<string> RequirdSet,set<string>UpdatedLeadId) {
        system.debug('RequirdSet'+RequirdSet);
        map<string,list<string>> DuplicateMap =new map<string,list<string>>();
        list<Lead> UpdatedQrnLead = [select QRN__c,RequiredField__c,Location_Id__c from lead where id In:UpdatedLeadId];
        List<String> PRNSList = new List<String>();
        List<Lead> duplicatePRNs = [SELECT Id, PRN__c,RequiredField__c FROM Lead WHERE PRN__c != null AND RequiredField__c IN :RequirdSet ];
        if(duplicatePRNs.size()>0 && duplicatePRNs != null) {
            for(lead each:duplicatePRNs){
                if(DuplicateMap.containsKey(each.RequiredField__c)){
                    DuplicateMap.get(each.RequiredField__c).add(each.PRN__c);
                } 
                else {
                    DuplicateMap.put(each.RequiredField__c,new list<string>{each.PRN__c});
                }
            }
        }
        list<wrapper>wrapperList = new list<wrapper>();
        list<Integration_Token__c> TokenList = new list<Integration_Token__c>([select id,Token__c from Integration_Token__c where name = 'IntegrationLayerCreds']);
        list<Integration_Message__c> IMList = new  list<Integration_Message__c>();
        for(lead each: UpdatedQrnLead){
            if(DuplicateMap != null && DuplicateMap.size()>0 && DuplicateMap.containsKey(each.RequiredField__c)) {
                wrapper wrap = new wrapper();
                wrap.DuplicatePRNs = DuplicateMap.get(each.RequiredField__c);
                wrap.QRN = each.QRN__c;
                wrap.LocationId = each.Location_Id__c;
                string JSONBody = '';
                JSONBody = JSON.serialize(wrap);
                
                if(TokenList != null && TokenList.size()>0) {
                    string authToken = TokenList[0].Token__c; //G
                    
                    HttpRequest req1 = new HttpRequest();
                    req1.setEndpoint(system.label.PRN_Cancellation_API);
                    req1.setMethod('POST');
                    req1.setHeader('Content-Type', 'application/json');
                    req1.setHeader('Authorization', authToken);
                    req1.setTimeout(120000);
                    req1.setBody(JSONBody);
                    system.debug('JSONBODY==>'+JSONBody);
                    Http http1 = new Http();
                    HttpResponse resp = new HttpResponse();
                    if(!Test.isRunningTest()) {
                        resp = http1.send(req1);
                    }
                    else {
                        resp.setBody('{"statusCode" : 400 ,"data" : {"responseMessage":"null","qrnid":"0","prnid":null,"messageType":"E","crmsfleadId":"null"}}');
                    }
                    Integration_Message__c IM = IntegrationHelper.createIMForSpecial(req1, 'Lead__c',3, each.id,resp.getBody(),resp.getStatusCode()); //Create Integration Message
                   
                    IMList.add(IM);
                }
            }
        }
        if(IMList.size()>0 && IMList != null){
            insert IMList;
        }
    }
    public class wrapper {
        public list<string> DuplicatePRNs;
        public string QRN;
        public string LocationId;
    }
}