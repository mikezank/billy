=begin
** Form generated from reading ui file 'billmaintain.ui'
**
** Created: Mon Jan 12 10:05:39 2015
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_BillmaintainDialog
    attr_reader :billTable
    attr_reader :exitButton
    attr_reader :layoutWidget
    attr_reader :verticalLayout
    attr_reader :addButton
    attr_reader :changeButton
    attr_reader :deleteButton

    def setupUi(billmaintainDialog)
    if billmaintainDialog.objectName.nil?
        billmaintainDialog.objectName = "billmaintainDialog"
    end
    billmaintainDialog.resize(1018, 646)
    @billTable = Qt::TableWidget.new(billmaintainDialog)
    @billTable.objectName = "billTable"
    @billTable.geometry = Qt::Rect.new(10, 10, 871, 621)
    @exitButton = Qt::PushButton.new(billmaintainDialog)
    @exitButton.objectName = "exitButton"
    @exitButton.geometry = Qt::Rect.new(900, 210, 114, 32)
    @layoutWidget = Qt::Widget.new(billmaintainDialog)
    @layoutWidget.objectName = "layoutWidget"
    @layoutWidget.geometry = Qt::Rect.new(900, 30, 111, 121)
    @verticalLayout = Qt::VBoxLayout.new(@layoutWidget)
    @verticalLayout.objectName = "verticalLayout"
    @verticalLayout.setContentsMargins(0, 0, 0, 0)
    @addButton = Qt::PushButton.new(@layoutWidget)
    @addButton.objectName = "addButton"

    @verticalLayout.addWidget(@addButton)

    @changeButton = Qt::PushButton.new(@layoutWidget)
    @changeButton.objectName = "changeButton"

    @verticalLayout.addWidget(@changeButton)

    @deleteButton = Qt::PushButton.new(@layoutWidget)
    @deleteButton.objectName = "deleteButton"

    @verticalLayout.addWidget(@deleteButton)


    retranslateUi(billmaintainDialog)
    Qt::Object.connect(@addButton, SIGNAL('clicked()'), billmaintainDialog, SLOT('add_masterbill()'))
    Qt::Object.connect(@changeButton, SIGNAL('clicked()'), billmaintainDialog, SLOT('change_masterbill()'))
    Qt::Object.connect(@deleteButton, SIGNAL('clicked()'), billmaintainDialog, SLOT('delete_masterbill()'))
    Qt::Object.connect(@exitButton, SIGNAL('clicked()'), billmaintainDialog, SLOT('accept()'))

    Qt::MetaObject.connectSlotsByName(billmaintainDialog)
    end # setupUi

    def setup_ui(billmaintainDialog)
        setupUi(billmaintainDialog)
    end

    def retranslateUi(billmaintainDialog)
    billmaintainDialog.windowTitle = Qt::Application.translate("BillmaintainDialog", "Dialog", nil, Qt::Application::UnicodeUTF8)
    @exitButton.text = Qt::Application.translate("BillmaintainDialog", "Exit", nil, Qt::Application::UnicodeUTF8)
    @addButton.text = Qt::Application.translate("BillmaintainDialog", "Add", nil, Qt::Application::UnicodeUTF8)
    @changeButton.text = Qt::Application.translate("BillmaintainDialog", "Change", nil, Qt::Application::UnicodeUTF8)
    @deleteButton.text = Qt::Application.translate("BillmaintainDialog", "Delete", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(billmaintainDialog)
        retranslateUi(billmaintainDialog)
    end

end

module Ui
    class BillmaintainDialog < Ui_BillmaintainDialog
    end
end  # module Ui

