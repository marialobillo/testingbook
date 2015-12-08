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

  describre 'equivalence truthiness matchers' do

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

    end

    it 'will math class instances with #have_attributes' do

    end

    it 'will match anything with #satisfy' do

    end
  end

end
