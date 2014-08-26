Sprout Homework
===============

So what does it do?
--------------------

For a coding challenge related to my interview with Sprout Social, I was given the task of creating an implementation seen in Sprout Social's platform which allows Sprout users to see if a Twitter user is in one of their Twitter Lists. In addition, they are given the ability to add and remove users from the lists.

So that's what it does!

But how?
---------------------

It's built with Backbone using a Sinatra based API to connect to Twitter, RequireJS for awesome organization, Handlebars for some sweet templating, jQuery for all that DOM manipulation, and of course Bootstrap since I didn't feel like writing much CSS ;)

Setup instructions:
---------------------

Requirements to begin setup of this app:

NodeJS:

Google installing NodeJS on your operating system.


Grunt:

Once node is installed type

```
sudo npm install -g grunt-cli
```

Bower:

 Once node is installed, type

```
sudo npm install -g bower install
```


Compass:

type

```
gem install compass
```




There are two parts you need to setup after you done the above steps: the client side of the app and the server side.

Client Side
---------------------

cd into the client directory and type:

```
npm install
```

which installs the node modules needed. Then type:


```
bower install
```

which installs the app's dependencies. Lastly, type 

```
grunt server
```
which will start the development server.

Server side
---------------------
cd into the server directory and type:

```
bundle install
```

Lastly, type 

```
shotgun app.rb to start the API server.
```

Navigate to http:localhost:9000 and enjoy the app!
