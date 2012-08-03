Feature: Vaults

  Scenario: creating a vault
    Given I am signed in as "winnie@thepooh.com"
    When I follow "New Vault"
    And I fill in "Name" with "Project Honeypot"
    And I fill in "Password" with "s3cr3t"
    And I press "Create Vault"
    Then I should see "Project Honeypot"

    Given I am signed in as "tigger@too.com"
    Then I should not see "Project Honeypot"