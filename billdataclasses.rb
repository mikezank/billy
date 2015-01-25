require 'date'
require 'Qt4'
require 'ice_cube'
require 'pstore'
require 'csv'
require 'uuidtools'
include IceCube

class Preferences
  
  PREF_PSTORE = 'billyprefs.pstore'
  
  attr_reader :data_directory, :lookahead_days
  
  #
  # Preferences records user-specified preferences
  #
  # data_directory is the location of all PStores
  #
  # lookahead_days is the number of days beyond today to generate and display Bills
  #
  def initialize
    @pstore = PStore.new(PREF_PSTORE)
    @pstore.transaction do
      @data_directory = @pstore.fetch(:data_directory, Qt::Dir.currentPath)
      @lookahead_days = @pstore.fetch(:lookahead_days, 30)
    end
  end
  
  def set_data_directory(direct)
    @data_directory = direct
    @pstore.transaction do
      @pstore[:data_directory] = @data_directory
    end
  end
  
  def set_lookahead_days(days)
    @lookahead_days = days
    @pstore.transaction do
      @pstore[:lookahead_days] = @lookahead_days
    end
  end
end

class Bill
  
  attr_reader :duedate, :name, :amount, :parent, :paid, :url, :key
  
  #
  # duedate is the duedate of the Bill  and is generated according to the schedule specified
  # by the parent MasterBill
  #
  # name is the name of the Bill as specified by the parent MasterBill
  #
  # amount is the amount of the Bill as specified by the parent MasterBill
  #
  # parent is the uuid of the parent MasterBill that generated the Bill
  #
  # paid indicates whether the Bill has been paid or not (boolean)
  #
  # url is the url of the site where the Bill can be paid
  #
  # key is a unique key that identifies the Bill.  It is a concatenation of the date in
  # yyyy-mm-dd format plus the parent UUID string
  #
  def initialize(duedate, name, amount, parent, paid, url)
    @duedate, @name, @amount, @parent, @paid, @url = duedate, name, amount, parent, paid, url
    @key = duedate.to_s + @parent
  end
  
  def set_paid(paid_status)
    @paid = paid_status
  end
  
  def format_label
    weekday = %w(Sun Mon Tue Wed Thu Fri Sat)[@duedate.wday]
    amtstr = "%.2f" % amount
    label = "%-28s %-11s" % [@name, @duedate.to_s] + weekday + "%10s" % amtstr
  end
  
  def pprint #pretty printer
    line2 = "Duedate: #{@duedate}; Amount: #{@amount}; Paid: #{@paid};"
    line1 = "Name: #{@name}; URL: #{@url}; Parent: #{@parent}"
    puts line1, line2
  end
  
end

class BillList
  #
  # @bills is a hash indexed by Bill key which is unique for every Bill
  #
  # empty_list is a boolean to indicate whether the list should be empty to start with
  #
  attr_reader :bills, :lookahead_days
  
  def initialize(bstorename, empty_list)
    prefs = Preferences.new
    @lookahead_days = prefs.lookahead_days
    @bstore = PStore.new(prefs.data_directory + '/' + bstorename)
    if empty_list
      # start with an empty list
      @bills = {}
      save_bills
    else
      # restore the list from the PStore
      @bstore.transaction do
        @bills = @bstore.fetch(:bills, {})
      end
    end
  end
  
  def generate_bills_from_masterbills(mblist, paidlist)
    #
    # generate unpaid Bills from the given MasterBillList (mblist), checking for duplicates in paidlist
    #
    # Bills are only generated until the lookahead date (until_date)
    #
    until_date = Date.today + @lookahead_days
    mblist.each_masterbill do |mbill|
      mbill.generate_bill do |bill|
        break if bill.duedate > until_date
        @bills[bill.key] = bill unless paidlist.bills.has_key?(bill.key)
      end
    end
    save_bills
  end
  
  def save_bills
    @bstore.transaction do
      @bstore[:bills] = @bills
    end
  end
  
  def clear_bills
    @bills = {}
    @bstore.transaction do
      @bstore[:bills] = @bills
    end
  end
  
  def delete_bill(bill)
    unless @bills.delete(bill.key)
      puts "Cannot delete bill #{bill.key}"
      raise SystemExit
    end
    save_bills
  end
  
  def add_bill(bill)
    if @bills.has_key?(bill.key)
      puts "Trying to add bill #{bill.key} to a list that already contains it"
      raise SystemExit
    else
      @bills[bill.key] = bill
      save_bills
      return
    end
  end
    
  def find_old_unpaid_bills(masterbill)
    #
    # finds all unpaid Bills older than today belonging to the given Masterbill
    #
    unpaid_bills = []
    @bills.sort_by {|key, value| key}.each do |k, bill|
      break if bill.duedate >= Date.today
      unless bill.paid
        unpaid_bills << bill if bill.parent == masterbill.uuid
      end
    end
    unpaid_bills
  end
  
  def delete_masterbill(mbill)
    #
    # deletes all Bills that belong to the given Masterbill
    #
    @bills.delete_if { |key, bill| bill.parent == mbill.uuid}
  end
  
  def write_csv_file(filename)
    CSV.open(filename, "wb", col_sep: "|") do |csv|
      @bills.each_value do |bill|
        csv << [bill.name, bill.amount, bill.duedate, bill.paid, bill.url]
      end
    end
  end
  
  def pprint # pretty printer
    @bills.each_value {|bill| bill.pprint}
  end
    
