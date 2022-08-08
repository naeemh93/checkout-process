Checkout process

Product
Product class allows create individual instances with the attributes code, name and price, all the the info necessary to add a new product to the Store class.

Order
Order class has items and total attributes that helps in calculations .

Currently there are two rules, both receives a code attribute to relate the instance with the product, and each rule has the apply method that is different depending on the rule. Following this pattern is pretty easy add future rules.

These are the available rules:

BulkPurchasesRule: In addition to the code this rule receives quantity and discount_rate, that allows apply a bulk discount, where by each X units(quantity) receives a Y% (discont_rate) of discount on the unit_price.
TotalItemRule: This rule is applied when the total amount is greater than the threshold amount defined to apply the discount by the discount rate provided.

Checkout
This is the Main Class to interact with the app, a new Checkout instance receive pricing_rules like parameter that contents all the discount available rules. Also has two main methods, the first one is scan, that allows register a new product in in the order, the second one is total to get the total to pay on your order, order to check the items scanned.


Tests
Each class is tested with unit tests using Rspec like testing framework, to run the tests, first remember install the gem from your terminal with gem install rspec, then from Project's root run rspec spec to run all the tests at same time, or rspec spec/name_class_spec.rb to run a specific test.

Improvements that can be made:
1)
    Currently i am handling two rules , for adding dynamic we can handle by defining it in some yaml file and we can load the file to fetch all rules 
also we can define some standards in terms of providing some key attributes to each rules.
2) code refactoring can be done by applying one promotional class and defining the promotions based on some conditions defined like case statements, we might need to add type field to 
distinguish between different promotions.


