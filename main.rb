require 'byebug'
require 'date'
require 'Qt4'
require_relative 'billdataclasses'
require_relative 'billmaintain'
require_relative 'main_ui'

#-- Add date conversions between QDate and ruby Date
class Date
  def to_qdate
    Qt::Date.new(self.year, self.month, self.day)
  end
end

class Qt::Date
  def to_rubydate
    Date.parse(self.toString)
  end
end
#--

class Globals
  ACTIVE_MBILL_STORE = 'active_mbill_store.pstore'
  INACTIVE_MBILL_STORE = 'inactive_mbill_store.pstore'
  PAID_BILL_STORE = 'paid_bill_store.pstore'
  UNPAID_BILL_STORE = 'unpaid_bill_store.pstore'
  MAX_LOOKAHEAD_DAYS = 90 # how many days after today that bills will be generated and displayed
end

class MainWindow < Qt::MainWindow
  
  STYLE = 'background-color: yellow; border-style: outset;' +\
                   'border-width: 2px; border-radius: 10px; ' +\
                   'border-color: beige; color: black; font: 18px'
  CHECKSTYLE = 'color: black; font: 18px'
  ATTN_STYLE = 'background-color: yellow; border-style: outset;' +\
                   'border-width: 2px; border-radius: 10px; ' +\
                   'border-color: beige; color: red; font: 18px'
  ATTN_CHECKSTYLE = 'color: orange; font: 18px'
  DUE_CHECKSTYLE = 'color: red; font: 18px'
  
  slots 'do_maintenance()' # referenced by main.ui
  
  def initialize(parent=nil)
    super
    @ui = Ui_MainWindow.new
    @ui.setupUi(self)
    reload_bills
    show_bill_table
  end
  
  def reload_bills
    activeMBlist = MasterBillList.new(Globals::ACTIVE_MBILL_STORE)
    activeMBlist.test_load
    @blist = AllBills.new(activeMBlist)
  end
  
  def show_bill_table
    @billAtPaidBox = {}
    @urlAtPayButton = {}
    scroller = Qt::Widget.new
    grid = Qt::GridLayout.new(scroller)
    row = 0
    
    @blist.each_bill do |bill|
      label = bill.format_label
      paidBox = Qt::CheckBox.new(label)
      paidBox.setFixedSize(600,25)
      paidBox.setChecked(bill.paid)
      @billAtPaidBox[paidBox] = bill
      grid.addWidget(paidBox, row, 0)
      paidBox.setStyleSheet(CHECKSTYLE)
      
      duedays = bill.duedate - Date.today
      if duedays < 2 
        paidBox.setStyleSheet(DUE_CHECKSTYLE) unless paidBox.isChecked
      elsif duedays < 7
        paidBox.setStyleSheet(ATTN_CHECKSTYLE) unless paidBox.isChecked
      end
      
      payButton = Qt::PushButton.new('Pay')
      payButton.setMaximumWidth(100)
      payButton.setDisabled(true) if bill.url == ''
      @urlAtPayButton[payButton] = bill.url
      grid.addWidget(payButton, row, 1)
      payButton.connect(SIGNAL('clicked()')) do
        puts "open the website #{@urlAtPayButton[payButton]}"
      end
      paidBox.connect(SIGNAL('clicked()')) do
        selected_bill = @billAtPaidBox[paidBox]
        selected_bill.set_paid(paidBox.isChecked)
        @blist.move_bill(selected_bill, paidBox.isChecked)
      end
      row += 1
    end
    
    scroller.setLayout(grid)
    @ui.scrollArea.setWidget(scroller)
  end
  
  def do_maintenance()
    maintwin = BillMaintainDialog.new(@blist)
    retcode = maintwin.exec
    reload_bills
    show_bill_table
  end
  
end

app = Qt::Application.new(ARGV)
appfont = Qt::Font.new("Courier", 10, Qt::Font::Bold, true)
app.setFont(appfont)
main_window = MainWindow.new
main_window.show
main_window.raise
app.exec