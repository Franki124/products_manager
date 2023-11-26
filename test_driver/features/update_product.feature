Feature: Update Product
  Scenario: As a user, I want to update a new product
    Given I am on the home screen
    When I select desired product
    And I swipe the product to the right
    And I tap on the product name field
    And I fill in the 'Product name' with 'Updated Smartphone'
    And I tap the save button
    Then I should see the updated product in the list