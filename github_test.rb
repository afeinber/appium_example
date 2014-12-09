# require 'rspec'
require 'appium_lib'
require 'appium_capybara'
require 'capybara/rspec'
require 'pry'

module Capybara
  module Selenium
    class Driver
      def browser_initialized?
        return false
      end
    end
  end
end

driver = nil

Capybara.register_driver(:appium) do |app|
  appium_lib_options = {
    server_url:           url
  }
  all_options = {
    appium_lib:  appium_lib_options,
    caps:        desired_caps_ios
  }
  driver = Appium::Capybara::Driver.new app, all_options
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

# Capybara.default_driver = :appium
Capybara.server_host = '0.0.0.0' # Listen to all interfaces
Capybara.server_port = 56844     # Open port TCP 56844, change at your convenience

describe 'visit hope page', :type => :feature do


  after(:all) do

    driver.quit

  end

  it 'should log in to our site' do

    Capybara.current_driver = :appium

    visit('https://qa-int-playlist.ampaxs.com')
    find('#get-started-button').click



    fill_in 'Email', with: 'amplifytest469@amplifydev.net'
    fill_in 'Password', with: 'MayanParty2012'
    click_on 'Sign in'
    click_on 'Accept'


    Capybara.current_driver = :selenium

    visit('https://qa-int-playlist.ampaxs.com')
    find('#get-started-button').click



    fill_in 'Email', with: 'amplifytest471@amplifydev.net'
    fill_in 'Password', with: 'MayanParty2012'
    click_on 'Sign in'
    click_on 'Accept'


    Capybara.current_driver = :appium

    click_on 'Logout'


  end
end

def url
  "http://localhost:4723/wd/hub"
end

def desired_caps_ios
  {
    'appium-version' => '1.1.0',
    platform:       'Mac',
    platformName:   'iOS',
    platformVersion: '8.1',
    deviceName:      'iPad 2',
    browserName:     'Safari',
    safariAllowPopups: true
  }
end
