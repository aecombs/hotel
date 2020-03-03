require_relative 'test_helper'
describe "date_range class" do
  before do
    @date = Hotel::DateRange.new([2020, 1, 28], [2020, 1, 30])
  end
  describe "initialize" do
    it "can be created" do
      expect(@date).must_be_instance_of Hotel::DateRange
    end
    it "will have the correct amount of readable attributes" do
      expect(@date).must_respond_to :check_in_time
      expect(@date).must_respond_to :check_out_time
    end
    it "will have check in and check out times that are Date objects" do
      expect(@date.check_in_time).must_be_instance_of Date
      expect(@date.check_out_time).must_be_instance_of Date
    end
    it "will not create instance if check out time is before check in time" do
      expect {
        Hotel::DateRange.new([2020, 1, 28], [2020, 1, 27])
      }.must_raise ArgumentError
    end
  end

  describe "create days array method" do
    it "will create an array of Date objects" do
      expect(@date.create_days_array).must_be_instance_of Array
      expect(@date.create_days_array).wont_be_empty
      expect(@date.create_days_array[0]).must_be_instance_of Date
    end

    it "will have the correct number of days" do
      expect(@date.create_days_array.length).must_equal 3
    end
  end

  describe "include? method" do
    it "will return true if a day is included in its range" do
      day = Date.new(2020, 1, 29)
      expect(@date.include?(day)).must_equal true
      expect(@date.include?(day.next)).must_equal true
      expect(@date.include?(day - 1)).must_equal true
    end
  end

  describe "overlap? method" do
    it "will return true if another date range overlaps more than one day" do
      my_days = Hotel::DateRange.new([2020, 1, 29], [2020, 1, 31])

      expect(@date.overlap?(my_days)).must_equal true
    end

    it "will return false if the first/end days overlap" do
      my_days = Hotel::DateRange.new([2020, 1, 27], [2020, 1, 28])
      my_other_days = Hotel::DateRange.new([2020, 1, 30], [2020, 1, 31])

      expect(@date.overlap?(my_days)).must_equal false
      expect(@date.overlap?(my_other_days)).must_equal false
    end
  end

  describe "nights method" do
    
    it "can be called" do
      expect(@date).must_respond_to :nights
    end
    it "will calculate number of nights" do
      expect(@date.nights).must_equal (@date.create_days_array.length - 1)
      expect(@date.nights).must_equal 2
    end
    it "will not equal the number of days" do
      expect(@date.nights).wont_equal @date.create_days_array.length
    end
  end
end