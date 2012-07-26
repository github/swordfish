Feature: Passwords

  Scenario: creating a password
    Given a vault named "Honeypot"
    And I am on the homepage
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

    When I go to the homepage
    And I follow "Honeypot"
    Then I should see "example.com"
