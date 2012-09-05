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
    Given I have generated a key
    When I go to the dashboard
    Then I should see "Unlock"
    When I fill in "passphrase" with "testing"
    And I press "Unlock"
    Then I should see "+"

  Scenario: Uploading key to sign in
    Given I am on the dashboard
    And I follow "Load existing key"

    And I attach the file "spec/fixtures/priv.pem" to "key"
    And I fill in "passphrase" with "testing"
    And I press "Unlock"
    Then I should see "+"

  Scenario: Failing to unlock key
    Given I have generated a key
    When I go to the dashboard
    Then I should see "Unlock"

    When I fill in "passphrase" with "wrong"
    And I press "Unlock"
    Then I should see "Your passphrase was incorrect!"

    When I fill in "passphrase" with "testing"
    And I press "Unlock"
    Then I should see "+"
