Feature: Authenticating with GitHub

  Scenario: Sign up with GitHub
    Given I am signed in to GitHub as:
      | nickname | name            | email              |
      | bkeepers | Brandon Keepers | bkeepers@gmail.com |

    When I go to the dashboard
    Then I should be on the sign in page

    When I follow "Sign In with GitHub"
    Then I should be on the dashboard

    When I follow "Sign Out"
    Then I should be on the sign in page

  Scenario: Sign in with GitHub
    Given I signed up using GitHub as:
      | nickname | name           | email          |
      | lcuke    | Larry Cucumber | larry@cucumber.com |
    When I go to the sign in page
    And I follow "Sign In with GitHub"
    Then I should be on the dashboard

  Scenario: Failed GitHub sign in
    When I fail to sign in to GitHub
    Then I should be on the sign in page
    And I should see "Authentication error"
