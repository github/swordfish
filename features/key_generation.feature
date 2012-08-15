Feature: Key Generation

  Background:
    Given I am signed in as "bkeepers@github.com"

  Scenario: Creating a key
    Then I should see "Create a Key"

    When I fill in "passphrase" with "this is my secret"
    And I press "Generate Key"
    And I wait an eternity
    Then I should see "Download Private Key"

    When I follow "Done"
    Then I should see "+"

  Scenario: Successfully Unlocking key
    Given "bkeepers@github.com" has generated a key
    When I go to the dashboard
    Then I should see "Unlock"
    When I fill in "passphrase" with "testing"
    And I press "Unlock"
    Then I should see "+"