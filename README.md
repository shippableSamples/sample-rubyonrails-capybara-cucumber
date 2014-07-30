Sample for Rails application with Capybara and Cucumber tests
=============================================================

This sample illustrates how to run Capybara with Cucumber tests on Shippable.

Using Selenium
--------------

When you take a look at scenarios declared in this repository, some of them are tagged
with `@javascript`. It tells Capybara to run the scenario in a runner that supports
JavaScript. By default, Selenium Webdriver is used. To make it available in Shippable
environment, we need to add the following lines to the `shippable.yml` file:

    addons:
      firefox: "28.0"
    services:
      - selenium

    env:
      global:
        - DISPLAY=:99.0

    before_script: 
      - /etc/init.d/xvfb start 

    after_script:
      - /etc/init.d/xvfb stop

It will make sure that Selenium is installed on the minion and will start and then stop virtual
framebuffer device for X server to render to.

Also, remember to install the required gems by adding the following entries to the `Gemfile`:

    group :test do
      gem 'cucumber-rails', :require => false
      gem 'database_cleaner'
      gem 'selenium-webdriver'
    end

Configuring test reporting
--------------------------

To have Cucumber output test and coverage reports to the directories expected by Shippable, we need
to declare the following environment variables:

    env:
      global:
        - CI_REPORTS=shippable/testresults COVERAGE_REPORTS=shippable/codecoverage

Then, add the following entries to the `Gemfile`:

    group :test do
      gem 'simplecov'
      gem 'simplecov-csv'
    end

Finally, initialize the coverage support in `features/support/env.rb`:

    require 'simplecov'
    require 'simplecov-csv'
    SimpleCov.formatter = SimpleCov::Formatter::CSVFormatter
    SimpleCov.coverage_dir(ENV["COVERAGE_REPORTS"])
    SimpleCov.start 'rails'

And add the required options to Cucumber invocation by modifying `config/cucumber.yml`:

    default: --profile ci --profile dev
    ci: --format junit --out <%= ENV['CI_REPORTS'] %>
    dev: <%= std_opts %> features

For more detailed documentation, please see [section on Selenium](http://docs.shippable.com/en/latest/config.html#selenium) in Shippable docs.

This sample is built for Shippable, a docker based continuous integration and deployment platform.
