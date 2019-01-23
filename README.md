reinierapp
=====

An OTP application

Build
-----

$ rebar3 release


Build Docker
-----

$ make build-docker


Run as docker
----
$docker run -it -p 3434:3434 reinierapp

Run
----

$ rebar3 console


Run Background
----

$ rebar3 start
   

Deploy Cloud
----

./nube.sh
    
Test App
----

```bash
curl http://localhost:3434/reinerservice/echo?msg='sdfasfdasdf'
```



    
