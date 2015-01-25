require 'byebug'
require 'date'
require 'Qt4'
require_relative 'billdataclasses'
require_relative 'billaddchange_ui'

class MasterBillAddChangeWindow < Qt::Dialog
  
  #
  # Constructors:
  #
  #    MasterBillAddChange.new()  -- adds a MasterBill
  #
  #    MasterBillAddChange.new(master_bill) -- changes the given MasterBill
  #
  
  slots 'save_clicked()', 'clear_clicked()', # defined on the form
          'start_date_check()', 'end_date_check()',
          'monthly_period_clicked()', 'weekly_period_clicked()', 
          'daily_period_clicked()', 'semi_period_clicked()',
          'name_selected(int,int)'
         
  def initialize(mbills, *arg)
    @mbills = mbills
    if arg.length == 0
      @changemode = false
    elsif arg.length == 1
      @sel_mbill = arg[0]
      @changemode = true
    else
      raise "Invalid call with arg = #{arg}"
    end
    super(parent=nil)
    @ui = Ui_MaintDialog.new
    @ui.setupUi(self)
    @ui.errorMsg.setStyleSheet('QLabel {color: red}')
    @mindate = Date.new(Date.today.year, 1, 1).to_qdate
    @ui.amountSpin.setRange(0.0, 100000.0)
    @ui.monthSpin.setMinimum(1)
    @ui.monthCombo.insertItems(0, Frequency::MONTHDAYS)
    @ui.weekSpin.setMinimum(1)
    @ui.weekCombo.insertItems(0, Frequency::WEEKDAYS)
    @ui.semiCombo1.insertItems(0, Frequency::MONTHDAYS)
    @ui.semiCombo2.insertItems(0, Frequency::MONTHDAYS)
    @ui.daySpin.setMinimum(1)
    if @changemode
      preload_for_change
    else
      preload_for_add
    end
  end
  
  def preload_for_add
    disable_all_periods()
    @ui.nameEdit.setText('')
    @ui.urlEdit.setText('')
    @ui.amountSpin.setValue(0.0)
    @ui.monthSpin.setValue(1)
    @ui.weekSpin.setValue(1)
    @ui.daySpin.setValue(1)
    disable_all_dates()
  end
    
  def preload_for_change
    @ui.nameEdit.setText(@sel_mbill.name)
    @ui.amountSpin.setValue(@sel_mbill.amount)
    @ui.urlEdit.setText(@sel_mbill.url)
    
    disable_all_dates()
    freq = @sel_mbill.get_frequency
    if freq.start_date
      @ui.startdateEdit.setSpecialValueText('')
      @ui.startdateEdit.date = freq.start_date.to_qdate
      @ui.startdateEdit.setEnabled(true)
      @ui.startCheck.setChecked(true)
    end
    if freq.end_date
      @ui.enddateEdit.setSpecialValueText('')
      @ui.enddateEdit.date = freq.end_date.to_qdate
      @ui.enddateEdit.setEnabled(true)
      @ui.endCheck.setChecked(true)
    end
    
    disable_all_periods()
    case freq.period
    when "Monthly"
      @ui.monthlyButton.setChecked(true)
      @ui.monthSpin.setEnabled(true)
      @ui.monthSpin.setValue(freq.repeat)
      @ui.monthCombo.setEnabled(true)
      @ui.monthCombo.setCurrentIndex(freq.month_day_index) if freq.month_day_index
    when "Weekly"
      @ui.weeklyButton.setChecked(true)
      @ui.weekSpin.setEnabled(true)
      @ui.weekSpin.setValue(freq.repeat)
      @ui.weekCombo.setEnabled(true)
      @ui.weekCombo.setCurrentIndex(freq.week_day_index) if freq.week_day_index
    when "Daily"
      @ui.dailyButton.setChecked(true)
      @ui.daySpin.setEnabled(true)
      @ui.daySpin.setValue(freq.repeat)
    when "Semi-monthly"
      @ui.semiButton.setChecked(true)
      @ui.semiCombo1.setEnabled(true)
      @ui.semiCombo1.setCurrentIndex(freq.semi_day1_index) if freq.semi_day1_index
      @ui.semiCombo2.setEnabled(true)
      @ui.semiCombo2.setCurrentIndex(freq.semi_day2_index) if freq.semi_day2_index
    end
    
  end
  
  def disable_all_periods()
    #byebug
    @ui.monthlyButton.setChecked(false)
    @ui.weeklyButton.setChecked(false)
    @ui.dailyButton.setChecked(false)
    @ui.semiButton.setChecked(false)
    @ui.monthSpin.setEnabled(false)
    @ui.weekSpin.setEnabled(false)
    @ui.daySpin.setEnabled(false)
    @ui.monthSpin.setValue(1)
    @ui.weekSpin.setValue(1)
    @ui.daySpin.setValue(1)
    @ui.monthCombo.setEnabled(false)
    @ui.weekCombo.setEnabled(false)
    @ui.semiCombo1.setEnabled(false)
    @ui.semiCombo2.setEnabled(false)
    @ui.monthCombo.setCurrentIndex(0)
    @ui.weekCombo.setCurrentIndex(0)
    @ui.semiCombo1.setCurrentIndex(0)
    @ui.semiCombo2.setCurrentIndex(0)
  end
  
  def disable_all_dates()
    @ui.startCheck.setChecked(false)
    @ui.endCheck.setChecked(false)
    @ui.startdateEdit.setCalendarPopup(true)
    @ui.startdateEdit.setMinimumDate(@mindate)
    @ui.startdateEdit.setSpecialValueText('None')
    @ui.startdateEdit.date = @mindate
    @ui.startdateEdit.setEnabled(false)
    @ui.enddateEdit.setCalendarPopup(true)
    @ui.enddateEdit.setMinimumDate(@mindate)
    @ui.enddateEdit.setSpecialValueText('None')
    @ui.enddateEdit.date = @mindate
    @ui.enddateEdit.setEnabled(false)
  end
  
  def name_selecdted(x, y)
    # user is about to enter a new name so clear out the error text
    puts "name_selected: #{x}, #{y}"
    @ui.errorMsg.setText('')
  end
  
  def monthly_period_clicked()
    disable_all_periods()
    @ui.monthSpin.setEnabled(true)
    @ui.monthCombo.setEnabled(true)
  end
  
  def weekly_period_clicked()
    disable_all_periods()
    @ui.weekSpin.setEnabled(true)
    @ui.weekCombo.setEnabled(true)
  end
  
  def daily_period_clicked()
    disable_all_periods()
    @ui.daySpin.setEnabled(true)
  end
  
  def semi_period_clicked()
    disable_all_periods()
    @ui.semiCombo1.setEnabled(true)
    @ui.semiCombo2.setEnabled(true)
  end
  
  def start_date_check()
    if @ui.startCheck.isChecked
      @ui.startdateEdit.setSpecialValueText('')
      @ui.startdateEdit.setEnabled(true)
    else
      @ui.startdateEdit.date = @mindate
      @ui.startdateEdit.setSpecialValueText('None')
      @ui.startdateEdit.setEnabled(false)
    end
  end
  
  def end_date_check()
    if @ui.endCheck.isChecked
      @ui.enddateEdit.setSpecialValueText('')
      @ui.enddateEdit.setEnabled(true)
    else
      @ui.enddateEdit.date = @mindate
      @ui.enddateEdit.setSpecialValueText('None')
      @ui.enddateEdit.setEnabled(false)
    end
  end
  
  def clear_clicked()
    preload_for_add
  end
  
  def save_clicked()
    errorline = ''
    # check for proper date range and presence of name
    if @ui.startCheck.isChecked and @ui.endCheck.isChecked
      if @ui.startdateEdit.date.to_rubydate > @ui.enddateEdit.date.to_rubydate
        errorline += 'Start Date cannot be after End Date'
      end
    end
    if @ui.semiButton.isChecked
      if @ui.semiCombo1.currentText == '<none>' or @ui.semiCombo2.currentText == '<none>'
        msg =  'oth days of the month must be specified for Semi-monthly period'
        if errorline != ''
          errorline += '; b' + msg
        else
          errorline = 'B' + msg
        end
      end
    end
    if errorline != ''
      @ui.errorMsg.setText(errorline)
      return
    end
    
    # no errors so process the add / change
    start_date = @ui.startCheck.isChecked ? @ui.startdateEdit.date.to_rubydate : nil
    end_date = @ui.endCheck.isChecked ? @ui.enddateEdit.date.to_rubydate : nil
    name = @ui.nameEdit.text
    amount = @ui.amountSpin.value
    url = @ui.urlEdit.text
    if @ui.monthlyButton.isChecked
      repeat = @ui.monthSpin.value
      month_day = @ui.monthCombo.currentText == '<none>' ? nil : @ui.monthCombo.currentText
      freq = Frequency.new('Monthly', repeat, start_date, end_date, month_day, nil, nil, nil)
    elsif @ui.weeklyButton.isChecked
      repeat = @ui.weekSpin.value
      week_day = @ui.weekCombo.currentText == '<none>' ? nil : @ui.weekCombo.currentText
      freq = Frequency.new('Weekly', repeat, start_date, end_date, nil, nil, nil, week_day)
    elsif @ui.dailyButton.isChecked
      repeat = @ui.daySpin.value
      freq = Frequency.new('Daily', repeat, start_date, end_date, nil, nil, nil, nil)
    elsif @ui.semiButton.isChecked
      semi_day1 = @ui.semiCombo1.currentText
      semi_day2 = @ui.semiCombo2.currentText
      freq = Frequency.new('Semi-monthly', nil, start_date, end_date, nil, semi_day1, semi_day2, nil)
    end
    mbill = MasterBill.new(name, amount, freq, url)
    if @changemode
      # if in change mode, go back to the previous screen
      @mbills.add_masterbill(mbill)
      accept
    else
      # if in add mode, allow more MasterBills to be added
      @mbills.add_masterbill(mbill)
    end
    @ui.errorMsg.setText('New Master Bill saved')
  end
  
end