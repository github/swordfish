Feature: Passwords

  Scenario: creating a password
    Given I am signed in as "winnie@thepooh.com"
    Given a vault named "Honeypot"
    And "Honeypot" is shared with "winnie@thepooh.com"
    And I am on the dashboard
    When I follow "Honeypot"
    And I follow "New Item"
    Then I should see "Enter the password to unlock Honeypot"

    When I fill in "Enter the password" with "password"
    And I press "Unlock"
    Then I should see "New Item"

    When I fill in "Hostname" with "example.com"
    And I fill in "Username" with "myusername"
    And I fill in "Password" with "mypassword"
    And I press "Create"
    Then I should see "example.com"

    When I go to the dashboard
    And I follow "Honeypot"
    Then I should see "example.com"

    When I follow "example.com"
    And I fill in "Enter the password" with "password"
    And I press "Unlock"

    Then I should see "myusername"
    When I follow "reveal"
    Then I should see "mypassword"
