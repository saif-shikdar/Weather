# Weather


 **Build Details**

1. Using Swift 5 for developemnt 
2. Using XCode 12.5 
3. Using UIKit, Storybaords, URLsession, Combine. 


**Architecture**

1. This is using MVVM_C repository pattern.

**Code Structure**

**Module layer**

  This contains diffent Modules of app , currenlty there are two modules, WeatherSearch and WeatherDetails. 
  
     **View** 
     
        This has view controller and cell for needed tableviews or collection views. 
        Each view controller has its own view model and inserted as dependency from coordinator.
        
        
     **ViewModel**
     
        ViewModel object is created in coordinator and inserted as dependency to viewControllers
        ViewModel communicates to views view databindign using Combine. 
        
        
     **Model**
     
        these are structs which satisfy codable protocol to decode data from JSON. 
  
 
 **Networking layer**
 
   This contains Generic Network layer which supports GET and POST request.  Returns completion block with data or error. 
 
 **Repository Layer**
 
   This is abstraction b/w viewmodel and networking layer. 
   This will get data from network layer and decode as per need to single object or arary or objects
   This is Mocked in testing layer to stub local json data. 
 
 **Coordinator**
 
    Using only one Main coordinator in project
    This handles view navigation from start of app to next view. 


**Unit Tests**

1. Unit test are done using XCTest framework 
2. Unit test cases are written for business logic present in ViewModel. 
3. Mock Repository layer is created to test REST API calls and data is stubed from locally stored json file 
