

describe 'Expectation Matchers' do

  describe 'equivalence matchers' do

    it 'will match loose equality with #eq' do
      a = "2 cats"
      b = "2 cats"
      expect(a).to eq(b)
      expect(a).to be == b

      c = 17
      d = 17.0
      expect(c).to eq(d)
    end

    it 'will match value equality with #eql' do
      a = "2 cats"
      b = "2 cats"

      expect(a).to eql(b)

      c = 17
      d = 17.0
      expect(c).not_to eql(d)
    end

    it "will match identity equality with #equal" do
       a = "2 cats"
      b = "2 cats"
      expect(a).not_to equal(b)

      c = b
      expect(b).to equal(c)
      expect(c).to be(c)
    end
  end

  describe 'equivalence truthiness matchers' do

    it 'will match true/false' do
      expect(1 < 2).to be(true)
      expect(1 > 2).to be(false)

      expect('foo').not_to be(true)
      expect(nil).not_to be(false)
      expect(0).not_to be(false)
    end

    it 'will match truthy/falsey' do
      expect(1 < 2).to be_truthy
      expect(1 > 2).to be_falsey

      expect('foo').to be_truthy
      expect(nil).to be_falsey
      expect(0).not_to be_falsey
    end

    it 'wil match nil' do
      expect(nil).to be_nil
      expect(nil).to be(nil)

      expect(false).not_to be_nil
      expect(0).not_to be_nil
    end

  end

  describe 'other useful matchers' do

    it 'will match string with a regex' do
      string = 'The order has been received.'
      expect(string).to match(/order(.+)received/)

      expect('123').to match(/\d{3}/)
      expect(123).not_to match(/\d{3}/)

      email = 'someone@somewhere.com'
      expect(email).to match(/\A\w+@\w+\.\w{3}\Z/)
    end

    it 'will match object types' do
      expect('test').to be_instance_of(String)
      expect('test').to be_instance_of(String)

      expect('test').to be_kind_of(String)
      expect('test').to be_a_kind_of(String)
      expect('test').to be_a(String)
      expect([1,2,3]).to be_an(Array)
    end

    it 'will match objects with #respond_to' do
      string = 'test'
      expect(string).to respond_to(:length)
      expect(string).not_to respond_to(:sort)
    end

    it 'will math class instances with #have_attributes' do
      class Car
        attr_accessor :make, :year, :color
      end
      car = Car.new
      car.make = 'Dodge'
      car.year = 2010
      car.color = 'green'

      expect(car).to have_attributes(:color => 'green')
      expect(car).to have_attributes(
        :make => 'Dodge', :year => 2010, :color => 'green'
      )
    end

    it 'will match anything with #satisfy' do
      expect(10).to satisfy do |value|
        (value >= 5) && (value <= 10) && (value % 2 == 0)
      end
    end
  end

  describe 'predicate matchers' do

    it 'will match be_* to custom methods ending in ?' do

      expect([]).to be_empty
      expect(1).to be_integer
      expect(0).to be_zero
      expect(1).to be_nonzero
      expect(1).to be_odd
      expect(2).to be_even


      class Product
        def visible?; true; end
      end
      product = Product.new

      expect(product).to be_visible

      expect(product.visible?).to be true
    end

    it 'will match have_* to custom methods like has_*?' do


      hash = {:a => 1, :b => 2}
      expect(hash).to have_key(:a)
      expect(hash).to have_value(2)

      class Customer
        def has_pending_order?; true; end
      end
      customer = Customer.new

      expect(customer).to have_pending_order
      expect(customer.has_pending_order?).to be true
    end
  end

  describe 'observation matchers' do
    # expect {}
    it 'will match when events change object attributes' do
      array = []
      expect { array << 1 }.to change(array, :empty?).from(true).to(false)

      class WebsitesHits
        attr_accessor :count
        def initialize; @count = 0; end
        def increment; @count += 1; end
      end
      hits = WebsitesHits.new
      expect { hits.increment }.to change(hits, :count).from(0).to(1)
    end

    it 'will match when events change any values' do
      x = 10
      expect { x += 1 }.to change {x}.from(10).to(11)
      expect { x += 1 }.to change {x}.by(1)
      expect { x += 1 }.to change {x}.by_at_least(1)
      expect { x += 1 }.to change {x}.by_at_most(1)

      z = 11
      expect { z += 1 }.to change { z % 3 }.from(2).to(0)
    end

    it 'will match when errors are raised' do
      expect { raise StandarError, nil }.to raise_error
      expect { raise StandarError, nil }.to raise_exception

      expect { 1 / 0 }.to raise_error(ZeroDivisionError)
      expect { 1 / 0 }.to raise_error.with_message("divided by 0")
      expect { 1 / 0 }.to raise_error.with_message(/divided/)

      expect { 1 / 1 }.not_to raise_error
    end

    it 'will match when output is generated' do
      expect { print('hello') }.to output.to_stdout
      expect { print('hello') }.to output('hello').to_stdout
      expect { print('hello') }.to output(/ll/).to_stdout

      expect { warn('problem')}.to output(/problem/).to_stderr
    end

  end

  describe 'compound expectations' do

    it 'will match using: and, or, &, |' do
      expect([1,2,3,4]).to start_with(1).and end_with(4)

      expect([1,2,3,4]).to start_with(1) & include(2)

      expect(10 * 10).to be_odd.or be > 50

      array = ['hello', 'goodbye'].shuffle
      expect(array.first).to eq("hello") | eq("goodbye")
    end

  end

  describe 'composing matchers' do

    it 'will match all collection elements using a matcher' do

      array = [1,2,3]
      expect(array).to all(be < 5)
    end

    it 'will match by sending matchers as arguments to matchers' do
      string = "hello"
      expect { string = "goodbye"}.to change { string}.from(match(/ll/)).to( match(/oo/))

      hash = {:a => 1, :b => 2, :c => 3}
      expect(hash).to include(:a => be_odd, :b => be_even, :c => be_odd)
      expect(hash).to include(:a => be > 0, :b => be_within(2).of(4))
    end

    it 'will match using noun-phrase aliases for matchers' do
      fruits = ['apple', 'banana', 'cherry']
      expect(fruits).to start_with( start_with('a') ) &
        include( match(/a.a.a/) ) &
        end_with( end_with('y') )

      fruits = ['apple', 'banana', 'cherry']
      expect(fruits).to start_with(a_string_starting_with('a') ) &
        include( a_string_matching(/a.a.a/) ) &
        end_with( a_string_ending_with('y') )

      array = [1,2,3,4]
      expect(array).to start_with( a_value <= 2) |
        end_with( a_value_within(1).of(5) )
    end
  end
end
