Feature: Add Product
  Scenario: As a user, I want to add a new product
    Given I am on the home screen
    When I tap the add product button
    And I fill in the 'Product Name' with 'Smartphone'
    And I fill in the 'Product Price' with '1000'
    And I tap the submit button
    Then I should see the product in the list