require 'byebug'
require 'date'
require 'Qt4'
require_relative 'billdataclasses'
require_relative 'billaddchange'
require_relative 'billmaintain_ui'

class BillMaintainDialog < Qt::Dialog
  
  NUM_COLS = 6
  
  #slots 'do_maintenance()' # referenced by main.ui
  slots 'add_masterbill()', 'change_masterbill()', 'delete_masterbill()'
  
  def initialize(blist)
    super(parent=nil)
    @unpaid = blist.get_unpaid
    @paid = blist.get_paid
    @ui = Ui_BillmaintainDialog.new
    @ui.setupUi(self)
    @ui.billTable.setColumnCount(NUM_COLS)
    @ui.billTable.setHorizontalHeaderLabels(%w(Name Amount Start End Frequency Condition))
    border_style = 'QTableWidget {border-width: 5px; padding: 3px; border-color: darkblue}'
    @ui.billTable.setStyleSheet(border_style)
    show_table
  end
  
  def show_table
    @activeMBlist = MasterBillList.new(Globals::ACTIVE_MBILL_STORE)
    @inactiveMBlist = MasterBillList.new(Globals::INACTIVE_MBILL_STORE)
    @ui.billTable.setRowCount(@activeMBlist.length)
    row = 0
    @mbill_in_row = []
    @activeMBlist.each_masterbill do |mbill|
      col0 = Qt::TableWidgetItem.new(mbill.name)
      @ui.billTable.setItem(row, 0, col0)
      col1 = Qt::TableWidgetItem.new(mbill.amount.to_s)
      col1.setTextAlignment(Qt::AlignRight)
      @ui.billTable.setItem(row, 1, col1)
      col2 = Qt::TableWidgetItem.new(mbill.get_frequency.start_date.to_s)
      @ui.billTable.setItem(row, 2, col2)
      col3 = Qt::TableWidgetItem.new(mbill.get_frequency.end_date.to_s)
      @ui.billTable.setItem(row, 3, col3)
      col4 = Qt::TableWidgetItem.new(mbill.get_frequency.freq_text)
      @ui.billTable.setItem(row, 4, col4)
      col5 = Qt::TableWidgetItem.new(mbill.get_frequency.condition_text)
      @ui.billTable.setItem(row, 5, col5)
      row += 1
      @mbill_in_row << mbill
    end
    @ui.billTable.resizeRowsToContents
    @ui.billTable.resizeColumnsToContents
  end
  
  def add_masterbill()
    addwin = MasterBillAddChangeWindow.new(@activeMBlist)
    retcode = addwin.exec
    @unpaid.clear_bills
    @unpaid.generate_bills_from_masterbills(@activeMBlist, @paid)
    show_table
  end
  
  def delete_masterbill()
    selrow = @ui.billTable.currentRow
    deletembill = @mbill_in_row[selrow]
    if bill_deletions_verified?(deletembill)
      @activeMBlist.delete_masterbill(deletembill)
      @unpaid.delete_masterbill(deletembill)
      @inactiveMBlist.add_masterbill(deletembill)
    end
    show_table
  end
  
  def change_masterbill()
    selrow = @ui.billTable.currentRow
    changembill = @mbill_in_row[selrow]
    if bill_deletions_verified?(changembill)
      changewin = MasterBillAddChangeWindow.new(@activeMBlist, changembill)
      retcode = changewin.exec
      if retcode == Qt::Dialog.Accepted
        @activeMBlist.delete_masterbill(changembill)
        @inactiveMBlist.add_masterbill(changembill)
        @unpaid.clear_bills
        @unpaid.generate_bills_from_masterbills(@activeMBlist, @paid)
      end
    end
    show_table
  end
  
  def bill_deletions_verified?(mbill)
    deletions = @unpaid.find_old_unpaid_bills(mbill)
    return true if deletions.length == 0
    # there are unpaid Bills that will be deleted if this Masterbill is deleted
    # give the user a chance to back out of the transaction
    mindate = deletions.min {|bill| bill.duedate}.duedate
    maxdate = deletions.max {|bill| bill.duedate}.duedate
    msg = Qt::MessageBox.new
    horizontalSpacer = Qt::SpacerItem.new(400, 0, Qt::SizePolicy.Minimum, Qt::SizePolicy.Expanding)
    layout = msg.layout
    layout.addItem(horizontalSpacer, layout.rowCount(), 0, 1, layout.columnCount())
    if deletions.length == 1
      msg.setText("This Masterbill has 1 unpaid bill due on #{mindate.to_s}." +
        "It will be deleted.\n\nContinue anyway?")
    else
      msg.setText("This Masterbill has #{deletions.length} unpaid bills due between #{mindate.to_s} " +
        "and #{maxdate.to_s}.  They will be deleted.\n\nContinue anyway?")
    end
    msg.setStandardButtons(Qt::MessageBox.Yes | Qt::MessageBox.No)
    msg.setDefaultButton(Qt::MessageBox.No)
    retvalue = msg.exec
    return retvalue == Qt::MessageBox.Yes ? true : false
  end
  
end