#:::mockup::: http://cs3b-cucumber-fm.s3.amazonaws.com/business.overview.png
@business-dashboard
Feature: Business Overview - dashboard
  In order to view stuff to do and see cost and value
  As project manager, product owner
  I want to see estimation based on active scope and filter

  @_done @m1 @i1
  Scenario: Viewing dashobard
    When I visit documentation page
    Then I should see:
      |list of features                                       |
      |total quantity of features, scenarios and estimation   |
      |per feature total quantity of scenarios and estimation |

  @_done @m1 @i1
  Scenario: Filtering By tag and folder

  @_done @m1 @i1
  Scenario: Agregating by tag type

  @_done @m1 @i2
  Scenario: Going to feature editing

  @_done @m1 @i2
  Scenario: Agregating based on tag type
  
  @_done @m2 @i3
  Scenario: Sort tags that are use to aggregate

  @_done @m2 @i5
  Scenario: Clicking on scenario
    Then I should be on feature page
    And I editor should be focus on the scenario line