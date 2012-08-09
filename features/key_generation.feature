Feature: Key Generation

  Scenario: Creating a key
    Given I signed up using GitHub as:
      | nickname | name            | email               |
      | bkeepers | Brandon Keepers | bkeepers@github.com |
    When I go to the sign in page
    And I follow "Sign In with GitHub"
    Then I should see "Create a Key"

    When I fill in "passphrase" with "this is my secret"
    And I press "Generate Key"
    And I wait an eternity
    Then I should see "Download Private Key"

    When I follow "Done"
    Then I should see "Shared Vaults"
