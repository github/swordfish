Feature: Key Generation

  Scenario: Sign up and create new key
    Given I am on the dashboard
    Then I should see "Create a Key"

    When I fill in "passphrase" with "this is my secret"
    And I press "Generate Key"
    And I wait an eternity
    Then I should see "Download Private Key"
    And "Download Private Key" should contain the private key

    When I follow "Done"
    Then I should see "+"

  Scenario: Successfully Unlocking key
    Given "bkeepers@github.com" has generated a key
    When I go to the dashboard
    Then I should see "Unlock"
    When I fill in "passphrase" with "testing"
    And I press "Unlock"
    Then I should see "+"

  Scenario: Uploading key to sign in
    Given I am on the homepage
    And I follow "Load existing key"

    And I attach the file "features/support/key.pem" to "Key"
    And I press "Load"
    And I fill in "Passphrase" with "testing"
    And I press "Unlock"
    Then I should see "+"

  Scenario: Failing to unlock key
    Given "bkeepers@github.com" has generated a key
    When I go to the dashboard
    Then I should see "Unlock"

    When I fill in "passphrase" with "wrong"
    And I press "Unlock"
    Then I should see "Your passphrase was incorrect!"

    When I fill in "passphrase" with "testing"
    And I press "Unlock"
    Then I should see "+"
