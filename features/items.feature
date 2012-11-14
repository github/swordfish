Feature: Items

  Background:
    Given I have generated a key
    And I am on the dashboard
    And I fill in "passphrase" with "testing"
    And I press "Unlock"

  Scenario: creating and editing an item
    When I follow "New Item"
    And I fill in "Title" with "example.com"
    And I fill in "Username" with "myusername"
    And I fill in "Password" with "mypassword"
    And I fill in "Confirm" with "mypassword"
    And I press "Create"
    Then I should see "example.com" within the item list

    When I go to the dashboard
    And I fill in "passphrase" with "testing"
    And I press "Unlock"
    Then I should see "example.com"

    When I follow "example.com"

    Then I should see "myusername"
    When I follow "reveal"
    Then I should see "mypassword"

    When I follow "hide"
    Then I should not see "mypassword"

    When I follow "Edit"
    Then the "Title" field should contain "example.com"
    And the "Username" field should contain "myusername"
    And the "Password" field should contain "mypassword"
    And the "Confirm" field should contain "mypassword"

    When I fill in "Title" with "Example"
    And I fill in "Username" with "updated-username"
    And I press "Save"

    Then I should see "Example" within the item list
    And I should see "updated-username"

  Scenario: does not create on mismatching password confirmation
    When I follow "New Item"
    And I fill in "Title" with "example.com"
    And I fill in "Username" with "myusername"
    And I fill in "Password" with "mypassword"
    And I press "Create"
    Then I should not see "example.com" within the item list

    When I fill in "Password" with ""
    And I fill in "Confirm" with "mypassword"
    And I press "Create"
    Then I should not see "example.com" within the item list

  Scenario: requires matching passwords on update
    When I follow "New Item"
    And I fill in "Title" with "example.com"
    And I fill in "Username" with "myusername"
    And I fill in "Password" with "mypassword"
    And I fill in "Confirm" with "mypassword"
    And I press "Create"

    When I follow "example.com"
    And I follow "Edit"
    And I fill in "Password" with "newpassword"
    And I press "Save"
    Then I should see "Save"

    When I fill in "Confirm" with "newpassword"
    And I press "Save"
    And I follow "reveal"
    Then I should see "newpassword"
