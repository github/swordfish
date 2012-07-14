Feature: Vaults

  Scenario: creating a vault
    Given I am on the homepage
    When I follow "New Vault"
    And I fill in "Name" with "Project Honeypot"
    And I fill in "Password" with "s3cr3t"
    And I press "Create Vault"
    Then I should see "Project Honeypot"