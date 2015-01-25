# Knowtify

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'knowtify'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install knowtify

## Usage

### Configuration
Common configuration options that can be set in a Rails initializer if necessary.


    Knowtify.config.api_key   = "MySecreteKey"      # => Defaults to ENV['KNOWTIFY_API_TOKEN']
    Knowtify.config.logger    = Logger.new(STDOUT)  # => Defaults to Rails.logger if available, nil disables
    Knowtify.config.debug     = true                # => Default is false


### Client
    require 'knowtify'

    ENV['KNOWTIFY_API_TOKEN'] = 'MySuperSecretKey'
  
    new_contacts = [{
                        "name" => "John",
                        "email" => "john@test.com",
                        "data" => {
                          "category" => "sports",
                          "followers" => 300
                        }
                      },
                      {
                        "name" => "Samuel",
                        "email" => "sam@test.com",
                        "data" => {
                          "category" => "sports",
                          "followers" => 32,
                          "comments" => 54,
                          "role" => "Editor"
                        }
              }]
    client = Knowtify::Client.new
    resp = client.contacts_create_or_update(new_contacts) # => <Knowtify::Response:0x007fdb629e5c10>
    resp.successful? # => true


### Contact
Knowity::Contact can be initialized with JSON or hash.   

    data = {
              "name" => "John",
              "data" => {
                "category" => "sports",
                "followers" => 300
            }
            
    contact = Knowtify::Contact.new(data) 
    contact.save                    # => false
    contact.errors                  # => [Email is blank.]
    contact.email = "john@test.com"
    contact.save                    # => true
    contact.delete                  # => true

### Contacts
Knowity::Contacts can be initialized with JSON, an array of hashes or an array of Knowtify::Contact objects. 

    new_contacts = [{
                        "name" => "John",
                        "email" => "john@test.com",
                        "data" => {
                          "category" => "sports",
                          "followers" => 300
                        }
                      },
                      {
                        "name" => "Samuel",
                        "email" => ""
                  }] 

    Knowtify.config.ingore_invalid_contacts = false # default is true
    contacts = Knowtify::Contact.new(data) 
    contacts.save             # => false
    contacts.errors           # => ["There are invalid contacts."]
    contacts.invalid_contacts # => [<Knowtify::Contact:0x007fdb629e5c10>]
    Knowtify.config.ingore_invalid_contacts = true
    contacts.save             # => true
    contacts.delete           # => true


## Contributing

1. Fork it ( https://github.com/[my-github-username]/knowtify/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
