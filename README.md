# README

This is little example of how we can test api responses with dry-schema to define the shape of our
responses.

There is one route: `/characters`, which returns an array of characters:

The code is in [app/controllers/characters_controller.rb](app/controllers/characters_controller.rb) and
[spec/requests/characters_controller_spec.rb](spec/requests/characters_controller_spec.rb)

```json
{"characters":[
    {"id":1,"first_name":"Luke","last_name":"Skywalker","human":true},
    {"id":2,"first_name":"Han","last_name":"Solo","human":true},
    {"id":3,"first_name":"R2-D2","human":false}
  ]
}
```

We want to make sure we always return id, first_name and human, and sometimes last_name.
We want to always have id as an integer, first_name and last_name (when here) as strings, and human
as a boolean.

We explore here 2 different ways:
- One with classic rspec helpers
- One with dry-schema
