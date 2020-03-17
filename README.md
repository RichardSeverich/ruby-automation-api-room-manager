Elaboration for Daniel Cabero.
# Room Manager API Test Application
This framework for automation test of the Room Manager project using ruby programming and build.

This framework was developed by students of AT03 using all the knowledge in programming learned in the training of the Jala Foundation.

For the elaboration of this framework we used the Ruby language with all the properties that gives us this language.



#**Pre requeriments for the use:**

**Environmental requirements**

 + Have an Exchange services server
 
 + First install Room Manager application.
 
 + Start exchange server and room managers.
  
**Framework requeriments**
 
 + Open the cmd console and execute 
    
         gem install bundle
 
 + Execute the command.
        
        bundle install
    
 + Execute the command.
      
        bundle update
        
 The gems required will be installed automatically in the repository where the framework is due to the Gemfile.lock included in the repository.    

 **Test requeriments**
  
 + To start the test run must have at least rooms created before.
    
   **Exchange services server**.- Not need the rooms created. the Exchanges server
                    
                    Administrator@arabitpro.local
                    Encode64 name:password
                       
    **Room manager**.- To create the roms, it is necessary to enter the exchange server service, the requirements to create a room are the name and the e-mail corresponding to the room.
                     
                     rooms
                       RM@arabitpro.local   
        
 #**Rest API**
  
   In order to develop the framework we used the ruby gem 'rest-client' that have all methods for API testing of the room manager.
  
   The rest-client gem  inspired by the Sinatra microframework style of specifying actions: get, put, post, delete.
  
 # **Travis CI**
    
   The framework has a configuration of travis CI with a code analyzer, this allows the framework to have a clean implementation.
    
   The configuration of the travis has conditions to be able to execute it that are part of the framework like the gemafile, rakefile, travis.yml and the rubocop that is the clean code analyzer.
      
  
  #**Report generator execution.**
  The report generator execution has the following options:
            
   + **all**.- Execute the all features files of the framework
   + **smoke**.-Execute the smoke features files of the framework 
   + **Crud**.-Execute the CRUD features files of the framework
   + **functional**.-Execute the Functional features files of the framework
        
   For the report generator execution open the terminal console and execute the command according the execution type you are expecting:.
    
        rake @all
        rake @smoke
        rake @crud
        rake @functional
        
  Select the report you need.
  
  The report generator execution was used the 'rake' gem with which you can use the properties that this gem allows us.

  
 # **Use of hooks**
  
  Hooks are designed to facilitate the use and implementation of the framework, these hooks have specific functions that are necessary to operate the framework.
  