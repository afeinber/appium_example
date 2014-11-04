require 'rspec'
require 'appium_lib'
require 'appium_capybara'
require 'json'
require 'rest_client'
require 'capybara/rspec'
require 'pry'


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

Capybara.default_driver = :appium
Capybara.server_host = '0.0.0.0' # Listen to all interfaces
Capybara.server_port = 56844     # Open port TCP 56844, change at your convenience

describe 'visit hope page', :type => :feature do
  # before(:each) do
  #   Appium::Driver.new(desired_caps_ios).start_driver
  #   Appium.promote_appium_methods RSpec::Core::ExampleGroup
  # end

  after(:each) do
    # Get the success by checking for assertion exceptions,
    # and log them against the job, which is exposed by the session_id
    # job_id = driver.send(:bridge).session_id
    # update_job_success(job_id, example.exception.nil?)
    driver.quit
  end

  it 'should show Trending repositories' do
    visit("https://github.com")
    find('button', text: 'Sign up for GitHub').click
    expect(page).to have_content "Join GitHub"
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
    # udid:            '0d6e6aa75e62c204d6a18848140e49ecb2223896'
    # app:             '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/Applications/MobileSafari.app'
  }
end
