Feature: Signout

  Scenario: Sign out and lock key
    Given I have generated a key
    When I go to the dashboard
    And I fill in "passphrase" with "testing"
    And I press "Unlock"
    Then I should see "+"

    When I follow "Sign Out"
    Then I should see "Unlock"