end

class AllBills
  #
  # AllBills maintains two BillLists, one for unpaid bills and the other for paid bills
  #
  DAYS_BEFORE_EARLIEST_UNPAID_BILL = 7 # how many days of Bills to show before the earliest unpaid Bill
  START_EMPTY = true
  
  def initialize(mblist)
    #
    # @paid is always restored from PStore
    # @unpaid is always rebuilt from an empty list according to the given MasterBillList
    #
    @unpaid = BillList.new(Globals::UNPAID_BILL_STORE, START_EMPTY)
    @paid = BillList.new(Globals::PAID_BILL_STORE, !START_EMPTY)
    @unpaid.generate_bills_from_masterbills(mblist, @paid)
    # search for earliest unpaid bill and set @show_after_date
    @show_after_date = Date.new(1900,1,1)
    @paid.bills.sort_by { |key, value| key}.each do |k, bill|
      if !bill.paid
        @show_after_date = bill.duedate - DAYS_BEFORE_EARLIEST_UNPAID_BILL
        break
      end
    end
  end
  
  def each_bill
    #
    # yield a sorted list of all bills, both paid and unpaid, that are due between
    # @show_after_date and the lookahead date (until_date)
    #
    until_date = Date.today + @paid.lookahead_days
    @paid.bills.merge(@unpaid.bills).sort_by { |key, value| key }
     .select {|k, bill| bill.duedate.between?(@show_after_date, until_date)}.each do |k, bill|
       yield bill
     end
   end
   
   def move_bill(bill, paid_status)
     #
     # move the given Bill between the paid and unpaid BillLists depending on paid_status
     #
     if paid_status
       @from_list = @unpaid
       @to_list = @paid
     else
       @from_list = @paid
       @to_list = @unpaid
     end
     @from_list.delete_bill(bill)
     @to_list.add_bill(bill)
   end
   
   def get_unpaid
     @unpaid
   end
   
   def get_paid
     @paid
   end
  
end

