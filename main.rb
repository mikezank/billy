require 'byebug'
require 'date'
require 'Qt4'
require_relative 'billdataclasses'
require_relative 'keychainclasses'
require_relative 'billmaintain'
require_relative 'billpreferences'
require_relative 'keymaintain'
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
    @ui.menubar.setNativeMenuBar(false)
    define_menu_actions
    reload_bills
    show_bill_table
  end
  
  def define_menu_actions
    @ui.actionActive_MasterBills.connect(SIGNAL('triggered()')) do # File -> Export -> Active MasterBills
      filename = get_export_file
      if filename
        activeMBlist = MasterBillList.new(Globals::ACTIVE_MBILL_STORE)
        activeMBlist.write_csv_file(filename)
      end
    end
    @ui.actionInactive_MasterBills.connect(SIGNAL('triggered()')) do # File -> Export -> Inactive MasterBills
      filename = get_export_file
      if filename
        inactiveMBlist = MasterBillList.new(Globals::INACTIVE_MBILL_STORE)
        inactiveMBlist.write_csv_file(filename)
      end
    end
    @ui.actionPaid_Bills.connect(SIGNAL('triggered()')) do # File -> Export -> Paid Bills
      filename = get_export_file
      if filename
        @blist.get_paid.write_csv_file(filename)
      end
    end
    @ui.actionPreferences.connect(SIGNAL('triggered()')) do # File -> Preferences
      set_preferences
    end
    @ui.actionKeys.connect(SIGNAL('triggered()')) do # Maintain -> Keys
      maintain_keys
    end
  end
  
  def get_export_file
    prefs = Preferences.new
    filename = Qt::FileDialog.getSaveFileName(self, 'Export To', prefs.data_directory, 'CSV file (*.csv)')
  end
  
  def set_preferences
    prefwin = BillPreferencesDialog.new
    retcode = prefwin.exec
    reload_bills
    show_bill_table
  end
  
  def maintain_keys
    keywin = KeyMaintainDialog.new
    retcode = keywin.show
  end
  
  def reload_bills
    activeMBlist = MasterBillList.new(Globals::ACTIVE_MBILL_STORE)
    #activeMBlist.test_load
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
        system("open #{@urlAtPayButton[payButton]}")
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

#
# main program
#
Code.initialize_key  # init AESkey for encrypt/decrypt
app = Qt::Application.new(ARGV)
appfont = Qt::Font.new("Courier", 10, Qt::Font::Bold, true)
app.setFont(appfont)
main_window = MainWindow.new
main_window.show
main_window.raise
app.exec