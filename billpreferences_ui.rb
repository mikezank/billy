=begin
** Form generated from reading ui file 'billpreferences.ui'
**
** Created: Wed Jan 14 08:00:58 2015
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_BillPreferencesDialog
    attr_reader :widget
    attr_reader :horizontalLayout
    attr_reader :label
    attr_reader :directoryCombo
    attr_reader :browseButton
    attr_reader :widget1
    attr_reader :horizontalLayout_2
    attr_reader :label_2
    attr_reader :lookaheadSpin
    attr_reader :widget2
    attr_reader :horizontalLayout_3
    attr_reader :cancelButton
    attr_reader :saveButton

    def setupUi(billPreferencesDialog)
    if billPreferencesDialog.objectName.nil?
        billPreferencesDialog.objectName = "billPreferencesDialog"
    end
    billPreferencesDialog.resize(952, 458)
    @widget = Qt::Widget.new(billPreferencesDialog)
    @widget.objectName = "widget"
    @widget.geometry = Qt::Rect.new(30, 30, 901, 32)
    @horizontalLayout = Qt::HBoxLayout.new(@widget)
    @horizontalLayout.objectName = "horizontalLayout"
    @horizontalLayout.setContentsMargins(0, 0, 0, 0)
    @label = Qt::Label.new(@widget)
    @label.objectName = "label"
    @font = Qt::Font.new
    @font.pointSize = 14
    @label.font = @font

    @horizontalLayout.addWidget(@label)

    @directoryCombo = Qt::ComboBox.new(@widget)
    @directoryCombo.objectName = "directoryCombo"
    @font1 = Qt::Font.new
    @font1.family = "Courier"
    @font1.pointSize = 14
    @directoryCombo.font = @font1

    @horizontalLayout.addWidget(@directoryCombo)

    @browseButton = Qt::PushButton.new(@widget)
    @browseButton.objectName = "browseButton"

    @horizontalLayout.addWidget(@browseButton)

    @widget1 = Qt::Widget.new(billPreferencesDialog)
    @widget1.objectName = "widget1"
    @widget1.geometry = Qt::Rect.new(30, 90, 343, 26)
    @horizontalLayout_2 = Qt::HBoxLayout.new(@widget1)
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @horizontalLayout_2.setContentsMargins(0, 0, 0, 0)
    @label_2 = Qt::Label.new(@widget1)
    @label_2.objectName = "label_2"
    @label_2.font = @font

    @horizontalLayout_2.addWidget(@label_2)

    @lookaheadSpin = Qt::SpinBox.new(@widget1)
    @lookaheadSpin.objectName = "lookaheadSpin"
    @lookaheadSpin.font = @font1

    @horizontalLayout_2.addWidget(@lookaheadSpin)

    @widget2 = Qt::Widget.new(billPreferencesDialog)
    @widget2.objectName = "widget2"
    @widget2.geometry = Qt::Rect.new(540, 370, 371, 32)
    @horizontalLayout_3 = Qt::HBoxLayout.new(@widget2)
    @horizontalLayout_3.objectName = "horizontalLayout_3"
    @horizontalLayout_3.setContentsMargins(0, 0, 0, 0)
    @cancelButton = Qt::PushButton.new(@widget2)
    @cancelButton.objectName = "cancelButton"

    @horizontalLayout_3.addWidget(@cancelButton)

    @saveButton = Qt::PushButton.new(@widget2)
    @saveButton.objectName = "saveButton"

    @horizontalLayout_3.addWidget(@saveButton)


    retranslateUi(billPreferencesDialog)
    Qt::Object.connect(@browseButton, SIGNAL('clicked()'), billPreferencesDialog, SLOT('browse_directories()'))
    Qt::Object.connect(@cancelButton, SIGNAL('clicked()'), billPreferencesDialog, SLOT('reject()'))
    Qt::Object.connect(@saveButton, SIGNAL('clicked()'), billPreferencesDialog, SLOT('save_clicked()'))

    Qt::MetaObject.connectSlotsByName(billPreferencesDialog)
    end # setupUi

    def setup_ui(billPreferencesDialog)
        setupUi(billPreferencesDialog)
    end

    def retranslateUi(billPreferencesDialog)
    billPreferencesDialog.windowTitle = Qt::Application.translate("BillPreferencesDialog", "Dialog", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("BillPreferencesDialog", "Location of program data files", nil, Qt::Application::UnicodeUTF8)
    @browseButton.text = Qt::Application.translate("BillPreferencesDialog", "Browse...", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("BillPreferencesDialog", "Number of days beyond today to view bills", nil, Qt::Application::UnicodeUTF8)
    @cancelButton.text = Qt::Application.translate("BillPreferencesDialog", "Cancel", nil, Qt::Application::UnicodeUTF8)
    @saveButton.text = Qt::Application.translate("BillPreferencesDialog", "Save", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(billPreferencesDialog)
        retranslateUi(billPreferencesDialog)
    end

end

module Ui
    class BillPreferencesDialog < Ui_BillPreferencesDialog
    end
end  # module Ui

