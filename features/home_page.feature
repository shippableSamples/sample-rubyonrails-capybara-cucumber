Feature: Home page
  Scenario: Viewing application's home page
    Given there is score recorded that equals 1234
    When I am on the homepage
    Then I should see "Hello World" h2
    And I should see "Increment" button
    And I should see "The score is 1234"

  @javascript
  Scenario: Clicking "increment" button
    Given there is score recorded that equals 1234
    When I am on the homepage
    And I click "Increment" button
    Then I should see "The score is 1235"

  @javascript
  Scenario: Repeatedly clicking "increment" button
    Given there is score recorded that equals 1234
    When I am on the homepage
    And I click "Increment" button
    And I click "Increment" button
    And I click "Increment" button
    Then I should see "The score is 1237"
