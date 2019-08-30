# [Office Hours Queue](http://selt18project-g002-3.herokuapp.com/)
##### By: selt18project-g002
   
      
### Download this Repo:
```bash
git clone https://github.com/abpwrs/selt-fall-18.git
```

### Ruby version  
  
Selt18project-g002 Office Hours Queue is being built in `ruby 2.4.4` for 
Heroku compatibility reasons. 
  
### System dependencies

In order to install all dependencies associated with our project, 
you will need to install all of the associated gems.
```bash
bundle install --without production
```

### Configuration

For local development, you will need to set to environmental variables inside of your `.bashrc`  
```bash
echo "export client_id='{REAL_CLIENT_ID_HERE}'" >> ~/.bashrc
echo "export client_secret='{REAL_CLIENT_SECRET_HERE}'" >> ~/.bashrc
```


### Database creation and initialization

Our database creation and reloading is managed by a set of scripts inside of the utils directory.   
To reset the local database
```bash
./utils/reset_local_db.sh
```
To reset the heroku database
```bash
./utils/reset_heroku_db.sh
```
Both of these scripts will automatically seed the database with the contents of `db/seeds.rb`

### Testing

Our testing sweet is built off of the following frameworks and technologies: 
* [RSpec](http://rspec.info/)
* [Cucmber](https://cucumber.io/)
* [Capybara](https://teamcapybara.github.io/capybara/)
* [Factory Bot Rails](https://github.com/thoughtbot/factory_bot_rails)
* [Omniauth Config Mock](https://github.com/omniauth/omniauth/wiki/Integration-Testing)
  
#### Running the test suite:  
Unit Tests
```bash
> rspec
```  
Behavior Driven Tests
```bash
> bundle exec cucumber
```
### Deployment instructions

Our current version only supports site deployment on heroku, but we hope to expand support in the future.  
Heroku Instructions:   
Run the deploy script to push the code to the heroku remote and set up the heroku database  
```bash
./utils/heroku_deploy.sh
```
Set Environmental Variables:
```bash
heroku config:set client_id='{REAL_CLIENT_ID_HERE}'
heroku config:set client_secret='{REAL_CLIENT_SECRET_HERE}'
``` 
And now your heroku deployment should be up and running
