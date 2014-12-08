# ChangeLog

ChangeLog is a Rails engine designed to facilitate parsing change log from git commit message and display in the browser.

## Requirements

ChangeLog is compatible with Rails  > 3.1

## Installation & Setup

To install add the following to your Gemfile:

```ruby
  gem 'change-log'
```

To setup just run:

```bash
  $ rake change_log:setup
```

and follow the guide !

## Authentication

If you want to authenticate users who can access ChangeLog, you need to provide <tt>ChangeLog::ApplicationController.authenticator</tt> proc. For example :

```ruby
  # config/initializers/tolk.rb
  ChangeLog::ApplicationController.authenticator = proc {
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'change-log' && password == 'transpass'
    end
  }
```

Authenticator proc will be run from a before filter in controller context.