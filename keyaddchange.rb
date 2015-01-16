require 'byebug'
require 'set'
require 'Qt4'
require_relative 'keychainclasses'
require_relative 'keyaddchange_ui'

class KeyAddChangeDialog < Qt::Dialog
  
  #
  # Constructors:
  #
  #    KeyAddChangeDialog.new()  -- returns a new Key based on form values provided by the user
  #
  #    KeyAddChangeDialog.new(key) -- populates the form with values specified by the given Key;
  #                                   returns a new Key based on form values provided by the user
  #
  
  slots 'save_clicked()', 'code_clicked()' # referenced by keyaddchange.ui
  
  attr_reader :newkey
         
  def initialize(*arg)
    if arg.length == 0
      @changemode = false
    elsif arg.length == 1
      @sel_key = arg[0]
      @changemode = true
    else
      raise "Invalid call with arg = #{arg}"
    end
    super(parent=nil)
    @ui = Ui_KeyAddChangeDialog.new
    @ui.setupUi(self)
    # define convenience arrays
    @infoEdits = [@ui.info1Edit, @ui.info2Edit, @ui.info3Edit, @ui.info4Edit]
    @infoChecks = [@ui.info1Check, @ui.info2Check, @ui.info3Check, @ui.info4Check]
    @codeEdits = [@ui.code1Edit, @ui.code2Edit, @ui.code3Edit, @ui.code4Edit]
    if @changemode
      preload_for_change
    else
      preload_for_add
    end
  end
  
  def preload_for_add
    disable_all_codes()
  end
    
  def preload_for_change
    disable_all_codes
    @ui.nameEdit.setText(@sel_key.name)
    0.upto(3) do |n|
       @infoEdits[n].setText(@sel_key.info[n])
       if @sel_key.coded[n]
         @infoChecks[n].setChecked(true)
         @codeEdits[n].setText(@sel_key.codes[n].decode)
       end
     end
   end
    
  def disable_all_codes()
    0.upto(3) do |n|
     @infoChecks[n].setChecked(false)
     @codeEdits[n].setEnabled(false)
     @codeEdits[n].setText('')
     @codeEdits[n].setPlaceholderText('none')
    end
  end
  
  def code_clicked()
    selcheck = @infoChecks.index(sender) # find which check box was clicked
    @codeEdits[selcheck].setEnabled(@infoChecks[selcheck].isChecked)
    if @infoChecks[selcheck].isChecked
      @codeEdits[selcheck].setText('') 
      @codeEdits[selcheck].setFocus
    else
      @codeEdits[selcheck].setText('')
    end
  end
  
  def clear_clicked()
    preload_for_add
  end
  
  def save_clicked()
=begin
    # verify that all info field names are unique
    nameset = Set.new
    namecount = 0
    0.upto(3) do |n|
      if @infoEdits[n].text != ''
        nameset<<@infoEdits[n].text
        namecount += 1
      end
    end
    if nameset.length != namecount
      # the info field names are not unique
      msgBox = Qt::MessageBox.new
      msgBox.setText("All Info Field names must be unique")
      msgBox.exec
      return
    end
=end
    # create new Key from the values on the form
    info = []
    coded = []
    plain = []
    name = @ui.nameEdit.text
    0.upto(3) do |n|
      info<<@infoEdits[n].text
      if @infoChecks[n].isChecked
        coded<<true
        plain<<@codeEdits[n].text
      else
        coded<<false
        plain<<nil
      end
    end
    
    @newkey = Key.new(name, info, coded, plain)
    accept
  end
  
end