class Frequency
  
  MAX_YEARS_AHEAD = 5 # date limit on Bill generation
  WEEKDAYS_ICECUBE = [:none, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  WEEKDAYS = %w(<none> Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
  MONTHDAYS = %w(<none> 1st 2nd 3rd 4th 5th 6th 7th 8th 9th 10th 11th 12th 13th 14th 15th 16th 17th) +
    %w(18th 19th 20th 21st 22nd 23rd 24th 25th 26th 27th 28th) + ['Last day']
  
  attr_reader :start_date, :end_date, :freq_text, :condition_text
  attr_reader :period, :repeat, :month_day, :semi_day1, :semi_day2, :week_day
  attr_reader :month_day_index, :semi_day1_index, :semi_day2_index, :week_day_index
  
  def initialize(period, repeat, start_date, end_date, month_day, semi_day1, semi_day2, week_day)
    #
    # period is the frequency period:  Monthly, Weekly, Daily, or Semi-monthly
    #
    # repeat is how often to repeat the Bill in period units (e.g. for the period 'M', repeat=1 
    # means every month, repeat=2 means every other month, ...).  repeat is not used with semi-monthly
    #
    # start_date, end_date specify the starting date and ending date of the Bills to be generated.  Either can
    # be left nil
    #
    # month_day specifies the day of the month for a monthly period; it is not used for the other periods.
    # legal values are 1st, 2nd, 3rd, 4th, 5th, ... 28th, or 'Last day' (meaning the last day of the month),
    # 29th, 30th, 31st are invalid since Bill generation would produce inconsistent results
    #
    # semi_day1, semi_day2 are used only for the semi-monthly period to specify the particular days of the 
    # month to generate the Bill.  legal values are the same as for month_day
    #
    # week_day is used only for the weekly period to specify the day of the week to generate the Bill.
    # legal values are Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    #
    @period = period
    @freq_text = ''
    @condition_text = ''
    @start_date, @end_date = start_date, end_date
    # calculate effective start/end dates
    # if start_date is nil, effective_start_date is set to today
    # if end_date is nil, effective_end_date is set to MAX_YEARS_AHEAD
    effective_start_date = start_date ? start_date : Date.today()
    max_end_date = Date.new(Date.today.year + MAX_YEARS_AHEAD, Date.today.month, Date.today.day)
    effective_end_date = end_date ? [end_date, max_end_date].min : max_end_date
    
    case period
    when "Monthly"
      
      # valid forms:  (1) every xx months (optional start_date, end_date), no month_day specified
      #               (2) every xx months on month_day (optional start_date, end_date)
      #
      # month_day can be 1st - 28th or Last day (or left blank for form 1)
      #
      # repeat must be specified and is used to calculate xx
      #
      # (1) generates Bills beginning on the start_date every xx months until the end_date
      # (2) generates Bills beginning on the first month_day that occurs after the start_date, every
      # xx months thereafter until the end_date
      #
      # all other fields are ignored
      #
      if repeat == nil
        puts "repeat value must be specified for monthly period"
        return
      else
        @repeat = repeat
        if repeat == 1
          @freq_text = "Every month"
        else
          @freq_text = "Every #{repeat} months"
        end
      end
      if month_day == nil
        @month_day = month_day
        @month_day_index = nil
        @schedule = Schedule.new(effective_start_date)
        @schedule.rrule(Rule.monthly(@repeat).until(effective_end_date))
        return
      end
      mindex = check_month_day('month_day', month_day)
      if mindex and (mindex > 0)
        @month_day = MONTHDAYS[mindex]
        @month_day_index = mindex
        @condition_text = "on the #{@month_day} of the month".downcase
        ice_month_day = @month_day == 'Last day' ? -1 : @month_day_index
        @schedule = Schedule.new(effective_start_date)
        @schedule.rrule(Rule.monthly(@repeat).day_of_month(ice_month_day).until(effective_end_date))
      end
      
    when "Semi-monthly"
      
      # valid form: semi-monthly on days semi_day1 and semi_day2 (optional start_date, end_date)
      #
      # semi_day1 and semi_day2 must be in the range 1st - 28th or Last day. They can be specified
      # in any order but must not be the same day
      #
      # repeat cannot be used with semi-monthly period and must be specified as nil
      #
      # Bills will be generated on semi_day1 and semi_day2 of every month beginning on start_date
      # and ending on end_date
      #
      # all other fields are ignored
      #
      if repeat
        puts "Repeat cannot be used with semi-monthly period"
        return
      end
      if semi_day1 and semi_day2
        s1index = check_month_day('semi_day1', semi_day1)
        s2index = check_month_day('semi_day2', semi_day2)
        if s1index and (s1index > 0) and s2index and (s2index > 0)
          @semi_day1 = MONTHDAYS[s1index]
          @semi_day1_index = s1index
          @semi_day2 = MONTHDAYS[s2index]
          @semi_day2_index = s2index
          @condition_text = "on the #{@semi_day1} and the #{@semi_day2} of the month".downcase
          ice_semi1_day = @semi_day1 == 'Last day' ? -1 : @semi_day1_index
          ice_semi2_day = @semi_day2 == 'Last day' ? -1 : @semi_day2_index
        else
          return
        end
        if @semi_day1 == @semi_day2
          puts "semi_day1 (#{@semi_day1}) and semi_day2 (#{@semi_day2}) must specify different days of the month"
          return
        end
      else
        puts "semi_day1 and semi_day2 must be specified for semi-monthly period"
        return
      end
      @freq_text = "Every month"
      @schedule = Schedule.new(effective_start_date)
      @schedule.rrule(Rule.monthly.day_of_month(ice_semi1_day, ice_semi2_day).until(effective_end_date))
      
      
    when "Weekly"
      
      # valid forms:  (1) every xx weeks (optional start_date, end_date), no week_day specified
      #               (2) every xx weeks on week_day (optional start_date, end_date)
      #
      # week_day can be Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, or Sunday (or left
      #                  blank for form 1)
      #
      # repeat must be specified and is used to calculate xx
      #
      # (1) generates Bills beginning on the start_date every xx weeks until the end_date
      # (2) generates Bills beginning of the first week_day that occurs after the start_date, every
      # xx weeks thereafter until the end_date
      #
      # all other fields are ignored
      #
      if repeat == nil
        puts "repeat value must be specified for weekly period"
        return
      else
        @repeat = repeat
        if repeat == 1
          @freq_text = "Every week"
        else
          @freq_text = "Every #{repeat} weeks"
        end
      end
      if week_day == nil
        @week_day = week_day
        @schedule = Schedule.new(effective_start_date)
        @schedule.rrule(Rule.weekly(@repeat).until(effective_end_date))
        return
      end
      day_index = WEEKDAYS.index(week_day)
      if day_index and (day_index > 0)
        @week_day = week_day
        @condition_text = "on #{@week_day}"
        @schedule = Schedule.new(effective_start_date)
        @schedule.rrule(Rule.weekly(@repeat).day(WEEKDAYS_ICECUBE[day_index]).until(effective_end_date))
      else
        puts "week_day value (#{week_day}) is illegal.  Must be Monday - Sunday"
      end
      
    when "Daily"
      
      # valid form:  every xx days (optional start_date, end_date)
      #
      # repeat must be specified and is used to calculate xx
      #
      # generates Bills beginning on the start_date every xx days until the end_date
      #
      # all other fields are ignored
      #
      if repeat == nil
        puts "repeat value must be specified for daily period"
        return
      else
        @repeat = repeat
        if repeat == 1
          @freq_text = "Every day"
        else
          @freq_text = "Every #{repeat} days"
        end
      end
      @schedule = Schedule.new(effective_start_date)
      @schedule.rrule(Rule.daily(@repeat).until(effective_end_date))
      
    else
      puts "period value (#{period}) is illegal.  Must be Monthly, Weekly, Daily, or Semi-monthly"
    end
  end
  
  def each_date
    # returns each date generated by the Frequency object
    @schedule.all_occurrences.each {|occurrence| yield occurrence.start_time.to_date}
  end
  
  def check_month_day(name, value)
    vindex = MONTHDAYS.index(value)
    if vindex and (vindex > 0)
      return vindex
    else
      puts "#{name} value (#{value}) is illegal.  Must be in the range 1st - 28th or Last day"
      return nil
    end
  end
  
  def pprint #pretty printer
    line1 = "Period: #{@period}; Repeat: #{@repeat}; Start_date: #{@start_date}; End_date: #{@end_date};"
    line2 = "Month_day: #{@month_day}; Semi_day1: #{@semi_day1}; Semi_day2: #{@semi_day2}; Week_day: #{@week_day};"
    puts line1, line2
  end
  
end
        
class MasterBill
  
  attr_accessor :name, :amount, :url, :uuid
  
  #
  # name is the name of the MasterBill
  #
  # amount is the amount of the MasterBill
  #
  # frequency is a Frequency object specifying how to generate Bills from the MasterBill
  #
  # uuid is a randomly generated unique key to identify the MasterBill
  #
  def initialize(name, amount, frequency, url)
    @name, @amount, @frequency, @url = name, amount, frequency, url
    @uuid = UUIDTools::UUID.random_create.to_str
  end
  
  def generate_bill
    @frequency.each_date do |duedate|
      yield Bill.new(duedate, @name, @amount, @uuid, false, @url)
    end
  end
  
  def get_frequency
    @frequency
  end
  
  def pprint #pretty printer
    line1 = "Name: #{@name}; Amount: #{@amount}; URL: #{@url};"
    puts line1
    @frequency.pprint
  end
  
end

class MasterBillList
  #
  # @mbills is a hash indexed by uuid because uuid will remain consistent after a refresh from the
  # Pstore, whereas the MasterBill object id itself will not.
  #
  def initialize(mbstorename)
    prefs = Preferences.new
    @mbstore = PStore.new(prefs.data_directory + '/' + mbstorename)
    @mbstore.transaction do
      @mbills = @mbstore.fetch(:mbills, {})
    end
  end
  
  def add_masterbill(mbill)
    @mbstore.transaction do
      @mbills[mbill.uuid] = mbill
      @mbstore[:mbills] = @mbills
    end
  end
  
  def delete_masterbill(mbill)
    @mbstore.transaction do
      unless @mbills.delete(mbill.uuid)
        puts "Couldn't delete Masterbill #{mbill.uuid}"
        raise SystemExit
      end
      @mbstore[:mbills] = @mbills
    end
  end
  
  def each_masterbill
    @mbills.each_value {|mbill| yield mbill}
  end
  
  def write_csv_file(filename)
    CSV.open(filename, "wb", col_sep: "|") do |csv|
      each_masterbill do |mbill|
        csv << [mbill.name, mbill.amount, mbill.get_frequency.start_date.to_s,
          mbill.get_frequency.end_date.to_s, mbill.get_frequency.freq_text,
          mbill.get_frequency.condition_text, mbill.url]
      end
    end
  end
  
  #-- The following methods are used primarily for testing and debugging purposes
  def test_load
    if @mbills.length == 0 # only happens if PStore does not exist
      sd = Date.new(2015,1,1)
      ed = Date.new(2015, 6,1)
      ed2 = Date.new(2015, 3, 1)
      sd2 = Date.new(2015, 2, 1)
      freq = Frequency.new('Monthly', 1, sd, ed, 'Last day', nil, nil, nil)
      mbill = MasterBill.new('Phone', 125.0, freq, 'www.payphone.com')
      add_masterbill(mbill)
      freq = Frequency.new('Monthly', 2, sd, ed, '10th', nil, nil, nil)
      mbill = MasterBill.new('Cable', 130.0, freq, 'www.paycable.com')
      add_masterbill(mbill)
      freq = Frequency.new('Monthly', 1, sd, ed, nil, nil, nil, nil)
      mbill = MasterBill.new('Lawn', 100.0, freq, 'www.paylawn.com')
      add_masterbill(mbill)
      freq = Frequency.new('Semi-monthly', nil, sd, ed, nil, '1st', '15th', nil)
      mbill = MasterBill.new('Dog', 25.0, freq, 'www.paydog.com')
      add_masterbill(mbill)
      freq = Frequency.new('Semi-monthly', nil, sd, ed, nil, '10th', 'Last day', nil)
      mbill = MasterBill.new('Cat', 30.0, freq, 'www.paycat.com')
      add_masterbill(mbill)
      freq = Frequency.new('Weekly', 1, sd2, ed2, nil, nil, nil, 'Friday')
      mbill = MasterBill.new('Rent', 1300.0, freq, 'www.payrent.com')
      add_masterbill(mbill)
      freq = Frequency.new('Weekly', 6, sd, ed, nil, nil, nil, nil)
      mbill = MasterBill.new('Alimony', 2500.0, freq, 'www.payalimony.com')
      add_masterbill(mbill)
      freq = Frequency.new('Daily', 10, sd, ed, nil, nil, nil, nil)
      mbill = MasterBill.new('Credit', 500.0, freq, 'www.paycredit.com')
      add_masterbill(mbill)
      freq = Frequency.new('Monthly', 1, sd, nil, '5th', nil, nil, nil)
      mbill = MasterBill.new('Old one', 20.0, freq, 'www.payoldone.com')
      add_masterbill(mbill)
    end
  end
  
  def first_masterbill
    hashkeys = @mbills.keys
    @mbills[hashkeys[0]]
  end
  
  def last_masterbill
    hashkeys = @mbills.keys
    @mbills[hashkeys[-1]]
  end
  
  def length
    @mbills.length
  end
  
end

class CalendarDay
  
  attr_accessor :cal_tasks
  
  #
  # cal_tasks is an array of all tasks with duedates on a particular calendar day
  #
  def initialize
    @cal_tasks = []
  end
  
  def add_task(task)
    # check to see if task is already in the cal_task list, in the case of a SavedTask
    duplicate = false
    @cal_tasks.each { |caltask| duplicate = true if caltask.parent == task.parent }
    @cal_tasks << task unless duplicate
  end
  
  def formatted
    form = ""
    @cal_tasks.each { |task| form += "- " + task.short_text + "\n" }
    form
  end
      
end

class Calendar
  
  #
  # calendar_days is a hash indexed by date that contains CalendarDays (all tasks due on that date)
  #
  def initialize(remlist, cal_start, cal_end)
    @calendar_days = {}
    # load all SavedTasks first so they take precedence over any newly generated Tasks.  This works
    # because CalendarDay.add_task checks for duplicate tasks on the same day
    saved_list = SavedTaskList.new
    cal_start.upto(cal_end) do |date|
      saved_list.tasks_for_date(date).each do |task|
        @calendar_days[task.duedate] = CalendarDay.new unless @calendar_days.has_key?(task.duedate)
        @calendar_days[task.duedate].add_task(task)
      end
    end
    # load new generated Tasks
    remlist.each_task(cal_start, cal_end) do |task|
      @calendar_days[task.duedate] = CalendarDay.new unless @calendar_days.has_key?(task.duedate)
      @calendar_days[task.duedate].add_task(task)
    end
  end
  
  def has_day?(date)
    @calendar_days.has_key?(date)
  end
  
  def get_day(date)
    @calendar_days[date]
  end
  
  def pprint
    @calendar_days.each {|date, cday| puts cday.formatted}
  end
  
end

  