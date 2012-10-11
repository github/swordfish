Feature: Teams

  Scenario: Creating and updating a team
    Given I have generated and unlocked my key
    And I follow "New Team"
    And I fill in "Name" with "GitHub"
    And I press "Create"
    Then I should see "GitHub" within the sidebar
    And I should see "GitHub" within the details

    When I follow "Edit" within the details
    And I fill in "Name" with "GitHub Staff"
    And I press "Save"
    Then I should see "GitHub Staff" within the sidebar
    And I should see "GitHub Staff" within the details
