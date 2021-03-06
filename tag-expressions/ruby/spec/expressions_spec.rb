require 'cucumber/tag_expressions/parser'

describe 'Expression node' do
  shared_examples 'expression node' do |infix_expression, data|
    data.each do |tags, result|
      expression = Cucumber::TagExpressions::Parser.new.parse(infix_expression)
      it "#{infix_expression.inspect} with variables: #{tags.inspect}'" do
        expect(expression.evaluate(tags)).to eq(result)
      end
    end
  end

  describe Cucumber::TagExpressions::Not do
    context '#evaluate' do
      infix_expression = 'not x'
      data = [[%w(x), false],
              [%w(y), true]]
      include_examples 'expression node', infix_expression, data
    end
  end

  describe Cucumber::TagExpressions::And do
    context '#evaluate' do
      infix_expression = 'x and y'
      data = [[%w(x y), true],
              [%w(x), false],
              [%w(y), false]]
      include_examples 'expression node', infix_expression, data
    end
  end

  describe Cucumber::TagExpressions::Or do
    context '#evaluate' do
      infix_expression = 'x or y'
      data = [[%w(), false],
              [%w(x), true],
              [%w(y), true],
              [%w(x q), true],
              [%w(x y), true]]
      include_examples 'expression node', infix_expression, data
    end
  end
end
