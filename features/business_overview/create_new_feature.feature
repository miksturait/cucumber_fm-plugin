Feature: Business Overview - Create New Feature
  To track information about new requirements
  product owner
  should be able to add new feature

  @_done @m1 @i3 @p2
  Scenario: Creating new feature file
    Given I am on the business overview page
    When I fill in "name" with "Editor - advance"
    And I press "Add"
    Then I should be redirected to edit page for feature 'editor___advance.feature'

  @_done @m1 @i4 @p7
  Scenario: Creating new feature file with name that already exist
    Given feature with name 'awesome_tagging.feature' exists
    And I am on the business overview page
    When I fill in "name" with "Awesome Tagging"
    And I press "Add"
    Then I should be redirected to edit page for feature 'awesome_tagging.feature'

  @_done @m1 @i4 @p4
  Scenario: Creating new feature file with too short name
    Given I am on the business overview page
    When I fill in "name" with "Abc"
    And I press "Add"
    Then I should see error notice "Filename is too short"


