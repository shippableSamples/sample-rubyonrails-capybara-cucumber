Given(/^there is score recorded that equals (\d*)$/) do |score|
  @score = Score.create(score: score)
end

When(/^I am on the homepage$/) do
  visit root_path
end

When(/^I click "([^"]*)" button$/) do |content|
  click_button(content)
end

Then(/^I should see "(.*?)" (.+)$/) do |content, selector|
  page.find(selector, :text => content)
end

Then(/^I should see "(.*?)"$/) do |content|
  page.has_content?(content)
end
