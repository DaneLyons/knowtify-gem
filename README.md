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
	resp = client.contacts_upsert(new_contacts) # <Knowtify::Response:0x007fdb629e5c10>
	resp.successful? # true

## Contributing

1. Fork it ( https://github.com/[my-github-username]/knowtify/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
