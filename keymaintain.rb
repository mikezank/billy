require 'byebug'
require 'Qt4'
require 'clipboard'
require_relative 'keychainclasses'
require_relative 'keyaddchange'
require_relative 'keymaintain_ui'

class KeyMaintainDialog < Qt::Dialog
  
  NUM_COLS = 5
  
  slots 'add_key()', 'change_key()', 'delete_key()' # referenced by keymaintain.ui
  
  #slots 'do_maintenance()' # referenced by main.ui
  #slots 'add_masterbill()', 'change_masterbill()', 'delete_masterbill()'
  
  def initialize
    super(parent=nil)
    @ui = Ui_KeyMaintainDialog.new
    @ui.setupUi(self)
    @ui.keyTable.setColumnCount(NUM_COLS)
    #@ui.billTable.setHorizontalHeaderLabels(%w(Name Amount Start End Frequency Condition))
    border_style = 'QTableWidget {border-width: 5px; padding: 3px; border-color: darkblue}'
    @ui.keyTable.setStyleSheet(border_style)
    @keylist = KeyList.new
    show_table
  end
  
  def show_table
    @ui.keyTable.setRowCount(@keylist.length)
    row = 0
    @key_in_row = []
    @info_for_button = {}
    @keylist.each_key do |key|
      col0 = Qt::TableWidgetItem.new(key.name)
      @ui.keyTable.setItem(row, 0, col0)
      1.upto(4) do |n|
        button = Qt::PushButton.new(key.info[n-1])
        button.setStyleSheet('background-color: olive') if key.coded[n-1]
        @info_for_button[button] = "#{n-1}#{key.uuid}" # record the info field # as well as the key uuid
        button.connect(SIGNAL('clicked()')) do
          info_index = @info_for_button[button][0].to_i
          key_uuid = @info_for_button[button][1..-1]
          thiskey = @keylist.get_key(key_uuid)
          if thiskey.coded[info_index]
            Clipboard.copy(thiskey.codes[info_index].decode)
          else
            Clipboard.copy(thiskey.info[info_index])
          end
        end
        @ui.keyTable.setCellWidget(row, n, button)
      end
      row += 1
      @key_in_row<<key
    end
    @ui.keyTable.resizeRowsToContents
    @ui.keyTable.resizeColumnsToContents
  end
  
  def add_key()
    addwin = KeyAddChangeDialog.new
    retcode = addwin.exec
    @keylist.add_key(addwin.newkey) if retcode == Qt::Dialog.Accepted
    show_table
  end
  
  def change_key()
    selrow = @ui.keyTable.currentRow
    changekey = @key_in_row[selrow]
    changewin = KeyAddChangeDialog.new(changekey)
    retcode = changewin.exec
    if retcode == Qt::Dialog.Accepted
      @keylist.add_key(changewin.newkey)
      @keylist.delete_key(changekey)
    end
    show_table
  end
  
  def delete_key()
    selrow = @ui.keyTable.currentRow
    deletekey = @key_in_row[selrow]
    @keylist.delete_key(deletekey)
    show_table
  end
  
end