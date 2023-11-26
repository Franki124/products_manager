Feature: Delete Product
  Scenario: As a user, I want to delete a product
    Given I am on the home screen
    When I select desired product
    And I swipe the product to the left
    Then I should no longer see the product in the list