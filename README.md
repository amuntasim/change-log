# ChangeLog

ChangeLog is a Rails engine designed to facilitate parsing change log from git commit message and display in the browser.

## Requirements

ChangeLog is compatible with Rails  > 3.1

ChangeLog works with `activerecord` and `mongoid`

##Usage
ChangeLog does not consider all the commit messages but with a special prefix. (`~~~` is default but you can override in the `change_log.rb` config file)

You can tag your messages. Like you may have 3/4 tags in each build.

If you commit with a message like this:
```bash
   ~~~VERSION_NUMBER(optional) # it will starts from 0.0.1 and path option will be increased if VERSION_NUMBER is not given
   ~~feature # here feature is a tag
    - feature one
    - feature two
    - feature three implemented

   ~~bug
    - bug 1 resolved
    - bug 2 resolved
    - bug 3 resolved

   ~~api
    + api foo implemented
    + api bar modified
```

and run

```ruby
  rake change_log:update_log
```
You will have output like:

##0.0.1 {TIME}
<p>feature:</p>
   - feature one
   - feature two
   - feature three implemented

<p>bug:</p>
   - bug 1 resolved
   - bug 2 resolved
   - bug 3 resolved

<p>api:</p>
   + api foo implemented
   + api bar modified

The commit message is markdown enabled
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
  # config/initializers/change_log.rb
  ChangeLog::ApplicationController.authenticator = proc {
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'change-log' && password == 'passme'
    end
  }
```

Authenticator proc will be run from a before filter in controller context.