Given /^I am not yey playing$/ do

end

When /^I start a new game$/ do
  Codebreaker::Game.new.start
end
