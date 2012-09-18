@wip
Feature: Signing in to a new site

  @chrome
  Scenario: Signing into a new site
    Given I have generated a key
    # Copy the key to extension
    And I go to the dashboard
    Given I am on the test site
    When I fill in "Username" with "bkeepers"
    And I fill in "Password" with "testing"
    And I press "Sign In"
    And I pause
    And I fill in "Enter your passphrase" with "testing"
    And I press "Unlock"
    Then I should see "Do you want to save this login?"

    When I fill in "Name" with "From Chrome Extension"
    And I press "Save"
    Then I should not see "Do you want to save this login?"

    When I go to the dashboard
    Then I should see "From Chrome Extension"

    When I go to the test site
    And I sign in with the extension
    Then I should see "signed in with bkeepers/testing"