Feature: Lock

  Scenario: Lock key
    Given I have generated a key
    When I go to the dashboard
    And I fill in "passphrase" with "testing"
    And I press "Unlock"
    Then I should see "+"

    When I follow "Lock"
    Then I should see "Unlock"
