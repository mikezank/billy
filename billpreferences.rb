require 'byebug'
require 'date'
require 'Qt4'
require_relative 'billdataclasses'
require_relative 'billpreferences_ui'

class BillPreferencesDialog < Qt::Dialog
  
  slots 'browse_directories()', 'save_clicked()' # referenced by billpreferences.ui
  
  def initialize
    super(parent=nil)
    @ui = Ui_BillPreferencesDialog.new
    @ui.setupUi(self)
    @prefs = Preferences.new
    @ui.directoryCombo.insertItem(0, @prefs.data_directory)
    @ui.lookaheadSpin.setRange(0, 20000)
    @ui.lookaheadSpin.setValue(@prefs.lookahead_days)
  end
  
  def browse_directories()
    directory = Qt::FileDialog.getExistingDirectory(self, 'Find Files', Qt::Dir.currentPath)
    if directory != ''
      @ui.directoryCombo.addItem(directory) if @ui.directoryCombo.findText(directory) == -1
      @ui.directoryCombo.setCurrentIndex(@ui.directoryCombo.findText(directory))
    end
  end
        
  def save_clicked()
    @prefs.set_data_directory(@ui.directoryCombo.currentText)
    @prefs.set_lookahead_days(@ui.lookaheadSpin.value)
    accept
  end

end