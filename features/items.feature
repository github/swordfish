Feature: Items

  Scenario: creating an item
    Given I am signed in as "winnie@thepooh.com"
    And "winnie@thepooh.com" has generated a key
    And I am on the dashboard
    And I fill in "passphrase" with "testing"
    And I press "Unlock"
    And I follow "New Item"
    When I fill in "Title" with "example.com"
    And I fill in "Username" with "myusername"
    And I fill in "Password" with "mypassword"
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
