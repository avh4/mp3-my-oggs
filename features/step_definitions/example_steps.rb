Given /^some setup$/ do
  setup_example # defined in features/support/example.rb
end

When /^I do something$/ do
  @string = example_text # defined in features/support/example.rb
end

Then /^I should see something$/ do
  @string.should == "String"
end
