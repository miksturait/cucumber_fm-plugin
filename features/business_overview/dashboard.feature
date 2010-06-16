#:::mockup: http://cs3b-cucumber-fm.s3.amazonaws.com/business.overview.png
Feature: Business Overview - dashboard
  In order to view stuff to do and see cost and value
  As project manager, product owner
  I want to see estimation based on active scope and filter

  @_done @m1 @i1 @p1
  Scenario: Viewing dashobard
    When I visit documentation page
    Then I should see:
      |list of features                                       |
      |total quantity of features, scenarios and estimation   |
      |per feature total quantity of scenarios and estimation |

  @_todo @m1 @i3 @p1
  Scenario: Adding new feature

  @_done @m1 @i1 @p2
  Scenario: Filtering By tag and folder

  @_done @m1 @i1 @p5
  Scenario: Agregating by tag type

  @_done @m1 @i2 @p1
  Scenario: Going to feature editing

  @_done
  Scenario: Agregating based on tag type